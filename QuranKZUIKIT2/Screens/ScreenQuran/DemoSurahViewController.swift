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

class DemoSurahViewController: UIViewController {
    
//    var arrayOfSurahs: [SurahVerses] = []
    
    var arrayOfSurahs: [SurahVerses] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var str: [String] = []
    var index: Int = 2 {
        didSet {
            callToViewModelForUIUpdate()
            self.tableView.reloadData()
        }
    }
    
    private var viewModel: SurahDescriptionViewModel!

   
    let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
   
    lazy private var tableView: UITableView = {
       let table = UITableView()
        table.register(TableViewCell.self, forCellReuseIdentifier: "cell")

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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        print(arrayOfSurahs.count)
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
//            print(arrayOfSurahs.)
            tableView.reloadData()
  
            print("----------------------------------")
            print(arrayOfSurahs.count)
            print("----------------------------------")
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
//
//extension DemoSurahViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return arrayOfSurahs.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SurahCollectionViewCell else { return UICollectionViewCell() }
//        cell.label.text = arrayOfSurahs[indexPath.row].name_simple
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SurahCollectionViewCell
//
//        APICaller.shared.getInfoChapters(with: arrayOfSurahs[indexPath.row].id!) { res in
//            switch res {
//            case .success(let success):
//                    DispatchQueue.main.async {
//                        self.text.text = success.short_text
//                }
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//
//
//    }
//}
extension DemoSurahViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfSurahs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.textArabic.text! = ""
        cell.arabicText.text! = ""
        cell.text.text = arrayOfSurahs[indexPath.row].verse_key
        if let word = arrayOfSurahs[indexPath.row].words {
            for i in word {
                if let word2 = i.transliteration?.text {
                    cell.textArabic.text! += "  \(word2.uppercased())"
                }
                if let word1 = i.translation?.text {
                    cell.arabicText.text! += " \(word1.uppercased())"
                }
            }
            str.append(cell.textArabic.text!)

            
        }
        
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
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let font = UIFont.systemFont(ofSize: 15.0)
//
//
//        let text = arrayOfSurahs[indexPath.row].words![].text
//        let maxHeight: CGFloat = 300// Specify the maximum height you want
//        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
//        let size = CGSize(width: tableView.frame.size.width, height: maxHeight)
//        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
//        let boundingRect = text!.boundingRect(with: size, options: options, attributes: attributes, context: nil)
//        let height = boundingRect.size.height
//
//        let additionalHeightBuffer: CGFloat = 100// Specify the additional height buffer if needed
//
//        return height + additionalHeightBuffer
//    }

  
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.section == tableView.numberOfSections - 1 &&
//            indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
//            print("ADdas")
//        }
//    }
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
         return UITableView.automaticDimension
    }

     func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
         return UITableView.automaticDimension
    }
}

extension DemoSurahViewController: EachSurah {
    func showTheSurah(_ chapter: Surah) {
        self.index = chapter.id!
        navigationItem.title = chapter.name_arabic
    }
    
    
}
