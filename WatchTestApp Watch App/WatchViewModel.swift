//
//  ViewModel.swift
//  WatchTestApp Watch App
//
//  Created by Максим Евграфов on 20.03.2025.
//

import Foundation
import WatchConnectivity

class WatchViewModel: NSObject, ObservableObject {
    @Published
    var characterList: [CharacterModel] = []
    
    override init() {
        super.init()
    }
    
    func getDataFromPhone() {
        let session = WCSession.default
        guard session.isReachable else {
            return
        }
        
        session.sendMessage(["request": "getCharacters"]) { [weak self] reply in
            guard let characters = reply["response"] as? [CharacterModel] else { return }
            DispatchQueue.main.async { [weak self] in
                self?.characterList = characters
            }
        } errorHandler: { error in
            print("Ошибка::: ", error.localizedDescription)
        }
    }
}

extension WatchViewModel: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        print("Watch session:", activationState)
    }
}
