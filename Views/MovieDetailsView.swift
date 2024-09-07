//
//  MovieDetailsView.swift
//  Setflix
//
//  Created by Hemant Rajkumar Pancheshwar on 05/09/24.
//

import SwiftUI

struct MovieDetailsView: View {
    let movie: MovieModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: movie.poster)) { image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "film")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .background(Color.gray.opacity(0.2))
                }
                .frame(height: 300)
                .cornerRadius(10)
                .padding()
                
                Text(movie.title) // Replace with actual title
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                
                Text("Genre: Action, Drama") // Replace with actual genre
                    .font(.subheadline)
                    .padding(.horizontal)
                    .foregroundColor(.gray)
                
                Text("Rating: 8.5/10") // Replace with actual rating
                    .font(.subheadline)
                    .padding(.horizontal)
                    .foregroundColor(.gray)
                
                Text("Description goes here. This is a placeholder for the movie's detailed description.")
                    .padding()
            }
        }
        .navigationTitle("Movie Details")
    }
}

#Preview {
    MovieDetailsView(movie: MovieModel(title: "Example Movie", year: "2024", poster: "https://via.placeholder.com/150"))
}
