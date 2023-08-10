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
        chartView.delegate = self
        
        return chartView
    }()
    
    private var totalValueLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.titleBold24
        label.textAlignment = .right
        label.text = "R$ ?"
        label.numberOfLines = 0
        label.textColor = Colors.backgroundTertiaryColor
        label.heroID = HeroIds.totalPrice
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    private lazy var ordersTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        return tableView
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
        viewContent.addSubview(totalValueLabel)
        viewContent.addSubview(ordersTableView)
        
        ordersTableView.register(OrderTableViewCell.self, forCellReuseIdentifier: OrderTableViewCell.identifier)
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
            pieChartView.heightAnchor.constraint(equalToConstant: ValueConst.x240),
            
            totalValueLabel.topAnchor.constraint(equalTo: pieChartView.bottomAnchor, constant: ValueConst.x8),
            totalValueLabel.trailingAnchor.constraint(equalTo: pieChartView.trailingAnchor),
            totalValueLabel.heightAnchor.constraint(equalToConstant: ValueConst.x64),
            
            ordersTableView.topAnchor.constraint(equalTo: totalValueLabel.bottomAnchor, constant: ValueConst.x8),
            ordersTableView.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor),
            ordersTableView.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor),
            ordersTableView.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -ValueConst.x16),
        ])
    }
    
    private func setupChart() {
        let track = ["Pix", "Cartão", "Dinheiro"]
        var entries = [PieChartDataEntry]()
        
        for (index, value) in viewModel.paymentEntries.enumerated() {
            let entry = PieChartDataEntry()
            entry.y = Double(value)
            entry.label = track[index]
            entry.accessibilityLabel = track[index]
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
    
    func fetchTotalValueByType(totalValue: String) {
        totalValueLabel.text = totalValue
    }
}

extension PaymentAnalysisViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        if (entry.y == Double(viewModel.paymentEntries.first ?? 0) && (entry.accessibilityLabel == "Pix")) {
            viewModel.getOrderByPayment(method: .pix)
        } else if (entry.y == Double(viewModel.paymentEntries.last ?? 0) && (entry.accessibilityLabel == "Dinheiro")) {
            viewModel.getOrderByPayment(method: .cash)
        } else {
            viewModel.getOrderByPayment(method: .card)
        }
        
        self.ordersTableView.reloadData()
    }
}

extension PaymentAnalysisViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getOrdersFilteredByPayment().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.identifier,
                                                       for: indexPath) as? OrderTableViewCell else {return UITableViewCell()}
        let order = viewModel.getOrdersFilteredByPayment()[indexPath.row]
        let products = order.products ?? []
        cell.setupCell(name: order.name,
                       date: order.orderDateCreate.toDate(),
                       products: products,
                       isOpen: order.isOpen)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
