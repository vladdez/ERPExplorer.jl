# ERPExplorer

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://vladdez.github.io/ERPExplorer.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://vladdez.github.io/ERPExplorer.jl/dev/)
[![Build Status](https://github.com/vladdez/ERPExplorer.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/vladdez/ERPExplorer.jl/actions/workflows/CI.yml?query=branch%3Amaster)
[![Coverage](https://codecov.io/gh/vladdez/ERPExplorer.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/vladdez/ERPExplorer.jl)

## About ERPExplorer.jl

It is a collection of functions for interactive ERP (event-related potential) visualization.

EEG data is a multidimensional data with at least 3 dimensions: time, voltage and sensors (channels). It is extremely difficult to present multidimensional data. ERPExplorer.jl will allow you to interactively explore EEG data and find meaningful insights. 

Currently ERPExplorer.jl has 6 functions:
- click_topoplot() - shows the name of the sensor on topoplot after clicking on it;
- slider_topoplot() - topoplot with voltage changing over time by moving the slider position;
- menu_butterfly_topoplot() - combination of butterfly plot and topoplot with the possibility to select the sensor by choosing it in the menu;
- click_butterfly_topoplot() - combination of butterfly plot and topoplot with possibility to select sensor by clicking on the topoplot;
- slider_butterfly_topoplot() - combination of butterfly plot and topoplot with voltage changing over time by moving the slider position;
- toggle_butterfly_topoplot() - combination of butterfly plot and topoplot with a button to toggle between solid and nulticolor mode.


## Gallery

### Tutorials

| Function  | How it looks like |
| ------------- | ------------- |
| Topoplot   | <img src="https://user-images.githubusercontent.com/33777074/220991361-86e5e38c-2723-4599-a383-163f9faf35a5.gif" width="580" height="500">|
| click_butterfly_topoplot   | ![topo_butter_clicking](https://user-images.githubusercontent.com/33777074/220991449-0ae94417-72d4-40a3-a249-042d901dcb6f.gif)|
| menu_butterfly_topoplot   | ![topo_butter_toggle](https://user-images.githubusercontent.com/33777074/220995782-0e8aa601-bab6-4230-9245-bcf3de40cb5c.gif)
| toggle_butterfly_topoplot   | ![topo_butter_menu](https://user-images.githubusercontent.com/33777074/220991965-48e0fe6e-0340-472c-91ff-c323831932da.gif)| |

## Citing

See [`CITATION.bib`](CITATION.bib) for the relevant reference(s).
