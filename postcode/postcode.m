BeginPackage["postcode`"];

postcode::usage = "";

Begin["`Private`"];

postcode[code_String] := Module[{ request, response },
 request = HTTPRequest["http://api.postcodes.io/postcodes/" <> code]
 response = URLRead[request]
 ImportString[response["Body"], "RawJSON"] 
]

End[]

EndPackage[]

