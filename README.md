# stori-ios-challenge
This repository holds the code for the iOS take home challenge, part of the recruiment process of Stori.

The architecture of my app emulates VIPER+C.

The entry point is the Coordinator which instantiates and injects necessay data into each module.
My ViewController is fairly simple since it does not handle any logic or processing other that UI configuration.
This allows to delegate those responsibilities to the presenter, which by using the methods provided by the interactor is able to redirect the flow of the app in response of the results obtained by the interactor.
The interactor module communicates with services to capture and interact with data. It will prepare it so that the presenter can use it and will provide the information necessay to process specific user cases.
In this project I’ve only used a remote service, which gets the data from the endpoint and decodes it.


# Preview:
<img width="303" alt="Screenshot 2024-03-13 at 01 18 03" src="https://github.com/danieltibaquira/stori-ios-challenge/assets/39937982/aa6acccf-6382-4d92-b83a-fabef9b67512">

# Arch Flow:
<img width="290" alt="Screenshot 2024-03-13 at 01 15 24" src="https://github.com/danieltibaquira/stori-ios-challenge/assets/39937982/bca96006-e967-4c32-8d69-ffce485fb02e">
