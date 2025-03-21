//
//  PhoneViewModel.swift
//  WatchTestApp
//
//  Created by Максим Евграфов on 20.03.2025.
//

import Foundation
import WatchConnectivity

class PhoneViewModel: NSObject, ObservableObject {
    
    @Published
    var characterList: [CharacterModel] = []
    
    override init() {
        super.init()
        activateSession()
    }
    
    func fetchCharacters(handler: (() -> ())? = nil) {
        let url = URL(string: "https://rickandmortyapi.com/api/character")
        
        URLSession.shared.dataTask(with: url!) { [weak self] data, _, error in
            if let error {
                print(error.localizedDescription)
            }
            
            if let data {
                do {
                    let result = try JSONDecoder().decode(CharacterResult.self, from: data)
                    DispatchQueue.main.async {
                        self?.characterList = result.results
                        handler?()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    private func activateSession() {
        let session = WCSession.default
        session.delegate = self
        session.activate()
    }
}

extension PhoneViewModel: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        print(activationState.rawValue)
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print(#function)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        fetchCharacters { [weak self] in
            let dictionaryArray = self?.characterList.compactMap { $0.asDictionary }
            guard let dictionaryArray else { return }
            replyHandler(["response": dictionaryArray])
        }
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print(#function)
    }
}
