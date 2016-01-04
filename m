From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/5] serial: sh-sci: Add support for SCIFA/SCIFB variable sampling rates
Date: Mon,  4 Jan 2016 14:45:17 +0100
Message-ID: <1451915122-30219-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi Greg, Jiri,

This patch series adds support for variable sampling rates on the SCIFA
and SCIFB variants.

Currently the driver uses a fixed sampling rate divider (usually 16 or 32),
except on HSCIF (full range of 8 to 32).  Supporting all available
sampling rates on SCIFA and SCIFB increases the range and accuracy of
supported baud rates.

E.g. on r8a7791/koelsch:
  - Supports now 134, 150, and standard 500000-4000000 bps,
  - Perfect match for 134, 150, 500000, 1000000, 2000000, and 4000000
    bps,
  - Accuracy has increased for most standard bps values.

Tested on:
  - r8a7791/koelsch (Fully tested on SCIFA and SCIFB),
  - r8a7740/armadillo (Fully tested on SCIFA and SCIFB),
  - sh73a0/kzm9g (Fully tested on SCIFA only, no easy access to SCIFB),
  - r8a73a4/ape6evm (SCIFA/FTDI console at 460800 bps, no easy access to
    SCIFB).

This series depends on my scif-clk-sck-brg-for-v4.5 pull request.

Thanks for your comments!

Geert Uytterhoeven (5):
  serial: sh-sci: Add more Serial Mode Register documentation
  serial: sh-sci: Preserve SCIFA/SCIFB bit rate config for serial
    console
  serial: sh-sci: Use premultiplier to handle half sampling rate
  serial: sh-sci: Use a bitmask to indicate supported sampling rates
  serial: sh-sci: Add support for SCIFA/SCIFB variable sampling rates

 drivers/tty/serial/sh-sci.c | 106 ++++++++++++++++++++++++++------------------
 drivers/tty/serial/sh-sci.h |  15 +++++++
 2 files changed, 77 insertions(+), 44 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
