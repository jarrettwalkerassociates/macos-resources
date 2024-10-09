#!/bin/sh

#simple one liner to get last four of a serial number

ioreg -k IOPlatformSerialNumber | sed -En 's/^.*"IOPlatformSerialNumber".*(.{4})"$/\1/p'

