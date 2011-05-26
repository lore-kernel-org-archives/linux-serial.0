From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [GIT PATCH] TTY/serial driver patches for .40
Date: Thu, 26 May 2011 12:54:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105261248060.9307@axis700.grange>
References: <20110523190539.GA17519@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59971 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723Ab1EZKyh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 May 2011 06:54:37 -0400
In-Reply-To: <20110523190539.GA17519@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Felipe Balbi <balbi@ti.com>

On Mon, 23 May 2011, Greg KH wrote:

> Here's the big tty/serial merge for .40

/me confused: this patch

> Felipe Balbi (1):
>       tty: make receive_buf() return the amout of bytes received

is more than one year old, which I wouldn't care about, if it didn't=20
introduce a regression on my mackerel=20
(arch/arm/mach-shmobile/board-mackerel.c) board. With it in place print=
ing=20
a lot of text over ssh pauses the output multiple times for several=20
seconds. With this patch reverted the behaviour is back to normal. To=20
reproduce one can either cat a few largish files under /etc or just dme=
sg=20
- if there have been enough messages accumulated.

Thanks
Guennadi

>=20
> Some api cleanups, and driver updates, nothing really major.  You wil=
l
> get two conflicts when you merge this to your tree (one in the tty
> Makefile and one in the bluetooth driver), but they should be "obviou=
s"
> as to what to do.  If you want me to do the merge, just let me know a=
nd
> I will.
>=20
> Please pull from:
> 	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/tty-2.6.git/ tty-=
next
>=20
> All of these patches have been in the -mm and -next trees for a while=
=2E
>=20
> Patches will be sent to the linux-serial mailing list, if anyone want=
s
> to see them.
>=20
> thanks,
>=20
> greg k-h
>=20
> ------------
>=20
>  Documentation/pti/pti_intel_mid.txt         |   99 +++
>  drivers/bluetooth/hci_ldisc.c               |   10 +-
>  drivers/input/serio/serport.c               |   10 +-
>  drivers/isdn/gigaset/ser-gigaset.c          |    8 +-
>  drivers/misc/Kconfig                        |   25 +-
>  drivers/misc/Makefile                       |    1 +
>  drivers/misc/pch_phub.c                     |  153 +++-
>  drivers/misc/pti.c                          |  980 +++++++++++++++++=
++++++
>  drivers/misc/ti-st/st_core.c                |    6 +-
>  drivers/net/caif/caif_serial.c              |    6 +-
>  drivers/net/can/slcan.c                     |    9 +-
>  drivers/net/hamradio/6pack.c                |    8 +-
>  drivers/net/hamradio/mkiss.c                |   11 +-
>  drivers/net/irda/irtty-sir.c                |   16 +-
>  drivers/net/ppp_async.c                     |    6 +-
>  drivers/net/ppp_synctty.c                   |    6 +-
>  drivers/net/slip.c                          |   11 +-
>  drivers/net/wan/x25_asy.c                   |    7 +-
>  drivers/parport/parport_pc.c                |    2 +-
>  drivers/tty/Kconfig                         |   31 +
>  drivers/tty/Makefile                        |    2 +
>  drivers/tty/amiserial.c                     |    2 -
>  drivers/tty/cyclades.c                      |    5 +-
>  drivers/tty/ipwireless/Makefile             |    2 -
>  drivers/tty/moxa.c                          |   18 +-
>  drivers/tty/n_gsm.c                         |   41 +-
>  drivers/tty/n_hdlc.c                        |   18 +-
>  drivers/tty/n_r3964.c                       |   10 +-
>  drivers/tty/n_tracerouter.c                 |  243 ++++++
>  drivers/tty/n_tracesink.c                   |  238 ++++++
>  drivers/tty/n_tracesink.h                   |   36 +
>  drivers/tty/n_tty.c                         |   61 +--
>  drivers/tty/nozomi.c                        |   29 +-
>  drivers/tty/pty.c                           |   35 +-
>  drivers/tty/rocket.c                        |   47 --
>  drivers/tty/serial/21285.c                  |    2 -
>  drivers/tty/serial/8250.c                   |   44 +-
>  drivers/tty/serial/8250.h                   |    3 +-
>  drivers/tty/serial/8250_accent.c            |    2 -
>  drivers/tty/serial/8250_boca.c              |    2 -
>  drivers/tty/serial/8250_exar_st16c554.c     |    2 -
>  drivers/tty/serial/8250_fourport.c          |    2 -
>  drivers/tty/serial/8250_hub6.c              |    2 -
>  drivers/tty/serial/8250_mca.c               |    2 -
>  drivers/tty/serial/8250_pci.c               |   53 ++-
>  drivers/tty/serial/8250_pnp.c               |    2 -
>  drivers/tty/serial/Kconfig                  |   27 +-
>  drivers/tty/serial/Makefile                 |    1 +
>  drivers/tty/serial/altera_uart.c            |   26 +-
>  drivers/tty/serial/amba-pl010.c             |    2 -
>  drivers/tty/serial/amba-pl011.c             |    2 -
>  drivers/tty/serial/atmel_serial.c           |    2 -
>  drivers/tty/serial/clps711x.c               |    2 -
>  drivers/tty/serial/cpm_uart/cpm_uart.h      |    2 -
>  drivers/tty/serial/cpm_uart/cpm_uart_core.c |    2 -
>  drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c |    2 -
>  drivers/tty/serial/cpm_uart/cpm_uart_cpm1.h |    2 -
>  drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c |    2 -
>  drivers/tty/serial/cpm_uart/cpm_uart_cpm2.h |    2 -
>  drivers/tty/serial/ifx6x60.c                |    2 -
>  drivers/tty/serial/imx.c                    |    2 -
>  drivers/tty/serial/msm_serial.c             |    2 +-
>  drivers/tty/serial/msm_serial.h             |    2 -
>  drivers/tty/serial/msm_smd_tty.c            |    3 +-
>  drivers/tty/serial/netx-serial.c            |    2 -
>  drivers/tty/serial/pch_uart.c               |    8 +
>  drivers/tty/serial/pmac_zilog.c             |    2 -
>  drivers/tty/serial/pxa.c                    |    2 -
>  drivers/tty/serial/s3c2400.c                |    3 +-
>  drivers/tty/serial/s3c2410.c                |    3 +-
>  drivers/tty/serial/s3c2412.c                |    3 +-
>  drivers/tty/serial/s3c2440.c                |    3 +-
>  drivers/tty/serial/s3c24a0.c                |    3 +-
>  drivers/tty/serial/s3c6400.c                |    3 +-
>  drivers/tty/serial/s5pv210.c                |    3 +-
>  drivers/tty/serial/sa1100.c                 |    2 -
>  drivers/tty/serial/samsung.c                |    3 +-
>  drivers/tty/serial/samsung.h                |    3 +-
>  drivers/tty/serial/sb1250-duart.c           |    2 -
>  drivers/tty/serial/serial_core.c            |   90 +--
>  drivers/tty/serial/serial_ks8695.c          |    2 -
>  drivers/tty/serial/serial_txx9.c            |    2 -
>  drivers/tty/serial/sh-sci.c                 |    2 -
>  drivers/tty/serial/vt8500_serial.c          |    2 -
>  drivers/tty/serial/xilinx_uartps.c          | 1113 +++++++++++++++++=
++++++++++
>  drivers/tty/synclink.c                      |    2 -
>  drivers/tty/tty_buffer.c                    |   15 +-
>  drivers/tty/tty_io.c                        |   53 +-
>  drivers/tty/tty_ioctl.c                     |    2 -
>  drivers/tty/tty_ldisc.c                     |   13 +
>  drivers/tty/tty_mutex.c                     |    3 -
>  drivers/tty/vt/keyboard.c                   |    2 -
>  drivers/tty/vt/selection.c                  |    5 +-
>  drivers/tty/vt/vc_screen.c                  |    2 -
>  drivers/tty/vt/vt.c                         |   13 +-
>  drivers/tty/vt/vt_ioctl.c                   |   25 +-
>  fs/exec.c                                   |    1 +
>  include/linux/pti.h                         |   42 +
>  include/linux/serial_core.h                 |    6 +-
>  include/linux/serial_reg.h                  |    2 +
>  include/linux/tty.h                         |    4 +
>  include/linux/tty_ldisc.h                   |    9 +-
>  sound/soc/codecs/cx20442.c                  |    8 +-
>  103 files changed, 3344 insertions(+), 512 deletions(-)
>  create mode 100644 Documentation/pti/pti_intel_mid.txt
>  create mode 100644 drivers/misc/pti.c
>  create mode 100644 drivers/tty/n_tracerouter.c
>  create mode 100644 drivers/tty/n_tracesink.c
>  create mode 100644 drivers/tty/n_tracesink.h
>  create mode 100644 drivers/tty/serial/xilinx_uartps.c
>  create mode 100644 include/linux/pti.h
>=20
> ---------------
>=20
> Alan Cox (1):
>       parport: Use request_muxed_region for IT87 probe and lock
>=20
> Andrew Morton (1):
>       drivers/tty/vt/vt_ioctl.c: repair insane ?: expression
>=20
> Antony Pavlov (1):
>       serial: 8250_pci: add support for Cronyx Omega PCI multiserial =
board.
>=20
> Arthur Taylor (1):
>       vt: Add K_OFF return value to vt_ioctl KDGKBMODE
>=20
> Felipe Balbi (1):
>       tty: make receive_buf() return the amout of bytes received
>=20
> Govindraj.R (1):
>       Serial: Remove unused code.
>=20
> Herton Ronaldo Krzesinski (1):
>       vt: remove uneeded retval check before tty->ops->open inside tt=
y_open
>=20
> J Freyensee (4):
>       export kernel call get_task_comm().
>       Kernel documentation for the PTI feature.
>       Intel PTI implementaiton of MIPI 1149.7.
>       n_tracerouter and n_tracesink ldisc additions.
>=20
> Jesper Juhl (1):
>       Serial: ifx6x60c: Remove duplicate includes of linux/tty.h
>=20
> Jiri Slaby (23):
>       tty: VT, remove unused variable
>       TTY: serial_core, remove unused variable
>       Char: cyclades, fix unused variable
>       TTY: VT, remove unused variables
>       Char: moxa, remove unused variables
>       TTY: rocket, remove unused variables
>       TTY: unify tty_init_dev fail path handling
>       TTY: unify pty_install fail path handling
>       TTY: unify pty_unix98_install fail path handling
>       TTY: introduce deinit helpers for proper ldisc shutdown
>       TTY: plug in deinitialize_tty_struct
>       TTY: fix fail path in tty_open
>       Char: moxa, do not touch NORMAL_ACTIVE bit
>       serial: core, move termios handling to uart_startup
>       serial: core, do not set DTR/RTS twice on startup
>       serial: core, remove uart_update_termios
>       Char: nozomi, use GFP_KERNEL for kfifo allocation
>       Char: nozomi, remove port.count checks
>       Char: nozomi, remove useless tty_sem
>       Char: moxa, fix locking in moxa_write
>       TTY: serial_core, remove invalid test
>       TTY: serial_core, remove superfluous set_task_state
>       TTY: tty_io, annotate locking functions
>=20
> Joe Perches (1):
>       n_gsm: Use print_hex_dump_bytes
>=20
> John Linn (1):
>       tty/serial: add support for Xilinx PS UART
>=20
> Jovi Zhang (1):
>       tty: remove invalid location line in file header
>=20
> Julia Lawall (1):
>       drivers/tty/moxa.c: Put correct tty value
>=20
> Kukjin Kim (1):
>       tty: Remove to support serial for S5P6442
>=20
> Mark Brown (1):
>       ASoC: Update cx20442 for TTY API change
>=20
> Petr P=C3=ADsa=C5=99 (1):
>       tty: Clean console safely
>=20
> Scott Kilau (1):
>       8250_pci: Add support for the Digi/IBM PCIe 2-port Adapter
>=20
> Stephen Warren (2):
>       tty/serial: Add explicit PORT_TEGRA type
>       tty/serial: Fix break handling for PORT_TEGRA
>=20
> Tobias Klauser (1):
>       serial: altera_uart: Scan for a free port if platform device id=
 is -1
>=20
> Tomoya MORINAGA (2):
>       pch_uart: Support new device ML7223 IOH
>       pch_phub: Support new device ML7223
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
http://www.open-technology.de/
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
