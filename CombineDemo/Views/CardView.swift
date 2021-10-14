//
//  CardView.swift
//  CombineDemo
//
//  Created by Anjali Aggarwal on 28/09/21.
//

import Foundation
import SwiftUI

struct CardView: View {
    var date: String?
    var time: String?
    var temperature: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                       .fill(Color.blue)
            VStack {
                       Text(date ?? "")
                           .font(.title)
                           .foregroundColor(.black)
                       
                       Text(time ?? "")
                           .font(.title)
                           .foregroundColor(.black)

                       Text(temperature)
                           .font(.title2)
                           .foregroundColor(.gray)
                   }
                   .padding(20)
                   .multilineTextAlignment(.center)
               }
               .frame(width: 200, height: 250)
           }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(date: "", temperature: "45 C")
    }
}
