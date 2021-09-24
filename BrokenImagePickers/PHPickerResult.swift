//
//  PHPickerResult.swift
//  BrokenImagePickers
//
//  Created by Foggin, Oliver (Developer) on 24/09/2021.
//

import PhotosUI
import Combine

extension PHPickerResult {
  func loadImage() -> Future<UIImage?, Never> {
    return Future { promise in
      guard case let provider = self.itemProvider,
            provider.canLoadObject(ofClass: UIImage.self) else {
              return promise(.success(nil))
            }
      
      provider.loadObject(ofClass: UIImage.self) { image, error in
        guard let image =  image as? UIImage else {
          return promise(.success(nil))
        }
                
        return promise(.success(image))
      }
    }
  }
}
