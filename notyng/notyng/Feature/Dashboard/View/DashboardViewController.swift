//
//  DashboardViewController.swift
//  notyng
//
//  Created by João Pedro on 20/03/23.
//

import UIKit
import Lottie
import Hero

class DashboardViewController: UIViewController {
    
    // MARK: - Properties
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.titleBold64
        label.textAlignment = .left
        label.text = "notyn"
        label.numberOfLines = 0
        label.textColor = Colors.backgroundPrimaryColor
        label.heroID =  HeroIds.title
        
        return label
    }()
    
    private var totalValueLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.titleBold24
        label.textAlignment = .right
        label.text = "R$ ?"
        label.numberOfLines = 0
        label.textColor = Colors.backgroundPrimaryColor
        label.heroID = HeroIds.totalPrice
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    private var dashboardAnimationView: LottieAnimationView = {
        let view = LottieAnimationView(name: "lottie_order_animation")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var dashboardView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.backgroundSecondaryColor
        view.layer.cornerRadius = ValueConst.x14
        view.heroID = HeroIds.background
        
        return view
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
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        refreshControl.tintColor = Colors.primaryColor
        
        return refreshControl
    }()
    
    private var addOrderButton: FloatingButton = FloatingButton(backgroundColor: Colors.primaryColor,
                                                                iconImage: Icons.addOrder,
                                                                cornerRadius: ValueConst.x32)
    
    private lazy var viewModel: DashboardViewModel = {
        let vm = DashboardViewModel()
        
        vm.delegate = self
        
        return vm
    }()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLoader()
        hero.isEnabled = true
        
        setupLayout()
        setupLayoutConstraints()
        setupAction()
        
        dashboardAnimationView.play()
        viewModel.fetchData()
    }
    
    // MARK: - Layout Setups
    private func setupLayout() {
        view.backgroundColor = Colors.primaryColor
        addOrderButton.translatesAutoresizingMaskIntoConstraints = false
        addOrderButton.heroID = HeroIds.floatingButton
        
        view.addSubview(dashboardAnimationView)
        view.addSubview(titleLabel)
        view.addSubview(totalValueLabel)
        view.addSubview(dashboardView)
        
        dashboardView.addSubview(ordersTableView)
        dashboardView.addSubview(addOrderButton)
        
        ordersTableView.register(OrderTableViewCell.self, forCellReuseIdentifier: OrderTableViewCell.identifier)
        ordersTableView.refreshControl = refreshControl
        dashboardAnimationView.contentMode = .top
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ValueConst.x24),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ValueConst.x16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -ValueConst.x16),
            titleLabel.heightAnchor.constraint(equalToConstant: ValueConst.x64),
            
            totalValueLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            totalValueLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -ValueConst.x16),
            totalValueLabel.heightAnchor.constraint(equalToConstant: ValueConst.x48),
            totalValueLabel.widthAnchor.constraint(equalToConstant: ValueConst.x168),
            
            
            dashboardAnimationView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ValueConst.x24),
            dashboardAnimationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            dashboardAnimationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            dashboardAnimationView.heightAnchor.constraint(equalToConstant: ValueConst.x240),
            
            dashboardView.topAnchor.constraint(equalTo: dashboardAnimationView.bottomAnchor),
            dashboardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ValueConst.x16),
            dashboardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -ValueConst.x16),
            dashboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            ordersTableView.topAnchor.constraint(equalTo: dashboardView.topAnchor),
            ordersTableView.bottomAnchor.constraint(equalTo: dashboardView.bottomAnchor),
            ordersTableView.leadingAnchor.constraint(equalTo: dashboardView.leadingAnchor),
            ordersTableView.trailingAnchor.constraint(equalTo: dashboardView.trailingAnchor),
            
            addOrderButton.widthAnchor.constraint(equalToConstant: ValueConst.x64),
            addOrderButton.heightAnchor.constraint(equalToConstant: ValueConst.x64),
            addOrderButton.bottomAnchor.constraint(equalTo: dashboardView.bottomAnchor, constant: -ValueConst.x24),
            addOrderButton.trailingAnchor.constraint(equalTo: dashboardView.trailingAnchor, constant: -ValueConst.x16),
        ])
    }
    
    // MARK: - Action Setups
    private func setupAction() {
        addOrderButton.interactionButton.addTarget(self, action: #selector(addOrder), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(openAnalysis))
        totalValueLabel.addGestureRecognizer(tap)
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc
    private func addOrder() {
        let orderVC = OrderViewController()
        orderVC.hero.isEnabled = true
        orderVC.modalPresentationStyle = .overFullScreen
        
        self.present(orderVC, animated: true)
    }
    
    @objc
    private func openAnalysis() {
        let orderVC = PaymentAnalysisViewController()
        orderVC.hero.isEnabled = true
        orderVC.modalPresentationStyle = .overFullScreen
        
        self.present(orderVC, animated: true)
    }
    
    @objc
    private func refreshData() {
        viewModel.fetchData()
    }
}


// MARK: - Extensions
extension DashboardViewController: DashboardProtocol {
    public func fetchOrdersListData() {
        hideLoader()
        refreshControl.endRefreshing()
        ordersTableView.reloadData()
        let topRow = IndexPath(row: 0,
                               section: 0)
        self.ordersTableView.scrollToRow(at: topRow,
                                         at: .top,
                                         animated: true)
    }
    
    public func fetchOrdersListFailData() {
        hideLoader()
        refreshControl.endRefreshing()
        ordersTableView.reloadData()
    }
    
    public func fetchTotalValueData(totalValue: String) {
        totalValueLabel.text = totalValue
    }
    
    public func fetchTotalValueFailData() {
        totalValueLabel.text = "R$ ?"
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.identifier,
                                                       for: indexPath) as? OrderTableViewCell else {return UITableViewCell()}
        let order = viewModel.orders[indexPath.row]
        let products = order.products ?? []
        cell.setupCell(name: order.name,
                       date: order.orderDateCreate.toDate(),
                       products: products,
                       isOpen: order.isOpen)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = viewModel.orders[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let orderVC = OrderViewController()
        orderVC.hero.isEnabled = true
        orderVC.modalPresentationStyle = .overFullScreen
        orderVC.viewModel.order = order
        
        self.present(orderVC, animated: true)
    }
}
