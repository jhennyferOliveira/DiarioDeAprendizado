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
    func editInformation(user: User, edit: EditUserBy, newValue: String)
    func saveInformation(matricula: String, password: String)
    func checkInformation(username: String, password: String) -> Bool
}

enum AuthenticationError: Error {
    case refusedLogin
    case ecryptError
    case decryptError
}

enum EditUserBy {
    case name
    case password
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
            Voce esta logado como \(currentUser.username)
        """)
    }
    
    func editInformation(user: User, edit: EditUserBy, newValue: String) {
        /* not implemented yet **/
        let editedUser = user
        
        switch edit {
        case .name:
            editedUser.nome = newValue
        case .password:
            editedUser.senha = newValue
        }
        service.deleteById(filePath: completePathUser, id: user.id)
        service.save(object: editedUser, folderPath: completePathUser)
        
    }

    /* faltam ajustes */
    func saveInformation(matricula: String, password: String) {
        let users = service.read(filePath: completePathUser)
        if users.isEmpty {
            let user = User(username: "teste", nome: "vinicius mesquta", matricula: matricula, senha: password)
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

