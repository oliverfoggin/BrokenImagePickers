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
    NavigationView {
        VStack(spacing: 20) {
          Text("""
Run this app on a device.
Tap a button to open either the old UIImagePickerViewController or the new PHPickerViewController.
When you enter into the search it will either crash out of the image picker or display an error.
""")
            .multilineTextAlignment(.leading)
            .padding(.init(top: 0, leading: 30, bottom: 0, trailing: 30))
          
          Group {
            if let image = image {
              Image(uiImage: image)
                .centerCropped()
            } else {
              Text("Select an image picker")
            }
          }
          .frame(width: 200, height: 200)
          .background(Color.gray)
          
          Button {
            self.showImagePicker = true
          } label: {
            Text("Old Image Picker")
          }
          
          Button {
            self.showPhotoPicker = true
          } label: {
            Text("New Photo Picker")
          }
          
          Spacer()
        }
        .navigationTitle("Broken Image Pickers")
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
