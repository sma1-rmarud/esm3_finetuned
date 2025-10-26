#!/usr/bin/env bash
set -euo pipefail

protein_name="amie"
ligand_name="fluorescein"

: "${protein_name:?protein_name not set}"
: "${ligand_name:?ligand_name not set}"

HOST_IN_DIR="$HOME/evolve_pro_demo_pilot/biogui/utils/result"
HOST_OUT_DIR="$HOME/evolve_pro_demo_pilot/biogui/utils/result"
HOST_MODELS_DIR="$HOME/evolve_pro_demo_pilot/external/evolve_pro_demo_alphafold/Model_param"
HOST_DB_DIR="$HOME/evolve_pro_demo_pilot/external/evolve_pro_demo_alphafold/Database"

docker run -it \
  --gpus all \
  --volume "${HOST_IN_DIR}:/root/af_input" \
  --volume "${HOST_OUT_DIR}:/root/af_output" \
  --volume "${HOST_MODELS_DIR}:/root/models" \
  --volume "${HOST_DB_DIR}:/root/public_databases" \
  alphafold3:latest \
  /bin/bash