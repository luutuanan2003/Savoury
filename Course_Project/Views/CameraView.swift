//
//  ContentView.swift
//  Savoury
//
//  Created by An Luu on 9/10/24.
//

import SwiftUI
import Vision

struct CameraView: View {
    /// State to track whether the image picker sheet is presented (used for photo library or camera)
    @State var isPresenting: Bool = false
    
    /// State to store the selected image from the photo library or camera
    @State var uiImage: UIImage?
    
    /// State to store the selected source type (photo library or camera)
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    /// Array to store detected ingredients (classification results)
    @State var ingredients: [String]
    
    /// ObservedObject that holds the image classifier (used to classify images)
    @ObservedObject var classifier: ImageClassifier
    
    /// Define a confidence threshold of 10%
    private let confidenceThreshold: VNConfidence = 0.1
    
    var body: some View {
        VStack{
            Rectangle()
                .strokeBorder()
                .foregroundColor(.yellow)
                .overlay(
                    Group {
                        if uiImage != nil {
                            Image(uiImage: uiImage!)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                )
            Spacer()
            HStack{
                Image(systemName: "photo")
                    .onTapGesture {
                        isPresenting = true
                        sourceType = .photoLibrary
                    }
                
                Image(systemName: "camera")
                    .onTapGesture {
                        isPresenting = true
                        sourceType = .camera
                    }
            }
            .font(.title)
            .foregroundColor(.blue)
            
            Spacer()
            
            VStack{
                Button(action: {
                    if uiImage != nil {
                        classifier.detect(uiImage: uiImage!)
                    }
                }) {
                    Image(systemName: "bolt.fill")
                        .foregroundColor(.orange)
                        .font(.title)
                }
                
                
                Group {
                // Filter and display only results with confidence >= threshold
                    let filteredResults = classifier.allImageClasses.filter { $0.confidence >= confidenceThreshold }
                    
                    if !filteredResults.isEmpty {
                        VStack {
                            Text("Detected Objects:")
                                .font(.caption)
                            
                            ForEach(filteredResults, id: \.identifier) { result in
                                HStack {
                                    Text(result.identifier)
                                        .bold()
                                    Text(String(format: "%.2f", result.confidence * 100) + "% confidence")
                                    }
                                }
                            }
                        } else {
                        HStack{
                            Text("Image categories: NA")
                                .font(.caption)
                        }
                    }
                }
                .font(.subheadline)
                .padding()
            }
        }
        
        // Present the image picker sheet for photo library or camera
        .sheet(isPresented: $isPresenting){
            ImagePicker(uiImage: $uiImage, isPresenting:  $isPresenting, sourceType: $sourceType)
                .onDisappear{
                    if uiImage != nil {
                        classifier.detect(uiImage: uiImage!)
                    }
                }
        }
        
        // Button to append confident classifications to ingredients
                Button(action: {
                    let filteredResults = classifier.allImageClasses.filter { $0.confidence >= confidenceThreshold }
                    if !filteredResults.isEmpty {
                        for result in filteredResults {
                            ingredients.append(result.identifier) // Append detected objects with high confidence
                        }
                        print(ingredients)
                    } else {
                        print("No confident detections available.")
                    }
                }, label: {
                    Image(systemName: "bolt")
                })
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(ingredients: [""], classifier: ImageClassifier())
    }
}

