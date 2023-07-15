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
    
    
    let headerView = HeaderView(frame: .zero)
    
    let headerForTable = HeaderForTable(frame: .zero) 
    lazy private var lenta: UIView = {
        let rect = UIView()
        rect.backgroundColor = Color.shared.greenRect
        return rect
    }()
    
    lazy private var text: UILabel = {
        let text = UILabel()
        text.text = "Al-Asr"
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return text
    }()
    lazy private var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SurahTableViewCell.self, forCellReuseIdentifier: "cell")
        table.backgroundColor = .white
        table.layer.cornerRadius = 10
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.shared.greenRect
        navigationController?.navigationBar.tintColor = UIColor.white
        [headerView, tableView].forEach { view.addSubview($0) }
        headerView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        setupConstraints()
        
        callToViewModelForUIUpdate()
        headerView.delegate = self
        navigationItem.title = "Quran"
        
        
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
            guard let data = viewModel.empData else { return }
            arrayOfSurahs = data
            tableView.reloadData()
        }
    }
    
    
    func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.07)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(10)
            make.height.equalToSuperview()
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
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row + 1 == arrayOfSurahs.count {
//            headerView.layer.opacity = 0.8
//        }
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            return headerForTable
        }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}

extension QuranViewController: EachSurah {
    func showTheSurah(_ chapter: Surah) {
        self.index = chapter.pages[0]
        headerForTable.configure(chapter.name_arabic!)

//        navigationItem.title =
    }
    
    
}
