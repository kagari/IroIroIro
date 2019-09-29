//
//  ContentView.swift
//  IroIro
//
//  Created by 大城昂希 on 2019/09/25.
//  Copyright © 2019 大城昂希. All rights reserved.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
//        let boxAnchor = try! Experience.loadBox()
        let catAnchor = try! Cat.load_Cat()
        
        // Add the box anchor to the scene
//        arView.scene.anchors.append(boxAnchor)
        arView.scene.anchors.append(catAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
