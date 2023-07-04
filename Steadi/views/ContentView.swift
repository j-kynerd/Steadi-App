import SwiftUI
import CoreMotion

struct ContentView: View {
    
    @State private var isRunning = false
    @State private var motion = CMMotionManager()
    @State private var timer: Timer?
    @State private var data = [String]()
    @State private var startTime: TimeInterval?
    
    @State private var username = ""
    @State private var password = ""
    @State private var isLoggedin = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    self.startAccelerometerDataCollection()
                }) {
                    Text(isRunning ? "Running..." : "Start")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .font(.headline)
                        .cornerRadius(10)
                }
                .disabled(isRunning)
                
                Text(isRunning ? "Data collection is running..." : "")
                    .foregroundColor(isRunning ? .green : .red)
                    .padding(.top, 20)
                
                if data.count > 0 {
                    List {
                        ForEach(data, id: \.self) { item in
                            Text(item)
                        }
                    }
                }
            }
        }
    }
    
    func startAccelerometerDataCollection() {
        self.isRunning = true
        self.motion.startAccelerometerUpdates()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            self.updateData()
        }
        self.startTime = Date().timeIntervalSince1970
    }
    
    func updateData() {
        if let accelerometerData = self.motion.accelerometerData {
            let elapsedTime = Date().timeIntervalSince1970 - self.startTime!
            let dataString = "\(elapsedTime),\(accelerometerData.acceleration.x),\(accelerometerData.acceleration.y),\(accelerometerData.acceleration.z)"
            self.data.append(dataString)
        }
        
        if self.data.count == 1000 {
            self.stopAccelerometerDataCollection()
        }
    }
    
    func stopAccelerometerDataCollection() {
        self.isRunning = false
        self.motion.stopAccelerometerUpdates()
        self.timer?.invalidate()
        self.timer = nil
        
        self.startTime = nil
    }
}
