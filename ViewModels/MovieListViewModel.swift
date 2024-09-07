import Foundation
import SwiftUI
import Combine

class MovieListViewModel: ObservableObject {
    
    @Published var movies: [MovieModel] = []
    @Published var searchTerm: String = ""
    @Published var errorMessage: String?
    private let favouritesKey = "favourites"
    
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
                self?.movies = movies.map { movie in
                    var movie = movie
                    movie.isFavourite = self?.isFavourite(movie: movie) ?? false
                    return movie
                }
            }
            .store(in: &cancellables)
    }
    
    func toggleFavourite(movie: MovieModel) {
        var updatedMovie = movie
        updatedMovie.isFavourite.toggle()
        saveFavourite(movie: updatedMovie)
        
        // Update the movie list to reflect changes
        movies = movies.map { $0.id == movie.id ? updatedMovie : $0 }
    }
    
    private func saveFavourite(movie: MovieModel) {
        var Favourites = loadFavouritesFromDefaults()
        if movie.isFavourite {
            Favourites[movie.id.uuidString] = movie
        } else {
            Favourites.removeValue(forKey: movie.id.uuidString)
        }
        saveFavouritesToDefaults(Favourites: Favourites)
    }
    
    private func loadFavourites() {
        let Favourites = loadFavouritesFromDefaults()
        movies = movies.map { movie in
            var movie = movie
            movie.isFavourite = Favourites[movie.id.uuidString] != nil
            return movie
        }
    }
    
    private func loadFavouritesFromDefaults() -> [String: MovieModel] {
        guard let data = UserDefaults.standard.data(forKey: favouritesKey) else { return [:] }
        return (try? JSONDecoder().decode([String: MovieModel].self, from: data)) ?? [:]
    }
    
    private func saveFavouritesToDefaults(Favourites: [String: MovieModel]) {
        if let data = try? JSONEncoder().encode(Favourites) {
            UserDefaults.standard.set(data, forKey: favouritesKey)
        }
    }
    
    private func isFavourite(movie: MovieModel) -> Bool {
        let Favourites = loadFavouritesFromDefaults()
        return Favourites[movie.id.uuidString] != nil
    }
}
