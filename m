From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/3] serial: sh-sci: Assorted flow control fixes
Date: Tue, 28 Mar 2017 11:13:43 +0200
Message-ID: <1490692426-19252-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa@sang-engineering.com>, Christoph Baumann <cbaumann@visteon.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi Greg, Jiri,

This patch series fixes several issues related to hardware flow control
on Renesas SCIF UARTs.

For changes compared to v1 ("[PATCH 0/2] serial: sh-sci: Assorted flow
control fixes", https://lkml.org/lkml/2016/12/2/226), please refer to
the comments in the individual patches.

Thanks!

Geert Uytterhoeven (3):
  serial: sh-sci: Fix hang in sci_reset()
  serial: sh-sci: Fix late enablement of AUTORTS
  serial: sh-sci: Fix (AUTO)RTS in sci_init_pins()

 drivers/tty/serial/sh-sci.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
