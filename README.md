# Traffic light controller

## Review

* two 7-segments common anode for each street, one for ones and the other for tens.
* one traffic light for each street (20s green, 3s yellow, 15s red) for West, (12s green, 3s yellow, 23s red) for South.
* the 7-segment that is made for ones of each street shared the same decoder (7447) and that are made for tens shared the same decoder (7447) for BCD.
* each of common anode pin of 7-segments connected with a transistor to control either turn it on or off.
* two switches, one to switch between <b> Automatic </b> and <b> Manual </b> mode, and the other to switch between the two streets in the manual mode.

View the project simulation on youtube: <a href="https://www.youtube.com/watch?v=Tye5bUF7SSg&t=23s">Click here</a>
