//
//  CityDetailVC.swift
//  SiriusiOSAssignment
//
//  Created by Nay Oo Linn on 06/10/2022.
//

import MapKit
import UIKit
import RxSwift

// MARK: - Class & Life Cycle
class CityDetailVC: BaseVC, Storyboarded {
    
    static var storyboardName: String = Storyboard.main
    
    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var btnMap: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    
    // MARK: Variables
    private lazy var router = CityDetailRouter(viewController: self)
    let disposeBag = DisposeBag()
    
    var data: CityData?
    
    // MARK: View Lifecycles And View Setups
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        binding()
    }
}

// MARK: - Setup Data
extension CityDetailVC {
    
    func setData() {
        setMapData()
    }
    
    func setMapData() {
        guard let data = data, let coord = data.coord else { return }
        let location = CLLocationCoordinate2D(
            latitude: coord.lat ?? 0,
            longitude: coord.lon ?? 0
        )
        let region = MKCoordinateRegion(
            center: location,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        let point = MKPointAnnotation()
        point.title = data.name
        point.coordinate = location
        mapView.addAnnotation(point)
        mapView.setRegion(
            region,
            animated: true
        )
    }
    
    func setInfoData() {
        lblCityName.text = data?.name
        lblLocation.text = "\(data?.coord?.latDMS ?? "") | \(data?.coord?.lonDMS ?? "")"
    }
    
}

// MARK: - Binding
extension CityDetailVC {
    func binding() {
        btnMap.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let data = self?.data else { return }
                self?.router.routeToMap(
                    lat: data.coord?.lat,
                    lon: data.coord?.lon,
                    name: data.name
                )
            })
            .disposed(by: disposeBag)
        
        btnClose.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

