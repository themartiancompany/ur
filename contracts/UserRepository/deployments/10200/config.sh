#!/usr/bin/env bash

declare \
  -A \
  solc_version \
  evm_version \
  contract_address

solc_version=(
  ["1.1"]="0.8.28"
)
evm_version=(
  ["1.1"]="cancun"
)
contract_address=(
  ["1.1"]="0x2ac2475Cb1B4C0B0A6725089A24dC32312eC515e"
)
