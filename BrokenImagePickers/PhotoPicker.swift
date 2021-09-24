//
//  PhotoPicker.swift
//  BrokenImagePickers
//
//  Created by Foggin, Oliver (Developer) on 24/09/2021.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
  @Environment(\.presentationMode) var presentationMode
  @Binding var photoPickerResult: PHPickerResult?
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoPicker>) -> some UIViewController {
    var config = PHPickerConfiguration()
    config.filter = .images
    config.selectionLimit = 1
    
    let picker = PHPickerViewController(configuration: config)
    picker.delegate = context.coordinator
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: PHPickerViewControllerDelegate {
    let parent: PhotoPicker
    
    init(_ parent: PhotoPicker) {
      self.parent = parent
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      parent.presentationMode.wrappedValue.dismiss()
      
      parent.photoPickerResult = results.first
    }
  }
}
