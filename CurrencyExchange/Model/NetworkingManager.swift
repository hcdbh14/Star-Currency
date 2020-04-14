import Foundation

enum APIError: Error {
    case responseProblem
    case decodingProblem
    case otherProblem
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

struct NetworkingManager {
    let resourceURL: URL
    
    init(endpoint: String) {
        let resourceString = endpoint
        guard let resourceURL = URL(string: resourceString) else {
            fatalError()
        }
        self.resourceURL = resourceURL
    }
    
    
    func httpRequest (httpMethod: HTTPMethod,completion: @escaping (Result<Data, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpMethod = httpMethod.rawValue
            
            print("🔸🔸🔸🔸🔸🔸 \n sending request :  \(urlRequest.httpMethod ?? "") \(urlRequest) \n🔸🔸🔸🔸🔸🔸")
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) {data, response, error in
                
                guard let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...299:
                        print("\n🔹🔹🔹🔹🔹🔹\n response success \(httpResponse.statusCode) \n🔹🔹🔹🔹🔹🔹")
                        if let jsonConsolePrint = String(data: jsonData, encoding: .utf8) {
                            print("- - - response message - - - \n \(jsonConsolePrint)")
                        }
                    default:
                        print("\n🔻🔻🔻🔻🔻🔻\n failed with response code \(httpResponse.statusCode) \n🔻🔻🔻🔻🔻🔻")
                        if let jsonConsolePrint = String(data: jsonData, encoding: .utf8) {
                            print("- - - response message - - - \n \(jsonConsolePrint)")
                        }
                        completion(.failure(.responseProblem))
                        return
                    }
                }
                completion(.success(jsonData))
            }
            dataTask.resume()
        }
    }
}
