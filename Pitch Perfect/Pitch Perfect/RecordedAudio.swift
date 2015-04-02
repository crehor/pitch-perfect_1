//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Charlie Rehor on 3/29/15.
//  Copyright (c) 2015 Charlie Rehor. All rights reserved.
//

import Foundation


class RecordedAudio: NSObject{

    var filePathUrl: NSURL
    var title: String
        
    init (title: String, filePathUrl: NSURL) {
        
        self.filePathUrl = filePathUrl
        self.title = title
    }

}
