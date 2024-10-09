{
  lib,
  buildPythonPackage,
  fetchPypi,
  hatchling,
  pytest,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "rsyncfilter";
  version = "2024.5.30";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-M5uKY0u5cca8RtWS0CwXg72EoAScUMwzJSFNiHDT+ko=";
  };

  nativeBuildInputs = [
    hatchling
  ];

  propagatedBuildInputs = [
    pytest
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [ "rsyncfilter" ];

  meta = with lib; {
    description = "A Python module that implements rsync's sending-side rsync-filter specification";
    homepage = "https://github.com/presto8/python-rsync-filter";
    license = licenses.asl20;
    maintainers = with maintainers; [ presto8 ];
  };
}
