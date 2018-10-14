//
//  UserWallVC.swift
//  SolutionPlanetDemoTask
//
//  Created by Kondya on 13/10/18.
//  Copyright © 2018 Kondya. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
class UserWallVC: UIViewController {

    var isNewDataLoading = true
    
    func loadJsonFromBundel()
    {
        if self.wallDataArray.count == 0
        {
            self.myWallTableView.isHidden = true
        }
        if let path = Bundle.main.path(forResource: "postList", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                do {
                    let decoder = JSONDecoder()
                    let gitData = try decoder.decode(PostList.self, from: data)
                    print(gitData.post_list )
                    
                    
                    self.wallDataArray.append(contentsOf: gitData.post_list )
                    DispatchQueue.main.async {
                        self.myWallTableView.reloadData()
                        self.myWallTableView.isHidden = false
                        self.isNewDataLoading = true
                        if self.wallDataArray.count == 50
                        {
                            self.isNewDataLoading = false
                        }
                    }
                } catch let err {
                    print("Err", err)
                }
                
                
            } catch {
               
            }
        }

    }
    @IBOutlet weak var myWallTableView: UITableView!
    
    var wallDataArray = [WallDataModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.loadJsonFromBundel()

    }
    func setUpUI()  {
        self.myWallTableView.delegate = self
        self.myWallTableView.dataSource = self
        
       
    }

    override func viewDidLayoutSubviews() {
       
    
        
    }
}

//MARK:-TableViewDelegateAndDataSourecMethod
extension UserWallVC : UITableViewDataSource,UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wallDataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = self.wallDataArray[indexPath.row]
        
        if model.postVideoUrl == "" && model.postImageUrlArray?.count == 0
        {
            if let cell = self.myWallTableView.dequeueReusableCell(withIdentifier: "WallTableCell1") as? WallTableCell1
            {
                let profileImageTap = UITapGestureRecognizer(target: self, action: #selector(profileImageTaphandleTap))
                profileImageTap.numberOfTapsRequired = 1
                cell.userProfileImageView.addGestureRecognizer(profileImageTap)
                cell.userProfileImageView.isUserInteractionEnabled = true
                cell.userProfileImageView.tag = indexPath.row
                 cell.setDataModel(model: self.wallDataArray[indexPath.row])
                return cell
            }
            else
            {
                let cell = UITableViewCell()
                return cell
            }
        }
        else
        if model.postVideoUrl != ""
        {
            if let cell = self.myWallTableView.dequeueReusableCell(withIdentifier: "WallTableCellVideo") as? WallTableCellVideo
            {
                
                let model = self.wallDataArray[indexPath.row]
                
                let profileImageTap = UITapGestureRecognizer(target: self, action: #selector(profileImageTaphandleTap))
                profileImageTap.numberOfTapsRequired = 1
                cell.userProfileImageView.addGestureRecognizer(profileImageTap)
                cell.userProfileImageView.isUserInteractionEnabled = true
                cell.userProfileImageView.tag = indexPath.row
                cell.setDataModel(model: self.wallDataArray[indexPath.row])
                if model.postVideoUrl != ""
                {
                    if let videoURL = URL(string: model.postVideoUrl ?? "")
                    {
                        cell.videoAndPostBackView.isHidden = false
                       // cell.heightConstraint.constant = 280
                        let playerController = AVPlayerViewController()
                        let player = AVPlayer(url: videoURL)
                        playerController.player = player
                        
                        self.addChildViewController(playerController)
                        cell.videoAndPostBackView.addSubview((playerController.view)!)
                        playerController.view.frame = cell.videoAndPostBackView.bounds
                        
                    }
                }
                
                return cell
                
            }
            else
            {
                let cell = UITableViewCell()
                return cell
            }
        }
        else if let cell = self.myWallTableView.dequeueReusableCell(withIdentifier: "WallTableCell") as? WallTableCell
        {
            
            cell.setDataModel(model: self.wallDataArray[indexPath.row])
            cell.image1.isHidden = false
            cell.image2.isHidden = false
            cell.image3.isHidden = false
            cell.image4.isHidden = false
            
            let profileImageTap = UITapGestureRecognizer(target: self, action: #selector(profileImageTaphandleTap))
            profileImageTap.numberOfTapsRequired = 1
            cell.userProfileImageView.addGestureRecognizer(profileImageTap)
            cell.userProfileImageView.isUserInteractionEnabled = true
            cell.userProfileImageView.tag = indexPath.row
            
            
            let image1Tap = UITapGestureRecognizer(target: self, action: #selector(image1TaphandleTap))
            image1Tap.numberOfTapsRequired = 1
            cell.image1.addGestureRecognizer(image1Tap)
            cell.image1.isUserInteractionEnabled = true
            cell.image1.tag = indexPath.row
            
            let image3Tap = UITapGestureRecognizer(target: self, action: #selector(image3TaphandleTap))
            image3Tap.numberOfTapsRequired = 1
            
            let image4Tap = UITapGestureRecognizer(target: self, action: #selector(image4TaphandleTap))
            image4Tap.numberOfTapsRequired = 1
            
            let image2Tap = UITapGestureRecognizer(target: self, action: #selector(image2TaphandleTap))
            image2Tap.numberOfTapsRequired = 1
            cell.image2.tag = indexPath.row
            cell.image2.addGestureRecognizer(image2Tap)
            cell.image3.isUserInteractionEnabled = true
            cell.image2.isUserInteractionEnabled = true
            
            cell.image3.tag = indexPath.row
            cell.image4.tag = indexPath.row
            cell.image3.addGestureRecognizer(image3Tap)
            cell.image3.isUserInteractionEnabled = true
            
            cell.image4.addGestureRecognizer(image4Tap)
            cell.image4.isUserInteractionEnabled = true
            
            return cell
        }
        else
        {
            let cell = UITableViewCell()
            return cell
        }
        
        
        
    }
    
    
    @objc func profileImageTaphandleTap(_ sender: UITapGestureRecognizer) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageVeiwerVC") as! ImageVeiwerVC
        
        if let imaheView = sender.view as? UIImageView
        {
            vc.passImage = imaheView.image
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
  
    }
    
    
    @objc func image1TaphandleTap(_ sender: UITapGestureRecognizer) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageVeiwerVC") as! ImageVeiwerVC
       
        if let imaheView = sender.view as? UIImageView
        {
            vc.passImage = imaheView.image
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
        
       
        
        
    }
    
   
    
    
    
    @objc func image2TaphandleTap(_ sender: UITapGestureRecognizer) {
        
        
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageVeiwerVC") as! ImageVeiwerVC
        if let imaheView = sender.view as? UIImageView
        {
            vc.passImage = imaheView.image
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
        
        
    }
    @objc func image3TaphandleTap(_ sender: UITapGestureRecognizer) {
        
        
      
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageVeiwerVC") as! ImageVeiwerVC
         if let imaheView = sender.view as? UIImageView
            {
                vc.passImage = imaheView.image
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: true, completion: nil)
            }
        
        
        
        
        
    }
    @objc func image4TaphandleTap(_ sender: UITapGestureRecognizer) {
        
        
        let model = self.wallDataArray[(sender.view?.tag)!]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageVeiwerVC") as! ImageVeiwerVC
        
        if model.postImageUrlArray?.count == 3
        {
            UIImageView().sd_setImage(with: URL(string: (model.postImageUrlArray![2])), completed: { (image, error, cache, url) in
                if image != nil {
                    DispatchQueue.main.async {
                        
                        vc.passImage = image
                        vc.modalPresentationStyle = .overCurrentContext
                        self.present(vc, animated: true, completion: nil)
                    }
                } else {
                    print("didn't load image")
                }
            })
            
            
        }
        else
        if (model.postImageUrlArray?.count)! == 4
        {
            if let imaheView = sender.view as? UIImageView
            {
                vc.passImage = imaheView.image
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: true, completion: nil)
            }
        
        }
        else
        {
            vc.model = model
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
        
        
        
    }
   
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)  {
        
        //Bottom Refresh
        
        if scrollView == self.myWallTableView{
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                if isNewDataLoading{
                    
                    
                        isNewDataLoading = false
                        loadJsonFromBundel()
                }
            }
        }
    }

    
}















/*
 
 func loadData()  {
 
 if self.wallDataArray.count == 0
 {
 self.myWallTableView.isHidden = true
 }
 guard let gitUrl = URL(string: mainJsonFileUrl) else { return }
 URLSession.shared.dataTask(with: gitUrl) { (data, response
 , error) in
 guard let data = data else { return }
 do {
 let decoder = JSONDecoder()
 let gitData = try decoder.decode(PostList.self, from: data)
 print(gitData.post_list )
 
 
 self.wallDataArray.append(contentsOf: gitData.post_list )
 DispatchQueue.main.async {
 self.myWallTableView.reloadData()
 self.myWallTableView.isHidden = false
 self.isNewDataLoading = true
 if self.wallDataArray.count == 50
 {
 self.isNewDataLoading = false
 }
 }
 } catch let err {
 print("Err", err)
 }
 }.resume()
 }
 
  var mainJsonFileUrl = "https://www.dropbox.com/s/gfuc6mdqni8q57r/postList.json?dl=1"
 
 
 */
 
 
