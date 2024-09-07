//
//  MovieCell.swift
//  Setflix
//
//  Created by Hemant Rajkumar Pancheshwar on 06/09/24.
//

import SwiftUI

struct MovieCell: View {
    let movie: MovieModel
    var body: some View {
        NavigationLink(destination: MovieDetailsView(movie: movie)) {
            HStack{
                AsyncImage(url: URL(string: movie.poster)) { image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "film")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 75)
                        .cornerRadius(8)
                        .background(Color.gray.opacity(0.2))
                }
                .frame(width: 50, height: 75)
                VStack(alignment: .leading){
                    Text(movie.title)
                        .font(.headline)
                    Text("Release date: 2024")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                Spacer()
                Button(action: {
                    
                }){
                    Image(systemName: "heart")
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding()
        }
    }
}

#Preview {
    MovieCell(movie: MovieModel(title: "Example Movie", year: "2024", poster: "https://via.placeholder.com/150"))
}
