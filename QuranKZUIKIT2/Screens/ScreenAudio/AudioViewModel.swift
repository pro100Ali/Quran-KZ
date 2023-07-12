//
//  SurahViewModel.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 26.06.2023.
//

import Foundation

class AudioViewModel: NSObject {
    
    private var apiCaller: APICaller!
    private(set) var empData : Audio! {
           didSet {
               self.bindViewModelToController()
           }
       }
    
    var bindViewModelToController: (() -> ()) = {}
    
    init(with id: Int) {
        super.init()
        self.apiCaller = APICaller()
        callFuncToGetEmpData(with: id)

    }
    
    func callFuncToGetEmpData(with id: Int) {
        self.apiCaller.getAudioSurah(with: id) { res in
            switch res {
            case .success(let success):
                self.empData = success

            case .failure(let failure):
                print("Error", failure)
            }
        }
    }
}
