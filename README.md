# CCSP - Copy Correct Shader Parameters

## Overview
This plugin for the Godot Engine adds an extra dock that showcases all parameters of a selected shader, which can be manipulated via code (also known as uniforms). The dock features a clean and readable table-like layout, presenting each parameter's name required for addressing it, along with its expected data type.

It also offers the functionality to copy a parameter's name to the clipboard by either clicking directly on the name itself when the corresponding setting at the top of the dock is enabled, or by clicking on the dedicated copy button. This feature aims to mitigate unnecessary and frustrating bugs caused by misspelled string literals.

## Features
- **A useful custom dock**: Either place the dock in the dedicated slots of the Godot Engine or make it floating and place it freely whereever you want.
- **Simple Shader Selection**: Easy selection of `.gdshader` files through the _Load Shader_ button.
- **Easy to read List of Parameters**: After loading a shader file the uniform parameters are listed easy to read in a scrollable list _(see Screenshots)_.
- **Reload to update the list**: If you added or removed some uniforms in the selected shader file simply press _Reload_ to update the overview.
- **Copy Button**: To prevent misspelled string literals by manual typing simply click the _Copy_ Button to copy the name of the uniform to your clipboard.
- **Copy on click**: Alternatively, by enabling the setting _Copy on Click_ in the top, you can also copy the uniform name to the clipboard by simply clicking on the name itself _(Activated by default)_.

## Installation
1. Clone or download this repository.
2. Copy the `addons/copy_correct_shader_parameters` folder into the `addons` directory of your Godot project.
3. In Godot, go to `Project` -> `Project Settings` -> `Plugins`.
4. Find "Copy Correct Shader Parameters" in the list and click "Activate".

## Usage
1. Once the plugin is activated, the new dock will appear on the right side of the engine.

![Alt Text](/screenshots/dock_empty.png?raw=true "The new dock")

2. Click on _Load Shader_ to open a file dialog to select a `.gdshader` file.

![Alt Text](/screenshots/select_shader_dialog.png?raw=true "Select the shader file")

3. Once a shader file is selected, the dock will list the uniform parameters that were found in that shader.

![Alt Text](/screenshots/shader_selected.png?raw=true "See the uniforms of the shader")

## Compatibility
As of now, this plugin has been tested and confirmed to work on Godot 4.2.2, as this is the version I am currently using. Version 4.0.0 stable lacks a function necessary for displaying the type of the uniform. If there are requests for it to work on that version I will be looking into solving this.

## Contributing
Contributions to the plugin are welcome! If you have suggestions for improvements or have found a bug, please open an issue or a pull request.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements
- Thanks to the Godot community for their continuous support and feedback.
