From: Martin Sperl <kernel@martin.sperl.org>
Subject: serial: clk: bcm2835: Strange effects when using aux-uart in console
Date: Wed, 10 Feb 2016 16:12:05 +0100
Message-ID: <A5F427B7-9B78-4892-9722-69418C4D0C10@martin.sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>
Cc: Eric Anholt <eric@anholt.net>
List-Id: linux-serial@vger.kernel.org

Hi!

I got a strange effect when using the auxiliar UART as the logging cons=
ole:

The kernel is configured for drivers/tty/serial/8250/8250_bcm2835aux.c =
to
get linked into the main kernel (requires also 8250.c to be linked in).

As long as I boot using the main UART (PL011) in the kernel parameters:
  earlyprintk consoleblank=3D0 console=3DttyAMA0 root=3D/dev/mmcblk0p2 =
rootwait

Everything works fine - early_printk works and normal logging works as =
well.
Both configured ttys (/dev/ttyAMA0 and /dev/ttyS0) in /etc/initttab
work fine.

Now when I switch the console to use the auxiliar UART
(which right now does not support early_printk) like this:
  earlyprintk consoleblank=3D0 console=3DttyS0,115200n1 root=3D/dev/mmc=
blk0p2 rootwait

I get the situation where:
* u-boot starts and writes to the main UART
* Kernel boots using early_printk logging to the main UART until we get=
 to:
  [    2.657090] bootconsole [earlycon0] disabled
* then we see the earlyprintk buffer dumped on the aux-uart
* then booting continues and logging happens on the aux-uart:
  [    2.657090] bootconsole [earlycon0] disabled
  [    2.662673] 20201000.serial: ttyAMA0 at MMIO 0x20201000 (irq =3D 8=
1, base_baud =3D 0) is a PL011 rev2
  [    2.663793] console [ttyS0] disabled
  [    2.663899] 20215040.serial: ttyS0 at MMIO 0x0 (irq =3D 53, base_b=
aud =3D 31224999) is a 16550
  [    3.384166] console [ttyS0] enabled
* everything works fine and I get networking and everything up
  [....] Starting NTP server: ntpd. ok
  [....] Starting OpenBSD Secure Shell server: sshd. ok
  My IP address is 10.10.10.41 ::127.0.0.1

  Raspbian GNU/Linux 7 raspcm.intern.sperl.org ttyS0
* I can even log in via SSH and networking works.
  Note that I have the getty for ttyAMA0 disabled in inittab
* when I then enable the tty on the main UART like this:
  root@raspcm:~# /sbin/getty -a root -L ttyAMA0 115200 vt100
* I get the following:
  [   72.962845] uart-pl011 20201000.serial: no DMA platform data
* the system freezes=E2=80=A6
* sometimes I still get the following on the auxiliar UART before the s=
ystem =E2=80=9Ccrashes":
  (at least when starting the tty from inittab)
  [   73.072985] bcm2835-clk 20101000.cprman: plld: couldn't lock PLL
  [   73.079132] ------------[ cut here ]------------
  [   73.083848] WARNING: CPU: 0 PID: 2329 at drivers/clk/clk.c:680 clk=
_core_disable+0x34/0xf0()
  [   73.093067] ---[ end trace 416e78cea88f5fb5 ]---
  [   73.097848] ------------[ cut here ]------------
  [   73.102616] WARNING: CPU: 0 PID: 2329 at drivers/clk/clk.c:575 clk=
_core_unprepare+0x34/0x110()
  [   73.112219] ---[ end trace 416e78cea88f5fb6 ]---

A similar effect I get when using stty:=20
  root@raspcm:~# stty -F /dev/ttyAMA0
  [  128.878127] uart-pl011 20201000.serial: no DMA platform data
  speed 9600 baud; line =3D 0;
  -brkint -imaxbel
Then the system freezes.

As if the plld does not lock - even if it (probably) is already locked.

Or the message actually comes from bcm2835_clock_wait_busy which also
produces this message - so maybe we should better identify the message.

Note that the same also applies if I remove earlyprintk with
the only difference being that I do not get the initial boot
messages on the main UART.
(at that time only: "Uncompressing Linux... done, booting the kernel.=E2=
=80=9D
shows on the main uart after u-boot start..)

Unfortunately it is only possible to really test this on a
rpi-Compute module, as only there we can expose both uarts
on distinct GPIOs at the same time:
  GPIO 14: level=3D1 fsel=3D4 alt=3D0 func=3DTXD0
  GPIO 15: level=3D1 fsel=3D4 alt=3D0 func=3DRXD0
  GPIO 32: level=3D1 fsel=3D2 alt=3D5 func=3DTXD1
  GPIO 33: level=3D1 fsel=3D2 alt=3D5 func=3DRXD1

Here the commits I have used based on spi/for-next (based on 4.4.0)
with the patches (* prefix) for the driver for aux-uart
added separately as they are not in the tree I have used:
* a96f6c7 serial: bcm2835: add driver for bcm2835-aux-uart
* 464e876 clk: bcm2835: Add bindings for the auxiliary peripheral clock=
 gates.
* 1af1b28 clk: bcm2835: Add a driver for the auxiliary peripheral clock=
 gates.
ece19b8 Merge remote-tracking branch 'spi/fix/loopback' into spi-linus
887e6a3 Merge tag 'spi-v4.5' into spi-linus
ebea7c0 spi: fix counting in spi-loopback-test code
cabeea9 Merge remote-tracking branches 'spi/topic/sun4i', 'spi/topic/to=
pcliff-pc
4f95307 Merge remote-tracking branches 'spi/topic/overlay', 'spi/topic/=
pxa2xx',
41d5a70 Merge remote-tracking branches 'spi/topic/lm70llp', 'spi/topic/=
loopback'
635b9b2 Merge remote-tracking branches 'spi/topic/dw', 'spi/topic/dw-mi=
d', 'spi/
3c27892 Merge remote-tracking branches 'spi/topic/bcm63xx', 'spi/topic/=
butterfly
9b17e80 Merge remote-tracking branch 'spi/topic/sunxi' into spi-next
174c211 Merge remote-tracking branch 'spi/topic/core' into spi-next
f30f072 Merge remote-tracking branch 'spi/fix/mtk' into spi-linus
afd2ff9 Linux 4.4

Maybe someone has gotten any idea?

In the meantime I will try to reproduce on a 4.5-rc3 based branch.

Thanks,
	Martin

 