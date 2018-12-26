//
//  UserViewController.swift
//  SwiftyCompanion
//
//  Created by Ruslan on 04.11.2018.
//  Copyright © 2018 Ruslan NAUMENKO. All rights reserved.
//

import UIKit
import Charts

class UserViewController: UIViewController {

    //MARK: - Properties
    var user: UserModel!
    
    private let scrollView = UIScrollView()
    
    private let backImageViewContainer: MyUIView = {
        let view = MyUIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private let backImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "intra_background")
        
        imageView.image = image
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 60
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let displayNameLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let walletLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let correctionPointsLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let levelSlider: MyUISlider = {
        let slider = MyUISlider(height: 14.0)
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.tintColor = UIColor.green
        slider.setThumbImage(UIImage(), for: UIControl.State.normal)
        
        return slider
    }()
    
    private let skillsLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.text = "Skills"
        label.font = UIFont.systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Chart", "Sliders"])
        
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        control.addTarget(self, action: #selector(selectedView), for: .valueChanged)
        return control
    }()
    
    private let skillsContainer: MyUIView = {
        let view = MyUIView()
        
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let barChartView = BarChartView()
    private let skillsScrollView = UIScrollView()
    
    private let projectsLabel: UILabel = {
        let label = UILabel()

        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.text = "Projects"
        label.font = UIFont.systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private let projectsContainer: MyUIView = {
        let view = MyUIView()

        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.layer.cornerRadius = 25
        tableView.clipsToBounds = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
        
        setNavBar()
        setScrollView()
        setBackImage()
        setPhoto()
        setSlider()
        setLabels()
        setChartSkillsContainer()
        setSlidersSkillsContainer()
        setPojectsContainer()
        
        // shrink the size of the main scroll view to fit all subviews
        scrollView.subviews.last?.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20).isActive = true

    }
    
    //MARK: - setUIs
    
    /// Installation of the navigation bar
    private func setNavBar() {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "Profile"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textAlignment = .center
        label.textColor = .black
        navigationItem.titleView = label
        
    }
    
    /// Installation of the main scroll view
    private func setScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        scrollView.backgroundColor = scrollView.superview?.backgroundColor
        
        scrollViewConstraints()
    }
    
    /// Installation of the back image in the container to provide a shadow
    private func setBackImage() {
        backImageViewContainer.addSubview(backImageView)
        scrollView.addSubview(backImageViewContainer)
        
        backImageViewConstraints()
    }
    
    /// Installation of the user's photo
    private func setPhoto() {
        let activityIndicator: UIActivityIndicatorView = {
            let actInd = UIActivityIndicatorView()
            
            actInd.hidesWhenStopped = true
            actInd.color = .white
            actInd.translatesAutoresizingMaskIntoConstraints = false
            
            return actInd
        }()
        
        let imageStr = user.imageURL
        let imageUrl = URL(string: imageStr)
        
        photoImageView.addSubview(activityIndicator)
        backImageView.addSubview(photoImageView)
        
        photoImageViewConstraints(activityIndicator)
        
        activityIndicator.startAnimating()
        DispatchQueue.global(qos: .utility).async {
            if let data = try? Data(contentsOf: imageUrl!) {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                    let image = UIImage(data: data)
                    self.photoImageView.image = image
                }
            }
        }
    }
    
    /// Installation of the user's level slider
    private func setSlider() {
        
        levelSlider.value = Float(String("0." + user.level.components(separatedBy: ".")[1]))!
        backImageView.addSubview(levelSlider)
        
        levelSliderConstraints()
    }
    
    /// Installation of the user's general info labels
    private func setLabels() {
        
        displayNameLabel.text = user.displayname.uppercased()
        backImageView.addSubview(displayNameLabel)
        
        loginLabel.text = user.login
        backImageView.addSubview(loginLabel)
        
        walletLabel.text = "Wallet: " + user.wallet
        backImageView.addSubview(walletLabel)
        
        correctionPointsLabel.text = "Correction: " + user.correctionPoints
        backImageView.addSubview(correctionPointsLabel)
        
        phoneLabel.text = user.phone
        backImageView.addSubview(phoneLabel)
        
        emailLabel.text = user.email
        backImageView.addSubview(emailLabel)
        
        levelLabel.text = "Level : " + user.level.components(separatedBy: ".")[0] + " - " + String(Int(user.level.components(separatedBy: ".")[1])!) + "%"
        backImageView.addSubview(levelLabel)

        labelConstraints()
    }
    
    /// Installation of the user's skills info container (chart)
    private func setChartSkillsContainer() {
        scrollView.addSubview(skillsLabel)
        scrollView.addSubview(segmentedControl)
        
        barChartView.isUserInteractionEnabled = false
        barChartView.translatesAutoresizingMaskIntoConstraints = false
        barChartView.noDataText = "Oh"
        let skills = user.skills
        var skillsText = [String]()
        var skillsLevel = [Double]()
        
        for skill in skills {
            skillsText.append((skill as! NSDictionary)["name"] as! String)
            skillsLevel.append(((skill as! NSDictionary)["level"] as! NSNumber).doubleValue)
        }
        
        var dataEntries = [BarChartDataEntry]()
        
        for i in 0..<skills.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: skillsLevel[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "")
        chartDataSet.drawValuesEnabled = false
        chartDataSet.colors = ChartColorTemplates.colorful()
        
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: skillsText)
        barChartView.xAxis.labelCount = skillsText.count
        barChartView.xAxis.labelRotationAngle = -90.0
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.granularityEnabled = true
        barChartView.xAxis.granularity = 1
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelFont = UIFont.boldSystemFont(ofSize: 6)
        barChartView.rightAxis.enabled = false
        barChartView.legend.enabled = false
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        
        scrollView.addSubview(skillsLabel)
        skillsContainer.layer.cornerRadius = 25
        skillsContainer.addSubview(barChartView)
        scrollView.addSubview(skillsContainer)
        
        chartSkillsContainerConstraints()
    }

    /// Installation of the user's skills info container (common)
    private func setSlidersSkillsContainer() {
        let skills = user.skills
        let skillsStack = MyStack(array: skills)

        var sliderLabels = [UILabel]()

        for i in 0..<skills.count {
            let sliderLabel = UILabel()
            sliderLabel.text = String(((skills[i] as! NSDictionary)["level"] as! NSNumber).floatValue)
            sliderLabel.textColor = .black
            sliderLabel.font = UIFont.systemFont(ofSize: 8.0)
            sliderLabel.translatesAutoresizingMaskIntoConstraints = false
            sliderLabels.append(sliderLabel)
        }

        skillsScrollView.translatesAutoresizingMaskIntoConstraints = false
        skillsScrollView.layer.cornerRadius = 25
        skillsScrollView.clipsToBounds = true
        skillsScrollView.alwaysBounceVertical = true

        skillsScrollView.addSubview(skillsStack)
        for i in 0..<sliderLabels.count {
            skillsScrollView.addSubview(sliderLabels[i])

            sliderLabels[i].centerXAnchor.constraint(equalTo: skillsStack.subviews[i].subviews[1].centerXAnchor).isActive = true
            sliderLabels[i].centerYAnchor.constraint(equalTo: skillsStack.subviews[i].subviews[1].centerYAnchor).isActive = true
        }

        skillsContainer.layer.cornerRadius = 25
        skillsContainer.addSubview(skillsScrollView)
        skillsScrollView.isHidden = true
        scrollView.addSubview(skillsContainer)

        slidersSkillsContainerConstraints(skillsStack: skillsStack)
    }
    
    /// Installation of the user's projects info container
    private func setPojectsContainer() {
        tableView.dataSource = self
        tableView.delegate = self
        
        scrollView.addSubview(projectsLabel)
        
        projectsContainer.layer.cornerRadius = 25
        projectsContainer.addSubview(tableView)
        scrollView.addSubview(projectsContainer)
        
        projectsContainerConstraints()
    }
    
    //MARK: - Constraints
    
    /// Main scroll view constraints
    private func scrollViewConstraints() {
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    /// Constraints for the back image view and its container
    private func backImageViewConstraints() {
        backImageViewContainer.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        backImageViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -16).isActive = true
        backImageViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
        backImageViewContainer.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        backImageView.topAnchor.constraint(equalTo: backImageViewContainer.topAnchor).isActive = true
        backImageView.rightAnchor.constraint(equalTo: backImageViewContainer.rightAnchor).isActive = true
        backImageView.bottomAnchor.constraint(equalTo: backImageViewContainer.bottomAnchor).isActive = true
        backImageView.leftAnchor.constraint(equalTo: backImageViewContainer.leftAnchor).isActive = true
    }
    
    /// Constraints for the user's photo and its activity indicator
    private func photoImageViewConstraints(_ activityIndicator: UIActivityIndicatorView) {
        photoImageView.topAnchor.constraint(equalTo: self.backImageView.topAnchor, constant: 16).isActive = true
        photoImageView.leftAnchor.constraint(equalTo: self.backImageView.leftAnchor, constant: 16).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor).isActive = true
    }
    
    /// User's level slider constraints
    private func levelSliderConstraints() {
        levelSlider.bottomAnchor.constraint(equalTo: backImageView.bottomAnchor, constant: -16).isActive = true
        levelSlider.leftAnchor.constraint(equalTo: photoImageView.leftAnchor).isActive = true
        levelSlider.rightAnchor.constraint(equalTo: backImageView.rightAnchor, constant: -16).isActive = true
    }
    
    /// Constraints for the user's general info labels
    private func labelConstraints() {
        displayNameLabel.leftAnchor.constraint(equalTo: photoImageView.leftAnchor).isActive = true
        displayNameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8).isActive = true
        displayNameLabel.rightAnchor.constraint(equalTo: photoImageView.rightAnchor).isActive = true
        
        loginLabel.topAnchor.constraint(equalTo: photoImageView.topAnchor).isActive = true
        loginLabel.rightAnchor.constraint(equalTo: backImageView.rightAnchor, constant: -16).isActive = true
        loginLabel.leftAnchor.constraint(equalTo: backImageView.centerXAnchor, constant: 16).isActive = true
        
        walletLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 8).isActive = true
        walletLabel.rightAnchor.constraint(equalTo: loginLabel.rightAnchor).isActive = true
        walletLabel.leftAnchor.constraint(equalTo: loginLabel.leftAnchor).isActive = true
        
        correctionPointsLabel.topAnchor.constraint(equalTo: walletLabel.bottomAnchor, constant: 8).isActive = true
        correctionPointsLabel.rightAnchor.constraint(equalTo: walletLabel.rightAnchor).isActive = true
        correctionPointsLabel.leftAnchor.constraint(equalTo: walletLabel.leftAnchor).isActive = true
        
        phoneLabel.topAnchor.constraint(equalTo: correctionPointsLabel.bottomAnchor, constant: 8).isActive = true
        phoneLabel.rightAnchor.constraint(equalTo: correctionPointsLabel.rightAnchor).isActive = true
        phoneLabel.leftAnchor.constraint(equalTo: correctionPointsLabel.leftAnchor).isActive = true
        
        emailLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 8).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: phoneLabel.rightAnchor).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: phoneLabel.leftAnchor).isActive = true
        
        levelLabel.bottomAnchor.constraint(equalTo: levelSlider.topAnchor, constant: -8).isActive = true
        levelLabel.rightAnchor.constraint(equalTo: backImageView.rightAnchor, constant: -16).isActive = true
        levelLabel.leftAnchor.constraint(equalTo: backImageView.leftAnchor, constant: 16).isActive = true
        
    }
    
    /// Constraints for the user's skills info container (chart)
    private func chartSkillsContainerConstraints() {
        skillsLabel.topAnchor.constraint(equalTo: backImageViewContainer.bottomAnchor, constant: 16).isActive = true
        skillsLabel.leadingAnchor.constraint(equalTo: backImageViewContainer.leadingAnchor).isActive = true
        
        segmentedControl.topAnchor.constraint(equalTo: backImageViewContainer.bottomAnchor, constant: 16).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: backImageViewContainer.trailingAnchor).isActive = true
        
        skillsContainer.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        skillsContainer.widthAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.widthAnchor, constant: -16).isActive = true
        skillsContainer.topAnchor.constraint(equalTo: skillsLabel.bottomAnchor, constant: 8).isActive = true
        skillsContainer.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        barChartView.centerXAnchor.constraint(equalTo: skillsContainer.centerXAnchor).isActive = true
        barChartView.widthAnchor.constraint(equalTo: skillsContainer.widthAnchor).isActive = true
        barChartView.topAnchor.constraint(equalTo: skillsContainer.topAnchor).isActive = true
        barChartView.bottomAnchor.constraint(equalTo: skillsContainer.bottomAnchor, constant: -8).isActive = true
    }
    
    /// Constraints for the user's skills info container (common)
    private func slidersSkillsContainerConstraints(skillsStack: MyStack) {
        skillsScrollView.centerXAnchor.constraint(equalTo: skillsContainer.centerXAnchor).isActive = true
        skillsScrollView.widthAnchor.constraint(equalTo: skillsContainer.widthAnchor).isActive = true
        skillsScrollView.topAnchor.constraint(equalTo: skillsContainer.topAnchor).isActive = true
        skillsScrollView.bottomAnchor.constraint(equalTo: skillsContainer.bottomAnchor).isActive = true
        
        skillsStack.leadingAnchor.constraint(equalTo: skillsScrollView.leadingAnchor).isActive = true
        skillsStack.trailingAnchor.constraint(equalTo: skillsScrollView.trailingAnchor).isActive = true
        skillsStack.topAnchor.constraint(equalTo: skillsScrollView.topAnchor).isActive  = true
        skillsStack.bottomAnchor.constraint(equalTo: skillsScrollView.bottomAnchor).isActive = true
        skillsStack.widthAnchor.constraint(equalTo: skillsScrollView.widthAnchor).isActive = true
    }
    
    /// Constraints for the user's projects info container
    private func projectsContainerConstraints() {
        projectsLabel.topAnchor.constraint(equalTo: skillsContainer.bottomAnchor, constant: 16).isActive = true
        projectsLabel.leadingAnchor.constraint(equalTo: skillsContainer.leadingAnchor).isActive = true
        
        projectsContainer.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        projectsContainer.widthAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.widthAnchor, constant: -16).isActive = true
        projectsContainer.topAnchor.constraint(equalTo: projectsLabel.bottomAnchor, constant: 8).isActive = true
        projectsContainer.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        tableView.centerXAnchor.constraint(equalTo: projectsContainer.centerXAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: projectsContainer.widthAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: projectsContainer.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: projectsContainer.bottomAnchor).isActive = true
    }
    
    //MARK: - Selector
    
    /// Change the subview of skills container
    @objc func selectedView(target: UISegmentedControl) {
        if target == segmentedControl {
            switch target.selectedSegmentIndex {
            case 0:
                barChartView.isHidden = false
                skillsScrollView.isHidden = true
            case 1:
                barChartView.isHidden = true
                skillsScrollView.isHidden = false
            default:
                break
            }
        }
    }
}

// MARK: - extensions for UITableViewDataSource and UITableViewDelegate

extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyTableViewCell
        
        cell.model = CellModel(projectName: ((user.projects[indexPath.row]["project"] as! NSDictionary)["name"] as? String)!, projectMark: String((user.projects[indexPath.row]["final_mark"] as! NSNumber).floatValue) + "%", validated: user.projects[indexPath.row]["validated?"] as! NSNumber)
        
        cell.layoutIfNeeded()
        return cell
    }
    
}

extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
