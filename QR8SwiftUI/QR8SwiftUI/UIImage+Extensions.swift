//
//  UIImage+Extensions.swift
//  QR8SwiftUI
//
//  Created by SopanSharma on 9/30/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

extension UIImage {
    
    public class func image(forQRCodeString qrCodeString: String,
                            foregroundColor: CIColor = .black,
                            backgroundColor: CIColor = .white,
                            scale: CGFloat = 10.0) -> UIImage? {
        guard let qrCodeFilter = CIFilter(name: "CIQRCodeGenerator"),
            let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }
        qrCodeFilter.setDefaults()
        qrCodeFilter.setValue(qrCodeString.data(using: .utf8, allowLossyConversion: false), forKey: "inputMessage")

        colorFilter.setDefaults()
        colorFilter.setValue(qrCodeFilter.outputImage, forKey: kCIInputImageKey)
        colorFilter.setValue(foregroundColor, forKey: "inputColor0")
        colorFilter.setValue(backgroundColor, forKey: "inputColor1")

        guard let outputImage: CIImage = colorFilter.outputImage else { return nil }
        guard scale > 0 else { return UIImage(ciImage: outputImage) }

        let scaleTransform = CGAffineTransform(scaleX: scale, y: scale)
        let scaledImage: CIImage = outputImage.transformed(by: scaleTransform)
        return UIImage(ciImage: scaledImage)
    }
    
}
