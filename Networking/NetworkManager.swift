import Foundation
import Combine


enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}

struct MovieResponse: Codable {
    let search: [MovieModel]

    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "http://www.omdbapi.com/"
    private let apiKey = "8c90706e"
    
    private init() {}
        
        func fetchMovies(searchTerm: String) -> AnyPublisher<[MovieModel], Error> {
            guard let url = URL(string: "\(baseUrl)?apikey=\(apiKey)&type=movie&s=\(searchTerm)") else {
                return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
            }
            
            return URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { data, response in
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw NetworkError.invalidResponse
                    }
                    return data
                }
                .decode(type: MovieResponse.self, decoder: JSONDecoder())
                .map { $0.search }
                .eraseToAnyPublisher()
        }
}


