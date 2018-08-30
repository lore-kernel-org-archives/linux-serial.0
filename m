From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] serial: sh-sci: Fix earlycon on Renesas ARM platforms
Date: Thu, 30 Aug 2018 14:54:02 +0200
Message-ID: <20180830125404.21192-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Chris Brandt <chris.brandt@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulrich Hecht <uli+renesas@fpond.eu>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi Greg,

Due to an unfortunate oversight, commit 2d4dd0da45401c7a ("serial: sh-sci:
Allow for compressed SCIF address") broke earlycon on all Renesas ARM
platforms using a SCIF port for the serial console (R-Car, RZ/A1, RZ/G1,
RZ/G2 SoCs), due to an incorrect value of port->regshift.

This patch series fixes that by reverting that commit, and a (reverse)
dependency.

Earlycon for RZ/A2 (which is a new platform) will be fixed later in a
separate patch.

Thanks for applying!

Geert Uytterhoeven (2):
  Revert "serial: sh-sci: Remove SCIx_RZ_SCIFA_REGTYPE"
  Revert "serial: sh-sci: Allow for compressed SCIF address"

 drivers/tty/serial/sh-sci.c | 56 +++++++++++++++++++++++++++----------
 include/linux/serial_sci.h  |  1 +
 2 files changed, 42 insertions(+), 15 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
