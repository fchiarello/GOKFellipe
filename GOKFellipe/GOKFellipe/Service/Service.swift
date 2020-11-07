//
//  Service.swift
//  GOKFellipe
//
//  Created by Fellipe Ricciardi Chiarello on 11/6/20.
//

import Foundation

enum ErrorType {
    case urlError
    case responseError
    case jsonError
    case statusCodeError(code: Int)
    case taskError(error: Error)
}

class Service {
    static let session = URLSession.shared
    
   class func loadList(url: String, onComplete: @escaping (MainModel) -> Void, onError: @escaping (ErrorType) -> Void) {
        guard let urlString = URL(string: url) else {
            onError(.urlError)
            return }
        
        let task = Service.session.dataTask(with: urlString) { (data, response, error) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onError(.responseError)
                    return }
                
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let list = try decoder.decode(MainModel.self, from: data)
                        onComplete(list)
                    } catch let jsonErr as NSError {
                        onError(.jsonError)
                        print(jsonErr.localizedDescription)
                        print(jsonErr.debugDescription)
                    }
                } else {
                    onError(.statusCodeError(code: response.statusCode))
                    print("Erro no servidor")
                }
            } else {
                onError(.taskError(error: error!))
                print("Algo Errado")
            }
        }
        task.resume()
    }
}
