import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GyroscopeViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.attitudeData)
                .padding()
            
            Button("Land") {
                viewModel.sendLandCommand()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
