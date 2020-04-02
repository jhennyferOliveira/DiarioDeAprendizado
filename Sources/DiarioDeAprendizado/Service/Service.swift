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
    let key = "keykeykeykeykeyk"
    let iv = "drowssapdrowssap"
    var arrayObject = [Type]()
    
    func read(filePath: String) -> [Type] {
        var arrayType = [Type]()
        if fileManager.fileExists(atPath: filePath) {
            do {
                let json = try String(contentsOf: URL(fileURLWithPath: filePath))
                let jsonData = json.data(using: .utf8)!
                
                arrayType = try decoder.decode([Type].self, from: jsonData)
                arrayType.sort(){$0.id < $1.id}
                return arrayType
            } catch {
                print(error.localizedDescription)
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

    
    func autoIncrement(path: String) -> Int {
        let array = read(filePath: path)
        let lengthArray = array.count
        var id = 0
        if(lengthArray == 0) {
            id = 1
            return id
        } else {
            id = array[lengthArray - 1].id + 1
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
                arrayObject.sort() { $0.id < $1.id }
                write(filePath: filePath)
 
            }
        } else { // if dont exist will create a new directory
            createDirectory(folderPath: folderPath, filePath: filePath)
            arrayObject.append(object)
            arrayObject.sort() { $0.id < $1.id }
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
                if array.count>1{
                let length = array.count - 1
                for i in 0...length{
                    if array[i].id == id {
                        array.remove(at: i)
                        write(array: array, filePath: filePath)
                        break
                    }
                }
                } else {
                    array.remove(at: 0)
                    write(array: array, filePath: filePath)
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
    
    func writeEncrypted(filePath: String) {
        encoder.outputFormatting = .prettyPrinted
        
        do { // write
            let jsonData = try encoder.encode(arrayObject)
            let aes = try AES(key: key, iv: iv)
            let encrypted = try jsonData.encrypt(cipher: aes)
            try encrypted.write(to: URL(fileURLWithPath: filePath))
        } catch {
            // print(error.localizedDescription)
        }
    }
    
    func saveEcrypted(object: Type, folderPath: String, fileName: String? = nil) {
        var filePath = folderPath
        
        if let filename = fileName {
            filePath = folderPath + "/\(filename)"
        }
        
        if fileManager.fileExists(atPath: filePath) {
            do { // read & append
                arrayObject = readEncrypted(filePath: filePath)
                arrayObject.append(object)
                writeEncrypted(filePath: filePath)
            }
        } else { // if dont exist will create a new directory
            createDirectory(folderPath: folderPath, filePath: filePath)
            arrayObject.append(object)
            writeEncrypted(filePath: filePath)
        }
    }
    
    
    func readEncrypted(filePath: String) -> [Type] {
        var arrayType = [Type]()
        
        
        if fileManager.fileExists(atPath: filePath) {
            do {
                let aes = try AES(key: key, iv: iv)
                let decrypted = try Data(contentsOf: URL(fileURLWithPath: filePath)).decrypt(cipher: aes)
                arrayType = try decoder.decode([Type].self, from: decrypted)
                return arrayType
            } catch {
                // print(error.localizedDescription)
            }
        }
        return arrayType
    }
    
    
    func deleteEncrypted(filePath: String, id: Int) {
        
        if fileManager.fileExists(atPath: filePath) {
            var array = readEncrypted(filePath: filePath)
            if !array.isEmpty {
                let length = array.count - 1
                for i in 0...length {
                    if array[i].id == id {
                        array.remove(at: i)
                        writeEncrypted(filePath: filePath)
                    }
                }
            }
        }
    }
    
    
}
