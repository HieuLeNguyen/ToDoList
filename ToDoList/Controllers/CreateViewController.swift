//
//  CreateViewController.swift
//  ToDoList
//
//  Created by Nguyễn Văn Hiếu on 14/10/24.
//

import UIKit

class CreateViewController: UIViewController {
    //MARK: - Properties
    private let fieldLabel: UILabel = {
        let _label = UILabel()
        _label.text = "Task:"
        _label.font = .systemFont(ofSize: 16)
        _label.numberOfLines = 0
        _label.textAlignment = .left
        return _label
    }()
    
    private let nameField: UITextField = {
        let _textField = UITextField()
        _textField.placeholder = "Enter your task..."
        _textField.layer.borderWidth = 1
        _textField.layer.borderColor = UIColor.lightGray.cgColor
        _textField.layer.cornerRadius = 10
        _textField.leftViewMode = .always
        _textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        _textField.rightViewMode = .always
        _textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        return _textField
    }()
    
    private let descLabel: UILabel = {
        let _label = UILabel()
        _label.text = "Description:"
        _label.font.withSize(12)
        _label.numberOfLines = 6
        _label.textAlignment = .left
        return _label
    }()
    
    private let descField: UITextField = {
        let _textField = UITextField()
        _textField.placeholder = "Enter your description..."
        _textField.layer.borderWidth = 1
        _textField.layer.borderColor = UIColor.lightGray.cgColor
        _textField.layer.cornerRadius = 10
        _textField.leftViewMode = .always
        _textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        _textField.rightViewMode = .always
        _textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        return _textField
    }()
    
    private let chooseTime: UIDatePicker = {
        let _datePicker = UIDatePicker()
        _datePicker.datePickerMode = .countDownTimer
        _datePicker.timeZone = .autoupdatingCurrent
        _datePicker.preferredDatePickerStyle = .automatic
        _datePicker.minimumDate = .now
        //Max 30day
        _datePicker.maximumDate = Date().addingTimeInterval(60 * 60 * 24 * 30)
        return _datePicker
    }()
    
    private let previewImage: UIImageView = {
        let _imageView = UIImageView()
        _imageView.image = UIImage(systemName: "photo")
        _imageView.contentMode = .scaleAspectFill
        _imageView.tintColor = .lightGray
        return _imageView
    }()
    
    private let upLoadButton: UIButton = {
        let _button = UIButton()
        _button.setTitleColor(.white, for: .normal)
        _button.setTitle("Upload Image", for: .normal)
        _button.backgroundColor = .systemBlue
        _button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        _button.titleLabel?.textAlignment = .center
        _button.titleLabel?.numberOfLines = 0
        _button.layer.cornerRadius = 10
        return _button
    }()
    
    var onCreate: ((TodoItem) -> Void)?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Task"
        
        setupViews()
        setupLayout()
        
        let saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTask))
        navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
    //MARK:
    @objc private func saveTask() {
        guard let title = nameField.text,
              let desc = descField.text else { return }
        
        let todoItem = TodoItem(title: title,
                                description: desc,
                                image: (previewImage.image == UIImage(systemName: "photo"))
                                ? UIImage(systemName: "seal") :
                                    previewImage.image,
                                type: TodoTypes.new)
        
        print(title)
        print(desc)
        
        onCreate?(todoItem)
        
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: Setup methods
    private func setupViews() {
        [fieldLabel,
         nameField,
         descLabel,
         descField,
         chooseTime,
         previewImage,
         upLoadButton].forEach(
            {
                $0.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview($0)
            }
         )
        
    }
    
    private func setupLayout() {
        view.layoutMargins = UIEdgeInsets(top: 6,
                                          left: 10,
                                          bottom: 6,
                                          right: 10)
        
        NSLayoutConstraint.activate([
            fieldLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            fieldLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            nameField.topAnchor.constraint(equalTo: fieldLabel.bottomAnchor, constant: 8),
            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameField.heightAnchor.constraint(equalToConstant: 40),
            
            descLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            descLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            descField.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 8),
            descField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descField.heightAnchor.constraint(equalToConstant: 40),
            
            chooseTime.topAnchor.constraint(equalTo: descField.bottomAnchor, constant: 20),
            chooseTime.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            previewImage.topAnchor.constraint(equalTo: chooseTime.bottomAnchor, constant: 40),
            previewImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            previewImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            previewImage.heightAnchor.constraint(equalToConstant: 200),
            
            upLoadButton.topAnchor.constraint(equalTo: previewImage.bottomAnchor, constant: 40),
            upLoadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            upLoadButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),
            upLoadButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
}
