//
//  MMMovieService.swift
//  MyMovies
//
//  Created by Ihor on 31.01.2024.
//

import Foundation

class MMMovieService {
    
    private let headers = [
      "accept": "application/json",
      "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5YTY4OTg0NDEzYWRkMWIxMTQ0MzAzYjQ2ZDU0M2Y2OCIsInN1YiI6IjY1NTQ4ZWVmOTY1M2Y2MTNmNjJhMzgzNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eJeK6hezCrhDCs1o8JLW15RlNcAEBG7LE_YtOE1WfYY"
    ]
    
    func downloadData(completionHandler: @escaping (_ data: Data?, _ error: String?) -> ()) {
        
        guard let url = URL(string: MMConstants.http + MMConstants.topRatedMoviePath) else { return }
        
        var request = URLRequest(url: url)
                
        request.httpMethod = HTTP.Method.get.rawValue
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error downloading data \(String(describing: error?.localizedDescription))")
                completionHandler(nil, "Error downloading data, check internet connection")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(nil, "Invalid response code")
                return
            }
            
            completionHandler(data, nil)
            
        }
        .resume()
    }
}
