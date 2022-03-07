//
//  CardView.swift
//  Edvora
//
//  Created by Aakash Sinha on 07/03/22.
//

import SwiftUI

struct CardView: View {
    var isExpanded: Bool
    var ride: RideSorted
    var body: some View {
        
        VStack {
            AsyncImage(url: URL(string: ride.mapURL)!) {
                phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(height: 80)
                case .success(let image):
                    image.resizable()
                        .frame(maxWidth: UIScreen.main.bounds.width , maxHeight: 200)
                        .overlay(ImageOverlay(distance: ride.distance), alignment: .bottomTrailing)
                    
                        .cornerRadius(15)
                case .failure:
                    EmptyView()
                    
                @unknown default:
                    
                    EmptyView()
                }
                Spacer()
            }
            
            
            HStack {
                Text("# \(ride.id)")
                
                Spacer()
                
                Text("\(convertToString(dateString: ride.date, formatIn:"MM/dd/yyyy HH:mm a", formatOut: "dd MMM"))")
            }
            
        }
        
        if isExpanded {
            DetailView(ride: ride)
                .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.cyan, lineWidth: 4)
                            .shadow(color: .white, radius: 3, x: -2, y: 2)
                    )
            
        }
    }
    func convertToString (dateString: String, formatIn : String, formatOut : String) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = formatIn
        let date = dateFormater.date(from: dateString)
        dateFormater.dateFormat = formatOut
        let timeStr = dateFormater.string(from: date!)
        return timeStr
    }
}
