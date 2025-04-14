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
  ["1.1"]="0x321d5854144096e1B77436679C9B43F6A04dbeb2"
)
