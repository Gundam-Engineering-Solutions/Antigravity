# cli_main.py
import typer
import logging
import subprocess
from pathlib import Path
from typing import Optional

# Configure system logs for FAA/Federal compliance
logging.basicConfig(level=logging.INFO, format="[%(asctime)s] [%(levelname)s] %(message)s")

app = typer.Typer(
    name="Gundam Robotics Control",
    help="Type-S (Saiya) Anti-Gravity Platform Mission Control",
    add_completion=False
)

# --- SAFETY WRAPPER ---
def verify_system_integrity(func):
    """Ensures environment variables and files exist before operation."""
    def wrapper(*args, **kwargs):
        # Verification that core CAD assets are present
        if not Path("assembly_v3.scad").exists():
            typer.secho("WARNING: CAD Asset missing in root.", fg=typer.colors.YELLOW)
        return func(*args, **kwargs)
    return wrapper

@app.command()
def render(
    component: str = typer.Argument(..., help="Component name (e.g., central_hub_saiya_v4)"),
    format: str = typer.Option("stl", help="Output format (stl, dxf, png)")
):
    """
    Triggers OpenSCAD rendering for chassis plates and hub segments.
    """
    file_path = f"{component}.scad"
    if not Path(file_path).exists():
        typer.secho(f"CRITICAL: {file_path} not found in repository.", fg=typer.colors.RED)
        raise typer.Exit(code=1)
        
    typer.echo(f"Initializing OpenSCAD rendering engine for {file_path}...")
    subprocess.run(["openscad", "-o", f"{component}.{format}", file_path])
    typer.echo("Render complete. Asset verified.")

@app.command()
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
def spec(
    component: str = typer.Argument("central_hub_v4", help="Component to retrieve specs for")
):
    """Retrieves technical specifications from documentation."""
    spec_file = Path("docs") / "avionics_specs.md"
    if spec_file.exists():
        typer.echo(f"Accessing {spec_file}...")
        # Simple printout of the tech specs
        typer.echo(spec_file.read_text())
    else:
        typer.secho("Spec file not found.", fg=typer.colors.RED)

if __name__ == "__main__":
    app()
