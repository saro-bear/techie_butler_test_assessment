//
//  User.swift
//  TaskAssessment
//
//  Created by SARO BEAR on 26/04/24.
//  Copyright © 2024 TechieButler. All rights reserved.
//

import Foundation

struct User: Decodable, Identifiable, Hashable {
    var id: Int
    var userId: Int
    var title: String
    var body: String
}
