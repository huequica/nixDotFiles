{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (fenix.combine [
      fenix.stable.toolchain
    ])

    # build required compiler
    gcc
  ];
}
