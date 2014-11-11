From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 2/2] tty: serial: bcm63xx: Allow device nodes to be
 renamed to /dev/ttyBCM*
Date: Tue, 11 Nov 2014 11:50:20 -0800
Message-ID: <CAJiQ=7BkuAMCf+oJaBAuP16WUtftD1c1HfMgD9_ajQGK-u8_zQ@mail.gmail.com>
References: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
 <1415523348-4631-2-git-send-email-cernekee@gmail.com> <CAL_JsqLXznpCo3YjN+XqF6cDG38C6dKzO9DHJmzi6=sNnAU=hQ@mail.gmail.com>
 <CAJiQ=7DUV0isdRooz6112Ncx07+9RE5DS5tMBwxr47hTWA8PAw@mail.gmail.com>
 <CAL_JsqLYoUKr71Q-hfLQhXOVL72Gy7PkO-Zd4rBc0Fn-prOqTw@mail.gmail.com>
 <CAJiQ=7C5ki+9opnH68Kw9a573PmO=ANeiVutmVROUP2Typn2qw@mail.gmail.com> <CAL_JsqKE=p_d53A7n4QZpQc_z0tbAp0bhZGerjsUt2BSSvGgtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:62649 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbaKKTul (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Nov 2014 14:50:41 -0500
In-Reply-To: <CAL_JsqKE=p_d53A7n4QZpQc_z0tbAp0bhZGerjsUt2BSSvGgtw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Grant Likely <grant.likely@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux-MIPS <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, stable@vger.kernel.org

On Tue, Nov 11, 2014 at 9:35 AM, Rob Herring <robh@kernel.org> wrote:
>> What is the current best practice for new drivers?
>
> I think it would be using dynamic numbering, but would be good to have
> others weigh in here. It looks like a dynamic major would solve your
> problem. See tty_register_driver. Also, there was a patch to make this
> the fallback behavior instead of an error[1], but it was never merged
> (and it's not clear why). This was the Samsung related change I was
> remembering.
>
> Rob
>
> [1] http://lists.linaro.org/pipermail/linaro-kernel/2014-January/010383.html

This doesn't seem to fix the coexistence problems with the 8250
driver.  Perhaps it is time to write a simpler version of the 8250
driver geared toward embedded applications?  Some items on my wishlist
include:

 - OF_EARLYCON support
 - Native-endian and big-endian register support
 - Move to a pure runtime-enumerated model and drop the ISA code
 - Drop support for obsolete chips (16450, 8250) and quirks for obsolete PCs

It looks like sunsu, serial-tegra, omap-serial, and possibly others
have already started down this path.  Or I could just write a
dedicated uart_bcm7xxx driver if that's easier...

Here are my results after grabbing V2 of Tushar's patch from the list
archives and reverting the bcm63xx_uart driver to claim "ttyS" with
major 4, minor 64:

 - Building with CONFIG_SERIAL_8250_NR_UARTS=0 rendered the 8250-based
system unbootable (it dies with no output right after the bootconsole
is disabled)

 - Building with CONFIG_SERIAL_8250_NR_UARTS=1 rendered the
bcm63xx_uart-based system unbootable, with the following output:

Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
Default device node (4:64) for ttyS is busy, using dynamic major number
bcm63xx_uart 10000100.serial: ttyS0 at MMIO 0x10000100 (irq = 28,
base_baud = 1562500) is a bcm63xx_uart
console [ttyS0] enabled
console [ttyS0] enabled
bootconsole [uart0] disabled
bootconsole [uart0] disabled
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x64/0xbc()
sysfs: cannot create duplicate filename '/class/tty/ttyS0'
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.18.0-rc4+ #384
Stack : 00000000 00000004 00000000 80075444 00000000 00000000 00000000 00000000
      809e5012 0000003a 00000001 00000000 00010000 87c282b8 8056dac4 805b9ce7
      00000001 00000000 809e39d8 87c282b8 87c6ae10 00000001 87c6ae10 804edeb0
      805c0000 80032984 00000000 00000000 80571d28 87c2da84 87c2da84 8056dac4
      00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
      ...
Call Trace:
[<8001a00c>] show_stack+0x64/0x7c
[<804eff94>] dump_stack+0xc8/0xfc
[<80032bd8>] warn_slowpath_common+0x7c/0xac
[<80032c68>] warn_slowpath_fmt+0x2c/0x38
[<8015c784>] sysfs_warn_dup+0x64/0xbc
[<8015cabc>] sysfs_do_create_link_sd.isra.2+0xec/0xf4
[<802c193c>] device_add+0x4b0/0x59c
[<802a452c>] tty_register_device_attr+0xe4/0x278
[<802b625c>] uart_add_one_port+0x344/0x474
[<802bbffc>] bcm_uart_probe+0x14c/0x240
[<802c6c20>] platform_drv_probe+0x54/0xc4
[<802c51bc>] really_probe+0xa0/0x2cc
[<802c5544>] __driver_attach+0xd0/0xd8
[<802c3660>] bus_for_each_dev+0x68/0xb0
[<802c4160>] bus_add_driver+0x168/0x230
[<802c5f6c>] driver_register+0x84/0x138
[<805e86ec>] bcm_uart_init+0x30/0x58
[<805d4ce0>] do_one_initcall+0x148/0x208
[<805d4f0c>] kernel_init_freeable+0x16c/0x228
[<804eb6dc>] kernel_init+0x10/0x100
[<80013ce8>] ret_from_kernel_thread+0x14/0x1c

---[ end trace dc92a8c272541296 ]---
bcm63xx_uart 10000100.serial: Cannot register tty device on line 0
libphy: Fixed MDIO Bus: probed
usbcore: registered new interface driver asix
usbcore: registered new interface driver ax88179_178a
usbcore: registered new interface driver cdc_ether
usbcore: registered new interface driver net1080
usbcore: registered new interface driver cdc_subset
usbcore: registered new interface driver zaurus
usbcore: registered new interface driver cdc_ncm
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-platform: EHCI generic platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-platform: OHCI generic platform driver
usbcore: registered new interface driver usb-storage
TCP: cubic registered
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Freeing unused kernel memory: 4144K (805d4000 - 809e0000)
starting pid 797, tty '': '/etc/init.d/rcS'
Mounting virtual filesystems
Starting mdev
Configuring lo interface
Configuring sit0 interface
Starting network services
starting pid 826, tty '': '/bin/cttyhack /bin/sh -l'
process '/bin/cttyhack /bin/sh -l' (pid 826) exited. Scheduling for restart.
starting pid 828, tty '': '/bin/cttyhack /bin/sh -l'
process '/bin/cttyhack /bin/sh -l' (pid 828) exited. Scheduling for restart.
starting pid 830, tty '': '/bin/cttyhack /bin/sh -l'
