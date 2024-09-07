import Foundation
import SwiftUI
import Combine

class MovieListViewModel: ObservableObject {
    
    @Published var movies: [MovieModel] = []
    @Published var searchTerm: String = ""
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchTerm
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] term in
                guard !term.isEmpty else {
                    self?.movies = []
                    return
                }
                self?.fetchMovies(searchTerm: term)
            }
            .store(in: &cancellables)
    }
    
    func fetchMovies(searchTerm: String) {
        NetworkManager.shared.fetchMovies(searchTerm: searchTerm)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
       
                }
            } receiveValue: { [weak self] movies in
                self?.movies = movies
            }
            .store(in: &cancellables)
    }
}
