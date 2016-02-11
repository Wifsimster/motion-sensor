# Motion sensor with an ESP8266

This LUA script is for ESP8266 hardware.

##Principle

1. Connect to a wifi AP
2. If motion detected (change of value on GPIO_0), send a HTTP request on Jeedom

## Scheme

![scheme](https://github.com/Wifsimster/bmp180/blob/master/scheme.png)
