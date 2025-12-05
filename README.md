# Recipe Search App

iOS app for searching recipes using the Spoonacular API with AI-powered suggestions.

## Features
- Search recipes by ingredients
- Modern SwiftUI interface
- Secure API configuration
- AI-powered recipe suggestions (DeepSeek integration)
- Comprehensive unit testing with XCTest
- Professional project structure

## Setup
1. Get API keys:
   - [Spoonacular API](https://spoonacular.com/food-api)
   - [DeepSeek API](https://platform.deepseek.com/api-keys) (optional, for AI features)
2. Rename `Config.xcconfig.example` to `Config.xcconfig`
3. Replace placeholders with your actual API keys:
4. SPOONCULAR_API_KEY = your_spoonacular_key_here
DEEPSEEK_API_KEY = your_deepseek_key_here

4. Open in Xcode and build

## Testing
The project includes comprehensive XCTest coverage:
- Unit tests for data models and services
- Mock network responses for reliable testing
- UI tests for SwiftUI components
- Test-driven development approach

Run tests with: `Cmd + U` in Xcode

## Technologies
- **SwiftUI** - Modern declarative UI framework
- **XCTest** - Comprehensive testing framework
- **DeepSeek AI** - AI-powered recipe suggestions
- **Spoonacular API** - Recipe data source
- **Secure configuration** with .xcconfig files
- **SwiftData** - Local persistence (if implemented)
- **Async/Await** - Modern concurrency

## Architecture
- **MVVM** (Model-View-ViewModel) pattern
- **Repository pattern** for data abstraction
- **Dependency injection** for testability
- **Protocol-oriented** design


## Security
- API keys stored securely in `.xcconfig` files
- `.gitignore` configured to prevent key exposure
- Template files provided for easy setup

## Contributing
1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Ensure all tests pass
5. Submit a pull request
