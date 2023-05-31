//
//  FavouritesHScrollView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import SwiftUI
import CoreData

struct FavouritesHScrollView: View {
    
    @StateObject var items = Athletes()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                
                ForEach(items.userFavourites) { athlete in
                    NavigationLink {
                        AthleteView(athlete: athlete)
                    } label: {
                        VStack {
                            Text(athlete.initials)
                                .foregroundColor(.white)
                                .font(.headline)
                                .frame(width: 50, height: 50)
                                .background(Color.gray)
                                .clipShape(Circle())
                            Text(athlete.shortName)
                                .font(.caption2)
                                .foregroundColor(.primary)
                        }
                    }
                }
                
                NavigationLink {
                    FavouritesListView()
                } label: {
                    VStack {
                        Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(width: 50, height: 50)
                        .background(Color.gray)
                        .clipShape(Circle())
                    Text("Favourites")
                        .font(.caption2)
                        .foregroundColor(.primary)
                    }
                }
            }
            .padding(.horizontal)
        }
        .task {
            do {
                try await items.getFavourites()
            } catch {
                print(error)
            }
        }
    }
}

struct FavouritesHScrollView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesHScrollView()
    }
}