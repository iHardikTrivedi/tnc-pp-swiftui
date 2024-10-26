//
//  RPTermsCheck.swift
//  TncPPView
//
//  Created by Hardik Trivedi on 26/10/24.
//

import SwiftUI

//  MARK: MAIN
struct RPTermsCheck: View {
    @State var isClicked: Bool = false
    
    var textForPermission: String
    var arrClickableWord: [String] = []
    
    var clickAction: (_ isTick: Bool) -> ()
    var clickSubPart: ((_ uniqueId: Int) -> ())?
    
    func breakString(_ text: String, phrases: [String]) -> [String] {
        var parts: [String] = []
        var currentString = text
        
        for phrase in phrases {
            if let range = currentString.range(of: phrase) {
                
                parts.append(String(currentString[..<range.lowerBound]))
                parts.append(String(currentString[range]))
                currentString = String(currentString[range.upperBound...])
            }
        }
        if !currentString.isEmpty {
            parts.append(currentString)
        }
        return parts
    }
    
    func shouldHighlight(_ index: Int, phrases: [String], parts: [String]) -> Bool {
        return phrases.contains(where: { $0 == parts[index] })
    }
    
    func shouldUnderline(_ index: Int, phrases: [String], parts: [String]) -> Bool {
        return shouldHighlight(index, phrases: phrases, parts: parts)
    }
    
    var body: some View {
        HStack(alignment: .top, content: {
            Button(action: {
                self.isClicked.toggle()
                clickAction(self.isClicked)
            }, label: {
                if isClicked {
                    Image("CheckTick")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .aspectRatio(contentMode: .fit)
                } else {
                    Image("CheckEmpty")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .aspectRatio(contentMode: .fit)
                }
            })
            
            if arrClickableWord.count > 0 {
                let parts = breakString(textForPermission, phrases: arrClickableWord)
                
                HStack {
                    ForEach(parts.indices, id: \.self) { index in
                        Text(parts[index])
                            .underline(shouldUnderline(index, phrases: arrClickableWord, parts: parts))
                            .foregroundColor(shouldHighlight(index, phrases: arrClickableWord, parts: parts) ? .blue : .black)
                            .font(shouldHighlight(index, phrases: arrClickableWord, parts: parts) ? .system(size: 16.0, weight: .bold) : .system(size: 16.0))
                            .onTapGesture {
                                if shouldHighlight(index, phrases: arrClickableWord, parts: parts) {
                                    clickSubPart?(index)
                                }
                            }
                    }
                }
            } else {
                Text(textForPermission)
                    .font(.system(size: 16.0))
                    .foregroundColor(.black)
            }
            Spacer()
        })
    }
}

#Preview {
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
}
