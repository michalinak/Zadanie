//
//  NetworkManager.swift
//  Zadanie1
//
//  Created by Michalina Kukielko on 22/02/2020.
//  Copyright © 2020 Michalina Kukielko. All rights reserved.
//

import Foundation

class NetworkManager {
    func getNumbers(completion: @escaping ([NumberModel]?) -> Void) {
        guard let url = URL(string: baseUrl) else {
            completion(nil)
            return }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url) { data, response, error in

            guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else {
                print("status code different than 200")
                completion(nil)
                return
            }

            do {
                let decoder = JSONDecoder()
                let numbers = try decoder.decode([NumberModel].self, from: data)
                
                completion(numbers)
            } catch {
                print("Error: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
    
    func getNumberDetail(queryValue: String, completion: @escaping (NumberModel?) -> Void) {
        var urlComponents = URLComponents(string: baseUrl)

        let queryItem = URLQueryItem(name: "name", value: queryValue)
        urlComponents?.queryItems = [queryItem]
        guard let url = urlComponents?.url else {
            completion(nil)
            return
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url) { data, response, error in

              guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else {
                  print("status code different than 200")
                  completion(nil)
                  return
              }

              do {
                  let decoder = JSONDecoder()
                  let number = try decoder.decode(NumberModel.self, from: data)
                  completion(number)
              } catch {
                  print("Error: \(error)")
                  completion(nil)
              }
          }
          task.resume()
    }
}
