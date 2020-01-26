//
//  UIImageView+Extensions.swift
//  PhotoJournal
//
//  Created by Cameron Rivera on 1/26/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

extension UIImage{
    func resizeImage(_ height: CGFloat, _ width: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (contenxt) in
            self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        }
    }
}
