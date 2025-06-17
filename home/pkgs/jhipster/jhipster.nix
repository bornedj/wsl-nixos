{lib, buildNpmPackage, fetchFromGitHub}:

buildNpmPackage rec {
    pname = "generator-jhipster";
    version = "8.8.0";

    src = fetchFromGitHub {
        owner = "jhipster";
        repo = "generator-jhipster";
        rev = "v${version}";
        hash = "sha256-+jVC2OQbBURDmw+40Td4NYNu3II/MzkNGlznoMePJzo=";
    };
    
    npmDepsHash = "sha256-i9GfDAmw3ejYxP0vIjo3ZFnaLnHwmdpoQrfBq93Lf/Q=";

    # postInstall = ''
    #     npm i
    # '';

    meta = {
        description = "JHipster is a development platform to generate microservices and modern web applications";
        homepage = "https://www.jhipster.tech/";
        license = lib.licenses.asl20;
        maintainers = with lib.maintainers; [ bornedj ];
    };
}
