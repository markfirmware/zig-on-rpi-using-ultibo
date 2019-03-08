# Demonstrates:
* software response to tv remote controller buttons (tv requires cec - consumer electronics control)
* runs on any model of raspberry pi
* use of the advanced [zig](https://ziglang.org/documentation/master) programming language (a replacement for c)
* use of [ultibo](https://ultibo.org/wiki/Main_Page) - a high quality pascal-based unikernel

# Requires:
* any model of raspberry pi with a power supply
* an hdmi tv that has cec (consumer electronics control)
* an hdmi cable
* the remote controller for the tv
* a computer that can write an sd card
* an sd card that you can erase - its contents will be destroyed

# Steps:
* with the computer
    * format the sd card as FAT32
        * this destroys the current contents of the sd card
    * download the zip file
    * unzip it to the sd card
    * safely eject the sd card
* insert the sd card into the pi
* connect the pi to the tv using the hdmi cable
* turn on the tv
* apply power to the pi
* you should see a green border with large white regions with black text on the tv

# Operation:
* press the arrow keys on the tv remote controller - you should see the activity reflected on the tv
