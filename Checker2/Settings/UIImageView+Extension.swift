//
//  UIImageView+Extension.swift
//  Checker2
//
//  Created by bmtech on 25.07.2022.
//

import Foundation
import UIKit
import SwiftUI

extension UIImageView {
    
    func downloaded(
        from url: URL,
        contentMode mode: ContentMode = .scaleAspectFit
    ) {
        
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(
        from link: String,
        contentMode mode: ContentMode = .scaleAspectFill
    ) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension UIColor {
    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}

extension Color {
    public init(hex: Int) {
        self.init(UIColor(hex: hex))
    }
}
