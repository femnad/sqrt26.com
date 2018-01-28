---
date: 2015-03-26T19:03:18Z
title: Mod Marks the X
url: /2015/03/26/mod-marks-the-x/
---

Since no one is going to produce a keyboard which provides numerable keys within the range of the thumb, thus removing the need to leave the home row, allow me to somewhat remedy my misery by adding the following 7 lines to my .xmodmap file:

    keycode 133 = Mode_switch Mode_switch
    keycode 31 = c C Left
    keycode 32 = r R Right
    keycode 45 = t T Down
    keycode 46 = n N Up
    keycode 44 = h H Home
    keycode 33 = l L End

keycode 133 is the start key located on the lower left of a [TypeMatrix 2030][typematrix-2030] keyboard. It's still a long way away from the home row but it seemed to be the most viable candidate by allowing at least one hand to stay on the home row (Dvorak layout).

Eternally grateful to [(oremacs][(oremacs]

[typematrix-2030]: http://www.typematrix.com/2030/features.php
[(oremacs]: http://oremacs.com/2015/02/14/semi-xmodmap/
