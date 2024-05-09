import Foundation
import Alamofire

class WebServiceModel {
    
    var url: URL = URL(string: "https://www.google.com")!
    var method: HTTPMethod = .get
    var parameters: [String:Any] = [:]
    var headers: HTTPHeaders?
    var encodingType: ParameterEncoding = JSONEncoding.default
    
    init() {
        self.headers = HTTPHeaders()
        self.headers?.add(name: "Accept", value: "application/json")
        self.headers?.add(name: "Content-type", value: "application/json")
    }
}

class WebService {
    
    static var shared = WebService()
    
    // MARK: - PERFORM API CALLS
    func performWebService(model: WebServiceModel, complition: @escaping ((_ response: Data?, _ statusCode: Int?, _ error: String?) -> Void)) {

        AF.request(model.url, method: model.method, parameters: model.parameters, encoding: model.encodingType, headers: model.headers).response(completionHandler: { (response) in
                switch response.result {
                case .success:
                    if let string = String(data: response.data ?? Data(), encoding: .utf8){
                        print("\n==================== API RESPONSE ====================")
                        print("\nAPI URL (\(model.method.rawValue)) : ", response.request?.url?.absoluteString ?? "")
                        print("\nAPI STATUS CODE: \(response.response?.statusCode ?? 0)")
                        print("\nAPI HEADER: ", response.request?.headers ?? HTTPHeaders())
                        print("\nAPI PARAM: ", model.parameters)
                        print("\nAPI DATA: ", string)
                        print("\n======================== END =========================\n")
                    }
                    delay {
                        complition(response.data ?? Data(), (response.response?.statusCode ?? 0), nil)
                    }
                case .failure(let error):
                    print(error)
                }
            })
    }
    
    // MARK: - PERFORM API CALLS
    func performMultipartWebService(model: WebServiceModel, imageData: [Dictionary<String, Any>], complition: @escaping ((_ response: Data?, _ statusCode: Int?, _ error: String?) -> Void)) {

        var convertibleURL = URLRequest(url: model.url)
        convertibleURL.method = model.method
        convertibleURL.headers = model.headers ?? HTTPHeaders()
        
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in model.parameters {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            imageData.forEach({ data in
                if let imageData = data["image"] as? Data {
                    let mimeType = imageData.isPDF ? ("pdf", "application/pdf") : ("png", "image/png")
                    multiPart.append(imageData, withName: (data["title"] as? String ?? ""),
                                     fileName: "\((data["title"] as? String ?? "") + "\(Date().timeIntervalSinceNow)").\(mimeType.0)",
                                     mimeType: mimeType.1)
                }
            })
        }, with: convertibleURL as URLRequestConvertible)
        .uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .response(completionHandler: { (response) in
            switch response.result {
            case .success:
                if let string = String(data: response.data ?? Data(), encoding: .utf8){
                    print("\n==================== API RESPONSE ====================")
                    print("\nAPI URL (\(model.method.rawValue)) : ", response.request?.url?.absoluteString ?? "")
                    print("\nAPI STATUS CODE: \(response.response?.statusCode ?? 0)")
                    print("\nAPI HEADER: ", response.request?.headers ?? HTTPHeaders())
                    print("\nAPI PARAM: ", model.parameters)
                    print("\nAPI DATA: ", string)
                    print("\n======================== END =========================\n")
                }
                delay {
                    complition(response.data ?? Data(), (response.response?.statusCode ?? 0), nil)
                }
            case .failure(let error):
                print(error)
            }
        })
    }
}

// MARK: - Convert Data
extension Data {
    
    func convertData<T: Decodable>(_ model: T.Type) -> Any {
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let daata = try decoder.decode(model.self, from: self)
            return daata
        } catch {
            print("JSON FAILED: \(error)")
            return "\(error)"
        }
    }
    
}

extension Encodable {
    
    func toDictionary() -> [String:Any] {
        let jsonData = try! JSONEncoder().encode(self)
        return try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
    }
    
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
