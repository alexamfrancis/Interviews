//
//  ContentView.swift
//  QR8SwiftUI
//
//  Created by SopanSharma on 9/23/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented = false
    @State private var orderType = 0
    @State private var textViewText: String? = ""
    @State private var webOrderNumber: String = ""
    private let orderTypes = ["Custom", "APU", "PR"]
        
    var body: some View {
        VStack(spacing: 20) {
            Picker(selection: $orderType, label: Text("")) {
                ForEach(0..<self.orderTypes.count) { (index) in
                    Text(self.orderTypes[index]).tag(index)
                }
            }.edgesIgnoringSafeArea(.top)
            .pickerStyle(SegmentedPickerStyle())
            .frame(width: 300, height: 50, alignment: .leading)
            
            if self.orderType != 0 {
                TextField(" Web Order Number ", text: $webOrderNumber)
                .accessibility(identifier: "WebOrderNumber")
                .frame(width: 300, height: 40, alignment: .leading)
                .border(Color.black, width: 2)
            } else {
                TextView(text: $textViewText)
                .frame(width: 300, height: 100, alignment: .leading)
                .border(Color.black, width: 2)
                .multilineTextAlignment(.leading)
            }

            Button("Generate QR Code") {
                self.isPresented = true
            }
            
            Spacer()
        }.sheet(isPresented: $isPresented, onDismiss: {
            self.isPresented = false
        }) {
            QRCodeView(onDismiss: { self.isPresented = false }, qrCodeString: self.orderType == 0 ? self.textViewText ?? "" : self.webOrderNumber)
        }.padding()
    }
        
}

struct TextView : UIViewRepresentable {
    
    @Binding var text: String?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
        textView.text = text
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var field: TextView
        
        init(_ field: TextView) {
            self.field = field
        }
        
        func textViewDidChange(_ textView: UITextView) {
            field.text = textView.text
        }
    }
    
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
