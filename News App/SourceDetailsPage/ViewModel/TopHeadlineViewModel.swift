//
//  TopHeadlineViewModel.swift
//  News App
//
//  Created by Recep Bayraktar on 23.03.2021.
//

import Foundation

class TopHeadlineViewModel {
    
    var onSuccessResponse: (()->())?
    var onErrorResponse: ((String)->())?
    
    private var key = "00fcefaa26164dd0a0d4421698fc4982"
    private var components = URLComponents(string: "https://newsapi.org/v2/top-headlines")
    
    var topSources: [NewsModel] = []
    
    func fetchData(sources: String = "") {
        
        components?.queryItems = [
            URLQueryItem(name: "sources", value: String(sources)),
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
                            let response = try decoder.decode(NewsResult.self, from: data)
                            self.topSources = response.articles
                            self.onSuccessResponse?()
                            print(self.topSources.count)
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
