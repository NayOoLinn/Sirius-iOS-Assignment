# iOS Mobile Assignment for Sirius

This project is implemented by Nay Oo Linn and submit to Sirius Company for job application.

### About
In this project, user can type any keyword to search city information from provided local json file. User can view the location of the city in apple map by tapping city information.

#### Tasks:
* Load the list of cities from provided json file.
* Filter the results by a given prefix string
* Filter results are in scrollable list
* Display city name and coordinates
* Able to view city location in a map
* Unit testing

## ScreenShots
![](/Screenshots/1.png)

## Getting Started

This project is written with:
* XCode (13.4.1)
* Swift 5

### Installation
1. Download the repo
2. Go to project directory in Terminal
```
cd <Your Downloaded Project Directory>
```
3. Run pod install in Terminal
```
pod install
```
4. Open `SiriusiOSAssignment.xcworkspace`

## Description
### Architecture
MVVM + RxSwift

### File Structures
There are five main files.
* **ViewController(SearchVC)**: includes all the UI related codes
* **ViewModel(SearchVM)**: do data processing and business logic
* **Service(SearchService)**: handles api calls normally but for this project, it converts local json file to data model
* **Router(SearchRouter)**: contains all routing logics
* **UnitTesting(SearchVMTest)**: unit testing for respective ViewModel

### Algorithm Explanation
There are two algorithms implemented in the project. The following codes can be found in **SearchVM.swift** file.
#### 1. Preparing Data
After mapping the provided json to model data, the data will be group by first letter of city name. Filtering will be faster when finding the city from respective group instead of finding from the original long data.
```
// Sort data for better filter performance
func sortDataForSearch(_ cities: [CityData]) -> [CityData] {
    // Group cities by first character
    dataModel.sortedData = Dictionary(grouping: cities) {
        String($0.name?.first ?? Character("")).lowercased()
    }
    return cities
}
```

#### 2. Reuse already searched data
Keywords and cities results that user searched are stored and reuse when user search the same keyword again. By doing that if user search the same keyword, the stored data will be displayed instead of finding from the sorted data again.

* _Filter from **sorted** data and saved the results_
```
// Search from sorted data
let firstLetter = String(firstChar)
let cities = dataModel.sortedData[firstLetter]?.filter({
    $0.name?.lowercased().hasPrefix(key) ?? false
}) ?? []
```
```
// Saved searched data
dataModel.searchedData[key] = cities
```

* _Filter from **stored** data and display the results_
```
// Search from already searched data
if let searchedCities = dataModel.searchedData[key] {
    return searchedCities
}
```

## Author
Nay Oo Linn
