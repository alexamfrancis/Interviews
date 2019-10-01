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
//        UIImage(named: "QRCode")
        guard let image = self.generateQRCode(from: self.qrCodeString) else {
            print("Failed to find the URL for the QR code")
            return  UIImage(named: "QRCode")!
        }
        return image
//        return UIImage.image(forQRCodeString: self.qrCodeString) // This didn't work
    }
    
    var body: some View {
        NavigationView {
            Image(uiImage: self.qrImage).resizable()
            .frame(width: 300, height: 300, alignment: .center)
            .border(Color.black, width: 2)
            .navigationBarItems(trailing: Button(action: { self.onDismiss() }) { Text("Done") })
        }
    }
    
//    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
//    }
    
    func generateQRCode(from string: String) -> UIImage? {
//        let data = string.data(using: String.Encoding.ascii)
//
//        if let filter = CIFilter(name: "CIQRCodeGenerator") {
//            filter.setValue(data, forKey: "inputMessage")
//            let transform = CGAffineTransform(scaleX: 3, y: 3)
//
//            if let output = filter.outputImage?.transformed(by: transform) {
//                return UIImage(ciImage: output)
//            }
//        }
//
//        return nil
        
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
        guard let cgImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)

    }
    
//    private func downloadImage(from url: URL) -> UIImage {
//        print("Download Started")
//        var image = UIImage()
//        self.getData(from: url) { data, response, error in
//            guard let data = data, error == nil else { return }
//            print(response?.suggestedFilename ?? url.lastPathComponent)
//            print("Download Finished")
//            DispatchQueue.main.async() {
//                image = QRCodeView(onDismiss: <#T##() -> ()#>, qrCodeString: <#T##String#>)
//                image = UIImage(data: data)!
//            }
//        }
//        return image
//    }
}

#if DEBUG
struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView(onDismiss: {}, qrCodeString: "")
    }
}
#endif
