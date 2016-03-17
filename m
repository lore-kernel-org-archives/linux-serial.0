From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 0/5] serial: sh-sci: Hardware Flow Control Updates
Date: Thu, 17 Mar 2016 14:47:24 +0100
Message-ID: <1458222449-12324-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi all,

This RFC patch series contains updates to the Renesas SCI UART driver,
related to hardware flow control:
  - Device Tree binding updates for GPIO-controlled modem lines, and for
    dedicated RTS/CTS modem lines,
  - Driver support for GPIO-controlled modem lines, using the
    SERIAL_MCTRL_GPIO helpers,
  - Some preparations for fixing hardware-assisted flow control using
    the dedicated RTS/CTS modem lines later.

This was tested on r8a7791/koelsch, using UART and GPIO pins on expansion
connectors (I've pushed a few more DT overlays for testing to the
topic/renesas-overlays branch of
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git)

Testing for regressions on platforms without DT and/or GPIOLIB support
(SuperH) would be appreciated.
Compile-tested on ecovec24_defconfig(GPIOLIB=y) and se7780_defconfig
(GPIOLIB=n).

Thanks for your comments!

Geert Uytterhoeven (5):
  serial: sh-sci: Update DT binding documentation for GPIO modem lines
  serial: sh-sci: Update DT binding documentation for dedicated RTS/CTS
  serial: sh-sci: Always set TIOCM_CTS in .get_mctrl() callback
  serial: sh-sci: Add support for GPIO-controlled modem lines
  serial: sh-sci: Replace SCIx_HAVE_RTSCTS by standard UPF_HARD_FLOW

 .../bindings/serial/renesas,sci-serial.txt         |  8 +++++
 drivers/tty/serial/Kconfig                         |  1 +
 drivers/tty/serial/sh-sci.c                        | 41 +++++++++++++++++++---
 include/linux/serial_sci.h                         |  6 ----
 4 files changed, 46 insertions(+), 10 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
