//
//  PaymentAnalysisViewController.swift
//  notyng
//
//  Created by João Pedro on 02/05/23.
//

import UIKit
import DGCharts

class PaymentAnalysisViewController: UIViewController {
    
    // MARK: - Properties
    private var closeButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.tintColor = .white
        button.setBackgroundImage(Icons.close, for: .normal)
        
        return button
    }()
    
    private var viewContent: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.backgroundSecondaryColor
        view.layer.cornerRadius = ValueConst.x14
        view.heroID = HeroIds.background
        
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.titleBold64
        label.textAlignment = .left
        label.text = "notyn"
        label.numberOfLines = 0
        label.textColor = Colors.backgroundTertiaryColor
        label.heroID = HeroIds.title
        
        return label
    }()
    
    private lazy var pieChartView: PieChartView = {
        let chartView = PieChartView()
        let d = Description()
        
        d.text = "Tipos de pagamento"
        d.textColor = Colors.backgroundSecondaryColor ?? .black
        
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.chartDescription = d
        chartView.centerText = ""
        chartView.holeRadiusPercent = 0.2
        chartView.transparentCircleColor = UIColor.clear
        chartView.noDataText = "Sem dados"
        chartView.noDataTextColor = Colors.backgroundSecondaryColor ?? .black
        chartView.isUserInteractionEnabled = true
        
        return chartView
    }()
    
    private lazy var viewModel: PaymentAnalysisViewModel = {
        let viewModel = PaymentAnalysisViewModel()
        
        viewModel.delegate = self
        
        return viewModel
    }()
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupLayout()
        setupLayoutConstraints()
        setupActions()
        viewModel.fetchData()
    }
    
    // MARK: - Layout Setups
    private func setupLayout() {
        view.backgroundColor = Colors.primaryColor
        view.addSubview(closeButton)
        view.addSubview(viewContent)
        viewContent.addSubview(titleLabel)
        viewContent.addSubview(pieChartView)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ValueConst.x8),
            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ValueConst.x16),
            closeButton.heightAnchor.constraint(equalToConstant: ValueConst.x24),
            closeButton.widthAnchor.constraint(equalToConstant: ValueConst.x24),
            
            viewContent.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: ValueConst.x16),
            viewContent.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -ValueConst.x16),
            viewContent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ValueConst.x16),
            viewContent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -ValueConst.x16),
            
            titleLabel.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: ValueConst.x12),
            titleLabel.centerXAnchor.constraint(equalTo: viewContent.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: ValueConst.x64),
            
            pieChartView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ValueConst.x16),
            pieChartView.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: ValueConst.x16),
            pieChartView.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -ValueConst.x16),
            pieChartView.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -ValueConst.x16),
            
        ])
    }
    
    private func setupChart() {
        let track = ["Pix", "Cartão", "Dinheiro"]
        var entries = [PieChartDataEntry]()
        
        for (index, value) in viewModel.paymentEntries.enumerated() {
            let entry = PieChartDataEntry()
            entry.y = Double(value)
            entry.label = track[index]
            entries.append(entry)
        }
        
        let set = PieChartDataSet(entries: entries, label: "")
        set.entryLabelColor = Colors.backgroundSecondaryColor
        var colors: [UIColor] = []
        
        colors.append(Colors.primaryColor ?? .white)
        colors.append(Colors.secondaryColor ?? .white)
        colors.append(Colors.tertiaryColor ?? .white)
        
        set.colors = colors
        let data = PieChartData(dataSet: set)
        pieChartView.data = data
    }
    
    // MARK: - Action Setups
    private func setupActions() {
        closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    @objc
    private func dismissView() {
        self.dismiss(animated: true)
    }
}


// MARK: - Extensions
extension PaymentAnalysisViewController: PaymentAnalysisProtocol {
    func fetchPaymentEntriesData() {
        setupChart()
    }
    
    func fetchPaymentEntriesFailData() {
        setupChart()
    }
}

