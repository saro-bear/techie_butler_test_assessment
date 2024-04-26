//
//  NetworkManager.swift
//  TaskAssessment
//
//  Created by SARO BEAR on 26/04/24.
//  Copyright © 2024 TechieButler. All rights reserved.
//

import Combine
import SwiftUI

enum JsonAPI {
        
    static func loadUsers() -> AnyPublisher<[User], Error> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .handleEvents(receiveOutput: { print(NSString(data: $0.data, encoding: String.Encoding.utf8.rawValue)!) })
            .tryMap { try JSONDecoder().decode([User].self, from: $0.data) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class UserListViewModel: ObservableObject {
    
    @Published private(set) var state = State()
    private var subscriptions = Set<AnyCancellable>()
    
    func fetchNextPageIfPossible() {
                
        JsonAPI.loadUsers()
            .sink(receiveCompletion: onReceive,
                  receiveValue: onReceive)
            .store(in: &subscriptions)
    }
    
    private func onReceive(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure:
            break
        }
    }

    private func onReceive(_ batch: [User]) {
        state.users += batch
    }

    struct State {
        var users: [User] = []
    }
}
