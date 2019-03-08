# zig-on-rpi-using-ultibo

Download and operate using an sd card zip file: https://github.com/markfirmware/zig-on-rpi-using-ultibo/releases

The main ultibo program calls the zig function named zigmain.
zigmain logs the command line arguments that are passed to it.
zigmain then registers a callback with the raspberry pi userland that is embedded in ultibo.
This callback responds to tv remote controller button presses by recording a message in the ultibo log (displayed on screen.)

The tv requires cec (consumer electronics control.)

ultibo supports a lot of the [raspberry pi hardware and accessories](https://ultibo.org/wiki/Supported_Hardware#Single_board_computers) and has many software [features](https://ultibo.org/wiki/Current_Status#Feature_Support) including various free pascal packages .

## Development

Dependencies:

 * Developed on debian 9/x86_64
 * Install ultibo using [ultiboinstaller.sh](https://raw.githubusercontent.com/ultibohub/Tools/master/Installer/Core/Linux/ultiboinstaller.sh)
 * Install zig and add it to the PATH (must use most recent master from https://ziglang.org/download)
 * Install the arm embedded tool chain https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads
   * The installation directory is /usr and if not using gcc-arm-none-eabi-8-2018-q4-major then the build.zig file must be modified to reflect the correct path

Obtain this repo:

    git clone https://github.com/markfirmware/zig-on-rpi-using-ultibo

Build the kernels for the various raspberry pi models:

    zig build kernels

(For reference, these repositories have already been included as git subtrees:)

    git subtree add --prefix subtree/ultibohub/API https://github.com/ultibohub/API master --squash
    git subtree add --prefix subtree/ultibohub/Userland  https://github.com/ultibohub/Userland ultibo --squash
