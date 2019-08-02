//
//  CustomPhotoAlbum.swift
//
//  Created by Jan Zelaznog on 10/09/18.
//  Copyright © 2018 janzelaznog.com. All rights reserved.
//

import UIKit
import Photos

class CustomPhotoAlbum: NSObject {
    //El álbum se llama como el proyecto
    //static let albumName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
   
    // CAMBIA EL NOMBRE DEL ALBUM AQUI
    static let albumName = "AppPhotos"
    static let shared = CustomPhotoAlbum()
    
    private override init() {
        super.init()
    }
    
    private func checkAuthorizationWithHandler(completion: @escaping ((_ success: Bool) -> Void)) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            completion(true)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(){ (status) in
                self.checkAuthorizationWithHandler(completion: completion)
            }
        case .denied, .restricted:
            completion(false)
        }
    }
    
    private func assetCollection() -> PHAssetCollection? {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", CustomPhotoAlbum.albumName)
        let fetch = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        return fetch.firstObject
    }
    
    @objc public func save(image: UIImage) {
        func saveIt(_ validAssets: PHAssetCollection){
            PHPhotoLibrary.shared().performChanges({
                let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
                let assetPlaceHolder = assetChangeRequest.placeholderForCreatedAsset
                let albumChangeRequest = PHAssetCollectionChangeRequest(for: validAssets)
                let enumeration: NSArray = [assetPlaceHolder!]
                albumChangeRequest!.addAssets(enumeration)
                
            }, completionHandler: nil)
        }
        self.checkAuthorizationWithHandler { (success) in
            if success {
                if let validAssets = self.assetCollection() { // Album already exists
                    saveIt(validAssets)
                } else {                                    // create an asset collection with the album name
                    PHPhotoLibrary.shared().performChanges({
                        PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: CustomPhotoAlbum.albumName)
                    }) { success, error in
                        if success, let validAssets = self.assetCollection() {
                            saveIt(validAssets)
                        } else {
                            print ("Sorry, unable to create album and save image...")
                        }
                    }
                }
            }
        }
    }
}

