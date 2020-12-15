![readme][readme]

### original description:
merry kitschmas 2015 +++ turn a christmas tree into multi-touch interface and visualize with Neopixels

# kitschmas
*merry kitschmas 2015*

---
## what is it?
turn a christmas tree into multi-touch interface and visualize with Neopixels

## dependencies
RunningMedian library
Adafruit NeoPixel library

## materials
- arduino uno / mega
- white plexi, 3mm
- 20 Neopixels (or any WS2811B chip based led strips) (**cut into groups of two**)
- red thread (the christmas feelings!!)
- a lot of red control wire (form over function here)

## about the code
sorry, it's a bit messy since i hacked it together in a few hours BUT:

- neopixels standard animations are free from delay (see also my other git [neopixel-without-delay])
- for the tree sensing i am using the [touche arduino]

## how to connect
- neopixels to pin **~D6**
- touche sensor to pin **~D9** and **A0**

## build
1. laser cut everything out (i put a CS4 file)
2. assemble the boxes:
![assemble][assemble]

## pictures
![p1][p1]
![p2][p2]
![p3][p3]


## todos
[ ] get some images from my family's christmas tree :)
[ ] clean code

[neopixel-without-delay]: https://github.com/ndsh/neopixel-without-delay

[touche arduino]: http://www.instructables.com/id/Touche-for-Arduino-Advanced-touch-sensing/?ALLSTEPS
[readme]: readme.jpg
[assemble]: ./lasercut/assemble.png
[p1]: ./images/01.png
[p2]: ./images/02.png
[p3]: ./images/03.png