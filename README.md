# CCN - Correct Conventional Naming Plugin for Godot

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
2. Copy the `addons/correct_conventional_naming` folder into the `addons` directory of your Godot project.
3. In Godot, go to `Project` -> `Project Settings` -> `Plugins`.
4. Find "Correct Conventional Naming" in the list and click "Activate".

## Usage
Once the plugin is activated, every time you attach a script to a node:
1. In the default dialog there will appear a new setting for you to choose the naming convention for the script.

![Alt Text](/screenshots/attach_node_script.png?raw=true "The new setting")

2. Select your preferred naming style.

![Alt Text](/screenshots/attach_node_script_select.png?raw=true "Select the naming convention")

3. The script name will be automatically adjusted in the preview field according to your selection. Just hit apply if you're happy with it and click create afterwards.

![Alt Text](/screenshots/attach_node_script_snake_case.png?raw=true "Preview and apply the new name")

## Compatibility
As of now, this plugin has been tested and confirmed to work on Godot 4.2.1, as this is the version I am currently using.

## Contributing
Contributions to the plugin are welcome! If you have suggestions for improvements or have found a bug, please open an issue or a pull request. Also testing on other versions has not yet been conducted. If you are using a different version of Godot and would like to contribute, please feel free to test the plugin and provide feedback on compatibility with other versions.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements
- Thanks to the Godot community for their continuous support and feedback.
