{ lib
, buildPythonPackage
, fetchPypi

# build-system
, hatchling
, build

# propagated modules
, requests
, dateutil
, python-jose
, pycognito
, typing-extensions
}:

buildPythonPackage rec {
  pname = "pyemvue";
  version = "0.18.0";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-s1Uuoiog3OkqOb6PSTqh79vgyLDGFIuZMCyQKH+qG3g=";
  };

  nativeBuildInputs = [
    hatchling
    build
  ];

  propagatedBuildInputs = [
    requests
    dateutil
    python-jose
    pycognito
    typing-extensions
  ];

  pythonImportsCheck = [ "pyemvue" ];

  meta = with lib; {
    description = "A Python Library for reading data from the Emporia Vue energy monitoring system.";
    homepage = "https://github.com/magico13/PyEmVue";
    license = licenses.mit;
    maintainers = with maintainers; [ presto8 ];
  };
}
