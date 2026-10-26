#!/usr/bin/env python3
"""
KiKit Multi-Board Panelization Script
Combines PoE Hat (Board 1) and USB Bridge (Board 2) into a framed panel.
"""

import sys
import pcbnew
from kikit import panelize_ui_impl as ki
from kikit.panelize import Panel, Origin
from kikit.units import mm, deg

# Compatibility helper for KiCad 6 (wxPoint) vs KiCad 7/8/9 (VECTOR2I)
try:
    from pcbnew import VECTOR2I as Vector
except ImportError:
    from pcbnew import wxPoint as Vector

def create_panel():
    board1_path = "poe_hat.kicad_pcb"
    board2_path = "usb_bridge.kicad_pcb"
    output_path = "panel_output.kicad_pcb"

    # 1. Define panel configuration
    framing = {
        "type": "frame",
        "width": "5mm",
        "space": "3mm"       # Clearance between boards and outer frame
    }
    tabs = {
        "type": "spacing",
        "spacing": "20mm",
        "width": "3mm"
    }
    cuts = {
        "type": "mousebites",
        "drill": "0.5mm",
        "spacing": "0.8mm",
        "offset": "0.25mm"
    }
    tooling = {
        "type": "4hole",
        "hoffset": "2.5mm",
        "voffset": "2.5mm",
        "size": "1.152mm"
    }
    fiducials = {
        "type": "4fid",
        "hoffset": "3.5mm",
        "voffset": "3.5mm",
        "coppersize": "1mm",
        "opening": "1mm"
    }

    # Obtain merged KiKit preset configuration
    preset = ki.obtainPreset(
        [],
        framing=framing,
        tabs=tabs,
        cuts=cuts,
        tooling=tooling,
        fiducials=fiducials
    )

    # 2. Initialize panel and inherit board environment
    board1 = pcbnew.LoadBoard(board1_path)
    panel = Panel(output_path)
    panel.inheritDesignSettings(board1)
    panel.inheritProperties(board1)
    panel.inheritTitleBlock(board1)

    # 3. Position boards
    # Board 1 (PoE Hat) centered at (55 mm, 50 mm)
    b1_pos = Vector(55 * mm, 50 * mm)
    panel.appendBoard(
        board1_path,
        destination=b1_pos,
        origin=Origin.Center,
        tolerance=0.1 * mm
    )

    # Board 2 (USB Bridge) placed to the left at (15 mm, 50 mm)
    b2_pos = Vector(15 * mm, 50 * mm)
    panel.appendBoard(
        board2_path,
        destination=b2_pos,
        origin=Origin.Center,
        tolerance=0.1 * mm
    )

    # 4. Generate frame, partitions, tabs, and mousebites
    substrates = panel.substrates
    framing_substrates = ki.dummyFramingSubstrate(substrates, preset)
    panel.buildPartitionLineFromBB(framing_substrates)

    tab_cuts = ki.buildTabs(preset, panel, substrates, framing_substrates)
    ki.buildFraming(preset, panel)

    cuts_list = ki.buildCuts(preset, panel, tab_cuts)
    ki.buildTooling(preset, panel)
    ki.buildFiducials(preset, panel)
    ki.buildPostprocessing(preset["post"], panel)

    # 5. Save final panel
    panel.save()
    print(f"[✓] Panel successfully generated: {output_path}")

if __name__ == "__main__":
    create_panel()
