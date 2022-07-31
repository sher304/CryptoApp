//
//  ViewModel.swift
//  TestMVVMProject
//
//  Created by Шермат Эшеров on 31/7/22.
//

import Foundation

protocol ViewModelDelegate{
    func shareData()
}

class ViewModel{
    
    private lazy var network: Network = {
        return Network()
    }()
    
    let items = Dynamic(Currency(data: [], timestamp: 0))
    
    var didSelected = false
    var searchetItems: [CryptoData]?
    
    // MARK: - Share Data To View
    
    func shareData(){
        network.fetchData { [self] data in
            if didSelected{
                searchetItems = data.data
            }
            items.value = data
        }
    }
    
    // MARK: - Set Variable to Search
    func setVariable(value: Bool){
        didSelected = value
    }
    
}
