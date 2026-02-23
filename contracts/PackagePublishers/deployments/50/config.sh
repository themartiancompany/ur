#!/usr/bin/env bash

declare \
  -A \
  solc_version \
  evm_version \
  contract_address

solc_version=(
  ["1.0"]="0.8.24"
)
evm_version=(
  ["1.0"]="paris"
)
contract_address=(
  ["1.0"]="0x79769835A0E59737851CF8F7f71C468c46Bc0A34"
)
