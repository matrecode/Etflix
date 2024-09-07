//
//  MovieListView.swift
//  Setflix
//
//  Created by Hemant Rajkumar Pancheshwar on 05/09/24.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject private var viewModel = MovieListViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                }
                
                
                if viewModel.movies.isEmpty {
                    Text("Search for any movie")
                        .padding()
                } else {
                    List(viewModel.movies) { movie in
                        MovieCell(viewModel: viewModel, movie: movie)
                    }
                }
            }
            .navigationTitle("Movies")
            .searchable(text: $viewModel.searchTerm, prompt: "Search Movies")
        }
        
    }
}

#Preview {
    MovieListView()
}
