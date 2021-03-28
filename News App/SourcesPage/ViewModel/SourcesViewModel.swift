//
//  SourcesViewModel.swift
//  News App
//
//  Created by Recep Bayraktar on 22.03.2021.
//

import Foundation

class SourcesViewModel {
    
    var onSuccessResponse: (()->())?
    var onErrorResponse: ((String)->())?
    
    private var key = "00fcefaa26164dd0a0d4421698fc4982"
    private var language = "en"
    private var components = URLComponents(string: "https://newsapi.org/v2/sources")
    
    var origin: [Origin] = []
    
    func fetchData(categories: String? = "") {
        
        components?.queryItems = [
            URLQueryItem(name: "category", value: String(categories ?? "")),
            URLQueryItem(name: "language", value: String(language)),
            URLQueryItem(name: "apiKey", value: String(key))
        ]
        
        print(components?.url! as Any)
        
        let request = URLRequest(url: (components?.url!)!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            DispatchQueue.main.async {
                if response.statusCode == 200 {
                    if let data = data {
                        let decoder = JSONDecoder()
                        do {
                            let response = try decoder.decode(Origins.self, from: data)
                            self.origin = response.sources
                            self.onSuccessResponse?()
                            print(self.origin.count)
                        } catch let error {
                            self.onErrorResponse?("Not a Valid JSON Response with Error : \(error)")
                            print(error)
                        }
                    } else {
                        self.onErrorResponse?("HTTP Status: \(response.statusCode)")
                    }
                }
            }
        }
        task.resume()
    }
}
