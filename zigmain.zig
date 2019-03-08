const std = @import("std");
const ultibo = @cImport({
    @cInclude("ultibo/platform.h");
});
const usrlnd = @cImport({
    @cInclude("sys/types.h");
    @cInclude("bcm_host.h");
    @cInclude("vmcs_host/vc_cecservice.h");
});

export fn zigmain(argc: u32, argv: [*][*]u8) i32 {
    if (work(argc, argv)) {
        return 0;
    }
    else |err| {
        return @errorToInt(err);
    }
}

fn work(argc: u32, argv: [*][*]u8) void {
    initializeHdmiCec();
    sleep(2*1000);
    for (argv[0..argc]) |arg, i| {
        warn("zig command line argument {} is {s}\x00", i + 1, arg);
    }
    var i: i32 = 1;
    while (true) {
        if (i < 30) {
            warn("zig clock message {}\x00", i);
        } else if (i == 30) {
            warn("zig clock messages have been suspended\x00");
        }
        sleep(1*1000);
        i += 1;
    }
}

fn sleep(milliseconds: u32) void {
    var start = ultibo.get_tick_count();
    while (ultibo.get_tick_count() -% start < milliseconds) {
    }
}

fn initializeHdmiCec() void {
    usrlnd.bcm_host_init();
    _ = usrlnd.vc_cec_set_passive(1);
    usrlnd.vc_cec_register_callback(cecCallback, @intToPtr(*c_void, 0));
    _ = usrlnd.vc_cec_register_all;
    _ = usrlnd.vc_cec_set_osd_name(c"zig!\x00");
}

extern fn cecCallback(data: ?*c_void, reason: u32, p1: u32, p2: u32, p3: u32, p4: u32) void {
    const userControl = (p1 >> 16) & 0xff;

    switch (reason & 0xffff) {
        usrlnd.VC_CEC_BUTTON_PRESSED => warn("CEC: 0x{X} pressed\x00", userControl),
        usrlnd.VC_CEC_BUTTON_RELEASE => warn("CEC: 0x{X} released\x00", userControl),
        else => warn("cecCallback reason 0x{X} p1 0x{X} p2 0x{X} p3 0x{X} p4 0x{X}\x00", reason, p1, p2, p3, p4),
    }
}

var warnBuf: [1024]u8 = undefined;
fn warn(comptime fmt: []const u8, args: ...) void {
    if (std.fmt.bufPrint(&warnBuf, fmt, args)) |warning| {
        ultibo.logging_output(warning.ptr);
    }
    else |_| {
    }
}
