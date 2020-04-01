//
//  Service.swift
//  DiarioDeAprendizado
//
//  Created by Vinicius Mesquita on 14/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation
import CryptoSwift

public final class Service<Type: Codable & Incrementable> {
    
    let fileManager = FileManager.default
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    var arrayObject = [Type]()
    
    func read(filePath: String) -> [Type] {
        var arrayType = [Type]()
        if fileManager.fileExists(atPath: filePath) {
            do {
                let json = try String(contentsOf: URL(fileURLWithPath: filePath))
                let jsonData = json.data(using: .utf8)!
                
                arrayType = try decoder.decode([Type].self, from: jsonData)
                return arrayType
            } catch {
                print(error.localizedDescription) // tem que ajeitar isso depois porque ta aparecendo pro user
            }
        }
        return arrayType
    }
    
    func write(array: [Type]? = nil, filePath: String) {
        encoder.outputFormatting = .prettyPrinted
        if let arrayType = array {
            arrayObject = arrayType
        }
        do { // write
            let jsonData = try encoder.encode(arrayObject)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                try jsonString.write(to: URL(fileURLWithPath: filePath), atomically: true, encoding: .utf8)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    
    func autoIncrement(path:String) -> Int{
        let array = read(filePath: path)
        let lengthArray = array.count
        var id = 0
        if(lengthArray == 0){
            id = 1
            return id
        } else {
            id = array[lengthArray-1].id + 1
            return id
        }
    }

    func save(object: Type, folderPath: String, fileName: String? = nil) {
        encoder.outputFormatting = .prettyPrinted
        var filePath = folderPath
        if let filename = fileName {
            filePath = folderPath + "/\(filename)"
        }
        
        if fileManager.fileExists(atPath: filePath) {
            do { // read & append
                arrayObject = read(filePath: filePath)
                arrayObject.append(object)
                write(filePath: filePath)
            }
        } else { // if dont exist will create a new directory
            createDirectory(folderPath: folderPath, filePath: filePath)
            arrayObject.append(object)
            write(filePath: filePath)
        }
    }
    
    func delete(filePath: String) {
        if fileManager.fileExists(atPath: filePath) {
            do {
                try fileManager.removeItem(atPath: filePath)
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("arquivo não existe")
        }
    }
    
    func deleteById(filePath: String, id: Int) {
        if fileManager.fileExists(atPath: filePath) {
            var array = read(filePath: filePath)
            if !array.isEmpty{
                let length = array.count - 1
                for i in 0...length{
                    if array[i].id == id{
                        array.remove(at: i)
                        write(array: array, filePath: filePath)
                    }
                }
            }
            
        }
    }
    
    private func createDirectory(folderPath: String, filePath: String) {
        do {
            try fileManager.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
            let jsonData = try encoder.encode(arrayObject)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                let url = URL(fileURLWithPath: filePath)
                try jsonString.write(to: url, atomically: true, encoding: .utf8)
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func clearScreen() {
        let clear = Process()
        clear.launchPath = "/usr/bin/clear"
        clear.arguments = []
        clear.launch()
        clear.waitUntilExit()
    }
    
    func write(filePath: String, encryptionKey: String, iv: String) {
        encoder.outputFormatting = .prettyPrinted
        
        do { // write
            let jsonData = try encoder.encode(arrayObject)
            let aes = try AES(key: encryptionKey, iv: iv)
            let encrypted = try jsonData.encrypt(cipher: aes)
            try encrypted.write(to: URL(fileURLWithPath: filePath))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveEcrypted(object: Type, folderPath: String, fileName: String? = nil) {
        var filePath = folderPath
        let key = "keykeykeykeykeyk"
        let iv = "drowssapdrowssap"
        if let filename = fileName {
            filePath = folderPath + "/\(filename)"
        }
        
        if fileManager.fileExists(atPath: filePath) {
            do { // read & append
                arrayObject = read(filePath: filePath, encryptionKey: key, iv: iv)
                arrayObject.append(object)
                write(filePath: filePath, encryptionKey: key, iv: iv)
            }
        } else { // if dont exist will create a new directory
            createDirectory(folderPath: folderPath, filePath: filePath)
            arrayObject.append(object)
            write(filePath: filePath, encryptionKey: key, iv: iv)
        }
    }
    
    
    func read(filePath: String, encryptionKey: String, iv: String) -> [Type] {
        var arrayType = [Type]()
        
        
        if fileManager.fileExists(atPath: filePath) {
            do {
                let aes = try AES(key: encryptionKey, iv: iv)
                let decrypted = try Data(contentsOf: URL(fileURLWithPath: filePath)).decrypt(cipher: aes)
                arrayType = try decoder.decode([Type].self, from: decrypted)
                return arrayType
            } catch {
                print(error.localizedDescription)
            }
        }
        return arrayType
    }
    
    
    func deleteEncrypted(filePath: String, id: Int) {
        let key = "keykeykeykeykeyk"
        let iv = "drowssapdrowssap"
        
        if fileManager.fileExists(atPath: filePath) {
            var array = read(filePath: filePath, encryptionKey: key, iv: iv)
            if !array.isEmpty{
                let length = array.count - 1
                for i in 0...length {
                    if array[i].id == id{
                        array.remove(at: i)
                        write(array: array, filePath: filePath)
                    }
                }
            }
        }
    }
    
    
}
