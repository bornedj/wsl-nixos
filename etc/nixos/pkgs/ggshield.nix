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

  propagatedBuildInputs = with python3.pkgs; [
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

  depedencies = with python3.pkgs; [
    platformdirs
  ];

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

  meta = with lib; {
    description = "Tool to find and fix various types of hardcoded secrets and infrastructure-as-code misconfigurations";
    homepage = "https://github.com/GitGuardian/ggshield";
    changelog = "https://github.com/GitGuardian/ggshield/blob/${version}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
    mainProgram = "ggshield";
  };
}
