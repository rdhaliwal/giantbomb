# Giant Bomb app

- This app interacts with the Giant Bomb API.
- This project primarily exists as a venue for me to learn iOS, iPadOS and macOS developement using SwiftUI.
  - If you really want an iOS app to browse Giant Bomb, there are better options out there already on the App Store. Use those. Seriously.

## Setup

You need a `Development.xcconfig` file in the project root directory that is set with the following environment variables:

- `GB_API_KEY` - The API key used to authenticate with the Giantbomb API
- `GB_API_URL` - The base url for the Giantbomb API

To (optionally) create a release build, you will need a `Release.xcconfig` file in the project root directory that is set with the following environment variables:

- `GB_API_KEY` - The API key used to authenticate with the Giantbomb API
- `GB_API_URL` - The base url for the Giantbomb API
