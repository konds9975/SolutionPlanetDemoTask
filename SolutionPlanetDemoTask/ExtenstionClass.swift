//
//  ExtenstionClass.swift
//  SolutionPlanetDemoTask
//
//  Created by Kondya on 13/10/18.
//  Copyright © 2018 Kondya. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIViewContentMode) {
    
        self.sd_setImage(with: URL(string: link), completed: { (image, error, cache, url) in
            if image != nil {
                DispatchQueue.main.async {
                self.image = image
                self.contentMode = contentMode
                     print("load image")
                self.isHidden = false
                }
            } else {
                print("didn't load image")
            }
        })
        
    }
}



import UIKit
import AVKit;
import AVFoundation;

class PlayerView: UIView {
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self;
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer;
    }
    
    var player: AVPlayer? {
        get {
            return playerLayer.player;
        }
        set {
            playerLayer.player = newValue;
        }
    }
}
