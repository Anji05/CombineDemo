//
//  ManageCitiesView.swift
//  CombineDemo
//
//  Created by Anjali Aggarwal on 06/10/21.
//

import SwiftUI

struct ManageCitiesView: View {
    @State var isSearchActive: Bool = false
    
    @EnvironmentObject var user: UserSelectedCities
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var currentCity: MyCity?
    
    var backButton : some View {
        Button.init {
            dismiss()
        } label: {
            HStack(spacing: 0) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                Text("Back")
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(user.cities, id: \.self) { city in
                ZStack {
                    RoundedRectangle.init(cornerRadius: 10, style: .continuous)
                        .fill(Color.blue.opacity(0.5))
                    VStack {
                        Text(city.name ?? "")
                            .foregroundColor(.white)
                            .onTapGesture {
                                currentCity = city
                                dismiss()
                            }
                            .frame(height: 100)
                    }
                    .padding()
                }
                .swipeActions {
                    Button(role: .destructive) {
                        user.cities = user.cities.filter {$0 != city}
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            .listRowBackground(Color.clear)
            .listStyle(.plain)
            .listRowSeparator(.hidden, edges: .all)
        }
        
        .onAppear(perform: {
            print(user.cities)
        })
        .navigationTitle("Manage Cities")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button.init {
                    isSearchActive = true
                } label: {
                    Image.init(systemName: "magnifyingglass")
                }
                .tint(Color.gray)
                
            }
        }
        .sheet(isPresented: $isSearchActive) {
            //
        } content: {
            SearchLocationView(searchText: "")
        }
    }
}

struct ManageCitiesView_Previews: PreviewProvider {
    static var previews: some View {
        ManageCitiesView(currentCity: .constant(MyCity())).environmentObject(UserSelectedCities())
    }
}
