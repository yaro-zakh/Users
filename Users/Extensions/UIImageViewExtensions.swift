//
//  UIImageViewExtensions.swift
//  Users
//
//  Created by Yaroslav Zakharchuk on 10/26/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func load(url: URL?, completion: @escaping () -> Void) {
        if let url = url {
            DispatchQueue.global().async { [weak self] in
                guard let data = try? Data(contentsOf: url) else { return }
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.image = image
                    completion()
                }
            }
        } else {
            DispatchQueue.main.async {
                self.image = UIImage(named: "no avatar")
                completion()
            }
        }
    }
}
