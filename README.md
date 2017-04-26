# postcode

Binding to the postcodes.io api, which provides postcode -> geolocation lookups

For installation instructions, open the install.nb notebook

For usage examples, open the usage.nb notebook

Code examples:

~~~~
postcodes["OX49 5NU"] 

postcodes[{"OX49 5NU", "M32 0JG", "NE30 1DP"}]

postcodes[ GeoPosition[{51.45, -2.58333}] ]

postcodes[ {GeoPosition[{51.45, -2.58333}], GeoPosition[{51.45, -2.58333}]} ]

postcodes["Random"]

postcodes["OX49 5NU", "Validate"]

postcodes["OX49 5NU", "Nearest"]

postcodes["OX49 5", "Autocomplete"]

postcodes["OX49 5NU", "Query"]

outcodes["OX49"]

outcodes["OX49", "Nearest"]

outcodes[ GeoPosition[{51.45, -2.58333}] ]
~~~~
