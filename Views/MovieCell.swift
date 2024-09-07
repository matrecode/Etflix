import SwiftUI

struct MovieCell: View {
    @ObservedObject var viewModel: MovieListViewModel
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
                    viewModel.toggleFavourite(movie: movie)
                }){
                    Image(systemName: movie.isFavourite ? "heart.fill" : "heart")
                        .foregroundColor(movie.isFavourite ? .red : .gray)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding()
        }
    }
}

#Preview {
    MovieCell(viewModel: MovieListViewModel(),  movie: MovieModel(title: "Example Movie", year: "2024", poster: "https://via.placeholder.com/150"))
}
