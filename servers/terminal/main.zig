const zen = @import("std").os.zen;
const Message = zen.Message;
const Terminal = zen.Server.Terminal;

const v_addr = 0x20000000;  // TODO: don't hardcode.
const p_addr = 0xB8000;
const size   = 0x8000;
const vram   = @intToPtr(&volatile u8, v_addr)[0..size];

pub fn main() void {
    zen.createPort(Terminal);
    _ = zen.map(v_addr, p_addr, size, true);

    var i: usize = 0;
    while (true) {
        var message = Message.from(Terminal);
        zen.receive(&message);

        vram[2*(80*15 + i)] = u8(message.payload);
        i += 1;
    }
}