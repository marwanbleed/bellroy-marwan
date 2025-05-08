# bellroy-marwan
Component: Product Color Selector  
Tech: Elm (with Elm Architecture), responsive CSS, mock data fetch  

# 🎨 Elm Color Selector Component

This is a self-contained Elm project that recreates a simplified color selection component, inspired by Bellroy's UI. The project demonstrates clean Elm architecture, dynamic data fetching, responsive layout, and modular code organization.

## 📁 Project Structure


elm-color-selector/
├── elm.json                  # Elm project configuration
├── src/
│   ├── Main.elm              # Main entry point (initialization & structure)
│   └── ColorSelector.elm     # Reusable color selector component
├── colors.json               # Mocked external color data (fetched via Http)
├── index.html                # Loads compiled Elm app
└── README.md                 # You're reading it!



getting_started:
  - step: "Compile the Elm code"
    description: "Compile the app by running the command below to generate elm.js."
    command: "elm make src/Main.elm --output=elm.js"

  - step: "Serve the app locally"
    description: "Use a static server to serve the files locally."
    command: "npx serve ."
    note: "This ensures colors.json is accessible for the Elm app to fetch via HTTP."

  - step: "Open the app in your browser"
    description: "Visit http://localhost:3000 (or the port shown in your terminal)."

features_demonstrated:
  - "✅ Elm Architecture: Model, Msg, Update, View"
  - "✅ Modular component design (ColorSelector.elm)"
  - "✅ Fetching data via Http.get from colors.json"
  - "✅ Responsive layout with clean inline styling"
  - "✅ Clear file structure and separation of concerns"

notes:
  - "colors.json simulates an external API for demonstration purposes."
  - "No Astro or framework bundling is included, as requested."
  - "All Elm code is written with maintainability and readability in mind."
  - "This is a standalone Elm app that compiles to static assets (index.html, elm.js, colors.json)."

license: "MIT – feel free to use, modify, or extend this for your own needs."


