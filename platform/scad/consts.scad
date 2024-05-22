/*
DESCRIPTION
  Constants for SCUSU CAD model.

AUTHORS
  Saxon A. Nelson-Milton <saxon@ausocean.org>

LICENSE
  Copyright (C) 2020 the Australian Ocean Lab (AusOcean)

  It is free software: you can redistribute it and/or modify them
  under the terms of the GNU General Public License as published by the
  Free Software Foundation, either version 3 of the License, or (at your
  option) any later version.

  It is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
  for more details.

  You should have received a copy of the GNU General Public License
  in gpl.txt.  If not, see http://www.gnu.org/licenses.
*/

alpha = 0.5;

// Misc.
noOfFaces = 500;

$fn = noOfFaces;

// Pipe properties.
pipeLength              = 600;
pipeOuterDiameter       = 160;
pipeInternalDiameter    = 155;

// Access coupling properties.
couplingInnerDiameter = 160;
couplingOuterDiameter = couplingInnerDiameter+10;
couplingLength        = 160;

// Threaded cap properties.
capInnerDiameter    = couplingOuterDiameter;
capOuterDiameter    = 185;
capLength           = 35;

// Battery properties.
battLength = 151;
battWidth = 98;
battHeight = 93;

// Wood properties.
woodColor = [1,178/255,102/255];
woodThickness = 10;

// Battery holder end properties.
holderEndWidth = woodThickness;
holderEndDiameter = pipeInternalDiameter;

// Calculate battery displacement from center.
battDisplacement = sqrt(pow(pipeInternalDiameter/2,2)-pow(battWidth/2,2))-(battHeight/2);

// Reed switch properties.
reedSwitchLen = 40;
reedSwitchWidth = 10;
reedSwitchHeight = 10;
reedSwitchDisplacement = 30;

// Spacer properties.
spacerLegHeight = 120;
spacerLegLength = 80;
