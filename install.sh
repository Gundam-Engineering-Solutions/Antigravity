#!/bin/bash
# Antigravity Platform Installation Script

echo "--- Installing System Dependencies ---"
# OpenSCAD is required to render your .scad CAD files
sudo apt-get update
sudo apt-get install -y openscad python3-venv

echo "--- Setting up Python Environment ---"
# Create a virtual environment to keep your repo clean
python3 -m venv venv
source venv/bin/activate

# Upgrade pip and install requirements
pip install --upgrade pip
pip install -r requirements.txt

echo "--- Installation Complete ---"
echo "To activate: source venv/bin/activate"
echo "To run CLI: python cli_main.py --help"
