//
//  WelcomeViewModel.swift
//  Proof Of Concept
//
//  Created by Raghu on 21/12/20.
//

import Foundation

class WelcomeViewModel : NSObject {
    
    private var apiService : APIService!
    private(set) var welcomeData : Welcome! {
        didSet {
            self.bindWelcomeViewModelToController()
        }
    }
    var bindWelcomeViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
        callFuncToGetEmpData()
    }
    
    func callFuncToGetEmpData() {
        self.apiService.apiToGetWelcomeData { (welcomeData) in
            self.welcomeData = welcomeData
        }
    }
}
