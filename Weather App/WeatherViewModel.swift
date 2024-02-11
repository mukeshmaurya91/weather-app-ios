//
//  WeatherViewModel.swift
//  Weather App
//
//  Created by Mukesh Maurya on 11/02/24.
//

import Foundation

class WeatherViewModel : ObservableObject{
    
    @Published private (set) var weatherModel: WeatherData?
    
    @Published private (set) var cityName: String = "Bengaluru"
    
    @Published private (set) var isLoading: Bool = false
    private var forecast = "forecast"
    private var weather = "weather"
    init() {
        Task.init{
                isLoading.toggle()
                await fetchData()
            }
        }
    
    func fetchData() async{
        do {
                    guard let url = URL(string: "https://api.openweathermap.org/data/2.5/\(weather)?q=\(cityName)&APPID=9b8cb8c7f11c077f8c4e217974d9ee40&units=metric") else { fatalError("Missing URL") }
                    
                    let urlRequest = URLRequest(url: url)
                    
                    let (data, response) = try await URLSession.shared.data(for: urlRequest)
                    
                    guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
    
                    let decoder = JSONDecoder()
//                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(WeatherData.self, from: data)
                    DispatchQueue.main.async {
                        self.weatherModel = decodedData
                        self.isLoading.toggle()
                    }
                    
                } catch {
                    print("Error fetching data from Pexels: \(error)")
                }
            }
}
