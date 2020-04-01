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
    func saveInformation(nome: String, username: String, matricula: String, password: String)
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
    
    func details() {
        let currentUser = CurrentUser.instance
        
        if !(currentUser.nome != "") {
            print("""
                olá \(currentUser.nome)
                sua Matricula é \(currentUser.matricula)
            """)
        } else {
            print("Por favor, realize o login primeiro!")
        }
        
    }
    
    func editInformation(user: User, edit: EditUserBy, newValue: String) {
        /* not implemented yet **/
        let editedUser = user
        
        switch edit {
        case .name:
            editedUser.nome = newValue
        case .password:
            editedUser.senha = newValue.md5()
        }
        service.deleteById(filePath: completePathUser, id: user.id)
        service.save(object: editedUser, folderPath: completePathUser)
        
    }

    /* faltam ajustes */
    func saveInformation(nome: String, username: String, matricula: String, password: String) {
        let users = service.read(filePath: completePathUser)
        if users.isEmpty {
            let user = User(username: username, nome: nome, matricula: matricula, senha: password)
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
                setCurrentUser(user: user)
                result = true
            }
        }
        return result
    }
    
    private func setCurrentUser(user: User) {
        let currentUser = CurrentUser.instance
        currentUser.nome = user.nome
        currentUser.matricula = user.matricula
    }
    
}

