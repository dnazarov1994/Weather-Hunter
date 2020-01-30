# Weather Hunterfasf
The Weather Hunter app allows the user to see current weather **anywhere in the World** just by tapping a map! You don't need to know exactly the name of the city or town! This app is very helpful for your road trip or family vacation in the new location!


<img width="398" alt="Screen Shot 2019-06-25 at 10 52 29 PM" src="https://user-images.githubusercontent.com/46335329/60147903-1638ed80-979d-11e9-9f82-9954fb7d6efb.png">

<img width="397" alt="Screen Shot 2019-06-25 at 10 52 53 PM" src="https://user-images.githubusercontent.com/46335329/60147796-c22e0900-979c-11e9-86d3-e0e0f159d530.png">

## App Functionality 
When the user opens the Weather Hunter app, the Map View appears. The user is able to zoom and scroll around the map using standard pinch and drag gestures. Tapping and holding the map drops a new pin. Users can place any number of pins on the map. When the user placed a pin, the "SEE WEATHER" button is enabled. By tapping this button the Table View controller appears. While the data is downloading, the Table View in a temporary “downloading” state. In this View Controller user can see the location name (if it exists), current temperature in Fahrenheit and logo with current weather conditions associated with the latitude and longitude of the pin. The weather information is displayed in the same sequence as the pins were placed on the Map. By selecting a pin on the map, the "DELETE PIN" button is enabled. By tapping this button, the pin is removing from the app. All pins are saved in the same locations after reopening the app. If the submission fails to post the data to the server, then the user sees an alert with an error message describing the failure. 


## App Implementation
The app has two view controller scenes:
- Map View: Allows the user to place pins on the Map. 
When the User launches an app for the first time, the view controller scene appears with the short description by using NSUserDefaults:
```
 func checkFirstLaunch() {
        let userDefaults = UserDefaults.standard
        let key = "isNotFirstLaunch"
        if !userDefaults.bool(forKey: key) {
            performSegue(withIdentifier: "showInfo", sender: nil)
            userDefaults.set(true, forKey: key)
        }
  }
  ```
  Function that allows to delete pins from the map:
  ```
   func deletePins() {

        guard let pin = mapView.selectedAnnotations.first else {
            updateButtonState()
            return
        }
        mapView.removeAnnotation(pin)
   ``` 
        

- Table View: Allows the user to see the weather information of the location associated with the latitude and longitude of the pin:
```
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.set(coordinates: coordinates[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coordinates.count
    }
```
JSON API response located in the AreaInfoResponse struct 
```
struct AreaInfoResponse: Decodable {
    var weather: [WeatherResponse]
    var temperature: TemperatureResponse
    var name: String
    
    
    enum CodingKeys: String,CodingKey {
        case weather = "weather"
        case temperature = "main"
        case name = "name"
    }
}
```



## API
The Weather Hunter app using data from the OpenWeatherMap API: 
```
   private static let baseWeatherAPI = "https://api.openweathermap.org/data/2.5/"

```


## Requirements

- Xcode 9.2
- Swift 4.2

