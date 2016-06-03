From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 00/11] serial: sh-sci: Hardware Flow Control Updates
Date: Fri,  3 Jun 2016 12:00:00 +0200
Message-ID: <1464948011-377-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi Greg, Jiri, Peter,

This patch series contains updates to the Renesas SCI UART driver,
related to hardware flow control:
  - Patches 1-2: Device Tree binding updates for GPIO-controlled modem
    lines, and for dedicated RTS/CTS modem lines,
  - Patches 3-4: Driver support for GPIO-controlled modem lines, using
    the serial_mctrl_gpio helpers,
  - New patches 5-11: Driver support for hardware-assisted (automatic)
    hardware flow control, using the dedicated RTS/CTS modem lines.

Changes compared to v2:
  - No code changes,
  - Add Acked-by, Reviewed-by.

Changes compared to v1 (more details in the individual patches):
  - Add Acked-by,
  - Refer to the Generic Serial DT Bindings,
  - Drop out[12]-gpios,
  - Reject combining GPIO and dedicated RTS/CTS,
  - Drop "serial: sh-sci: Replace SCIx_HAVE_RTSCTS by standard
    UPF_HARD_FLOW",
  - Add support for hardware-assisted automatic RTS/CTS control on
    (H)SCIF, SCIFA, and SCIFB.

Dependencies:
  - The patches apply to v4.7-rc1 and next-20160603.

This was tested on r8a7791/koelsch and r8a7740/armadillo, using UARTs
and GPIO pins on expansion connectors.

Expected behavior, using GPIO-based RTS/CTS as a reference:
  - When CRTSCTS is disabled:
      - Reading from a UART asserts the RTS line,
      - Writing to a UART asserts the RTS line.
  - When CRTSCTS is enabled:
      - Reading from a UART asserts the RTS line,
      - Writing to a UART asserts the RTS line.
      - Writing is blocked until CTS is asserted.

Hardware-assisted hardware flow control with HSCIF and SCIFB on
r8a7791/koelsch behaves as expected when dedicated RTS/CTS modem lines
are enabled (beware the large transmission FIFOs on SCIFB ;-)

For SCIFA on r8a7740/armadillo, manually overriding (asserting) the RTS
signal doesn't seem to work. Hence when CRTSCTS is disabled, RTS is
never asserted. When CRTSCTS is enabled, hardware-assisted RTS/CTS does
control RTS as expected. As SCIFA on r8a7791 doesn't have dedicated
RTS/CTS modem lines, I cannot compare.

DT overlays for testing can be found in the topic/renesas-overlays
branch of
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git.

Regression testing on platforms without DT and/or GPIOLIB support
(SuperH) would be appreciated.
Compile-tested on ecovec24_defconfig(GPIOLIB=y) and se7780_defconfig
(GPIOLIB=n).

Please apply, thanks!

Geert Uytterhoeven (11):
  serial: sh-sci: Update DT binding documentation for GPIO modem lines
  serial: sh-sci: Update DT binding documentation for dedicated RTS/CTS
  serial: sh-sci: Always set TIOCM_CTS in .get_mctrl() callback
  serial: sh-sci: Add support for GPIO-controlled modem lines
  serial: sh-sci: Do not open-code sci_getreg()
  serial: sh-sci: Add more Serial Port Register documentation
  serial: sh-sci: Add more Serial Port Control/Data Register
    documentation
  serial: sh-sci: Correct pin initialization on (H)SCIF
  serial: sh-sci: Add pin initialization for SCIFA/SCIFB
  serial: sh-sci: Fix support for hardware-assisted RTS/CTS
  serial: sh-sci: Add DT support for dedicated RTS/CTS

 .../bindings/serial/renesas,sci-serial.txt         |   4 +
 drivers/tty/serial/Kconfig                         |   1 +
 drivers/tty/serial/sh-sci.c                        | 177 ++++++++++++++++++---
 drivers/tty/serial/sh-sci.h                        |  24 ++-
 4 files changed, 173 insertions(+), 33 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
