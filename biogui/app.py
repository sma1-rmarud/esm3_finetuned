import os
import tempfile
from functools import partial
import pandas as pd

import gradio as gr

from biogui.utils.esm3_utils import run_ours

with tempfile.TemporaryDirectory() as gradio_tmp:
    with gr.Blocks() as demo:
        gr.Markdown(
            """
            <h1 style='text-align: center'>
            🧬ES activity prediction using Deep Learning
            </h1>
            """,
            elem_id="title",
        )

        with gr.Tab(label='Run_ours_esm3_finetuned'):
            gr.Markdown("## 🔬 Predict activity score with our model")
            protein_name = gr.Textbox(
                label="protein name", placeholder="Enter protein name"
            )
            input_sequence_wt = gr.Textbox(label="Wildtype Sequence", placeholder="MMA...")
            ligand_name = gr.Textbox(
                label="ligand name", placeholder="Enter ligand name", value=None
            )
            ligand_smiles = gr.Textbox(label="Smiles code of ligand", placeholder="CC1([C@...", value=None)
            
            csv_file = gr.File(
                file_types=[".csv"],
                label="files to predict"
            )
            
            output_csv = gr.File(label="Download predictions CSV")
            
            predict_button = gr.Button("generate and run")
            predict_button.click(
                fn=run_ours,
                inputs=[
                    protein_name, input_sequence_wt, ligand_name, ligand_smiles, csv_file
                ],
                outputs=[
                    output_csv
                ]
            )


    demo.launch(debug=True)