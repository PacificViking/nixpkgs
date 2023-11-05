{ lib
, buildPythonPackage
, case
, fetchPypi
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "vine";
  version = "5.1.0";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-i2LpgdNcQQSSEc9ioKEkLYwe6b0Vuxls44rv1nmeYeA=";
  };

  nativeCheckInputs = [
    case
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "vine"
  ];

  meta = with lib; {
    description = "Python promises";
    homepage = "https://github.com/celery/vine";
    license = licenses.bsd3;
    maintainers = with maintainers; [ fab ];
  };
}
