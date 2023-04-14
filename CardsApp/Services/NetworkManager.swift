//
//  NetworkManager.swift
//  CardsApp
//
//  Created by Анатолий Миронов on 13.04.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case decodingError
    case error400(String)
    case error401
    case error500
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func getAllCards(currentCardsCount: Int, completion: @escaping(Result<[Card], NetworkError>) -> Void) {
        // URL-адрес сервера
        let url = URL(string: "http://dev.bonusmoney.pro/mobileapp/getAllCompanies")

        guard let url = url else {
            completion(.failure(.invalidURL))
            return
        }
        
        // Создание запроса
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("123", forHTTPHeaderField: "TOKEN")
        request.httpBody = "{ \"offset\": \(currentCardsCount) }".data(using: .utf8)

        // Создание сессии и выполнение запроса
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            // проверяем статус ответа
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            switch httpResponse.statusCode {
                
            case 200: // обрабатываем успешный ответ
                guard let data = data else {
                    completion(.failure(.noData))
                    print(error?.localizedDescription ?? "No error description")
                    return
                }
                
                // Декодирование полученных данных
                do {
                    let cards = try JSONDecoder().decode([Card].self, from: data)
                    completion(.success(cards))

    //              guard let jsonString = String(data: data, encoding: .utf8) else { return }
    //              guard let jsonData = jsonString.data(using: .utf8) else { return }
    //              let cards = try JSONDecoder().decode([Card].self, from: jsonData)
                } catch {
                    completion(.failure(.decodingError))
                }
            case 400:
                guard let data = data else {
                    completion(.failure(.noData))
                    print(error?.localizedDescription ?? "No error description")
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    completion(.failure(.error400(response.message)))
                } catch {
                    completion(.failure(.decodingError))
                }
                
            case 401: completion(.failure(.error401))
            case 500: completion(.failure(.error500))
            default:
                break
            }
        }
        // Запуск задачи
        task.resume()
    }
}
