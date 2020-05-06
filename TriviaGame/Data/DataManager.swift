//
//  DataManager.swift
//  TriviaGame
//
//  Created by Toni De Gea on 04/05/2020.
//  Copyright © 2020 Toni De Gea. All rights reserved.
//

import Foundation

enum MyErrors: Error {
    case num409
    case num401
    case num405
    case num403
}


struct DataManager {

    enum ServiceResult { //si es success devuelve cualquier cosa que se pida, si no, devuelve un mensaje diciendo que ha fallado
        case success(data: [Result])
        case failure(msg: MyErrors)
    }
    
    
    
    typealias ServiceCompletion = (_ results: ServiceResult) -> ()
    
    
    func getQuestions(completion: @escaping ServiceCompletion) -> Void {
        let urlString = "https://opentdb.com/api.php?amount=20&type=multiple"
        print(urlString)
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let result = try decoder.decode(TriviaAPI.self, from: safeData)
                            DispatchQueue.main.async {
                                let res: [Result] = result.results
                                print(res)
                                completion(.success(data: res))
                                //                                print(res)
                            }
                        } catch  {
                            completion(.failure(msg: MyErrors.num401))
                        }
                        
                    }
                } else {
                    completion(.failure(msg: MyErrors.num401))
                }
            }
            task.resume()
        }
    }
    
}


