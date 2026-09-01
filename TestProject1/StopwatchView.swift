import Combine
import SwiftUI

struct StopwatchView: View {
    @State private var isRunning: Bool = false
    @State private var startDate: Date? = nil
    @State private var accumulated: TimeInterval = 0
    @State private var now: Date = Date()

    // A timer that ticks every 0.1s for smooth updates
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Text("Stopwatch")
                    .font(.largeTitle).bold()
                    .foregroundStyle(.white)

                Text(formattedTime)
                    .font(.system(size: 64, weight: .medium, design: .monospaced))
                    .foregroundStyle(.green)
                    .padding(.vertical, 16)

                HStack(spacing: 24) {
                    Button(action: toggle) {
                        Text(isRunning ? "Stop" : "Start")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isRunning ? Color.red : Color.green)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }

                    Button(action: reset) {
                        Text("Reset")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .disabled(isRunning == false && accumulated == 0)
                    .opacity(isRunning == false && accumulated == 0 ? 0.5 : 1)
                }
                .padding(.horizontal)

                Spacer()
            }
        }
        .onReceive(timer) { date in
            guard isRunning else { return }
            now = date
        }
    }

    private var elapsed: TimeInterval {
        if let start = startDate, isRunning {
            return accumulated + now.timeIntervalSince(start)
        } else {
            return accumulated
        }
    }

    private var formattedTime: String {
        let total = Int(elapsed * 100) // hundredths
        let hours = total / 360000
        let minutes = (total % 360000) / 6000
        let seconds = (total % 6000) / 100
        let hundredths = total % 100
        if hours > 0 {
            return String(format: "%02d:%02d:%02d.%02d", hours, minutes, seconds, hundredths)
        } else {
            return String(format: "%02d:%02d.%02d", minutes, seconds, hundredths)
        }
    }

    private func toggle() {
        if isRunning {
            // Stop
            isRunning = false
            if let start = startDate {
                accumulated += Date().timeIntervalSince(start)
            }
            startDate = nil
        } else {
            // Start
            isRunning = true
            startDate = Date()
            now = Date()
        }
    }

    private func reset() {
        isRunning = false
        startDate = nil
        accumulated = 0
        now = Date()
    }
}

#Preview {
    StopwatchView()
}
