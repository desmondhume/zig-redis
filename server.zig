const std = @import("std");
const net = std.net;

pub fn main() !void {
    var server = net.StreamServer.init(.{ .reuse_address = true });
    defer server.close();
    const addr = try net.Address.resolveIp("127.0.0.1", 6896);
    try server.listen(addr);

    while (true) {
        const connection = try server.accept();
        try handler(connection.stream);
    }
}

fn handler(stream: net.Stream) !void {
    defer stream.close();
    try stream.writer().print("PONG", .{});
}
