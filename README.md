Crystal Sonification
====================

This Project is about crystal growth sonification. 
Pictures of crystalgrowth are analysed in Processing. The x and y values of new non black pixel is collected in Lists. Then I send the image data via the Open Sound Control Protocol to SuperCollider which creates the sound based on the crystal growth images.
I shot the images with a Raspberry Pi. In the folder data are the crystal images that I modified with Photoshop. Basically I cut out the crystals from the background and coloured the background in the images in black. If you do not do this the difference pictures the code is generating will show only black.


Requirements:
-------------
Download these two programms.
- https://processing.org
- https://supercollider.github.io
