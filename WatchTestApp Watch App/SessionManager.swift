//
//  SessionManager.swift
//  WatchTestApp Watch App
//
//  Created by Максим Евграфов on 20.03.2025.
//

import Foundation
import WatchConnectivity

class SessionManager: NSObject, ObservableObject {
    static let shared = SessionManager()
        
    // Флаг для отслеживания активации сессии
    var isSessionActivated: Bool = false
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
}

// MARK: - WCSessionDelegate

extension SessionManager: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error {
            print("Ошибка активации: \(error.localizedDescription)")
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.isSessionActivated = true
                NotificationCenter.default.post(name: .sessionActivated, object: nil)
            }
        }
    }
    
    func sessionReachabilityDidChange(_ session: WCSession) {
        print("Доступность сессии изменилась: \(session.isReachable)")
    }
}

extension Notification.Name {
    static let sessionActivated = Notification.Name("sessionActivated")
}
