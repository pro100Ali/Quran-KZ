//
//  SurahDescriptionViewController.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 18.06.2023.
//

import UIKit
import SnapKit

class SurahDescriptionViewController: UIViewController, SurahDelegate {
    
    var surah: SurahInfo?
    var viewModel: SurahDescriptionViewModel!

    lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.text = "Al ads"
        return label
    }()
    
    func callToViewModelForUIUpdate() {
        
        self.viewModel = SurahDescriptionViewModel()
        self.viewModel.bindViewModelToController = {
        self.updateDataSource()
        }
        
    }
    
    func updateDataSource(){
           DispatchQueue.main.async {
               self.surah = self.viewModel.empData               
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(label)
        setupConstraints()
    }
    
    func goToNext(_ array: Surah?) {
        if let array = array {
            DispatchQueue.main.async {

//                self.surah = array
                
//                self.callToViewModelForUIUpdate(self.surah?.id)
                APICaller.shared.getInfoChapters(with: array.id!) { res in
                    switch res {
                    case .success(let success):
                            DispatchQueue.main.async {
                            self.label.text = success.short_text
                        }
                    case .failure(let failure):
                        print(failure)
                    }
                }
            }
        }
    }
    
    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
