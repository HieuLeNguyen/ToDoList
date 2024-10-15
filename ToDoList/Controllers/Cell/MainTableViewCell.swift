//
//  MainTableViewCell.swift
//  ToDoList
//
//  Created by Nguyễn Văn Hiếu on 14/10/24.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    //MARK: - Properties
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    var todo: TodoItem? {
        didSet {
            guard let todo else { return }
            
            titleLabel.text = todo.title
            descLabel.text = todo.description
            durationLabel.text = todo.duration?.formattedDuration() ?? "..."
            previewImageView.image = todo.image ?? UIImage(systemName: "seal")
        }
    }
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            contentView.backgroundColor = UIColor.green.withAlphaComponent(0.2)
        } else {
            contentView.backgroundColor = UIColor.white
        }
    }
    
    //MARK: - Setup methods
    private func setupViews(){
        previewImageView.image = UIImage(systemName: "seal")
        statusLabel.textColor = .white
        statusLabel.backgroundColor = .systemBlue
        statusLabel.text = "unfinished"
        statusLabel.layer.cornerRadius = 10
    }
    
}
