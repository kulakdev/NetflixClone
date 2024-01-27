//
//  TableViewCell.swift
//  NetflixClone
//
//  Created by Macbook Pro on 27.01.2024.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

    
    static let identifier = "CollectionViewtableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}