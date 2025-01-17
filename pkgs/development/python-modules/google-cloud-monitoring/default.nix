{ lib
, buildPythonPackage
, fetchPypi
, google-api-core
, google-cloud-testutils
, libcst
, proto-plus
, pandas
, pytestCheckHook
, pytest-asyncio
, mock
}:

buildPythonPackage rec {
  pname = "google-cloud-monitoring";
  version = "2.6.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "47feb2e635ef79af98696eb22a5af1db8a78b3a2919e39bdec65ba45659b59ac";
  };

  propagatedBuildInputs = [ libcst google-api-core proto-plus ];

  checkInputs = [ google-cloud-testutils mock pandas pytestCheckHook pytest-asyncio ];

  disabledTests = [
    # requires credentials
    "test_list_monitored_resource_descriptors"
  ];

  pythonImportsCheck = [
    "google.cloud.monitoring"
    "google.cloud.monitoring_v3"
  ];

  meta = with lib; {
    description = "Stackdriver Monitoring API client library";
    homepage = "https://github.com/googleapis/python-monitoring";
    license = licenses.asl20;
    maintainers = with maintainers; [ SuperSandro2000 ];
  };
}
