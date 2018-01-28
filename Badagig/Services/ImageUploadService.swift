//
//  ImageUpload.swift
//  badagig
//
//  Created by Perfect Aduh on 08/10/2017.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import AWSS3




class ImageUploadService {
    
    static let instance = ImageUploadService()
    
    // AWS IOS SDK Image Upload
    
    func AWSImageUpload(image: UIImage) {
        let transferMannager = AWSS3TransferManager.default()
        
        guard let uploadRequest = AWSS3TransferManagerUploadRequest() else { return }
        uploadRequest.bucket = BUCKET
        
    
    }
    
    // AWS iOS SDK Image Download
    func AWSImageDownload(localFileName: String?, selectedImageUrl: NSURL){
        
    }

    // AWS Nodejs SDK image signed url upload
   func imageUpload(image: UIImage, completionHandler: @ escaping ImageUploadCallback ) {
        Alamofire.request(URL_UPLOAD_IMAGES, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_IMAGE_UPLOAD).responseJSON { (response) in
            if response.result.error == nil {
                guard let value = response.result.value else {
                    completionHandler(false, nil)
                    return }
                let json = JSON(value)
                let postUrl = json["postUrl"].stringValue
                let getUrl = json["getUrl"].stringValue
                self.performUpload(image: image, getUrl: getUrl, postUrl: postUrl, completionHandler: completionHandler)
            }else {
                debugPrint(response.result.error as Any)
                completionHandler(false, nil)
            }
        }
    }
    // AWS Nodejs SDK image signed url upload
    private func performUpload(image: UIImage, getUrl: String, postUrl: String, completionHandler: @escaping ImageUploadCallback) {
      //  guard let imageData = UIImageJPEGRepresentation(image, 0.1) else { return }
        if let imageData = UIImageJPEGRepresentation(image, 0.1) {
            print("Uploading")
            Alamofire.upload(imageData, to: postUrl, method: .put, headers: HEADER_IMAGE_UPLOAD).response { (response) in
                if response.error == nil {
                    completionHandler(true, getUrl)
                } else {
                    debugPrint(response.error as Any)
                    completionHandler(false, nil)
                    return
                }
            }
        }
    }
}
