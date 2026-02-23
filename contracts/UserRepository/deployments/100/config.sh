#!/usr/bin/env bash

declare \
  -A \
  solc_version \
  evm_version \
  contract_address

solc_version=(
  ["1.0"]="0.8.28"
  ["1.1"]="0.8.28"
)
evm_version=(
  ["1.0"]="cancun"
  ["1.1"]="cancun"
)
contract_address=(
  ["1.0"]="0x7EBb73c91A04E0aB7a0cDe4e43f9b09eE3464c36"
  ["1.1"]="0x1394B68548fB135372A472A6b22505FA5D67850f"
)
