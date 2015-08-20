//
//  VegasClient.swift
//  Vegas
//
//  Created by Chris Archibald on 8/18/15.
//  Copyright (c) 2015 Chris Archibald. All rights reserved.
//

import Foundation

class VegasClient : NSObject {
    
    func searchExpeida(inDate : String, outDate : String, completionHandler: (success: Bool, error: NSError?) -> Void) {
    }
    
    class func sharedInstance() -> VegasClient {
        struct Singleton {
            static var sharedInstance = VegasClient()
        }
        return Singleton.sharedInstance
    }
    
}