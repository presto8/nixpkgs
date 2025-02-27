{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pythonOlder,

  # build-system
  poetry-core,

  # propagates
  certifi,
  charset-normalizer,
  idna,
  jxmlease,
  oauthlib,
  python-dateutil,
  requests-oauthlib,
  requests,
  six,
  urllib3,
  xmltodict,

  # tests
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "pyetrade";
  version = "include-weekly";
  format = "pyproject";

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "presto8";
    repo = pname;
    tag = version;
    hash = "";
  };

  nativeBuildInputs = [ poetry-core ];

  propagatedBuildInputs = [
    certifi
    charset-normalizer
    idna
    jxmlease
    oauthlib
    python-dateutil
    requests-oauthlib
    requests
    six
    urllib3
    xmltodict
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  meta = with lib; {
    description = "Python interface to Etrade API";
    homepage = "https://github.com/presto8/pyetrade";
    license = licenses.gpl3;
    maintainers = [ presto8 ];
  };
}
