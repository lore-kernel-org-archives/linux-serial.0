From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] serial: sh-sci: Assorted flow control fixes
Date: Fri,  2 Dec 2016 13:35:09 +0100
Message-ID: <1480682111-9299-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Christoph Baumann <cbaumann@visteon.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi Greg, Jiri,

This patch series fixes two issues related to hardware flow control on
Renesas SCIF UARTs.

Thanks!

Geert Uytterhoeven (2):
  serial: sh-sci: Fix early deassertion of dedicated RTS
  serial: sh-sci: Fix hang in sci_reset()

 drivers/tty/serial/sh-sci.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
