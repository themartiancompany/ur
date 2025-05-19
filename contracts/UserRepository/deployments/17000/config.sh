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
  ["1.1"]="0x7b391971F864c29f8F7a13dB7cd9160c7D6d1c7D"
)
