What are the differences in electricity household prices among european countries due to?
There are some interesting differences in the price individuals pay depending on the country they reside in.
Is the membership to EU a factor? Do countries with a less liberalized electricity market pay less? Does the investment in renewables correspond to a rise in final price?

# Data
Information was taken from [Eurostat](https://ec.europa.eu/eurostat/data/database) and [World Bank](https://data.worldbank.org/).
Features of this analysis:

- *dependent variable* 
  Electricity Price - taxes excluded, in euros.

- *independent variables*
  * **Gas price** - taxes excluded, in euros.
  * **Dependency** - share of total energy needs of a country met by imports from other countries.
  * **Consumption** - how much electricity and heat every citizen consumes at home excluding energy used for transportation.
  * **GDP per capita** - ratio of real GDP to the average population of a specific year.
  * **Market share** of the largest generator in the electricity market.
  * **Oil Price** - data not taken from Eurostat but from [MacroTrends](https://www.macrotrends.net/1369/crude-oil-price-history-chart).
  * Share of **renewable energy** in gross final energy consumption. Share of renewable energy in gross final energy consumption.
  * **Emissions Intensity** - how many tonnes CO2 equivalents of energy-related GHGs are being emitted in a certain economy per unit of energy that is being consumed.
  * **Consumer Price Index** - proxy for inflation: how prices are changing with respect to 2015 (value 100 in 2015 for each country).
  * **Inflation** inflation level, normalized per country at the 2015 level. 
  
The time range of the analysis goes from 2000 to the second part of 2019.
