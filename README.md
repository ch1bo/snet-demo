## Install snet-cli

Using the `shell.nix` to get python and pip in scope:

``` sh
nix-shell
```

NOTE: Pip is setup to install packages locally into the current working directory `pip_packages`.

HACK: The following is a bit of a workaround to the native packages `grpcio` and `grpcio-tools` work on NixOS / in a nix-shell.

Temporarily remove `grpcio` and `grpcio-tools` from `shell.nix`, reload shell and do install `snet-cli` with:

``` sh
pip install snet-cli
```

Remove native packages from local `pip_packages` again (they won't work).

``` sh
pip uninstall grpcio
pip uninstall grpcio-tools
```

Re-enable `grpcio` and `grpcio-tools` in `shell.nix` and reload shell.

## Identity creation

Generate a new BIP39 mnemonic and write it down:

``` sh
python -c "from mnemonic import Mnemonic; print(Mnemonic('english').generate())"
```

And use it to create and swithc to a new snet identity:

``` sh
snet identity create user-ropsten mnemonic --mnemonic "YOUR MNEMONICS" --network ropsten
snet identity user-ropsten
snet account balance
```

Then, request ropsten testnet funds from these faucets:
 - ETH from https://faucet.egorfine.com/
 - AGIX from https://faucet.singularitynet.io/
