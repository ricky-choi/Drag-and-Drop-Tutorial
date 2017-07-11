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
            
            let dropInteraction = UIDropInteraction(delegate: self)
            imageView.addInteraction(dropInteraction)
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
        dragItem.localObject = dragImageView
        
        return [dragItem]
    }
}

extension ViewController: UIDropInteractionDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        if session.localDragSession != nil {
            return UIDropProposal(operation: .move)
        }
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        
        if let imageView = interaction.view as? PasteImageView, let dragItem = session.items.first {
            if session.localDragSession != nil {
                // move: delete and copy
                if let dragImageView = dragItem.localObject as? PasteImageView {
                    dragImageView.image = nil
                }
            } else {
                // copy
            }
            imageView.loadImage(itemProvider: dragItem.itemProvider)
        }
    }
}
