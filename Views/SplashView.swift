import Foundation
import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            MovieListView()
        } else {
            VStack{
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                    isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
