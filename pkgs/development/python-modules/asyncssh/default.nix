{ stdenv, buildPythonPackage, fetchPypi, pythonOlder
, cryptography
, bcrypt, gssapi, libnacl, libsodium, nettle, pyopenssl
, openssl, openssh }:

buildPythonPackage rec {
  pname = "asyncssh";
  version = "2.3.0";
  disabled = pythonOlder "3.4";

  src = fetchPypi {
    inherit pname version;
    sha256 = "44bda34c7123f00c3df95d24e2dc8d43c4d17b456fbb8c434ef4f4a7ebb5265e";
  };

  patches = [
    # Reverts https://github.com/ronf/asyncssh/commit/4b3dec994b3aa821dba4db507030b569c3a32730
    #
    # This changed the test to avoid setting the sticky bit
    # because that's not allowed for plain files in FreeBSD.
    # However that broke the test on NixOS, failing with
    # "Operation not permitted"
    ./fix-sftp-chmod-test-nixos.patch
  ];

  propagatedBuildInputs = [
    bcrypt
    cryptography
    gssapi
    libnacl
    libsodium
    nettle
    pyopenssl
  ];

  checkInputs = [
    openssh
    openssl
  ];

  # Disables windows specific test (specifically the GSSAPI wrapper for Windows)
  postPatch = ''
    rm tests/sspi_stub.py
  '';

  meta = with stdenv.lib; {
    description = "Provides an asynchronous client and server implementation of the SSHv2 protocol on top of the Python asyncio framework";
    homepage = "https://asyncssh.readthedocs.io/en/latest";
    license = licenses.epl20;
    maintainers = with maintainers; [ worldofpeace ];
  };
}
