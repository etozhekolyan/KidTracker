//
//  DescriptionPointView.swift
//  KidTracker
//
//  Created by Nickolay Vasilchenko on 25.08.2023.
//

import UIKit

class DescriptionPointView: UIView {
//MARK: - UI elements
    private let kidImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.blue.cgColor
        return imageView
    }()
    
    private var kidsNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private var wifiIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "wifi")
        return imageView
    }()
    
    private var calendarIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "calendar")
        return imageView
    }()
    
    private var clockIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "clock")
        return imageView
    }()
    
    private var connectionTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "GPS"
        return label
    }()
    
    private var lastDateLabel: UILabel = {
        let label = UILabel()
        label.text = "12.12.2023"
        return label
    }()
    
    private var lastTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "14:00"
        return label
    }()
    
    private var showHistoryButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.backgroundColor = .blue
        button.setTitle("Show history", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
//MARK: - initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        fillHierarhy()
        configureLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .white
    }
//MARK: - Public interface
    public func transferData(kidsName: String, kidsImage: String) {
        kidsNameLabel.text = kidsName
        kidImage.image = UIImage(named: kidsImage)
    }
//MARK: - setup view
    private func fillHierarhy() {
        [kidImage,
         kidsNameLabel,
         connectionTypeLabel,
         lastDateLabel,
         lastTimeLabel,
         wifiIcon,
         calendarIcon,
         clockIcon,
         showHistoryButton
        ].forEach { self.addSubview($0) }
    }
//MARK: - Layouts
    private func configureLayouts() {
        kidImage.setAnchors(top: self.topAnchor, botton: nil, left: self.leadingAnchor, right: nil,
                            padding: .init(top: 20, left: 15, bottom: 0, right: 0),
                            size: .init(width: 70, height: 70))
        kidsNameLabel.setAnchors(top: kidImage.topAnchor, botton: nil, left: kidImage.leadingAnchor, right: nil,
                                 padding: .init(top: 0, left: 75, bottom: 0, right: 0),
                                 size: .init(width: 100, height: 25))
        wifiIcon.setAnchors(top: kidsNameLabel.topAnchor, botton: nil, left: kidImage.leadingAnchor, right: nil,
                            padding: .init(top: 35, left: 75, bottom: 0, right: 0),
                            size: .init(width: 25, height: 25))
        connectionTypeLabel.setAnchors(top: kidsNameLabel.topAnchor, botton: nil, left: wifiIcon.leadingAnchor, right: nil,
                            padding: .init(top: 35, left: 35, bottom: 0, right: 0),
                            size: .init(width: 40, height: 25))
        calendarIcon.setAnchors(top: kidsNameLabel.topAnchor, botton: nil, left: connectionTypeLabel.leadingAnchor, right: nil,
                                padding: .init(top: 35, left: 45, bottom: 0, right: 0),
                                size: .init(width: 25, height: 25))
        lastDateLabel.setAnchors(top: kidsNameLabel.topAnchor, botton: nil, left: calendarIcon.leadingAnchor, right: nil,
                                padding: .init(top: 35, left: 30, bottom: 0, right: 0),
                                size: .init(width: 85, height: 25))
        clockIcon.setAnchors(top: kidsNameLabel.topAnchor, botton: nil, left: lastDateLabel.leadingAnchor, right: nil,
                                padding: .init(top: 35, left: 90, bottom: 0, right: 0),
                                size: .init(width: 25, height: 25))
        lastTimeLabel.setAnchors(top: kidsNameLabel.topAnchor, botton: nil, left: clockIcon.leadingAnchor, right: nil,
                                padding: .init(top: 35, left: 30, bottom: 0, right: 0),
                                size: .init(width: 50, height: 25))
        showHistoryButton.setAnchors(top: connectionTypeLabel.topAnchor, botton: nil, left: self.leadingAnchor, right: nil,
                                padding: .init(top: 60, left: 90, bottom: 0, right: 0),
                                size: .init(width: 200, height: 45))
    }
    
}
