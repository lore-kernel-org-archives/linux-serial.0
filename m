From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 00/13] serial: sh-sci: Cleanups and bug fixes
Date: Thu, 30 Apr 2015 18:21:24 +0200
Message-ID: <1430410897-12770-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi,

This patches series performs some cleanups, documentation updates, and
bug fixes for the Renesas (H)SCI(F(A/B)) serial driver, used on ARM and
SH (and H8300).

It should be safe to apply the first 10 patches.

The remaining patches are marked RFC, as they're make more invasive
changes, or depend on other patches doing that.

This received light testing on r8a7791/koelsch (SCIF) and
r8a7740/armadillo (SCIFA/SCIFB), i.e. all on ARM.

Thanks!

Geert Uytterhoeven (13):
  serial: sh-sci: Move private definitions to private header file
  serial: sh-sci: Add (H)SCIF RTS/CTS pin data register bit definitions
  serial: sh-sci: Add SCIFA/B SCPCR register definitions
  serial: sh-sci: Document remaining FIFO Control Register bits
  serial: sh-sci: Standardize on using the BIT() macro to define
    register bits
  serial: sh-sci: Replace hardcoded values in SCxSR_*_CLEAR macros
  serial: sh-sci: Replace hardcoded overrun bit values
  serial: sh-sci: Use the correct register for overrun checks
  serial: sh-sci: Don't set SCLSR bits in the SCxSR error mask
  serial: sh-sci: Remove obsolete comment about overrun detection
  [RFC] serial: sh-sci: Replace buggy big #ifdef by runtime logic
  [RFC] serial: sh-sci: Correct SCIF_ERROR_CLEAR for plain SCIF
  [RFC] serial: sh-sci: Correct FIFO stages on sh7705/sh7720/sh7721

 drivers/tty/serial/sh-sci.c | 147 +++++++++++++++++++++++++++-----------------
 drivers/tty/serial/sh-sci.h | 140 +++++++++++++++++++++++++++++++++--------
 include/linux/serial_sci.h  |  86 ++++----------------------
 3 files changed, 216 insertions(+), 157 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
