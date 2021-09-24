//
//  ContentView.swift
//  BrokenImagePickers
//
//  Created by Foggin, Oliver (Developer) on 24/09/2021.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
  @State var showImagePicker = false
  @State var showPhotoPicker = false
  
  @State var image: UIImage?
  @State var photoPickerResult: PHPickerResult?
  
  var body: some View {
    VStack(spacing: 20) {
      if let image = image {
        Image(uiImage: image)
          .centerCropped()
          .frame(width: 200, height: 200)
      }
      
      Button {
        self.showImagePicker = true
      } label: {
        Text("Image Picker")
      }
      
      Button {
        self.showPhotoPicker = true
      } label: {
        Text("Photo Picker")
      }
    }
    .sheet(isPresented: self.$showImagePicker) {
      ImagePicker(image: self.$image)
    }
    .sheet(isPresented: self.$showPhotoPicker) {
      PhotoPicker(photoPickerResult: self.$photoPickerResult)
    }
    .onChange(of: photoPickerResult) { newValue in
      guard let itemProvider = newValue?.itemProvider,
            itemProvider.canLoadObject(ofClass: UIImage.self) else {
              return
            }
      
      itemProvider.loadObject(ofClass: UIImage.self) { image, error in
        guard let image = image as? UIImage else {
          print(error?.localizedDescription ?? "here")
          return
        }
        print(image)
        self.image = image
      }
    }
  }
}

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
