BeginPackage["postcode`"];

postcodes::usage = "";
outcodes::usage = "";

Begin["`Private`"];

postcodes[code_String] := Module[{ request, response },
 request = HTTPRequest["http://api.postcodes.io/postcodes/" <> code];
 response = URLRead[request];
 ImportString[response["Body"], "RawJSON"] 
]

postcodes[codes:List[_String..]] := Module[{ request, response },
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

postcodes[location_GeoPosition] := Module[ {request,response,lat,lon},
 {lat, lon} = ToString /@ QuantityMagnitude[LatitudeLongitude[location]];
 request = HTTPRequest[ "http://api.postcodes.io/postcodes?lon=" <> lon <> "&lat=" <> lat];
 response = URLRead[request];
 ImportString[response["Body"], "RawJSON"]
]

postcodes[locations : List[_GeoPosition ..]] := Module[{request, response, post}, 
 post = StringJoin @@ Riffle[ MapIndexed[ 
  URLEncode[ "geolocations[" <> ToString[First[#2]] <> "][longitude]"] <> "=" <> ToString[QuantityMagnitude[Longitude[#]]] <> "&" <> 
  URLEncode[ "geolocations[" <> ToString[First[#2]] <> "][latitude]"] <> "=" <> ToString[QuantityMagnitude[Latitude[#]]] &, 
  locations], "&"]; 
 request = HTTPRequest[ 
  "http://api.postcodes.io/postcodes", <|
   Method -> "POST", 
   "Body" -> post, 
   "Headers" -> {"content-type" -> "application/x-www-form-urlencoded;charset=UTF-8", "user-agent" -> "Wolfram HTTPClient 11.1"}
  |>
 ]; 
 response = URLRead[request]; 
 ImportString[response["Body"], "RawJSON"]
]

postcodes["Random"] := Module[ {request,response},
 request = HTTPRequest[ "http://api.postcodes.io/random/postcodes"];
 response = URLRead[request];
 ImportString[response["Body"], "RawJSON"]
]

postcodes[code_String, "Validate"] := Module[ {request,response},
 request = HTTPRequest[ "http://api.postcodes.io/postcodes/" <> code <> "/validate"];
 response = URLRead[request];
 ImportString[response["Body"], "RawJSON"]
]

postcodes[code_String, "Nearest"] := Module[ {request,response},
 request = HTTPRequest[ "http://api.postcodes.io/postcodes/" <> code <> "/nearest"];
 response = URLRead[request];
 ImportString[response["Body"], "RawJSON"]
]

postcodes[code_String, "Autocomplete"] := Module[ {request,response},
 request = HTTPRequest[ "http://api.postcodes.io/postcodes/" <> code <> "/autocomplete"];
 response = URLRead[request];
 ImportString[response["Body"], "RawJSON"]
]

postcodes[code_String, "Query"] := Module[ {request,response},
 request = HTTPRequest[ "http://api.postcodes.io/postcodes?q=" <> URLEncode[code]];
 response = URLRead[request];
 ImportString[response["Body"], "RawJSON"]
]

outcodes[code_String] := Module[ {request,response},
 request = HTTPRequest[ "http://api.postcodes.io/outcodes/" <> code];
 response = URLRead[request];
 ImportString[response["Body"], "RawJSON"]
]

outcodes[code_String, "Nearest"] := Module[ {request,response},
 request = HTTPRequest[ "http://api.postcodes.io/outcodes/" <> code <> "/nearest"];
 response = URLRead[request];
 ImportString[response["Body"], "RawJSON"]
]

outcodes[location_GeoPosition] := Module[ {request,response,lat,lon},
 {lat, lon} = ToString /@ QuantityMagnitude[LatitudeLongitude[location]];
 request = HTTPRequest[ "http://api.postcodes.io/outcodes?lon=" <> lon <> "&lat=" <> lat];
 response = URLRead[request];
 ImportString[response["Body"], "RawJSON"]
]

End[]

EndPackage[]

