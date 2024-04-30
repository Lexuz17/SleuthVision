//
//  ImageRecognizer.swift
//  SleuthVision
//
//  Created by mac.bernanda on 28/04/24.
//

import Foundation
import UIKit
import SwiftUI

class ImageRecognizer {
    let apiToken: String
    let uuid = game0.culprit.uuid
    
    init(apiToken: String) {
        self.apiToken = apiToken
    }
    
    func recognizeImage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://api.luxand.cloud/photo/verify/\(uuid)") else {
            completion(.failure(ImageRecognizerError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(apiToken, forHTTPHeaderField: "token")
        
        let boundary = UUID().uuidString
        let contentType = "multipart/form-data; boundary=\(boundary)"
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        let body = NSMutableData()
        
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            completion(.failure(ImageRecognizerError.invalidImageData))
            return
        }
        
        body.append(convertFileData(fieldName: "photo", fileName: "image.jpg", mimeType: "image/jpeg", fileData: imageData, using: boundary))
        body.appendString("--\(boundary)--\r\n")
        
        request.httpBody = body as Data
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let data = data else {
                completion(.failure(ImageRecognizerError.noData))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
               
                if let result = json?["status"] as? String {
                    print(result)
                    
                    if result == "failure" {
                        completion(.failure(ImageRecognizerError.notVerified))
                    } else {
                        completion(.success(result))
                    }
                } else {
                    completion(.failure(ImageRecognizerError.invalidResponse))
                }
                
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

    private func convertFileData(fieldName: String, fileName: String, mimeType: String, fileData: Data, using boundary: String) -> Data {
        let data = NSMutableData()
        
        data.appendString("--\(boundary)\r\n")
        data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
        data.appendString("Content-Type: \(mimeType)\r\n\r\n")
        data.append(fileData)
        data.appendString("\r\n")
        
        return data as Data
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

enum ImageRecognizerError: Error {
    case invalidURL
    case invalidImageData
    case noData
    case invalidResponse
    case notVerified
}
