//
//  HomeViewController.swift
//  Spared
//
//  Created by luis loo on 12/9/16.
//  Copyright © 2016 lloo. All rights reserved.
//

import UIKit
import Charts

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeChart: LineChartView!
    @IBOutlet weak var investChart: BarChartView!
    
    let gradientLayer = CAGradientLayer()
    let markerView = MarkerView()
    
    let dollar = [-0.9,-0.91,-0.91,-0.91,5.3,
                  -0.91,-0.90,-0.90,5.1,-0.90,
                  -0.90,5.7,-0.90,-0.90,-0.90,
                  -0.90,-0.90,-0.90,-0.90,5.4,
                  -0.90,-0.90,5.1,-0.90,-0.90,
                  -0.90,-0.90,5.7,-0.90,-0.90]
    
    var chartData: [Double] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationItem.hidesBackButton = true
        
        self.view.backgroundColor = UIColor(red: 66, green: 191, blue: 183)
        gradientLayer.frame = self.view.bounds
        
        let color1 = UIColor(red: 148, green: 203, blue: 112).cgColor as CGColor
        let color2 = UIColor(red: 66, green: 191, blue: 183).cgColor as CGColor
        let color3 = UIColor(red: 8, green: 123, blue: 135).cgColor as CGColor
        gradientLayer.colors = [color1, color2, color3]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        self.homeChart.delegate = self
        self.homeChart.chartDescription?.enabled = false
        self.homeChart.drawGridBackgroundEnabled = false
        self.homeChart.legend.enabled = false
        self.homeChart.pinchZoomEnabled = false
        self.homeChart.setScaleEnabled(false)
        
        self.homeChart.xAxis.enabled = false
        self.homeChart.leftAxis.enabled = false
        self.homeChart.rightAxis.enabled = false
        
        let marker = BalloonMarker(color: .clear, font: UIFont.systemFont(ofSize: 12), textColor: .white, insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0))
        marker.chartView = self.homeChart
        marker.minimumSize = CGSize(width: 80.0, height: 40.0)
        self.homeChart.marker = marker
        
        self.investChart.delegate = self
        self.investChart.chartDescription?.enabled = false
        self.investChart.drawGridBackgroundEnabled = false
        self.investChart.legend.enabled = false
        self.investChart.pinchZoomEnabled = false
        self.investChart.setScaleEnabled(false)
        
        self.investChart.xAxis.enabled = false
        self.investChart.leftAxis.enabled = false
        self.investChart.rightAxis.enabled = false
        
        let xyMarker = XYMarkerView(color: .clear, font: UIFont.systemFont(ofSize: 12), textColor: .white, insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0), xAxisValueFormatter: self.investChart.xAxis.valueFormatter!)
        xyMarker.chartView = self.investChart
        xyMarker.minimumSize = CGSize(width: 80.0, height: 40.0)
        self.investChart.marker = xyMarker

        self.setChartData()
    }
    
    func setChartData() {
        var data: [ChartDataEntry] = [ChartDataEntry]()
        var barData: [BarChartDataEntry] = []
        var currentAmount: Double  = 35978.36
        
        var points: [Double] = []
        
        for amount in dollar.enumerated() {
            currentAmount -= Double(amount.element)
            chartData.append(currentAmount)
            barData.append(BarChartDataEntry(x: Double(amount.offset), y: (amount.element > 0.0) ? Double(amount.element): 0.0))
        }
        
        for (index, day) in chartData.enumerated() {
            points.append(Double(index))
            data.append(ChartDataEntry(x: Double(index), y: day))
        }
        
        let set1: LineChartDataSet = LineChartDataSet(values: data, label: nil)
        
        set1.axisDependency = .left
        set1.setColor(UIColor(red: 179, green: 64, blue: 67).withAlphaComponent(0.5))
        set1.valueTextColor = .white
        set1.drawCirclesEnabled = false
        set1.drawValuesEnabled = false
        set1.lineWidth = 2.0
        set1.fillAlpha = 65 / 255.0
        set1.mode = .cubicBezier
        
        let set2: BarChartDataSet = BarChartDataSet(values: barData, label: nil)
        
        set2.axisDependency = .left
        set2.setColor(UIColor(red: 253, green: 194, blue: 15))
        set2.valueTextColor = .white
        set2.drawValuesEnabled = false
        
        let lineChartData = LineChartData(dataSets: [set1])
        let barChartData = BarChartData(dataSets: [set2])
        
        self.homeChart.data = lineChartData
        self.investChart.data = barChartData
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        if chartView == self.homeChart {
            self.investChart.highlightValue(x: entry.x, dataSetIndex: highlight.dataSetIndex, stackIndex: highlight.stackIndex)
        } else {
            self.homeChart.highlightValue(x: entry.x, y: self.chartData[Int(entry.x)], dataSetIndex: highlight.dataSetIndex)
        }
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        print(chartView)
    }
}
