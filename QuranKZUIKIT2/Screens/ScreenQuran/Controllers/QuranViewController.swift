//
//  DemoSurahViewController.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 28.06.2023.
//

import UIKit
import SnapKit

protocol EachSurah: AnyObject {
    func showTheSurah(_ chapter: Surah)
}

class QuranViewController: UIViewController {
        
    var arrayOfSurahs: [SurahVerses] = []
    private var viewModel: SurahDescriptionViewModel!
    var str: [String] = []
    var index: Int = 2 {
        didSet {
            callToViewModelForUIUpdate()
        }
    }
    
    let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    lazy private var tableView: UITableView = {
        let table = UITableView()
        table.register(SurahTableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.shared.greenRect
        navigationController?.navigationBar.tintColor = UIColor.white
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        headerView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        setupConstraints()
        
        callToViewModelForUIUpdate()
        headerView.delegate = self
        navigationItem.title = "الفاتحة"
        
        
    }
    
    func callToViewModelForUIUpdate() {
        
        self.viewModel = SurahDescriptionViewModel()
        viewModel.callFuncToGetEmpData(index)
        
        self.viewModel.bindViewModelToController = {
            self.updateDataSource()
        }
        
    }
    
    func updateDataSource(){
        DispatchQueue.main.async { [self] in
            arrayOfSurahs = viewModel.empData
            tableView.reloadData()
        }
    }
    
    
    func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
        }
    }
    
    
    
}


extension QuranViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfSurahs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SurahTableViewCell
        cell.configure(arrayOfSurahs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        330
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == arrayOfSurahs.count {
            headerView.layer.opacity = 0.8
        }
    }
}

extension QuranViewController: EachSurah {
    func showTheSurah(_ chapter: Surah) {
        self.index = chapter.id!
        navigationItem.title = chapter.name_arabic
    }
    
    
}
