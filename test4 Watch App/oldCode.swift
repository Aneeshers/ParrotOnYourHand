/*import SwiftUI

struct OldContentView: View {
    private let baseUrl = "https://watchdrone-dfe04-default-rtdb.firebaseio.com/"
    
    var body: some View {
        VStack {
            HStack {
                Text("Left")
                    .onTapGesture {
                        updateActionInFirebase(action: "left", number: 1)
                    }
                Spacer()
                Text("Right")
                    .onTapGesture {
                        updateActionInFirebase(action: "right", number: 1)
                    }
            }
            HStack {
                Text("Down")
                    .onTapGesture {
                        updateActionInFirebase(action: "down", number: 1)
                    }
                Spacer()
                Text("Up")
                    .onTapGesture {
                        updateActionInFirebase(action: "up", number: 1)
                    }
            }
        }
        .padding()
    }
    
    func updateActionInFirebase(action: String, number: Int) {
        let actionValue = "\(action) \(number)"
        guard let url = URL(string: "\(baseUrl)action.json") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = "{\"action\": \"\(actionValue)\"}".data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error updating action: \(error)")
                return
            }
            print("Action updated to \(actionValue)")
        }
        task.resume()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
