//
//  ViewController.swift
//  calc
//
//  Created by 柴田謙真 on 2021/04/13.
//

import UIKit

class ViewController: UIViewController {
    enum CalcStatus {
        case none, plus, minus, multiplication, division
    }
    
    var firstNumber = ""
    var secondNumber = ""
    var calcStatus: CalcStatus = .none
    
    let numbers = [
        ["C","%","$","÷"],
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
        calcCollectionView.contentInset = .init(top: 0, left: 14, bottom: 0, right: 14)
        
        numberLabel.text = "0"
        view.backgroundColor = .black
    }

    
    func clear(){
        firstNumber = ""
        numberLabel.text = "0"
        calcStatus = .none
    }

}

extension ViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        var width:CGFloat = 0
        width = ((collectionView.frame.width - 10) - 14 * 5 ) / 4
        let height = width
        if indexPath.section == 4 && indexPath.row == 0 {
            width = width * 2 + 14 + 9
        }
        
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    //こちらでボタンのスタイル等を変えていく
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = calcCollectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CalcViewCell
        cell.numberLabel.text = numbers[indexPath.section][indexPath.row]
        
        numbers[indexPath.section][indexPath.row].forEach { (numberString) in
            if "0"..."9" ~= numberString || numberString.description == "." {
                cell.numberLabel.backgroundColor = .darkGray
            } else if numberString == "C" || numberString == "%" || numberString == "$" {
                cell.numberLabel.backgroundColor = UIColor.init(white: 1, alpha: 0.7)
                cell.numberLabel.textColor = .black
            }
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let number = numbers[indexPath.section][indexPath.row]
        
        switch calcStatus {
        case .none:
            switch number {
            case "0"..."9":
                firstNumber += number
                numberLabel.text = firstNumber
            
                if firstNumber.hasPrefix("0") {
                    firstNumber = ""
                }
            case ".":
                if !confirmIncludeDecimalPoint(numberString: firstNumber) {
                    firstNumber += number
                    numberLabel.text = firstNumber
                }
            case "+":
                firstNumber = numberLabel.text ?? ""
                calcStatus = .plus
            case "-":
                calcStatus = .minus
            case "×":
                calcStatus = .multiplication
            case "÷":
                calcStatus = .division
            case "C":
                clear()
            default:
               break
            }
        case .plus, .minus, .multiplication, .division:
            switch number {
            case "0"..."9":
                secondNumber += number
                numberLabel.text = secondNumber
                
                if secondNumber.hasPrefix("0") {
                    secondNumber = ""
                }

            case ".":
                if !confirmIncludeDecimalPoint(numberString: secondNumber){
                    secondNumber += number
                    numberLabel.text = secondNumber
                }
            case "=":
                let firstNum = Double(firstNumber) ?? 0
                let secondNum = Double(secondNumber) ?? 0
                
                var resultString: String?
                switch calcStatus {
                case .plus:
                    resultString = String(firstNum + secondNum)
                case .minus:
                    resultString = String(firstNum - secondNum)
                case .multiplication:
                    resultString = String(firstNum * secondNum)
                case .division:
                    resultString = String(firstNum / secondNum)
                default:
                    break
                }
                
                if let result = resultString, result.hasSuffix(".0"){
                    resultString = result.replacingOccurrences(of: ".0", with: "")
                }
                
                numberLabel.text = resultString
                firstNumber = ""
                secondNumber = ""
                
                firstNumber += resultString ?? ""
                calcStatus = .none
                
                
            case "C":
                clear()
            default:
                break
            }
        }
    }
    
    private func confirmIncludeDecimalPoint(numberString: String) -> Bool {
        if numberString.range(of: ".") != nil || numberString.count == 0{
            return true
        } else {
            return false
        }
    }
}

class CalcViewCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.numberLabel.alpha = 0.3
            } else {
                self.numberLabel.alpha = 1
            }
        }
    }
    
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

