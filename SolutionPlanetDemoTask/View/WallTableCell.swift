//
//  WallTableCell.swift
//  SolutionPlanetDemoTask
//
//  Created by Kondya on 13/5/18.
//  Copyright © 2018 Kondya. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
class WallTableCell: UITableViewCell {


    
    @IBOutlet weak var userNameLbl: UILabel!
    
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image1W: NSLayoutConstraint!
     @IBOutlet weak var image1H: NSLayoutConstraint!
    
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var image2W: NSLayoutConstraint!
    @IBOutlet weak var image2H: NSLayoutConstraint!
    
    
    @IBOutlet weak var image3: UIImageView!
    
    @IBOutlet weak var image3W: NSLayoutConstraint!
    @IBOutlet weak var image3H: NSLayoutConstraint!
    
    
    @IBOutlet weak var image4: UIImageView!
    
    @IBOutlet weak var image4W: NSLayoutConstraint!
    @IBOutlet weak var image4H: NSLayoutConstraint!
    
    
    @IBOutlet weak var firstLastNameLbl: UILabel!
    @IBOutlet weak var dateAndTimeLbl: UILabel!
    @IBOutlet weak var descrptionLbl: UILabel!
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var videoAndPostBackView: PlayerView!
    
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        self.image1W.constant = 0
        self.image1H.constant = 0
        self.image2W.constant = 0
        self.image2H.constant = 0
        self.image3W.constant = 0
        self.image3H.constant = 0
        self.image4W.constant = 0
        self.image4H.constant = 0
        self.countLbl.layer.shadowColor = UIColor.black.cgColor
        self.countLbl.layer.shadowRadius = 3.0
        self.countLbl.layer.shadowOpacity = 1.0
        self.countLbl.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.countLbl.layer.masksToBounds = false
    }
    func setDataModel(model:WallDataModel)  {
    
        self.userNameLbl.text = "@\(model.userName ?? "")"
        self.countLbl.isHidden  = true
        self.firstLastNameLbl.text = "\(model.firstName ?? "") \(model.lastName ?? "")"
        self.dateAndTimeLbl.text = model.postTimeAndDate ?? ""
        self.descrptionLbl.text = model.descrption ?? ""
        self.userProfileImageView.image = UIImage(named: "profileDemo")
        self.userProfileImageView.downloadImageFrom(link: model.userProfileImageUrl ?? "", contentMode: .scaleAspectFill)
        self.userProfileImageView.layer.cornerRadius = self.userProfileImageView.frame.width/2
        self.userProfileImageView.layer.borderWidth = 1
        self.userProfileImageView.layer.borderColor = UIColor.darkGray.cgColor
        //self.heightConstraint.constant = 0
        self.videoAndPostBackView.isHidden = true
        
        
        self.image1.isHidden = false
        self.image2.isHidden = false
        self.image3.isHidden = false
        self.image4.isHidden = false
        if model.postImageUrlArray?.count != 0
        {
            self.videoAndPostBackView.isHidden = false
            //self.heightConstraint.constant = 280
            //self.heightConstraint.constant
           
            if model.postImageUrlArray?.count == 1
            {
                self.image1.isHidden = false
                self.image2.isHidden = true
                self.image3.isHidden = true
                self.image4.isHidden = true
                self.image2W.constant = 0
                self.image2H.constant = 0
                self.image3W.constant = 0
                self.image3H.constant = 0
                self.image4W.constant = 0
                self.image4H.constant = 0
                self.image1W.constant = self.videoAndPostBackView.frame.width-2.5
                self.image1H.constant = self.videoAndPostBackView.frame.height-2.5
                
                self.image1.downloadImageFrom(link: model.postImageUrlArray![0], contentMode: .scaleAspectFill)
                
            }
            else
                if model.postImageUrlArray?.count == 2
            {
                
                self.image1.isHidden = false
                self.image2.isHidden = false
                self.image3.isHidden = true
                self.image4.isHidden = true
                self.image3W.constant = 0
                self.image3H.constant = 0
                self.image4W.constant = 0
                self.image4H.constant = 0
                
                self.image1W.constant = (self.videoAndPostBackView.frame.width/2)-2.5
                self.image1H.constant = self.videoAndPostBackView.frame.height-2.5
                
                self.image2W.constant = (self.videoAndPostBackView.frame.width/2)-2.5
                self.image2H.constant = self.videoAndPostBackView.frame.height-2.5
                
                self.image1.downloadImageFrom(link: model.postImageUrlArray![0], contentMode: .scaleAspectFill)
                self.image2.downloadImageFrom(link: model.postImageUrlArray![1], contentMode: .scaleAspectFill)
            }
            else
                if model.postImageUrlArray?.count == 3
            {
                self.image1.isHidden = false
                self.image2.isHidden = true
                self.image3.isHidden = false
                self.image4.isHidden = false
                self.image2W.constant = 0
                self.image2H.constant = 0
                self.image1W.constant = (self.videoAndPostBackView.frame.width)-2.5
                self.image1H.constant = (self.videoAndPostBackView.frame.height/2)-2.5
                
                self.image3W.constant = (self.videoAndPostBackView.frame.width/2)-2.5
                self.image3H.constant = (self.videoAndPostBackView.frame.height/2)-2.5
                
                self.image4W.constant = (self.videoAndPostBackView.frame.width/2)-2.5
                self.image4H.constant = (self.videoAndPostBackView.frame.height/2)-2.5
    
                
                
                self.image1.downloadImageFrom(link: model.postImageUrlArray![0], contentMode: .scaleAspectFill)
                self.image3.downloadImageFrom(link: model.postImageUrlArray![1], contentMode: .scaleAspectFill)                
                self.image4.downloadImageFrom(link: model.postImageUrlArray![2], contentMode: .scaleAspectFill)
                
                
            }
            else
            {
                if (model.postImageUrlArray?.count)! > 4
                {
                    self.countLbl.text = "\((model.postImageUrlArray?.count)!-4)+"
                    self.countLbl.isHidden  = false
                }
                else
                {
                    self.countLbl.isHidden  = true
                }
                
                self.image1.isHidden = false
                self.image2.isHidden = false
                self.image3.isHidden = false
                self.image4.isHidden = false
                
                
                self.image1W.constant = (self.videoAndPostBackView.frame.width/2)-2.5
                self.image1H.constant = (self.videoAndPostBackView.frame.height/2)-2.5
                
                self.image2W.constant = (self.videoAndPostBackView.frame.width/2)-2.5
                self.image2H.constant = (self.videoAndPostBackView.frame.height/2)-2.5
                
                self.image3W.constant = (self.videoAndPostBackView.frame.width/2)-2.5
                self.image3H.constant = (self.videoAndPostBackView.frame.height/2)-2.5
                
                self.image4W.constant = (self.videoAndPostBackView.frame.width/2)-2.5
                self.image4H.constant = (self.videoAndPostBackView.frame.height/2)-2.5
                
                self.image1.downloadImageFrom(link: model.postImageUrlArray![0], contentMode: .scaleAspectFill)
                self.image2.downloadImageFrom(link: model.postImageUrlArray![1], contentMode: .scaleAspectFill)
                self.image3.downloadImageFrom(link: model.postImageUrlArray![2], contentMode: .scaleAspectFill)
                self.image4.downloadImageFrom(link: model.postImageUrlArray![3], contentMode: .scaleAspectFill)
               
            }
            
        }
        self.image1.layer.cornerRadius = 5
        self.image1.layer.borderWidth = 1
        self.image1.layer.borderColor = UIColor.white.cgColor
        self.image2.layer.cornerRadius = 5
        self.image2.layer.borderWidth = 1
        self.image2.layer.borderColor = UIColor.white.cgColor
        self.image3.layer.cornerRadius = 5
        self.image3.layer.borderWidth = 1
        self.image3.layer.borderColor = UIColor.white.cgColor
        self.image4.layer.cornerRadius = 5
        self.image4.layer.borderWidth = 1
        self.image4.layer.borderColor = UIColor.white.cgColor
        

    }
    
    
}






class WallTableCell1: UITableViewCell {
    
    
    
    
   
    @IBOutlet weak var userNameLbl: UILabel!
    
    @IBOutlet weak var firstLastNameLbl: UILabel!
    @IBOutlet weak var dateAndTimeLbl: UILabel!
    @IBOutlet weak var descrptionLbl: UILabel!
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    func setDataModel(model:WallDataModel)  {
        
        self.userNameLbl.text = "@\(model.userName ?? "")"
        self.firstLastNameLbl.text = "\(model.firstName ?? "") \(model.lastName ?? "")"
        self.dateAndTimeLbl.text = model.postTimeAndDate ?? ""
        self.descrptionLbl.text = model.descrption ?? ""
        self.userProfileImageView.image = UIImage(named: "profileDemo")
        self.userProfileImageView.downloadImageFrom(link: model.userProfileImageUrl ?? "", contentMode: .scaleAspectFill)
        self.userProfileImageView.layer.cornerRadius = self.userProfileImageView.frame.width/2
        self.userProfileImageView.layer.borderWidth = 1
        self.userProfileImageView.layer.borderColor = UIColor.darkGray.cgColor
       
    }
    
    
}


class ImageViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var imageViewScroll: ImageScrollView!

}




class WallTableCellVideo: UITableViewCell {
    
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var firstLastNameLbl: UILabel!
    @IBOutlet weak var dateAndTimeLbl: UILabel!
    @IBOutlet weak var descrptionLbl: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var videoAndPostBackView: PlayerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    func setDataModel(model:WallDataModel)  {
        
        self.userNameLbl.text = "@\(model.userName ?? "")"
        self.firstLastNameLbl.text = "\(model.firstName ?? "") \(model.lastName ?? "")"
        self.dateAndTimeLbl.text = model.postTimeAndDate ?? ""
        self.descrptionLbl.text = model.descrption ?? ""
        self.userProfileImageView.image = UIImage(named: "profileDemo")
        self.userProfileImageView.downloadImageFrom(link: model.userProfileImageUrl ?? "", contentMode: .scaleAspectFill)
        self.userProfileImageView.layer.cornerRadius = self.userProfileImageView.frame.width/2
        self.userProfileImageView.layer.borderWidth = 1
        self.userProfileImageView.layer.borderColor = UIColor.darkGray.cgColor
      
        
    }
    
    
}
