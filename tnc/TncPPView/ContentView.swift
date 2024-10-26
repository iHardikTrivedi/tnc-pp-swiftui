//
//  ContentView.swift
//  TncPPView
//
//  Created by Hardik Trivedi on 26/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RPTermsCheck(
            textForPermission: "I agree to the terms & conditions and privacy policy.",
            arrClickableWord: [
               "terms & conditions",
               "privacy policy"
            ]
        ) { isTick in
                
            print("TICKED: \(isTick)")
        } clickSubPart: { uniqueId in
            
            print("WORD TAP: \(uniqueId)")
        }
        .padding(.all, 32.0)
    }
}

#Preview {
    ContentView()
}
