BeginPackage["postcode`"];

postcode::usage = "";

Begin["`Private`"];

postcode[code_String] := Module[{ request, response },
 request = HTTPRequest["http://api.postcodes.io/postcodes/" <> code];
 response = URLRead[request];
 ImportString[response["Body"], "RawJSON"] 
]

postcode[codes_List] := Module[{ request, response },
 request = HTTPRequest[
  "http://api.postcodes.io/postcodes", <|
   Method -> "POST",
   "Body" -> {"postcodes" -> codes},
   "Headers" -> {"content-type" -> "application/x-www-form-urlencoded;charset=UTF-8", "user-agent" -> "Wolfram HTTPClient 11.1"}
  |>
 ];
 response = URLRead[request];
 ImportString[response["Body"], "RawJSON"]
]

postcode[location_GeoPosition] := Module[ {request,response,lat,lon},
 {lat, lon} = ToString /@ QuantityMagnitude[LatitudeLongitude[location]];
 request = HTTPRequest[ "http://api.postcodes.io/postcodes?lon=" <> lon <> "&lat=" <> lat];
 response = URLRead[request];
 ImportString[response["Body"], "RawJSON"]
]

End[]

EndPackage[]

