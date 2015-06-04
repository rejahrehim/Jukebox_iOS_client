//
//  SongsViewController.swift
//  DemocraticJukebox
//
//  Created by Thahir Maheen on 30/05/15.
//  Copyright (c) 2015 Jukebox. All rights reserved.
//

import UIKit

class SongCell: MGSwipeTableCell, MGSwipeTableCellDelegate {
    
    var song = Song() {
        didSet {
            configureCell()
        }
    }
    
    func configureCell() {
        
        // set text labels
        textLabel?.text = song.title
        detailTextLabel?.text = song.album.title + " " + song.artist.name
        
        // set the
        delegate = self
        
        let buttonVote = MGSwipeButton(title: "Vote", backgroundColor: UIColor.greenColor()) { (cell) -> Bool in
            self.song.vote()
            return true
        }
        
        let buttonFavorite = MGSwipeButton(title: "Favorite", backgroundColor: UIColor.blueColor()) { (cell) -> Bool in
            println("fav")
            return true
        }

        leftButtons = [buttonVote, buttonFavorite]
        leftSwipeSettings.transition = MGSwipeTransition.Border
        leftExpansion.buttonIndex = 0
        leftExpansion.threshold = 1.5
        leftExpansion.fillOnTrigger = true

    }
    
    func swipeTableCell(cell: MGSwipeTableCell!, didChangeSwipeState state: MGSwipeState, gestureIsActive: Bool) {
        println("state is \(state.rawValue)")
    }
}

enum SongsViewMode: Int {
    case Queue = 0
    case Songs = 1
    case Favorites = 2
    case History = 3
    
    var keyPath: String {
        switch self {
        case .Queue: return Model.Api.KeyPaths.Queue
        case .Songs: return Model.Api.KeyPaths.Songs
        case .Favorites: return Model.Api.KeyPaths.Favorites
        case .History: return Model.Api.KeyPaths.History
        default: return ""
        }
    }
}

class SongsViewController: UITableViewController, UISearchBarDelegate {
    
    var songs = [Song]() {
        didSet {
            tableView?.reloadData()
        }
    }

    var songsViewMode = SongsViewMode.Songs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // determine mode
        if let tabBarController = tabBarController {
            songsViewMode = SongsViewMode(rawValue: tabBarController.selectedIndex)!
        }
        
//        let aSong = Song()
//        aSong.title = "sample song"
//        aSong.album = Album()
//        aSong.album.title = "sample album"
//        
//        songs = [aSong, aSong, aSong]
        
        
        // fetch songs
        Song.fetchSongs(mode: songsViewMode) { (songs) in
            self.songs = songs
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellIdentifiers.SongCell, forIndexPath: indexPath) as! SongCell
        cell.song = songs[indexPath.row]
        return cell
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        // fetch all songs
        Song.fetchSongs(mode: songsViewMode) { (songs) in
            self.songs = songs
        }
        
        // hide keyboard
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        // fetch songs based on search key
        Song.fetchSongs(mode: songsViewMode, searchKey: searchBar.text) { (songs) in
            self.songs = songs
        }
        
        // hide keyboard
        searchBar.resignFirstResponder()
    }

    struct Storyboard {
        struct CellIdentifiers {
            static let SongCell = "kSongCell"
        }
    }

}
