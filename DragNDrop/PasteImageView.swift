//
//  PasteImageView.swift
//  DragNDrop
//
//  Created by Jaeyoung Choi on 2017. 7. 4..
//  Copyright © 2017년 Appcid. All rights reserved.
//

import UIKit

class PasteImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPasteConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupPasteConfiguration()
    }
    
    func setupPasteConfiguration() {
        isUserInteractionEnabled = true
        
        pasteConfiguration = UIPasteConfiguration(forAccepting: UIImage.self)
    }
    
    override func paste(itemProviders: [NSItemProvider]) {
        if let item = itemProviders.first {
            loadImage(itemProvider: item)
        }
    }
    
    func loadImage(itemProvider: NSItemProvider) {
        itemProvider.loadObject(ofClass: UIImage.self) { (object, _) in
            DispatchQueue.main.async {
                self.image = object as? UIImage
            }
        }
    }
}
