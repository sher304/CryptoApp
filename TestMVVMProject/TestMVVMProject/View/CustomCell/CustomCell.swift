//
//  CustomCell.swift
//  TestMVVMProject
//
//  Created by Шермат Эшеров on 31/7/22.
//

import Foundation
import UIKit
import SnapKit


class CustomTableViewCell: UITableViewCell{
    
    static let identifier = "CustomCell"
    
    private lazy var parentOfCell: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        return view
    }()
    
    private lazy var cryptoTitle: UILabel = {
        let label = UILabel()
        label.text = "Ethereum"
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        label.textColor = .white
        return label
    }()
    
    private lazy var cryptoShortTitle: UILabel = {
        let label = UILabel()
        label.text = "ETH"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.thin)
        label.textColor = .white
        return label
    }()
    
    private lazy var cryptoPrice: UILabel = {
        let label = UILabel()
        label.text = "£1,939.74"
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        label.textColor = .white
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var cryptoPercent: UILabel = {
        let label = UILabel()
        label.text = "-0.70%"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.thin)
        label.textColor = .green
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var upDownIcons: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.up")
        image.tintColor = .white
        return image
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
}

// MARK: - Set Up Constaints

extension CustomTableViewCell{
    func setupConstraints(){
        let elements = [parentOfCell]
        for element in elements {
            contentView.addSubview(element)
        }
        let childs = [cryptoTitle, cryptoPrice, cryptoPercent, cryptoShortTitle, upDownIcons]
        for child in childs {
            parentOfCell.addSubview(child)
        }
        
        parentOfCell.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        cryptoTitle.snp.makeConstraints { make in
            make.leading.equalTo(45)
            make.top.equalTo(25)
        }
        
        cryptoShortTitle.snp.makeConstraints { make in
            make.leading.equalTo(45)
            make.top.equalTo(cryptoTitle.snp.bottom).offset(5)
        }
        
        cryptoPrice.snp.makeConstraints { make in
            make.centerY.equalTo(cryptoTitle)
            make.trailing.equalTo(-45)
            make.width.equalTo(85)
            make.height.equalTo(30)
        }
        
        cryptoPercent.snp.makeConstraints { make in
            make.top.equalTo(cryptoPrice.snp.bottom).offset(5)
            make.trailing.equalTo(-45)
            make.width.equalTo(40)
            make.height.equalTo(30)
        }
        
        upDownIcons.snp.makeConstraints { make in
            make.centerY.equalTo(cryptoPercent)
            make.trailing.equalTo(cryptoPercent.snp.leading).offset(-10)
        }
    }

// MARK: - Fetch Data from View To Set
    func fetchData(title: String, price: String, aliance: String, persent: String){
        cryptoTitle.text = title
        cryptoPrice.text = "$\(price)"
        cryptoShortTitle.text = aliance
        if persent.first == "-"{
            cryptoPercent.textColor = .red
            cryptoPercent.text = "\(persent)%"
            upDownIcons.image = UIImage(systemName: "chevron.down")
            upDownIcons.tintColor = .red
            
        }else {
            cryptoPercent.textColor = .green
            cryptoPercent.text = "+\(persent)%"
            upDownIcons.image = UIImage(systemName: "chevron.up")
            upDownIcons.tintColor = .green
        }
    }
}
