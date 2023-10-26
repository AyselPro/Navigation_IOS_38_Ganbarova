//
//  PostTableViewCell.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 26.10.2023.
//

import UIKit
import iOSIntPackage

final class PostTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct ImageProcessor {
        
        var title: String
        
        private func setupView() {}
        
    }
}
