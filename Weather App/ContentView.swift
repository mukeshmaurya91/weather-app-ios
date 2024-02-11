//
//  ContentView.swift
//  Weather App
//
//  Created by Mukesh Maurya on 11/02/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var isNight:Bool = false
    @StateObject var viewModel = WeatherViewModel()
    var body: some View {
        ZStack{
            BackgroundView(isNight: $isNight)
            if viewModel.isLoading {
                Image(systemName: "rainbow")
                    .symbolRenderingMode(.multicolor)
                    .resizable()
                    .symbolEffect(.pulse, options: .repeating, value: 2000)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 128, height: 128)
                    .padding(.all)
            } else{
                VStack{
                    Text("\(viewModel.cityName), IN")
                        .font(.system(size: 32,weight: .medium))
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                    VStack(spacing:10){
                        if let weather = viewModel.weatherModel?.weather?.first{
                            Image(systemName: isNight ? "moon.stars.fill" : weather.getIcon())
                                .symbolRenderingMode(.multicolor)
                                .resizable()
                                .contentTransition(.symbolEffect(.replace))
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 156,height: 156)
                        }
                        if let temp = viewModel.weatherModel?.main?.temp{
                            Text("\(temp, specifier: "%.0f")°")
                                .font(.system(size: 72, weight: .medium))
                                .foregroundColor(.white)
                        }
                    }.padding(.bottom, 34)
                    HStack(spacing: 24){
                        WeatherDayView(
                            dayOfWeek:"TUE",
                            weatherIcon: "cloud.bolt.rain.fill",
                            temprature: 22)
                        WeatherDayView(
                            dayOfWeek:"WED",
                            weatherIcon: "sun.rain.fill",
                            temprature: 25)
                        WeatherDayView(
                            dayOfWeek:"THU",
                            weatherIcon: "sunset.fill",
                            temprature: 20)
                        WeatherDayView(
                            dayOfWeek:"FRI",
                            weatherIcon: "cloud.sun.bolt.fill",
                            temprature: 21)
                        WeatherDayView(
                            dayOfWeek:"SAT",
                            weatherIcon: "wind",
                            temprature: 22)
                    }
                    Spacer()
                    Button{
                        isNight.toggle()
                    }label: {
                        Text("Change Day Time")
                            .frame(width: 256, height: 56)
                            .font(.system(
                                size: 20,
                                weight: .bold,
                                design: .default))
                            .background(.orange.gradient)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
            }
            }
    }


}

#Preview {
    ContentView()
}

struct WeatherDayView: View {
var dayOfWeek:String
var weatherIcon:String
var temprature:Int
    
    var body: some View {
        VStack(spacing: 8){
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            Image(systemName: weatherIcon)
                .symbolRenderingMode(.palette)
                .resizable()
                .foregroundStyle(.white, .yellow, .blue)
                .aspectRatio(contentMode: .fit)
                .frame(width: 48,height: 48)
            Text("\(temprature)°")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundView: View {
    @Binding var isNight:Bool
    var body: some View {
        LinearGradient(
            colors: [isNight ? .black : .blue, isNight ? .gray :Color("lightBlue")],
            startPoint:.topLeading,
            endPoint: .bottomTrailing
        ).ignoresSafeArea()
        .contentTransition(.symbolEffect(.replace))
    }
}
