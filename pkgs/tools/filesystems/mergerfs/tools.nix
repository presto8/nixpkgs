{ stdenv, fetchFromGitHub, coreutils, makeWrapper
, rsync, python3, pythonPackages }:

stdenv.mkDerivation rec {
  pname = "mergerfs-tools";
  version = "20200911";

  src = fetchFromGitHub {
    owner = "trapexit";
    repo = pname;
    rev = "480296ed03d1c3c7909697d7ef96d35840ee26b8";
    sha256 = "0xr06gi4xcr832rzy0hkp5c1n231s7w5iq1nkjvx9kvm0dl7chpq";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ python3 ];

  makeFlags = [
    "INSTALL=${coreutils}/bin/install"
    "PREFIX=${placeholder "out"}"
  ];

  postInstall = with stdenv.lib; ''
    wrapProgram $out/bin/mergerfs.balance --prefix PATH : ${makeBinPath [ rsync ]}
    wrapProgram $out/bin/mergerfs.consolidate --prefix PATH : ${makeBinPath [ rsync ]}
    wrapProgram $out/bin/mergerfs.dup --prefix PATH : ${makeBinPath [ rsync ]}
    wrapProgram $out/bin/mergerfs.mktrash --prefix PATH : ${makeBinPath [ pythonPackages.xattr ]}
  '';

  meta = with stdenv.lib; {
    description = "Optional tools to help manage data in a mergerfs pool";
    homepage = "https://github.com/trapexit/mergerfs-tools";
    license = licenses.isc;
    platforms = platforms.linux;
    maintainers = with maintainers; [ jfrankenau presto8 ];
  };
}
