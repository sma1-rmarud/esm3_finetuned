#!/usr/bin/env bash
set -euo pipefail

: "${protein_name:?protein_name not set}"
: "${ligand_name:?ligand_name not set}"

HOST_IN_DIR="$HOME/evolve_pro_demo_pilot/biogui/utils/result/${protein_name}_${ligand_name}_csv2json"
HOST_OUT_DIR="$HOME/evolve_pro_demo_pilot/biogui/utils/result/${protein_name}_${ligand_name}_structure_raw"
HOST_MODELS_DIR="$HOME/evolve_pro_demo_pilot/external/evolve_pro_demo_alphafold/Model_param"
HOST_DB_DIR="$HOME/evolve_pro_demo_pilot/external/evolve_pro_demo_alphafold/Database"


CUDA_VISIBLE_DEVICES=0 docker run -it --rm \
  --gpus all \
  -e CUDA_VISIBLE_DEVICES=0 \
  --volume "${HOST_IN_DIR}:/root/af_input" \
  --volume "${HOST_OUT_DIR}:/root/af_output" \
  --volume "${HOST_MODELS_DIR}:/root/models" \
  --volume "${HOST_DB_DIR}:/root/public_databases" \
  alphafold3:latest \
  python run_alphafold.py \
    --input_dir=/root/af_input \
    --model_dir=/root/models \
    --output_dir=/root/af_output
