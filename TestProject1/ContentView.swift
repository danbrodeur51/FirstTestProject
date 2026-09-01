//
//  ContentView.swift
//  TestProject1
//
//  Created by Daniel Brodeur on 8/31/26.
//

import SwiftUI

struct ContentView: View {
    @State private var showHello = false
    var body: some View {
        TabView {
            ZStack{
                Color(.mint)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Image("track")
                      .resizable()
                      .scaledToFit()
                      .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                      .shadow(radius: 8)
                    
                    HStack{
                        Text("Come to the Track")
                            .font(.title)
                            .bold()
                        
                        Spacer()
                        
                        VStack{
                            HStack{
                                Image(systemName: "star.fill")
                                Image(systemName: "star.fill")
                                Image(systemName: "star.fill")
                                Image(systemName: "star")
                                
                                
                            }
                            Text("Reviews(2)")
                            
                        }
                        .foregroundStyle(.orange)
                        .font(.caption)
                        
                        
                    }
                    
                    Text("This is a great place to train")
                    
                    HStack{
                        Spacer()
                        Image(systemName: "binoculars.fill")
                    }
                    .foregroundStyle(.gray)
                    
                    Button {
                        showHello = true
                    } label: {
                        Text("Say Hello")
                            .font(.headline)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(.blue)
                            .foregroundStyle(.white)
                            .clipShape(Capsule())
                    }
                    .padding(.top, 12)
                }
                .padding()
                .background(){
                    Rectangle()
                        .foregroundStyle(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .padding()
            }
            .alert("Hello!", isPresented: $showHello) {
                Button("OK", role: .cancel) {}
            }
            StopwatchView()
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

#Preview {
    ContentView()
}

