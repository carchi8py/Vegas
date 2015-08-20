//
//  VegasClient.swift
//  Vegas
//
//  Created by Chris Archibald on 8/18/15.
//  Copyright (c) 2015 Chris Archibald. All rights reserved.
//

import Foundation

class VegasClient : NSObject {
    
    var session: NSURLSession
    var sessionID : String? = nil
    
    override init() {
        session = NSURLSession.sharedSession()
        super.init()
    }
    
    func searchExpeida(inDate : String, outDate : String, completionHandler: (success: Bool, error: NSError?) -> Void) {
        
        let FormatedDate = inDate + "," + outDate
        
        //1 Set up the parameters that are needed
        //var parameters = [String: AnyObject]()
        
        let parameters : [String: AnyObject] = [
            //For now we are going to hardcode the location of vegas
            VegasClient.JSONKeys.Location: "36.1086,-115.173",
            //For now we are going to hardcode the distance to look from the location
            VegasClient.JSONKeys.Radius: "2km",
            VegasClient.JSONKeys.Dates: FormatedDate,
            VegasClient.JSONKeys.ApiKey: VegasClient.Constants.expediaAPIKey
        ]
        
        //2 Make the request
        let task = taskForExpediaGetMethod(VegasClient.Methods.Hotels, parameters: parameters){
            JSONResults, error in
            if let error = error {
                print("Something bad happened")
                completionHandler(success: false, error: error)
            } else {
                println("Nothing bad happened")
                completionHandler(success: true, error: nil)
            }
        }
    }
    
    func taskForExpediaGetMethod(method: String, parameters: [String : AnyObject], completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        //1 Set up the parameters that are needed
        var mutableParameters = parameters
        println(mutableParameters)
        
        let urlString = VegasClient.Constants.expediaBaseURL + method + VegasClient.escapedParameters(mutableParameters)
        println(urlString)
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        
        let task = session.dataTaskWithRequest(request) {data, response, downloadError in
            
            if let error = downloadError {
                println("22")
                completionHandler(result: nil, error: error)
            } else {
                println(data)
                completionHandler(result: nil, error: nil)
            }
        }
        task.resume()
        return task
    }
    
    class func sharedInstance() -> VegasClient {
        struct Singleton {
            static var sharedInstance = VegasClient()
        }
        return Singleton.sharedInstance
    }
    
    class func escapedParameters(parameters: [String : AnyObject]) -> String {
        
        var urlVars = [String]()
        
        for (key, value) in parameters {
            
            /* Make sure that it is a string value */
            let stringValue = "\(value)"
            
            /* Escape it */
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            
            /* Append it */
            urlVars += [key + "=" + "\(escapedValue!)"]
            
        }
        
        return (!urlVars.isEmpty ? "?" : "") + join("&", urlVars)
    }

    
}