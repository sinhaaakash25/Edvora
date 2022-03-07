//
//  UserApi.swift
//  Edvora
//
//  Created by Aakash Sinha on 07/03/22.
//

import Foundation
import Combine

enum userDB {
    static let apiClient = APIClient()
    static let baseUrl = URL(string: "https://assessment.api.vweb.app/")!
}


extension userDB {
    
    static func request(_ path: APIPath) -> AnyPublisher<User, Error> {
        // 3
        guard var components = URLComponents(url: baseUrl.appendingPathComponent(path.rawValue), resolvingAgainstBaseURL: true)
            else { fatalError("Couldn't create URLComponents") }
        components.queryItems = [URLQueryItem(name: "api_key", value: "your_api_key_here")] // 4
        
        let request = URLRequest(url: components.url!)
        print(request)
        return apiClient.run(request) // 5
            .map(\.value) // 6
            .eraseToAnyPublisher() // 7
    }
    
 
    
    
}
