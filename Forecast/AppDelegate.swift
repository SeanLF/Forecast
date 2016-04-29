//
//  AppDelegate.swift
//  Forecast
//
//  Created by Sean Floyd on 2016-04-28.
//  Copyright © 2016 Sean Floyd. All rights reserved.
//

import Cocoa
import CoreLocation
import ForecastIO

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var window: NSWindow!
    
    // Menu bar
    @IBOutlet weak var statusMenu: NSMenu!
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    
    // Location variables
    let locationManager = CLLocationManager.init()
    var coordinates: CLLocationCoordinate2D!
    
    // Timing to check weather
    let checkWeatherInterval = 10.0
    
    // Forecast API client
    let forecastIOClient = APIClient(apiKey: "YOUR_API_KEY")

    // Application initialization
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Set up menu bar image
        let icon = NSImage(named: "statusIcon")
        icon?.template = true
        statusItem.image = icon
        statusItem.menu = statusMenu
        
        // Start collecting location data if we can
        startLocationService()
        
        // Set API unit
        forecastIOClient.units = .SI
        
        // Fetch weather data every X minutes
        var _ = NSTimer.scheduledTimerWithTimeInterval(checkWeatherInterval, target: self, selector: #selector(AppDelegate.getWeather), userInfo: nil, repeats: true)
        
    }

    // Clean up before terminating app
    func applicationWillTerminate(aNotification: NSNotification) {
    }

    @IBAction func clickedQuitMenuItem(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    func startLocationService(){
        let locationAuthorizationStatus = CLLocationManager.authorizationStatus()
        if CLLocationManager.locationServicesEnabled() &&
            (locationAuthorizationStatus == CLAuthorizationStatus.Authorized || locationAuthorizationStatus == CLAuthorizationStatus.NotDetermined)
        {
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.distanceFilter = 1000 // 1000 meters
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        } else {
            let alert = NSAlert()
            alert.alertStyle = NSAlertStyle.WarningAlertStyle
            alert.icon = NSImage(named: "statusIcon")
            alert.messageText = "Can't use location services!"
            alert.runModal()
        }
    }
    
    func getWeather(){
        if(coordinates != nil){
            forecastIOClient.getForecast(latitude: coordinates.latitude, longitude: coordinates.longitude) { (currentForecast, error) -> Void in
                if let currentForecast = currentForecast {
                    // presentation logic not implemented
                } else if let error = error {
                    self.alertError(error)
                }
            }
        }
    }
    
    @objc func locationManager(manager: CLLocationManager, didUpdateLocations locations: [AnyObject]) {
        coordinates = locations[0].coordinate
        locationManager.stopUpdatingLocation()
    }
    
    @objc func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        alertError(error)
    }
    
    @objc func locationManager(manager: CLLocationManager, didFinishDeferredUpdatesWithError error: NSError?){
        alertError(error)
    }
    
    func alertError(error: NSError?){
        let alert = NSAlert(error: error!)
        alert.runModal()
        print(error!.localizedDescription)

    }
}

