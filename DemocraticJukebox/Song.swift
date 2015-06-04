//
//  Song.swift
//  DemocraticJukebox
//
//  Created by Thahir Maheen on 29/05/15.
//  Copyright (c) 2015 Jukebox. All rights reserved.
//

import Foundation

class Album {
    var id = 0
    var title = ""
    
    init() {}

    init(data: NSDictionary) {
        id = data.valueForKeyPath(Song.Api.Keys.ID) as? Int ?? 0
        title = (data.valueForKeyPath(Song.Api.Keys.Title) as? String ?? "").capitalizedString
    }
}

class Genre {
    var id = 0
    var name = ""
    
    init() {}
    
    init(data: NSDictionary) {
        id = data.valueForKeyPath(Song.Api.Keys.ID) as? Int ?? 0
        name = (data.valueForKeyPath(Song.Api.Keys.Name) as? String ?? "").capitalizedString
    }

}

class Artist {
    var id = 0
    var name = ""
    
    init() {}

    init(data: NSDictionary) {
        id = data.valueForKeyPath(Song.Api.Keys.ID) as? Int ?? 0
        name = (data.valueForKeyPath(Song.Api.Keys.Name) as? String ?? "").capitalizedString
    }
}

class Song {
    var id = 0
    var title = ""
    var length = 0
    var year = 0
    var queued = false
    var favorite = false
    
    var album = Album()
    var genre = Genre()
    var artist = Artist()
    
    init() {}
    
    init(data: NSDictionary) {
        id = data.valueForKeyPath(Api.Keys.ID) as? Int ?? 0
        title = (data.valueForKeyPath(Api.Keys.Title) as? String ?? "").capitalizedString
        length = data.valueForKeyPath(Api.Keys.Length) as? Int ?? 0
        year = data.valueForKeyPath(Api.Keys.Year) as? Int ?? 0
        queued = data.valueForKeyPath(Api.Keys.Queued) as? Bool ?? false
        favorite = data.valueForKeyPath(Api.Keys.Favorite) as? Bool ?? false
        
        album = Album(data: data.valueForKeyPath(Api.Keys.Album) as? NSDictionary ?? NSDictionary())
        genre = Genre(data: data.valueForKeyPath(Api.Keys.Genre) as? NSDictionary ?? NSDictionary())
        artist = Artist(data: data.valueForKeyPath(Api.Keys.Artist) as? NSDictionary ?? NSDictionary())
    }
    
    class func fetchSongs(mode: SongsViewMode = .Songs, searchKey: String = "", page: Int = 1, count: Int = 30, completionHandler: (songs: [Song]) -> ()) {
        
        let params = ["search_term": searchKey,
                      "page": "\(page)",
                      "count": "\(count)"]
        
        ParseEngine.sharedEngine.fetchData(mode.keyPath, params: params) { (data) in
            let rawSongs = data.valueForKeyPath(Song.Api.Keys.ItemList) as! [NSDictionary]
            let songs = rawSongs.map { Song(data: $0) }
            
            completionHandler(songs: songs)
        }
    }
    
    func vote() {
        ParseEngine.sharedEngine.postData(Model.Api.KeyPaths.Queue, params: ["id": "\(id)"]) { (data) in
            println(data)
        }
    }

    struct Api {
        struct Keys {
            static let Album = "album"
            static let Artist = "artist"
            static let Favorite = "favourite"
            static let Genre = "genre"
            static let ID = "id"
            static let ItemList = "itemList"
            static let Length = "length"
            static let Name = "name"
            static let Queued = "queued"
            static let Title = "title"
            static let Year = "year"
        }
    }
}

