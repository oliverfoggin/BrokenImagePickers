//
//  ImagePicker.swift
//  BrokenImagePickers
//
//  Created by Foggin, Oliver (Developer) on 24/09/2021.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
  @Environment(\.presentationMode) var presentationMode
  @Binding var image: UIImage?
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> some UIViewController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let parent: ImagePicker
    
    init(_ parent: ImagePicker) {
      self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      parent.presentationMode.wrappedValue.dismiss()
      
      guard let image = info[.originalImage] as? UIImage else {
        return
      }
      
      parent.image = image
    }
  }
}
