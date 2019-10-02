//
//  QRCodeView.swift
//  QR8SwiftUI
//
//  Created by SopanSharma on 9/30/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import SwiftUI

struct QRCodeView: View {
    
    var onDismiss: () -> ()
    var qrCodeString: String
    
    var qrImage: UIImage {
        let image: UIImage
        DispatchQueue.main.async {
            guard let qrCode = self.generateQRCode(from: self.qrCodeString) as? UIImage else {
                print("Failed to find the URL for the QR code")
                return
            }
            image = qrCode
        }
        return image ?? 
    }
    
    var body: some View {
            NavigationView {
                Image(uiImage: self.qrImage).resizable(resizingMode: Image.ResizingMode.stretch)
                .frame(width: 300, height: 300, alignment: .center)
                .border(Color.black, width: 2)
                .navigationBarItems(trailing: Button(action: { self.onDismiss() }) { Text("Done") })
        }
    }
    
    func generateQRCode(from string: String) -> UIImage? {
//        var image: UIImage
        // Get define string to encode
        let myString = "https://pennlabs.org"
        // Get data from the string
        let data = myString.data(using: String.Encoding.ascii)
        // Get a QR CIFilter
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        // Input the data
        qrFilter.setValue(data, forKey: "inputMessage")
        // Get the output image
        guard let qrImage = qrFilter.outputImage else { return nil }
        // Scale the image
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledQrImage = qrImage.transformed(by: transform)
        // Invert the colors
        guard let colorInvertFilter = CIFilter(name: "CIColorInvert") else { return nil }
        colorInvertFilter.setValue(scaledQrImage, forKey: "inputImage")
        guard let outputInvertedImage = colorInvertFilter.outputImage else { return nil }
        // Replace the black with transparency
        guard let maskToAlphaFilter = CIFilter(name: "CIMaskToAlpha") else { return nil }
        maskToAlphaFilter.setValue(outputInvertedImage, forKey: "inputImage")
        guard let outputCIImage = maskToAlphaFilter.outputImage else { return nil }
        // Do some processing to get the UIImage
        let context = CIContext()
        context.clearCaches()
        guard let cgImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else { return nil }
//        DispatchQueue.main.async() {
//            image = UIImage(cgImage: cgImage)
//        }
        return UIImage(cgImage: cgImage)

    }
}

#if DEBUG
struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView(onDismiss: {}, qrCodeString: "")
    }
}
#endif
