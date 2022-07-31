//
//  Network.swift
//  TestMVVMProject
//
//  Created by Шермат Эшеров on 31/7/22.
//

import Foundation

protocol NetworkDelegate{
    func fetchData(completion: @escaping (Currency) -> Void)
}

class Network: NetworkDelegate{
    
    let session = URLSession.shared
    
    func fetchData(completion: @escaping (Currency) -> Void){
        guard let url = URL(string: "https://api.coincap.io/v2/assets") else {return }
        
        session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            guard let request = try? JSONDecoder().decode(Currency.self, from: data) else { return }
            completion(request)
        }.resume()
    }

}
