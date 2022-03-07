//
//  ContentView.swift
//  Edvora
//
//  Created by Aakash Sinha on 04/03/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userViewModel = UserViewModel()
    @State private var isExpanded: Bool = false
    @ObservedObject var viewModel = RidesViewModel()
    @State private var tabSelected = 0
    
    var body: some View {
        
        HStack {
            
            Text("Edvora")
                .bold()
                .font(.system(size: 44))
            
            Spacer()
            
            AsyncImage(url: URL(string: userViewModel.userPhoto)) {
                phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                        .frame(width:40, height: 40)
                        .clipShape(Circle())
               
                case .empty:
                    ProgressView()
                case .failure(_):
                    
                    EmptyView()
                @unknown default:
                    EmptyView()
                }
                
            }
        }
        .frame(height: 100)
        .padding(.horizontal)
        
        HStack(spacing: 12) {
            Picker("What is your favorite color?", selection: $tabSelected) {
                Text("Nearest(12)").tag(0)
                Text("Upcoming(0)").tag(1)
                Text("Past(7)").tag(2)
            }
            .pickerStyle(.segmented)
            
            
            
            Menu {
                Button(action: {
                    filterByState()
                }) {
                    HStack {
                        Text("State")
                        Image(systemName: "chevron.down")
                    }
                }
                Button(action: {
                    filterByCity()
                }) {
                    HStack {
                        Text("City")
                        Image(systemName: "chevron.down")
                    }
                }
            } label: {
                HStack(spacing: 5) {
                    
                    Image("Vector")
                        .resizable()
                        .frame(width: 15.0, height: 15.0)
                    Text("Filter")
                }
                
            }
        }.padding(.horizontal)
        
        if tabSelected == 0 {
            List(viewModel.rideSorted, id: \.self) { ride in
                
                CardView(isExpanded: isExpanded, ride: ride)
                    .contentShape(Rectangle())
                    .onTapGesture{
                        withAnimation{
                            self.isExpanded.toggle()
                        }
                        
                        
                    }
                    .shadow(color: .white, radius: 3, x: -2, y: 2)
                
                    .edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: UIScreen.main.bounds.width , maxHeight: 300)
                    .padding(.vertical)
                
            }
            
            .listStyle(.plain)
            
            
        }
        
        else if tabSelected == 1 {
            List(viewModel.rideSorted, id: \.self) { ride in
                
                if isSameDay(date1: ride.date , date2: Date.now)
                {
                    CardView(isExpanded: isExpanded, ride: ride)
                        .contentShape(Rectangle())
                        .onTapGesture{
                            withAnimation{
                                self.isExpanded.toggle()
                            }
                            
                            
                        }
                        .shadow(color: .white, radius: 3, x: -2, y: 2)
                        .edgesIgnoringSafeArea(.all)
                        .frame(maxWidth: UIScreen.main.bounds.width , maxHeight: 300)
                        .padding(.vertical)
                    
                }
            }
            .listStyle(.plain)
        }
        
        else if tabSelected == 2 {
            List(viewModel.rideSorted, id: \.self) { ride in
                
                if !isSameDay(date1: ride.date , date2: Date.now)
                {
                    CardView(isExpanded: isExpanded, ride: ride)
                        .contentShape(Rectangle())
                        .onTapGesture{
                            withAnimation{
                                self.isExpanded.toggle()
                            }
                            
                            
                        }
                        .shadow(color: .white, radius: 3, x: -2, y: 2)
                        .edgesIgnoringSafeArea(.all)
                        .frame(maxWidth: UIScreen.main.bounds.width , maxHeight: 300)
                        .padding(.vertical)
                    
                }
            }
            .listStyle(.plain)
        }
        
    }
    func isSameDay(date1: String, date2: Date) -> Bool {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "MM/dd/yyyy HH:mm a"
        let date = dateformat.date(from: date1)
        
        if date! > date2 {
            return true
        }
        else {
            return false
        }
        
    }

    func filterByState() { }
    func filterByCity() { }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}


struct ImageOverlay: View {
    let distance: Int
    var body: some View {
        ZStack {
            Text("\(distance) km")
                .font(.callout)
                .padding(6)
                .foregroundColor(.white)
        }.background(Color.blue)
            .opacity(0.8)
            .cornerRadius(10.0)
            .padding(6)
    }
}




