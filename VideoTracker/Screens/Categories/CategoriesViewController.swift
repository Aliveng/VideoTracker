//
//  CategoriesViewController.swift
//  VideoTracker
//
//  Created by Татьяна Севостьянова on 16.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import UIKit
import SnapKit


struct Item {
    let image: UIImage
    let name: String
}

class CategoriesViewController: UIViewController {
    
    lazy var itemsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 142, height: 142)
        layout.sectionInset = .init(top: 8, left: 16, bottom: 0, right: 16)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.register(ItemCell.self, forCellWithReuseIdentifier: "ItemCell")
        view.showsVerticalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    let listImages: [Item] = [
        Item(image: .item1, name: "BMV"),
        Item(image: .item4, name: "Ferrari"),
        Item(image: .item2, name: "Audio"),
        Item(image: .item5, name: "Lexus"),
        Item(image: .item3, name: "Mercedes"),
        Item(image: .item6, name: "Lamborgini"),
        Item(image: .item1, name: "BMV"),
        Item(image: .item4, name: "Ferrari"),
        Item(image: .item2, name: "Audio"),
        Item(image: .item5, name: "Lexus"),
        Item(image: .item3, name: "Mercedes"),
        Item(image: .item6, name: "Lamborgini")
    ]
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        view.addSubview(itemsCollectionView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Категории"
        
          itemsCollectionView.snp.makeConstraints({ item in
              item.left.equalToSuperview().offset(12)
              item.right.equalToSuperview().offset(-12)
              item.bottom.equalToSuperview()
              item.top.equalToSuperview().offset(70)
        
          })
    }
}

extension CategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath)
        (cell as? ItemCell)?.image.image = listImages[indexPath.row].image
        (cell as? ItemCell)?.name.text = "\(listImages[indexPath.row].name)"
        cell.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.layer.cornerRadius = 8
        return cell
    }
}

extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Выбрана ячейка с номером \(indexPath.row)")
    }
}
