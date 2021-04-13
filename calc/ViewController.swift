//
//  ViewController.swift
//  calc
//
//  Created by 柴田謙真 on 2021/04/13.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = calcCollectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    

    @IBOutlet weak var calcHeightConstrait: NSLayoutConstraint!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var calcCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        calcCollectionView.delegate = self
        calcCollectionView.dataSource = self
        calcCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
    }


}

