From: Helge Deller <deller@gmx.de>
Subject: serial console problem with kernel 3.18.0-rc4
Date: Tue, 11 Nov 2014 20:13:17 +0100
Message-ID: <54625FCD.3070008@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:60443 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbaKKTNU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Nov 2014 14:13:20 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-parisc <linux-parisc@vger.kernel.org>

While testing kernel 3.18-rc4 I'm facing a problem with serial console.

I'm seeing at bootup this message:
[   17.724000] console [ttyS0] disabled
after that it's just hanging.

It seems as if ttyS0 is somehow being reprogrammed which then disturbs the
serial ports on the receiver side (in my case a HP PCI Diva Serial [GSP] Multiport UART).
Any idea what changed between 3.17 and 3.18 which have caused this behavior ?
Full log below.

Helge

serial driver: drivers/tty/serial/8250/8250_pci.c

PCI info:
00:04.1 Serial controller: Hewlett-Packard Company Diva Serial [GSP] Multiport UART (rev 03) (prog-if 02 [16550])
         Subsystem: Hewlett-Packard Company Device 1283
         Flags: medium devsel, IRQ 70
         Memory at ffffffff80000000 (32-bit, non-prefetchable) [size=4K]
         I/O ports at 0040 [size=64]
         Capabilities: [48] Power Management version 2
         Kernel driver in use: serial


dmesg after bootup:

[   17.708000] Serial: 8250/16550 driver, 8 ports, IRQ sharing enabled
[   17.724000] serial 0000:00:04.1: enabling device (0142 -> 0143)
[   17.724000] console [ttyS0] disabled
[   17.880000] serial 0000:00:04.1: ttyS0 at MMIO 0xffffffff80000000 (irq = 70, base_baud = 115200) is a 16550A
[   17.996000] console [ttyS0] enabled
[   38.888000] INFO: rcu_sched detected stalls on CPUs/tasks: { 3} (detected by 1, t=5252 jiffies, g=-290, c=-291, q=2)
[   38.888000] Task dump for CPU 3:
[   38.888000] swapper/0       R  running task        0     1      0 0x00000004
[   38.888000] Backtrace:
[   38.888000]  [<0000000040200848>] vprintk_emit+0x570/0x5f8
[   38.888000]  [<0000000040200bdc>] printk+0x64/0x78
[   38.888000]  [<0000000040201fc0>] register_console+0x438/0x550
[   38.888000]  [<0000000040688bb8>] uart_add_one_port+0x400/0x5d0
[   38.888000]  [<000000004068e6d4>] serial8250_register_8250_port+0x3e4/0x448
[   38.888000]  [<0000000040695f44>] pciserial_init_ports+0x22c/0x2c8
[   38.888000]  [<0000000040696628>] pciserial_init_one+0x250/0x2e0
[   38.888000]  [<00000000405f3880>] pci_device_probe+0xb0/0x150
[   38.888000]  [<00000000406a8244>] driver_probe_device+0x204/0x570
[   38.888000]  [<00000000406a8728>] __driver_attach+0xe0/0x158
[   38.888000]  [<00000000406a4558>] bus_for_each_dev+0xd0/0x128
[   38.888000]  [<00000000406a76f8>] driver_attach+0x48/0x60
[   38.888000]  [<00000000406a6de8>] bus_add_driver+0x268/0x460
[   38.888000]  [<00000000406a915c>] driver_register+0x124/0x1d0
[   38.888000]  [<00000000405f336c>] __pci_register_driver+0x64/0x78
[   38.888000]  [<00000000401375e4>] serial_pci_driver_init+0x44/0x58

[   59.084000] timer_interrupt(CPU 3): delayed! cycles 85EBC4C7D rem 2BAF83  next/now 2765C08677/276594D6F4
[   59.140000] bootconsole [ttyB0] disabled
[   59.144000] serial 0000:00:04.1: ttyS1 at MMIO 0xffffffff80000008 (irq = 70, base_baud = 115200) is a 16450
[   59.164000] serial 0000:00:04.1: ttyS2 at MMIO 0xffffffff80000010 (irq = 70, base_baud = 115200) is a 16550A
