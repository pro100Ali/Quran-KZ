//
//  SurahViewController.swift
//  QuranKzUIKit
//
//  Created by Али  on 18.06.2023.
//

import UIKit
import SnapKit
import Alamofire

protocol SurahDelegate {
    func goToNext(_ array: Surah?)
}

class SurahViewController: UIViewController {
    
    var delegate: SurahDelegate?
    var arrayOfSurahs: [Surah] = []
    
    private var viewModel : SurahViewModel!

    lazy private var tableView: UITableView = {
       let table = UITableView()
        table.register(SurahTableViewCell.self, forCellReuseIdentifier: "cell")
        table.backgroundColor = .yellow
        return table
    }()
    
    func callToViewModelForUIUpdate() {
        
        self.viewModel =  SurahViewModel()
        self.viewModel.bindViewModelToController = {
        self.updateDataSource()
        }
        
    }
    
    func updateDataSource(){
           DispatchQueue.main.async {
               self.arrayOfSurahs = self.viewModel.empData
               self.tableView.reloadData()
               
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
    
        setupConstraints()
        callToViewModelForUIUpdate()
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SurahViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfSurahs.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SurahDescriptionViewController()
        self.delegate = vc
        delegate?.goToNext(arrayOfSurahs[indexPath.row])
        navigationController?.present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SurahTableViewCell else { return UITableViewCell() }
        cell.label.text = arrayOfSurahs[indexPath.row].name_simple
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    

}
