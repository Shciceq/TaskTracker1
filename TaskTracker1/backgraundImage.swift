//
//  backgraundImage.swift
//  TaskTracker1
//
//  Created by Bohdan Harbuziuk on 5/15/25.
//

import SwiftUI

struct BackgroundImage: View {
    var body: some View {
        Image("Image")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}
