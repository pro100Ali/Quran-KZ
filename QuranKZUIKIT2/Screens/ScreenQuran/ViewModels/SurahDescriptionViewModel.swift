//
//  SurahViewModel.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 26.06.2023.
//

import Foundation

class SurahDescriptionViewModel: NSObject {
    
    private var apiCaller: APICaller!
//    var surahInfo: SurahInfo!
    private(set) var empData : [SurahVerses]! {
           didSet {
               self.bindViewModelToController()
           }
       }
    
    var bindViewModelToController: (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiCaller = APICaller()
    }
    
    func callFuncToGetEmpData(_ id: Int) {
        self.apiCaller.getInfoChapters(with: id) { res in
            APICaller.shared.getInfoChapters(with: id) { res in
                switch res {
                case .success(let success):
                        DispatchQueue.main.async {
                            self.empData = success
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
}
