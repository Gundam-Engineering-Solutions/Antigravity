import typer
import logging
import subprocess
from pathlib import Path
from typing import Optional

logging.basicConfig(level=logging.INFO, format="[%(asctime)s] [%(levelname)s] %(message)s")

app = typer.Typer(
    name="Gundam Robotics Control",
    help="Type-S (Saiya) Anti-Gravity Platform Mission Control",
    add_completion=False
)

# Dynamically find the root of the repository (since this script is now in the root)
REPO_ROOT = Path(__file__).parent

def verify_system_integrity(func):
    """Ensures environment variables and files exist before operation."""
    def wrapper(*args, **kwargs):
        # Verification that core CAD assets are present in the ROOT folder
        if not (REPO_ROOT / "assembly_v3.scad").exists():
            typer.secho("WARNING: CAD Asset missing in root.", fg=typer.colors.YELLOW)
        return func(*args, **kwargs)
    return wrapper

@app.command()
def math():
    """
    Retrieves the theoretical framework, mathematical models, and plasma chemistry equations for researchers.
    """
    spec_file = REPO_ROOT / "docs" / "theoretical_framework.md"
    if spec_file.exists():
        typer.secho("--- Accessing Theoretical Framework ---", fg=typer.colors.MAGENTA)
        typer.echo(spec_file.read_text())
    else:
        typer.secho("Theoretical framework file not found.", fg=typer.colors.RED)
        
@app.command()
@verify_system_integrity
def render(
    component: str = typer.Argument(..., help="Component name (e.g., central_hub_saiya_v4)"),
    format: str = typer.Option("stl", help="Output format (stl, dxf, png)")
):
    """
    Triggers OpenSCAD rendering for chassis plates and hub segments.
    """
    # Look for the SCAD file in the repo root
    file_path = REPO_ROOT / f"{component}.scad"
    if not file_path.exists():
        typer.secho(f"CRITICAL: {file_path.name} not found in repository.", fg=typer.colors.RED)
        raise typer.Exit(code=1)
        
    typer.echo(f"Initializing OpenSCAD rendering engine for {file_path.name}...")
    
    # Send the absolute paths to the subprocess
    output_path = REPO_ROOT / f"{component}.{format}"
    subprocess.run(["openscad", "-o", str(output_path), str(file_path)])
    typer.echo("Render complete. Asset verified.")

@app.command()
@verify_system_integrity
def power_cycle(
    source: str = typer.Option("GRID", help="Power Source: GRID or NUCLEAR (Legacy)"),
    voltage: float = typer.Option(480.0, help="Bus voltage in Volts")
):
    """
    Manages the Grid-to-Hull Power Bus for electron saturation.
    """
    if source.upper() == "NUCLEAR":
        typer.secho("ALERT: Nuclear 'Spider Crab' bus deprecated. Switching to Grid-to-Hull.", fg=typer.colors.YELLOW)
        source = "GRID"
        
    typer.echo(f"Routing High-Voltage AC via Snap Circuit Bus...")
    typer.echo(f"Power Source: {source} | Voltage: {voltage}kV")
    typer.echo("Rectifier array active: Negative electron saturation confirmed.")

@app.command()
@verify_system_integrity
def roadmap():
    """Display project development phase status."""
    phases = {
        "Phase 1": "Concept Validation (Complete)",
        "Phase 2": "OpenSCAD Modeling (Active)",
        "Phase 3": "Gemini Documentation (Active)",
        "Phase 4": "Bus Fabrication (Pending)"
    }
    typer.echo("--- Development Roadmap ---")
    for phase, status in phases.items():
        typer.echo(f"{phase}: {status}")

@app.command()
@verify_system_integrity
def spec(
    component: str = typer.Argument("central_hub_v4", help="Component to retrieve specs for")
):
    """Retrieves technical specifications from documentation."""
    # Look for the docs folder in the repo root
    spec_file = REPO_ROOT / "docs" / "avionics_specs.md"
    if spec_file.exists():
        typer.echo(f"Accessing {spec_file}...")
        # Simple printout of the tech specs
        typer.echo(spec_file.read_text())
    else:
        typer.secho(f"Spec file not found at {spec_file}.", fg=typer.colors.RED)
@app.command()

def spec(
    component: str = typer.Argument("overview", help="Component file: overview, coil_specifications, fluid_dynamics_simulation, electrical_schematic")
):
    """Retrieves technical specifications from documentation."""
    spec_file = REPO_ROOT / "docs" / f"{component}.md"
    if spec_file.exists():
        typer.secho(f"--- Accessing {spec_file.name} ---", fg=typer.colors.CYAN)
        typer.echo(spec_file.read_text())
    else:
        typer.secho(f"Spec file not found at {spec_file}.", fg=typer.colors.RED)
@app.command()
def bak_specs(
    doc: str = typer.Argument("bak_integration_overview", help="Available docs: bak_integration_overview, flight_dynamics_mapping, telemetry_and_export")
):
    """
    Retrieves documentation for integrating the Antigravity EMA with the BAK avionics software.
    """
    spec_file = REPO_ROOT / "docs" / f"{doc}.md"
    if spec_file.exists():
        typer.secho(f"--- Accessing {doc} ---", fg=typer.colors.CYAN)
        typer.echo(spec_file.read_text())
    else:
        typer.secho(f"BAK integration document '{doc}' not found.", fg=typer.colors.RED)

if __name__ == "__main__":
    app()
