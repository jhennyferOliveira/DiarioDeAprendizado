//
//  Service.swift
//  DiarioDeAprendizado
//
//  Created by Vinicius Mesquita on 14/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

public final class Service<Type: Codable> {
    
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
                print(error.localizedDescription)
            }
        }
        return arrayType
    }
    
    func write(filePath: String) {
        do { // write
            let jsonData = try encoder.encode(arrayObject)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                try jsonString.write(to: URL(fileURLWithPath: filePath), atomically: true, encoding: .utf8)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func override(object: Type, folderPath: String, fileName: String) {
        
        encoder.outputFormatting = .prettyPrinted
        let filePath = folderPath + "/\(fileName)"
        
        if fileManager.fileExists(atPath: filePath) {
            do { // read & append
                arrayObject = read(filePath: filePath)
                arrayObject.append(object)
                write(filePath: filePath)
            }
        } else { // if dont exist will create a new directory
            createDirectory(folderPath: folderPath, fileName: fileName)
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
    
    private func createDirectory(folderPath: String, fileName: String) {
        do {
            try fileManager.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
            let jsonData = try encoder.encode(arrayObject)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                let url = URL(fileURLWithPath: folderPath + "/\(fileName)")
                try jsonString.write(to: url, atomically: true, encoding: .utf8)
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
}
