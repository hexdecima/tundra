## tundra
### Usage
This repository is a flake, you can add it as an input (or consume it in any other way you prefer).

Packages are exposed as `packages.${system}.<package-name>`, so you can do
`inputs.tundra.packages.${system}.hello` as an example.

Other expressions are (will be?) exposed under `lib.<expression-name>`. There aren't any yet...

### Packages
#### Fonts
*Peek under the `packages/fonts` directory, I add them way too often to list them here.*

#### Tools
- [`textract`](https://github.com/Antag99/TExtract) `broken 🚫` - For extracting .xnb files
(meant for Terraria).
- `textract-bin` - Pre-compiled `textract` .jar file, named `textract`. Not broken.


### License
[Unlicense.](https://unlicense.org/)
