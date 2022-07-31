//
//  ViewController.swift
//  TestMVVMProject
//
//  Created by Шермат Эшеров on 31/7/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var viewModel: ViewModel = {
        return ViewModel()
    }()
    
    private lazy var appleLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "applelogo")
        image.tintColor = .white
        return image
    }()
    
    private lazy var btcIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "bitcoinsign.circle.fill")
        image.tintColor = .white
        return image
    }()
    
    private lazy var cryproTech: UILabel = {
        let label = UILabel()
        label.text = "Track Coins"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 23)
        return label
    }()
    
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.autocapitalizationType = .none
        searchBar.placeholder = "Search Coins"
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.textColor = .white
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var popularLabel: UILabel = {
        let label = UILabel()
        label.text = "Most Popular"
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.semibold)
        label.textColor = .white
        return label
    }()
    
    private lazy var cryptoTable: UITableView = {
        let table = UITableView()
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        table.backgroundColor = .clear
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binder()
        setupConstaints()
    }
    
}

extension ViewController{

// MARK: - Bind with View Model
    func binder(){
        viewModel.shareData()
        viewModel.items.bind { [self] _ in
            DispatchQueue.main.async {
                cryptoTable.reloadData()
            }
        }
    }
    
// MARK: - Set Up Constaints
    
    func setupConstaints(){
        view.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        
        let elemenets = [appleLogo, btcIcon, cryproTech, searchBar,
                         popularLabel, cryptoTable]
        for elemenet in elemenets {
            view.addSubview(elemenet)
        }
        
        appleLogo.snp.makeConstraints { make in
            make.leading.equalTo(30)
            make.top.equalTo(60)
            make.height.equalTo(30)
            make.width.equalTo(25)
        }
        
        cryproTech.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(70)
        }
        
        btcIcon.snp.makeConstraints { make in
            make.centerY.equalTo(cryproTech)
            make.height.equalTo(25)
            make.width.equalTo(25)
            make.trailing.equalTo(-30)
        }
        
        searchBar.snp.makeConstraints { make in
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.top.equalTo(cryproTech.snp.bottom).offset(20)
            make.height.equalTo(45)
        }
        
        popularLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(35)
            make.leading.equalTo(20)
        }
        
        cryptoTable.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalTo(popularLabel.snp.bottom).offset(25)
            make.leading.equalTo(15)
            make.trailing.equalTo(-15)
        }
    }
}


// MARK: - Table View Delegate

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.didSelected{
            return viewModel.searchetItems?.count ?? 0
        }else{
            return viewModel.items.value.data.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomTableViewCell()
        if viewModel.didSelected{
            let items = viewModel.searchetItems![indexPath.row]
            cell.fetchData(title: items.name, price: items.priceUsd, aliance: items.symbol, persent: items.changePercent24Hr)
        }else{
            let items = viewModel.items.value.data[indexPath.row]
            cell.fetchData(title: items.name, price: items.priceUsd, aliance: items.symbol, persent: items.changePercent24Hr)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

// MARK: - Search Bar Delegate

extension ViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let items = viewModel.items.value.data
        viewModel.searchetItems = items.filter({$0.name.lowercased().prefix(searchText.count) == searchText.lowercased()})
        viewModel.setVariable(value: true)
        cryptoTable.reloadData()
    }
}
