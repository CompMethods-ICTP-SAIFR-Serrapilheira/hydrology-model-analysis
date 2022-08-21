## Hydrology data analysis project

This project contains hydrology-related outputs from two versions of the dynamic vegetation model CAETÊ (CArbon and Ecosystem Trait-based Evaluation model) which I developed during my undergraduate studies. The idea was to conduct raw data manipulation and data visualization methods to compare both versions. Ideally, I would benchmark the models with data from elsewhere, such as GLDAS satellite data, which I did not do here due to time constraints.

## Versions

The two versions analysed here are:

#### IC-CAETE-DVM
- This version contains an updated hydrological module, with the implementation of an additional soil layer to the simulation, variable water retention capabilities derived from soil texture and a new runoff calculation system.

#### PVM-CAETE-DVM
- This version contains the previous hydrological module used on CAETÊ, which is based on CPTEC-PVM model (reference).

###### THE MODEL
[The entire main version](https://github.com/jpdarela/CAETE-DVM) of the model is available [here](https://github.com/jpdarela/CAETE-DVM)

## Dependencies

#### General Dependencies:

- R
- Climate Data Operators (CDO)
- PROJ
- GDAL

#### R Dependencies:

- dplyr
- ggplot2
- ggpubr
- ncdf4
- raster
- reshape
- rnaturalearth
- rnaturalearthdata
- sf
- zoo

## Directory structure

```
    ./
    ├── data/
    │   └── processed
    ├── outputs/
    │   ├── docs
    │   └── figs     
    ├── src/
    │   ├── R/
    │   │   └── mkdown 
    │   └── shell
    └── README.md
```

- In `data` you will find the `processed` data from CAETÊ raw outputs by the shell script located in `src`. The `raw` folder was not included in this repository due to the size of the raw files, which exceeds GitHub limit.
- The `outputs` folder contains outputs from R and RMarkdown scripts, divided in `docs` for the report and `figs` for all the graphs and maps generated.
- `src` is where all code is located. `R` folder for R code, `shell` for Shell script. 

## Contributors

The model used in this analysis is part of the work of several people. Here is the list of contributors to the CAETÊ project:

- Anja Rammig
- Bárbara R. Cardeli
- Bianca Rius
- Caio Fascina
- Carlos A. Quesada
- David Lapola
- Felipe Mammoli
- Gabriela M. Sophia
- Gabriel Marandola
- Helena Alves
- João Paulo Darela Filho
- Katrin Fleischer
- Phillip PAPAstefanou
- Tatiana Reichert
