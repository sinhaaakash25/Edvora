//
//  DetailView.swift
//  Edvora
//
//  Created by Aakash Sinha on 07/03/22.
//

import SwiftUI

struct DetailView: View {
    
    var ride: RideSorted
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Ride ID")
                        .font(.system(size: 12))
                    Text("\(ride.id)")
                        .font(.system(size: 13))
    
                    Text("Date")
                        .font(.system(size: 12))
                    Text("\(convertToString(dateString: ride.date, formatIn:"MM/dd/yyyy HH:mm a", formatOut: "dd MMM"))")
                        .font(.system(size: 13))
                    Text("State")
                        .font(.system(size: 12))
                    Text(ride.state)
                        .font(.system(size: 13))
                    
                    Text("Station Path")
                        .font(.system(size: 12))
                    HStack {
                        ForEach(ride.stationPath, id: \.self) { i in
                            Text("\(i)")
                                .font(.system(size: 13))
                            
                        }
                    }
                    
                    
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Origin")
                        .font(.system(size: 12))
                    Text("\(ride.originStationCode)")
                        .font(.system(size: 13))
                    Text("Distance")
                        .font(.system(size: 12))
                    Text("\(ride.distance)")
                        .font(.system(size: 13))
                    Text("City")
                        .font(.system(size: 12))
                    Text(ride.city)
                        .font(.system(size: 13))
                }
            }
           
        }
        
        .frame(maxWidth: UIScreen.main.bounds.width , maxHeight: 300)
        .padding(.all)
        .background(Color.white)
        .clipped()
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


