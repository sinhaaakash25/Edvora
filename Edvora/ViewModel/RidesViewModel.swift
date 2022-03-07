//
//  RidesViewModel.swift
//  Edvora
//
//  Created by Aakash Sinha on 04/03/22.
//

import Foundation

import Combine
import SwiftUI

class RidesViewModel: ObservableObject {
    @Published var rides: [Ride] = []
    @ObservedObject var userModel = UserViewModel()
    @Published var rideSorted: [RideSorted] = []
    var cancellationToken: AnyCancellable? // 2
    
    init() {
        getRides()
        
    }
}

extension RidesViewModel {
    // Subscriber implementation
    func getRides() {
        cancellationToken = rideDB.request(.rides)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                self.rides = $0
                for i in self.rides {
                    let a = abs(40 - self.closestValue(i.stationPath, self.userModel.userStationCode))
                    self.rideSorted.append(RideSorted(id: i.id, distance: a, originStationCode: i.originStationCode, destinationStationCode: i.destinationStationCode, date: i.date, mapURL: i.mapURL, state: i.state, city: i.city, stationPath: i.stationPath ))
                }
                self.rideSorted = self.rideSorted.sorted()
               // print(self.rideSorted)
            })
    }
}

extension RidesViewModel {
    // Binary sorting for calculating nearest ride
    func closestValue(_ arr: [Int],_ target: Int) -> Int {
        guard arr.count > 0 else { fatalError("Array must not be empty") }
        guard arr.count > 1 else { return arr[0] }
        
        for index in 1..<arr.count {
            if arr[index - 1] > arr[index] {
                fatalError("Array must be monotonous increasing. Did you forget to sort it?")
            }
        }
        guard arr.first! <= target else { return arr.first! }
        guard target <= arr.last! else { return arr.last! }
        var left = 0
        var right = arr.count - 1
        
        while left < right {
            if left == right - 1 {
                return abs(arr[left] - target) <= abs(arr[right] - target) ? arr[left] : arr[right]
            }
            
            let middle = (left + right) / 2
            switch arr[middle] {
            case target:
                return target
            case ..<target:
                left = middle
            default:
                right = middle
            }
        }
        
        fatalError("It should never come here")
    }
}

    

