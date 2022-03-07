//
//  RidesApi.swift
//  Edvora
//
//  Created by Aakash Sinha on 04/03/22.
//

import Foundation
import Combine


enum rideDB {
    static let apiClient = APIClient()
    static let baseUrl = URL(string: "https://assessment.api.vweb.app/")!
}

enum APIPath: String {
    case user = "user"
    case rides = "rides"
}

extension rideDB {
    
    static func request(_ path: APIPath) -> AnyPublisher<[Ride], Error> {
        // 3
        guard var components = URLComponents(url: baseUrl.appendingPathComponent(path.rawValue), resolvingAgainstBaseURL: true)
            else { fatalError("Couldn't create URLComponents") }
        components.queryItems = [URLQueryItem(name: "api_key", value: "your_api_key_here")] // 4
        
        let request = URLRequest(url: components.url!)
        
        return apiClient.run(request) // 5
            .map(\.value) // 6
            .eraseToAnyPublisher() // 7
    }
    
 
    
    
}
