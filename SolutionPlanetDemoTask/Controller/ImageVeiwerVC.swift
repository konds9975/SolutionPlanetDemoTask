//
//  ImageVeiwerVC.swift
//  SolutionPlanetDemoTask
//
//  Created by Kondya on 13/10/18.
//  Copyright © 2018 Kondya. All rights reserved.
//

import UIKit

class ImageVeiwerVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

   
    @IBAction func closeBtnAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    var model : WallDataModel?
    
    var passImage : UIImage?
    
     @IBOutlet weak var imageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageTableView.delegate = self
            
        self.imageTableView.dataSource = self
        
        
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let _ = passImage
        {
            return 1
        }
        else
        {
            return model!.postImageUrlArray!.count-3
        }
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.imageTableView.dequeueReusableCell(withIdentifier: "ImageViewCell") as? ImageViewCell
        {
            
            if let _ = passImage
            {
               
                    DispatchQueue.main.async {
                            
                            cell.imageViewScroll.display(image: self.passImage!)
                            
                        }
                
                
                return cell
            }
            else
            {
            
            UIImageView().sd_setImage(with: URL(string: (model?.postImageUrlArray![indexPath.row+3])!), completed: { (image, error, cache, url) in
                if image != nil {
                    DispatchQueue.main.async {
                       
                        cell.imageViewScroll.display(image: image!)
                        
                    }
                } else {
                    print("didn't load image")
                }
            })
            
            return cell
            }
        }
        else
        {
            let cell = UITableViewCell()
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.imageTableView.frame.height
    }
}
