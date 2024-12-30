//
//  ContentView.swift
//  ImageTextSwiftUI
//
//  Created by Taras Prystupa on 30.12.2024.
//

import SwiftUI

struct DynamicImageTextOverlayView: View {
    // Define a state for dynamic text that will change based on user input
    @State private var dynamicText: String = "H"
    // Define the selected option for the dropdown menu and its initial value
    @State private var selectedOption: String = "Forest"
    // Define an array of options for the dwopdown menu
    let option = ["Forest", "River", "Wood", "Lake"]
    var body: some View {
        ZStack {
            // Add a semi-transparent black background that covers the entire screen
            Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
            // Vertival stack for text and overlayed image elements
            VStack(spacing: 0) {
                // Header text with orange empasis on specific words
                Text(
                    "Dynamic Image Text\n\(Text("with SwiftUI").foregroundStyle(.orange))"
                )
                .multilineTextAlignment(.center) // Center-align text lines
                .font(.system(size: 25)) // Set font size for the header
                .foregroundStyle(.white) // Set text color to white
                .bold() // Make text bold
                
                VStack(spacing: 0) { // Create a VStack to structure the image and controls more neatly
                    ZStack {
                        // Display an image based on selected option from the dropdown menu
                        Image("\((option.firstIndex(of: selectedOption)! + 1))") // Map the selected option to the corresponding image name
                            .resizable() // Make the image resizable
                            .aspectRatio(contentMode: .fit) // Keep the aspect ratio  intact
                            .frame(width: UIScreen.main.bounds.width - 40, height: 200) // Set the frame width and height
                            .mask { // Apply a text mask to the image, creating a text overlay effect
                                Text(dynamicText)
                                    .font(.system(size: 250))
                                    .shadow(
                                        color: .black.opacity(0.8),
                                        radius: 3
                                    ) // Add a shadow to the text
                                    .foregroundStyle(.white) // Set text color to white
                                    .lineLimit(1) // Limit text to one line
                                    .minimumScaleFactor(0.1) // Scale down text if necessary
                                    .padding(.horizontal, 20)
                                    .animation(
                                        .easeInOut(duration: 0.2),
                                        value: dynamicText
                                    ) // Apply animation to dynamic text changes
                            }
                    }
                    // Dropdown menu for image selection
                    VStack {
                        Picker("Select an Option", selection: $selectedOption) {
                            ForEach(option, id: \.self) { option in
                                Text(option).tag(option) // Add each option as a tag in the dropdown
                            }
                        }
                        .pickerStyle(MenuPickerStyle()) // Set style to menu-based picker
                        .padding(.horizontal, 40) // Horisontal padding to the picker
                        .background(Color.white.opacity(0.9)) // Background color white slight opacity
                        .clipShape(.rect(cornerRadius: 10)) // Rounded corners for the picker
                        .shadow(radius: 5) // Add shadow for depth effect
                        // TextField to change the overlay text dynamically
                        TextField("Enter text", text: $dynamicText)
                            .textFieldStyle(RoundedBorderTextFieldStyle()) // Style TextField with rounded borders
                            .padding(.horizontal, 30) // Horizontal padding for TextField
                            .shadow(radius: 5) // Shadow for depth effect
                    }
                }
                .padding(.vertical, 20) // Vertical padding for the inner VStack
                .background( // Background gradient fot the inner VStack
                    LinearGradient(
                        gradient: Gradient(
                            colors: [Color.black.opacity(0.6),
                                     Color.red.opacity(0.6)]),
                        startPoint: .top,
                        endPoint: .bottom)
                )
                .clipShape(.rect(cornerRadius: 10)) // Rounded corners for the entire VStack
                .padding() // Outer padding for the VStack
            }
        }
    }
    
}

struct ContentView: View {
    var body: some View {
        DynamicImageTextOverlayView()
    }
}


#Preview {
    ContentView()
}
