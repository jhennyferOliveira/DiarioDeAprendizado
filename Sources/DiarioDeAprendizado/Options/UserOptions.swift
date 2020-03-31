//
//  File.swift
//  
//
//  Created by Vinicius Mesquita on 24/03/20.
//

import Foundation
import CryptoSwift

protocol UserOptionsDelegate: class {
    func details()
    func editInformation()
    func saveInformation(matricula: String, password: String)
    func checkInformation(username: String, password: String) -> Bool
}

public class UserOptions: UserOptionsDelegate {
    
    let folderPath = FileManager.default.currentDirectoryPath + "/json"
    let completePathUser = FileManager.default.currentDirectoryPath + "/json/user.txt"
    let service = Service<User>()
    let utils = Utils()
    
    func details() {
        let currentUser = utils.getCurrentUser()
        
        print("""
            olá \(currentUser.nome)
            Voce esta logado como \(currentUser)
        """)
    }
    
    func editInformation() {
        /* not implemented yet **/
    }

    /* faltam ajustes */
    func saveInformation(matricula: String, password: String) {
        let users = service.read(filePath: completePathUser)
        if users.isEmpty {
            let user = User(username: "", nome: "vinicius mesquta", matricula: matricula, senha: password)
            service.save(object: user, folderPath: folderPath, fileName: "user.txt")
        } else {
            print("ja existe o registro, deseja cadastrar mais um usuario?")
            guard let response = readLine() else { return }
            print(response)
        }
   
    }
    
    /* em testes */
    func checkInformation(username: String, password: String) -> Bool {
        let users = service.read(filePath: completePathUser)
        var result = false
        
        users.forEach { user in
            if (user.username == username && user.senha == password) {
                utils.setCurrentUser(user: user)
                result = true
            }
        }
        return result
    }
    
}

