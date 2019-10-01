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
        guard let url = URL(string: self.qrCodeString) else {
            print("Failed to find the URL for the QR code")
            return  UIImage(named: "QRCode") ?? UIImage()
        }
        return self.downloadImage(from: url)
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
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) -> UIImage {
        print("Download Started")
        var image = self
        self.getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                image = UIImage(data: data)!
            }
        }
        return image
    }
}

#if DEBUG
struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView(onDismiss: {}, qrCodeString: "")
    }
}
#endif
