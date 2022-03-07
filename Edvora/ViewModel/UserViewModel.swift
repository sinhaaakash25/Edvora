//
//  UserViewModel.swift
//  Edvora
//
//  Created by Aakash Sinha on 07/03/22.
//

import Foundation
import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    
    @Published var userStationCode: Int = 0
    @Published var userPhoto: String = ""
    @Published var userName: String = ""
    var cancellationToken: AnyCancellable?
    
    init() {
        getUser()
    }
    
}

extension UserViewModel {
    // Subscriber implementation
    func getUser() {
        cancellationToken = userDB.request(.user)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                self.userStationCode = $0.stationCode
                self.userPhoto = $0.profile
                self.userName = $0.name
            })
    }
}
