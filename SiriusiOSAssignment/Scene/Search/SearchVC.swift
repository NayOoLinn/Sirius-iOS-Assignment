//
//  SearchVC.swift
//  SiriusiOSAssignment
//
//  Created by Nay Oo Linn on 06/10/2022.
//

import UIKit
import RxCocoa
import RxSwift

// MARK: - Class & Life Cycle
class SearchVC: BaseVC {

    // MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblCities: UITableView!

    //  MARK: Variables
    let viewModel = SearchVM()
    private lazy var router = SearchRouter(viewController: self)
    let disposeBag = DisposeBag()

    // MARK: View Lifecycles And View Setups
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        binding()
    }
    
    func setupView() {
        tblCities.register(nib: CityTableCell.className)
        tblCities.contentInset = .init(top: 4, left: 0, bottom: 20, right: 0)
        tblCities.estimatedRowHeight = 70
        tblCities.rowHeight = UITableView.automaticDimension
    }
}

// MARK: - Binding
extension SearchVC {
    func binding() {
        let search = searchBar.rx.text.orEmpty
            .debounce(
                .milliseconds(200),
                scheduler: MainScheduler.instance
            )
        
        let input = SearchVM.Input(
            viewDidAppear: rx.viewDidAppear.take(1).mapToVoid(),
            search: search.asObservable()
        )
        
        let output = viewModel.transform(input)
        
        output.error
            .drive(rx.error)
            .disposed(by: disposeBag)
        
        output.cities
            .drive(tblCities.rx.items(
                cellIdentifier: CityTableCell.className,
                cellType: CityTableCell.self
            )
            ) { _, data, cell in
                cell.setData(data)
            }
            .disposed(by: disposeBag)
        
        output.cities
            .drive(onNext: { [weak self] in
                guard $0.count > 0 else { return }
                self?.tblCities.scrollToRow(
                    at: .init(row: 0, section: 0),
                    at: .top,
                    animated: false
                )
            })
            .disposed(by: disposeBag)
        
        tblCities.rx.modelSelected(CityData.self)
            .subscribe(onNext: { [weak self] in
                self?.router.routeToDetail(data: $0)
            })
            .disposed(by: disposeBag)
    }
}

