//
//  String+Extension.swift
//  ClubSquad
//
//  Created by Dumitru Manea on 23.02.2022.
//

import UIKit

extension String {
    var width: CGFloat {
        let size = self.size(withAttributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)
        ])
        return size.width
    }
}
