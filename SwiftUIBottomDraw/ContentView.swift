//
//  ContentView.swift
//  SwiftUIBottomDraw
//
//  Created by femi alaka on 23/06/2022.
//

import SwiftUI

struct ContentView: View {
    static let startWidth = UIScreen.main.bounds.size.width
    static let startHeight = UIScreen.main.bounds.size.height / 12
    @State private var dragWidth : CGFloat = startWidth
    @State private var dragHeight : CGFloat = startHeight
    
    // keeps the panes a reasonable size based on device resolution
    var minWidth : CGFloat = UIScreen.main.bounds.size.width / 6
    let minHeight : CGFloat = UIScreen.main.bounds.size.height / 12
    let maxHeight : CGFloat = UIScreen.main.bounds.size.height / 4
    let maxDragHeight : CGFloat = UIScreen.main.bounds.size.height * 0.8
    let screenWidth : CGFloat = UIScreen.main.bounds.size.width
    
    @State private var showBottomModal = false
    @State private var bottomModalLabel = "Activate Bottom Modal"
    
    // purple and orange grips are this thick
    let thickness : CGFloat = 9
    
    
    // use computed properties to keep the body tidy
    var body: some View {
        
        VStack(spacing: 0) {
            mainContent
            dragHandle
            
            VStack(spacing: 0) {
                ZStack {
                    Color.blue.edgesIgnoringSafeArea(.all)
                    Text("Bottom Modal").font(.title2).bold()
                }
            }
            .frame(height: dragHeight, alignment: .center)
        }
        
        .frame(width: dragWidth)
    }
    
    var mainContent : some View {
        ZStack(alignment: .center) {
            Color.green.edgesIgnoringSafeArea(.all)
            VStack{
                Text("Main Content").font(.largeTitle).bold()
                Button(bottomModalLabel) {
                    showBottomModal.toggle()
                    if showBottomModal {
                        dragHeight = maxDragHeight / 2
                        bottomModalLabel = "Close Bottom Modal"
                    }
                    else {
                        dragHeight = ContentView.startHeight
                        bottomModalLabel = "Activate Bottom Modal"
                    }
                }
                .font(.title2)
                .foregroundColor(Color.white)
                .padding()
                
               
            }
        }
    }
    
    
    var dragHandle : some View {
        Image(systemName: "line.3.horizontal")
            .padding(.top, 6)
            .foregroundColor(Color.white)
            .font(.system(size: 28.0))
            .frame(width: self.screenWidth)
            .background(Color.blue)
        
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        let screenHeight = UIScreen.main.bounds.size.height
                        let delta = gesture.translation.height
                        dragHeight = max(dragHeight - delta, minHeight)
                        dragHeight = min(screenHeight - thickness - maxHeight, dragHeight)
                    }
            )
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

