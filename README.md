What are the differences in electricity household prices among EU countries due to?

# Data
Features of this analysis:

- *dependent variable* 
  Electricity Price - taxes excluded

- *independent variables*
  * **Dependency** - share of total energy needs of a country met by imports from other countries.
  * **Consumption** - how much electricity and heat every citizen consumes at home excluding energy used for transportation.
  * **GDP per capita** - ratio of real GDP to the average population of a specific year.
  * **Market share** of the largest generator in the electricity market.
  * **Oil Price** - data not taken from Eurostat but from [MacroTrends](https://www.macrotrends.net/1369/crude-oil-price-history-chart).
  * Share of **renewable energy** in gross final energy consumption. Share of renewable energy in gross final energy consumption.
  * **Emissions Intensity** - how many tonnes CO2 equivalents of energy-related GHGs are being emitted in a certain economy per unit of energy that is being consumed.
  
Excluded the oil price, all other data are taken from Eurostat and the time range is 2008-2018.
What is up next:
* Normalization of the variables.
* Different dummies (years (2011, 2012, 2013), subgroup of countries).
