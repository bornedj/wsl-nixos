{
  lib,
  fetchFromGitHub,
  git,
  python3,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "ggshield";
  version = "1.30.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "GitGuardian";
    repo = "ggshield";
    rev = "v1.30.2";
    sha256 = "gN8dnUIwK/g8BgbwEdkoKihNZUrNWrNm5CCIbqZrQgY=";
  };

  build-system = with python3.pkgs; [ setuptools ];

  nativeBuildInputs = with python3.pkgs; [
    platformdirs
    charset-normalizer
    click
    cryptography
    marshmallow
    marshmallow-dataclass
    oauthlib
    platformdirs
    pygitguardian
    pyjwt
    python-dotenv
    pyyaml
    requests
    rich
  ];

  # propagatedBuildInputs = with python3.pkgs; [
  #   appdirs
  #   charset-normalizer
  #   click
  #   cryptography
  #   marshmallow
  #   marshmallow-dataclass
  #   oauthlib
  #   platformdirs
  #   pygitguardian
  #   pyjwt
  #   python-dotenv
  #   pyyaml
  #   requests
  #   rich
  # ];

  nativeCheckInputs =
    [ git ]
    ++ (with python3.pkgs; [
      jsonschema
      pyfakefs
      pytest-mock
      pytest-voluptuous
      pytestCheckHook
      snapshottest
      vcrpy
    ]);

  pythonImportsCheck = [ "ggshield" ];

  diabledTestPaths = [
    "tests/test_watch"
    "tests/test_force_polling"
  ];

  disabledTests = [
    "test_watch_polling_not_env"
    "test_awatch"
  ];

  meta = with lib; {
    description = "Tool to find and fix various types of hardcoded secrets and infrastructure-as-code misconfigurations";
    homepage = "https://github.com/GitGuardian/ggshield";
    changelog = "https://github.com/GitGuardian/ggshield/blob/${version}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
    mainProgram = "ggshield";
  };
}
