//
//  ViewController.swift
//  calc
//
//  Created by 柴田謙真 on 2021/04/13.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height:10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 3 * 10) / 4
        return .init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = calcCollectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CalcViewCell
        cell.numberLabel.text = numbers[indexPath.section][indexPath.row]
        
        return cell
    }
    
    let numbers = [
        ["C","%","S","+"],
        ["7","8","9","×"],
        ["4","5","6","-"],
        ["1","2","3","+"],
        ["0",".","="],
    ]
    
    @IBOutlet weak var calcHeightConstrait: NSLayoutConstraint!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var calcCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        calcCollectionView.delegate = self
        calcCollectionView.dataSource = self
        calcCollectionView.register(CalcViewCell.self, forCellWithReuseIdentifier: "cellId")
        calcHeightConstrait.constant = view.frame.width * 1.4
        calcCollectionView.backgroundColor = .clear
        
        view.backgroundColor = .black
    }

}

class CalcViewCell: UICollectionViewCell {
    
    let numberLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.text = "1"
        label.font = .boldSystemFont(ofSize: 32)
        label.clipsToBounds = true
        label.backgroundColor = .orange
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(numberLabel)
        
        numberLabel.frame.size = self.frame.size
        numberLabel.layer.cornerRadius = self.frame.height / 2
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

