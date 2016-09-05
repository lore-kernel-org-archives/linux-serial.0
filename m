From: Richard Genoud <richard.genoud@gmail.com>
Subject: [BUG] [BISECTED] atmel_serial: Oops in mctrl_gpio_irq_handle
Date: Mon, 5 Sep 2016 15:36:13 +0200
Message-ID: <c80608c5-0ab4-cde8-c799-56e8a43f3772@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


Hi,

Since:
commit 18dfef9c7f87b75bbb0fb66a634f7c13a45b9f8d
Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date:   Sun Oct 18 21:34:45 2015 +0200

    serial: atmel: convert to irq handling provided mctrl-gpio
    

An Oops happens when using hardware flow control with GPIOs.
Steps to trigger the oops:
- Set gpios to handle CTS/RTS in the device tree:
usart1: serial@f8020000 {
	/* CTS and DTS will be handled by GPIO */
	status = "okay";
	rts-gpios = <&pioB 17 GPIO_ACTIVE_LOW>;
	cts-gpios = <&pioB 16 GPIO_ACTIVE_LOW>;
	dtr-gpios = <&pioB 14 GPIO_ACTIVE_LOW>;
	dsr-gpios = <&pioC 31 GPIO_ACTIVE_LOW>;
	rng-gpios = <&pioB 12 GPIO_ACTIVE_LOW>;
	dcd-gpios = <&pioB 15 GPIO_ACTIVE_LOW>;
};
- Boot the kernel, and set the hardware flow control:
# stty -F /dev/ttyS2 crtscts
# stty -a -F /dev/ttyS2
speed 9600 baud;stty: /dev/ttyS2
 line = 0;
intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>;
eol2 = <undef>; swtch = <undef>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R;
werase = ^W; lnext = ^V; flush = ^O; min = 1; time = 0;
-parenb -parodd cs8 hupcl -cstopb cread clocal crtscts
-ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr icrnl ixon -ixoff
-iuclc -ixany -imaxbel -iutf8
opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0
isig icanon iexten echo echoe echok -echonl -noflsh -xcase -tostop -echoprt
echoctl echoke
- Plug / unplug the serial port to a modem (or another computer using a null-modem cable).
This will toggle the CTS pin and give this oops:

[   64.560000] Unable to handle kernel NULL pointer dereference at virtual address 00000114
[   64.560000] pgd = c0004000
[   64.560000] [00000114] *pgd=00000000
[   64.560000] Internal error: Oops: 17 [#1] ARM
[   64.560000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.4.0-rc5-00004-g18dfef9c7f87-dirty #63
[   64.560000] Hardware name: Atmel AT91SAM9
[   64.560000] task: c08d60a8 ti: c08d0000 task.ti: c08d0000
[   64.560000] PC is at tty_wakeup+0x14/0x68
[   64.560000] LR is at uart_write_wakeup+0x2c/0x30
[   64.560000] pc : [<c0262be8>]    lr : [<c027f014>]    psr: a0000093
[   64.560000] sp : c08d1dc8  ip : c08d1de0  fp : c08d1ddc
[   64.560000] r10: c79ac880  r9 : 41069265  r8 : 00000010
[   64.560000] r7 : 00000000  r6 : 00000020  r5 : c783a2f0  r4 : c0979cf4
[   64.560000] r3 : c798c970  r2 : 00000002  r1 : 00000020  r0 : 00000000
[   64.560000] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   64.560000] Control: 0005317f  Table: 271a0000  DAC: 00000053
[   64.560000] Process swapper (pid: 0, stack limit = 0xc08d0190)
[   64.560000] Stack: (0xc08d1dc8 to 0xc08d2000)
[   64.560000] 1dc0:                   c0979cf4 c783a2f0 c08d1dec c08d1de0 c027f014 c0262be4
[   64.560000] 1de0: c08d1e04 c08d1df0 c02802f8 c027eff8 00000020 c0979cf4 c08d1e2c c08d1e08
[   64.560000] 1e00: c0282c78 c02802a4 00000000 00000020 00000001 c7a45380 00000057 00000000
[   64.560000] 1e20: c08d1e64 c08d1e30 c00412dc c0282be0 c08dfa00 c08d1f28 c08d1e6c c79ac880
[   64.560000] 1e40: c799f710 c78a7780 c799f710 00000010 41069265 c8854600 c08d1e7c c08d1e68
[   64.560000] 1e60: c00414a0 c004127c 00000003 c79ac880 c08d1e94 c08d1e80 c00440e4 c0041478
[   64.560000] 1e80: c0044060 c781b264 c08d1ea4 c08d1e98 c0040bf4 c0044070 c08d1ed4 c08d1ea8
[   64.560000] 1ea0: c0247060 c0040bdc c08d1ec4 00010000 00000002 00000000 c781c0e0 00000001
[   64.560000] 1ec0: c08aa8cc c7ee3f00 c08d1ee4 c08d1ed8 c0040bf4 c0246fb8 c08d1f04 c08d1ee8
[   64.560000] 1ee0: c0040c94 c0040bdc c781b218 00000002 c08d1f28 c08d1f5c c08d1f24 c08d1f08
[   64.560000] 1f00: c0009490 c0040c14 c0477874 c000aa78 a0000013 ffffffff c08d1f84 c08d1f28
[   64.560000] 1f20: c000da30 c00093f0 00000000 0005317f 0005217f a0000013 00000000 c08d206c
[   64.560000] 1f40: c0949b20 ffffffff c08aa8cc 41069265 c7ee3f00 c08d1f84 a00000d3 c08d1f78
[   64.560000] 1f60: c0477874 c000aa78 a0000013 ffffffff 00000053 c047785c c08d1f94 c08d1f88
[   64.560000] 1f80: c003b09c c000aa4c c08d1fa4 c08d1f98 c003b198 c003b06c c08d1fb4 c08d1fa8
[   64.560000] 1fa0: c0631a78 c003b0b0 c08d1ff4 c08d1fb8 c0861c64 c0631a1c ffffffff ffffffff
[   64.560000] 1fc0: 00000000 c08616d0 00000000 c08aa8cc c0949c94 c08d2018 c08aa8c8 c08d6f18
[   64.560000] 1fe0: 20004000 208a8c60 00000000 c08d1ff8 20008048 c0861974 00000000 00000000
[   64.560000] [<c0262be8>] (tty_wakeup) from [<c027f014>] (uart_write_wakeup+0x2c/0x30)
[   64.560000] [<c027f014>] (uart_write_wakeup) from [<c02802f8>] (uart_handle_cts_change+0x64/0x84)
[   64.560000] [<c02802f8>] (uart_handle_cts_change) from [<c0282c78>] (mctrl_gpio_irq_handle+0xa8/0xcc)
[   64.560000] [<c0282c78>] (mctrl_gpio_irq_handle) from [<c00412dc>] (handle_irq_event_percpu+0x70/0x1fc)
[   64.560000] [<c00412dc>] (handle_irq_event_percpu) from [<c00414a0>] (handle_irq_event+0x38/0x4c)
[   64.560000] [<c00414a0>] (handle_irq_event) from [<c00440e4>] (handle_simple_irq+0x84/0x8c)
[   64.560000] [<c00440e4>] (handle_simple_irq) from [<c0040bf4>] (generic_handle_irq+0x28/0x38)
[   64.560000] [<c0040bf4>] (generic_handle_irq) from [<c0247060>] (gpio_irq_handler+0xb8/0xf4)
[   64.560000] [<c0247060>] (gpio_irq_handler) from [<c0040bf4>] (generic_handle_irq+0x28/0x38)
[   64.560000] [<c0040bf4>] (generic_handle_irq) from [<c0040c94>] (__handle_domain_irq+0x90/0xb8)
[   64.560000] [<c0040c94>] (__handle_domain_irq) from [<c0009490>] (aic_handle+0xb0/0xb8)
[   64.560000] [<c0009490>] (aic_handle) from [<c000da30>] (__irq_svc+0x50/0x64)
[   64.560000] Exception stack(0xc08d1f28 to 0xc08d1f70)
[   64.560000] 1f20:                   00000000 0005317f 0005217f a0000013 00000000 c08d206c
[   64.560000] 1f40: c0949b20 ffffffff c08aa8cc 41069265 c7ee3f00 c08d1f84 a00000d3 c08d1f78
[   64.560000] 1f60: c0477874 c000aa78 a0000013 ffffffff
[   64.560000] [<c000da30>] (__irq_svc) from [<c000aa78>] (arch_cpu_idle+0x3c/0x44)
[   64.560000] [<c000aa78>] (arch_cpu_idle) from [<c003b09c>] (default_idle_call+0x40/0x44)
[   64.560000] [<c003b09c>] (default_idle_call) from [<c003b198>] (cpu_startup_entry+0xf8/0x198)
[   64.560000] [<c003b198>] (cpu_startup_entry) from [<c0631a78>] (rest_init+0x6c/0x84)
[   64.560000] [<c0631a78>] (rest_init) from [<c0861c64>] (start_kernel+0x300/0x360)
[   64.560000] Code: e92dd830 e24cb004 e92d4000 e8bd4000 (e5903114) 
[   64.560000] ---[ end trace d545a155f3403411 ]---
[   64.560000] Kernel panic - not syncing: Fatal exception in interrupt
[   64.560000] Rebooting in 2 seconds..Reboot failed -- System halted

It seems that the interrupts are not disabled after the port is closed.


Here is the bisect log:
git bisect start '--' 'drivers/tty/serial/atmel_serial.c'
# good: [bfa76d49576599a4b9f9b7a71f23d73d6dcff735] Linux 3.19
git bisect good bfa76d49576599a4b9f9b7a71f23d73d6dcff735
# bad: [694d0d0bb2030d2e36df73e2d23d5770511dbc8d] Linux 4.8-rc2
git bisect bad 694d0d0bb2030d2e36df73e2d23d5770511dbc8d
# good: [a649943522de07e67a5981b1ff227684b94bada4] tty/serial: at91: fix I/O accesses on RHR and THR for AVR32
git bisect good a649943522de07e67a5981b1ff227684b94bada4
# bad: [041497eb721ddbdc1e690316976dd8ba7bc136a2] drivers/tty/serial: delete unused MODULE_DEVICE_TABLE from atmel_serial.c
git bisect bad 041497eb721ddbdc1e690316976dd8ba7bc136a2
# good: [378102f364d3fba88b8162df13d639d620e9272c] Merge 4.3-rc5 into tty-next
git bisect good 378102f364d3fba88b8162df13d639d620e9272c
# good: [77bdec6f0face395ceb303ee7f2525b9dbbeb036] serial: at91, fix rs485 properties
git bisect good 77bdec6f0face395ceb303ee7f2525b9dbbeb036
# bad: [18dfef9c7f87b75bbb0fb66a634f7c13a45b9f8d] serial: atmel: convert to irq handling provided mctrl-gpio
git bisect bad 18dfef9c7f87b75bbb0fb66a634f7c13a45b9f8d
# first bad commit: [18dfef9c7f87b75bbb0fb66a634f7c13a45b9f8d] serial: atmel: convert to irq handling provided mctrl-gpio

I'm using a at91sam9g35-cm board.


Regards,
Richard.
