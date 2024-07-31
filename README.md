# STYLEsnap - The Fashion AI

**AI-Driven Virtual stylist in your pocket. Snap your style, get inspired.**

![STYLEsnap Thumbnail](https://github.com/user-attachments/assets/a8889816-1ac4-4e25-835d-d21b40c01409)


## Description
Meet STYLEsnap, your new AI fashion BFF who always has your best look in mind. No more outfit anxiety or endless scrolling for inspiration—STYLEsnap is here to make your style journey a breeze. Snap a photo, and let STYLEsnap analyze your body proportions, style preferences, and occasion to curate personalized outfit recommendations that perfectly suit your unique taste. Get ready to unlock endless style possibilities and discover a wardrobe that truly reflects your best self.


## Preview 📽️
https://github.com/0xAdiyat/STYLEsnap/assets/67780459/97b85fdf-7dce-4329-a3be-a971ee8b9772


> [!IMPORTANT]
> ## Step-By-Step Tutorial
> Link -> [Click Here](https://youtu.be/TemisXFWeQw)


> [!NOTE]  
> It is just an MVP that I created to test out the new Gemini pro API model by Google. To be fair you can say it is just a quick test on my side. The overall UI isn't all that great :p as I had to finish it real quick. Sincere apology!
> 
> Please feel free to `star the repository` if you want to show your support and receive notifications about major updates during its development. Additionally, contributions are welcome.


## Screenshots

Analyzer Screen         |  Uploaded Screen       |   Result Screen
:-------------------------:|:-------------------------:|:-------------------------:|
![Analyzer Screen](https://github.com/0xAdiyat/STYLEsnap/assets/67780459/aa5d0fcf-7404-4810-bee6-1fe9e2d07625)|![Uploaded Screen](https://github.com/0xAdiyat/STYLEsnap/assets/67780459/875707e0-0384-4ea2-96dc-be09a7c0c726)|![Result Screen](https://github.com/0xAdiyat/STYLEsnap/assets/67780459/326781af-db60-4dc2-971b-91d255222e75)|

> [!IMPORTANT]
> ## Platform Support
> - [x] Android
> - [x] iOS
> - [ ] Web
> - [ ] Mac
> - [ ] Windows
> - [ ] Linux


## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/0xAdiyat/STYLEsnap.git
   ```
2. Install dependencies:
   ```bash
   cd style_snap
   flutter pub get
   ```
3. Add your Gemini pro API key in main.dart file
   ```
   Gemini.init(apiKey: ApiKeys.gemini_api_key);
   ```
5. Run the app:
   ```bash
   flutter run
   ```


> [!IMPORTANT]  
> If you wish to contribute a change to any of the existing features or add new to this repo,
> please feel free to contribute,
> and send a [pull request](https://github.com/0xAdiyat/STYLEsnap/pulls). I welcome and encourage all pull requests. It usually takes me within 24-48 hours to respond to any issue or request.

> [!NOTE]
> At first I thought of doing things from scratch through the provided rest API by Google. Sadly there was no official package released by Google for Flutter yet.
> Then I stumbled upon this awesome package called [flutter_gemini](https://pub.dev/packages/flutter_gemini). Therefore I switched my mind to making use of it instead, as my main goal was to test the API's performance and flexibility anyway :p
> 
> Image credit in the image & preview-video -> unsplash.com

## Author
@0xAdiyat

<br>
<p align="right">● <a href="#description">back to top</a></p>
