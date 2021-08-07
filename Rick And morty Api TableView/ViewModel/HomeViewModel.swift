//
//  HomeViewModel.swift
//  Rick And morty Api TableView
//
//  Created by Halis  Kara on 6.08.2021.
//

import Foundation

class HomeViewModel {
    
    var dataSource = [Character]()
    var loading = true
    
    // MARK: - API Request
    func requestApi (url: String, didFinish: @escaping (Result<[Character],Error>) -> Void) {
       
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
            guard let data = data , err == nil else {
                print("something went wrong")
                didFinish(.failure(err as! Error))
                return
             }
            var result: Response?
                  do {
                      result = try JSONDecoder().decode(Response.self,from: data)
                      self.dataSource.append(contentsOf: result!.results)
                   } catch {
                      print("failed to convert")
                    
                  }
             self.loading = false
             didFinish(.success(self.dataSource))
         }.resume()
     }
}
