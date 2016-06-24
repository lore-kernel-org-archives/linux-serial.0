From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/4] serial: sh-sci: FIFO initialization fixes
Date: Fri, 24 Jun 2016 16:59:12 +0200
Message-ID: <1466780356-12623-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <damm+renesas@opensource.se>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi Greg, Jiri,

When opening a Renesas SCIF serial port after it has been used before,
stale data may be read.  This has been observed on R-Car Gen2 and R-Car
Gen3, with all SCIF variants present (SCIF, SCIFA, SCIFB, and HSCIF). It
is much more likely to happen when DMA is enabled, although it has been
seen with PIO, too.

There are actually two reasons why stale data is received:
  1. Transfers are started, or are still activated, before the FIFO is
     reset, causing one or more (up to the RX FIFO size) stale bytes
     (fixed by patches 1 and 2),
  2. FIFO reset lacked clearing the RDF flag, causing one byte of stale
     data (fixed by patch 3).
While at it, patch 4 adds the missing clearing of two other flags in the
initialization sequence on (H)SCIF.

While the issue can be reproduced using subsequent runs of sertest[1],
I wrote a new test program, fifotest[2], to trigger it more easily.
More detailed test information can be found on the eLinux wiki[3].

I have verified that this series fixes the issue on SCIF, SCIFA, SCIFB,
and HSCIF, on R-Car Gen2 (r8a7791/koelsch) and R-Car Gen3
(r8a7795/salvator-x).
Basic regression testing has been done with SCIFA on sh73a0/kzm9g.
Regression testing on other variants (notably SCI) would be appreciated.

Changes compared to v1:
  - Do not clear clock source bits, since the serial console relies on
    them, as reported by Shimoda-san.

This series applies against both v4.6 and next-20160526.
For testing, it's also available in a topic branch at
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/scif-fifo-v2.

Please apply, thanks!

[1] https://github.com/geertu/sertest
[2] https://github.com/geertu/fifotest
[3] http://elinux.org/Tests:SCIF-FIFO

Geert Uytterhoeven (4):
  serial: sh-sci: Do not start transfers from sci_startup()
  serial: sh-sci: Stop transfers in sci_shutdown()
  serial: sh-sci: Clear RX, error, and break flags during reset
  serial: sh-sci: Clear (H)SCIF timeout and overrun during reset

 drivers/tty/serial/sh-sci.c | 20 ++++++++++++++------
 drivers/tty/serial/sh-sci.h |  1 +
 2 files changed, 15 insertions(+), 6 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
