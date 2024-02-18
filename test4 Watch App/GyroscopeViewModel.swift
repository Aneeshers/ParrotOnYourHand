import Foundation
import CoreMotion
import Combine

class GyroscopeViewModel: ObservableObject {
    private let motionManager = CMMotionManager()
    private var timer: Timer?
    private let baseUrl = "https://watchdrone-dfe04-default-rtdb.firebaseio.com/"

    @Published var attitudeData: String = "Pitch: 0.0, Roll: 0.0, Yaw: 0.0"
    
    init() {
        startDeviceMotion()
    }
    
    private func startDeviceMotion() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1.0 / 50.0
            motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
            
            // Configure a timer to fetch the motion data.
            timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 50.0, repeats: true) { [weak self] _ in
                guard let self = self, let data = self.motionManager.deviceMotion else { return }
                // Get the attitude relative to the magnetic north reference frame.
                let pitch = data.attitude.pitch
                let roll = data.attitude.roll
                let yaw = data.attitude.yaw
                
                // Update the attitude data
                DispatchQueue.main.async {
                    self.attitudeData = String(format: "Pitch: %.2f, Roll: %.2f, Yaw: %.2f", pitch, roll, yaw)
                    self.checkCommands(pitch: pitch, roll: roll)
                }
            }
        } else {
            attitudeData = "Device motion is not available"
        }
    }
    
    private func checkCommands(pitch: Double, roll: Double) {
        if pitch < -0.9 {
            sendLeftCommand()
        } else if pitch > 0.9 {
            sendRightCommand()
        }
         else if roll < -0.9 {
            sendUpCommand()
        }
        
    }
    
    private func sendLeftCommand() {
        print("Sending Left Command")
        updateActionInFirebase(action: "left", number: 1)
    }
    
    private func sendRightCommand() {
        print("Sending Right Command")
        updateActionInFirebase(action: "right", number: 1)
    }
    
    private func sendUpCommand() {
        print("Sending Up Command")
        updateActionInFirebase(action: "up", number: 1)
    }
    func sendLandCommand() {
        print("landing!")
        updateActionInFirebase(action: "land", number: 1)
    }
    
    private func sendDownCommand() {
        print("Sending Down Command")
        updateActionInFirebase(action: "down", number: 1)
    }
    private func updateActionInFirebase(action: String, number: Int) {
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
    
    deinit {
        motionManager.stopDeviceMotionUpdates()
        timer?.invalidate()
    }
}
