{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "jq-lsp";
  version = "0.1.12";

  src = fetchFromGitHub {
    owner = "wader";
    repo = "jq-lsp";
    tag = "v${version}";
    hash = "sha256-rq6AZsRwCWCIqLH78mOAA2tWa66ys78hRCxnNSXxegc=";
  };

  vendorHash = "sha256-8sZGnoP7l09ZzLJqq8TUCquTOPF0qiwZcFhojUnnEIY=";

  # based on https://github.com/wader/jq-lsp/blob/master/.goreleaser.yml
  env.CGO_ENABLED = 0;

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
    "-X main.commit=${src.rev}"
    "-X main.builtBy=Nix"
  ];

  meta = with lib; {
    description = "jq language server";
    homepage = "https://github.com/wader/jq-lsp";
    license = licenses.mit;
    maintainers = with maintainers; [ sysedwinistrator ];
    mainProgram = "jq-lsp";
  };
}
