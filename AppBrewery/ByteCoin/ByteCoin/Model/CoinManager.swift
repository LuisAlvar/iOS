//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//
import Foundation
protocol CoinManagerDelegate {
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)
}
struct CoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = Bundle.main.object(forInfoDictionaryKey: "COIN_BASE_API_KEY") as? String ?? ""
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS",
                         "INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK",
                         "SGD","USD","ZAR"]
    var delegate: CoinManagerDelegate?
    var cacheManager = CoinCacheManager()
    func getCoinPrice(for currency: String){
        print(currency)
        if let cached = cacheManager.getCachedCoinModel(for: currency) {
            print("Using cached coin for \(currency)")
            delegate?.didUpdateCoin(self, coin: cached)
            return
        }
        else {
            let urlString = "\(baseURL)/\(currency)"
            print(urlString)
            performRequestAndUpdate(with: urlString)
        }
    }
    func performRequestAndUpdate(with urlString: String){
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-CoinAPI-Key")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("Request error: \(error, default: "") ")
                return
            }
            if let safeData = data {
                if let result = parseJSON(safeData) {
                    self.cacheManager.cacheCoinCurrency(result)
                    self.delegate?.didUpdateCoin(self, coin: result)
                }
            }
        }
        task.resume()
    }
    func parseJSON(_ exchangeData: Data) -> CoinModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinModel.self, from: exchangeData)
            return decodedData
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
