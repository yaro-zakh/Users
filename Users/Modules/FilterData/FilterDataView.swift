//
//  FilterDataView.swift
//  Users
//
//  Created by Kateryna Zakharchuk on 10/27/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import UIKit

protocol FilterView {
    func filterData(first: Character, second: Character)
}


@IBDesignable
class FilterDataView: UIView {
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var firstLetter: UITextField!
    @IBOutlet weak var secondLetter: UITextField!
    
    var delegate: FilterView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        filterButtonStyle()
        addTargetToTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func addTargetToTextField() {
        firstLetter.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingChanged)
        secondLetter.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        if firstLetter.text?.isEmpty == false && secondLetter.text?.isEmpty == false {
            filterButton.isEnabled = true
        } else {
            filterButton.isEnabled = false
        }
    }
    
    private func filterButtonStyle() {
        filterButton.layer.cornerRadius = 4
        filterButton.clipsToBounds = true
    }
    
    private func commonInit() {
        let xibView = loadViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
    }
    
    private func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "FilterDataView", bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
    }
    
    @IBAction func filterButtonAction(_ sender: UIButton) {
        delegate?.filterData(first: Character(firstLetter.text!), second: Character(secondLetter.text!))
    }
}

extension FilterDataView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        return updatedText.count <= 1
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
