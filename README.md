GithubSearch POC -

Description 
This POC designed to get all github repositories basesd on search criteria. A minimum 4 letters and maximum 30 letters can be used in search box. Initially 20 results per pages are shown. Users can scroll down for further results (20 results at a time). The search box accepts letters and numbers. Only '_', '-', '.', '/' 
are accepted as special characters.

1) Design Pattern: The app uses MVC design pattern.

2) Deployment target - 
    I have se up  target to iOS 11 and applied checks so that app can run on iOS 11 devices also. The app is tested for iPhone with iOS11 and iOS 14.

3) Unit test cases - 
    Covered unit test cases for service logic only(SearchService.swift). Textfield validation in depth covered in UI test case.

4) UI  test cases -    
    In the Simulator, please make sure I/O -> Keyboard -> Connect hardware keyboard is off. Otherwise most of the test cases will fail.
    This is a workaround for inputting text in the simulator.
    
5)  Third Party Library - 
    I want to use "SDWebImage" library for caching images but unable to download cocoapod due to access restriction in my organization provided Mac machine. So I have not used any third party library.

