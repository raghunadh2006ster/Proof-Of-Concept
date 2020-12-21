//
//  APIService.swift
//  Proof Of Concept
//
//  Created by Raghu on 21/12/20.
//

import UIKit

class APIService :  NSObject {
    
    private let sourcesURL = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
    static let imageCache = NSCache<NSString,NSData>(), viewCache=NSCache<NSString,NSData>();
    
    func apiToGetWelcomeData(completion : @escaping (Welcome) -> ()){
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8)
                let empData = try! jsonDecoder.decode(Welcome.self, from: utf8Data!)
                completion(empData)
            }
        }.resume()
    }
    
    static func getImage(_ url:String, _ cache:Int, handler: @escaping (_ image:UIImage?, _ error: Error?, _ url:String)->Void) {
        let origUrl = url;
        let key = getKeyFromUrl(url);
        if let d = imageCache.object(forKey: key as NSString){
            handler(UIImage(data: d as Data) ,nil, origUrl);
            return;
        }
        if let d = viewCache.object(forKey: key as NSString){
            handler(UIImage(data: d as Data) ,nil, origUrl);
            return;
        }
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
        if FileManager.default.fileExists(atPath: dir.appendingPathComponent(key).path){
            let img = UIImage(contentsOfFile: dir.appendingPathComponent(key).path);
            handler(img,nil, origUrl);
            if img != nil && cache == 1 {
                let imgData = img!.jpegData(compressionQuality: 1)! as NSData;
                imageCache.setObject(imgData, forKey: url as NSString, cost: imgData.length);
            }
            return;
        }
        if let imgUrl = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
            URLSession.shared.dataTask(with: imgUrl) { (data, response, error) in
                DispatchQueue.main.async(execute: {() -> Void in
                    if error != nil {handler(nil,error, origUrl);return;}
                    if let img = UIImage(data: data!) {
                        handler(img,nil, origUrl);
                        let key = getKeyFromUrl(url);
                        let imgData = img.jpegData(compressionQuality: 1)! as NSData;
                        if cache == 1 {
                            addImageToCache(img, key);
                        } else if cache == 2 {
                            APIService.viewCache.removeObject(forKey: "small_\(key)" as NSString);
                            viewCache.setObject(imgData, forKey: key as NSString, cost: imgData.length);
                        } else {
                            viewCache.setObject(imgData, forKey: key as NSString, cost: imgData.length);
                        }
                    }else {handler(nil,error, origUrl);}
                })
                }.resume();
        }
    }
    
    class func addImageToCache(_ img:UIImage, _ key: String){
        let imgData = img.jpegData(compressionQuality: 1)! as NSData;
        imageCache.setObject(imgData, forKey: key as NSString, cost: imgData.length);
        do {
            let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
            try img.jpegData(compressionQuality: 1.0)!.write(to: dir.appendingPathComponent("\(key)"), options: .atomic)
        } catch { }
    }
    
    private class func getKeyFromUrl(_ url:String)->String{
        var url = url;
        return url.replace("[^a-z,0-9]", replaceWith: "");
    }
    
    class func onLowMemory(){
        viewCache.removeAllObjects();
        imageCache.removeAllObjects();
    }
}
//MARK:- Extensions
extension String {
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    mutating func replace(_ pattern: String, replaceWith: String) -> String{
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let range = NSMakeRange(0, self.count)
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replaceWith)
        } catch {
            return self;
        }
    }
}
