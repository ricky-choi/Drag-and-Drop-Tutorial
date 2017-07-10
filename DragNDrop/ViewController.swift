//
//  ViewController.swift
//  DragNDrop
//
//  Created by Jaeyoung Choi on 2017. 7. 4..
//  Copyright © 2017년 Appcid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageViews: [PasteImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDrag()
    }
    
    func setupDrag() {
        for imageView in imageViews {
            let dragInteraction = UIDragInteraction(delegate: self)
            dragInteraction.isEnabled = true // default if false, in iPhone
            
            imageView.addInteraction(dragInteraction)
        }
    }
}

extension ViewController: UIDragInteractionDelegate {
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        guard let dragImageView = interaction.view as? UIImageView, let dragImage = dragImageView.image else {
            return []
        }
        
        let itemProvider = NSItemProvider(object: dragImage)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        
        return [dragItem]
    }
}
