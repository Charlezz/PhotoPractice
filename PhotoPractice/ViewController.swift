//
//  ViewController.swift
//  PhotoPractice
//
//  Created by Charles on 2016. 4. 24..
//  Copyright © 2016년 Charles. All rights reserved.
//

import UIKit
import MobileCoreServices

import AVKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var mImage: UIImageView!
    
    
    let isCameraEditingMode = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func pickPhoto(sender: AnyObject) {
        var ac = UIAlertController(title: "카메라", message: "원하는 메뉴를 선택해주세요", preferredStyle: .ActionSheet)
        
        ac.addAction(UIAlertAction(title: "카메라", style: .Default, handler: { (UIAlertAction) in
            NSLog("카메라")
            self.takePhotoOrMovie()
        }))
        ac.addAction(UIAlertAction(title: "갤러리", style: .Default, handler: { (UIAlertAction) in
            NSLog("갤러리")
            self.pickPhotoOrMovieFromGallery()
        }))
        ac.addAction(UIAlertAction(title: "취소", style: .Destructive, handler: { (UIAlertAction) in
            NSLog("종료")
        }))
        
        self.presentViewController(ac, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("취소하였습니다")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("didFinishPickingMediaWithInfo")
        
        
        
        let mediaType = info[UIImagePickerControllerMediaType]
        
        if mediaType!.isEqual(kUTTypeImage){
            print("이미지는 여기에...")
            
            var image:UIImage? = nil
            
            if isCameraEditingMode{
                let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
                image = editedImage
            }else{
                let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
                image = originalImage
            }
            
            if let temp = image {
                mImage.image = temp
                UIImageWriteToSavedPhotosAlbum(temp, self, #selector(onResult), nil)
            }
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }else if mediaType!.isEqual(kUTTypeMovie){
            print("동영상은 여기에...")
            let url = info[UIImagePickerControllerMediaURL] as! NSURL
            self.dismissViewControllerAnimated(true, completion: nil)
            
            if !isFromGallery {
                UISaveVideoAtPathToSavedPhotosAlbum(url.path!, self, #selector(onResult), nil)

                
                let player = AVPlayer(URL: url)
                let playerController = AVPlayerViewController()
                playerController.player = player
                self.presentViewController(playerController, animated: true, completion: nil)
            }

        }
        
        
        
        
        
    }
    
    
    
    var isFromGallery = false
    
    func takePhotoOrMovie(){
        
        isFromGallery = false
        if !checkValid() {
            return
        }
        
        
        var picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = isCameraEditingMode
        picker.sourceType = .Camera
        picker.mediaTypes = [kUTTypeImage as! String, kUTTypeMovie as! String]
        self.presentViewController(picker, animated: true, completion: nil)
        
    }
    
    func pickPhotoOrMovieFromGallery(){
        isFromGallery = true
        var picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = isCameraEditingMode
        picker.sourceType = .PhotoLibrary
        picker.mediaTypes = [kUTTypeImage as! String, kUTTypeMovie as! String]
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func checkValid() -> Bool{
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            
            return true
        }else{
            let ac = UIAlertController(title: "미지원디바이스", message: "카메라를 사용할 수 없습니다.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "확인", style: .Cancel, handler: nil))
            self.presentViewController(ac, animated: true, completion: nil)
            return false
        }
    }
    
    func onResult(image: UIImage, didFinishSavingWithError error:NSErrorPointer, contextInfo:UnsafePointer<Void>){
        if error != nil{
            //오류가 있다면 이곳으로 진행
            print("저장실패:"+error.debugDescription)
        }else{
            print("저장성공")
        }
    }

    
}

