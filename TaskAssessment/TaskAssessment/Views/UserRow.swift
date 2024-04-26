//
//  UserRow.swift
//  TaskAssessment
//
//  Created by SARO BEAR on 26/04/24.
//  Copyright © 2024 TechieButler. All rights reserved.
//

import SwiftUI

struct UserRow: View {
    var user: User
    var body: some View {
        HStack {
            Text(String(user.id))
            Text(user.title)
        }
    }
}
