From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: sh-sci: Fix receive on SCIFA/SCIFB variants with DMA
Date: Tue,  9 Oct 2018 19:41:58 +0200
Message-ID: <20181009174158.4476-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ulrich Hecht <uli+renesas@fpond.eu>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

On SCIFA and SCIFB serial ports with DMA support (i.e. some ports on
R-Car Gen2 and RZ/G1 SoCs), receive DMA operations are submitted before
the DMA channel pointer is initialized.  Hence this fails, and the
driver tries to fall back to PIO.  However, at this early phase in the
initialization sequence, fallback to PIO does not work, leading to a
serial port that cannot receive any data.

Fix this by calling sci_submit_rx() after initialization of the DMA
channel pointer.

Reported-by: Jinzai Solution and RVC Test Teams via Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Fixes: 2c4ee23530ffc022 ("serial: sh-sci: Postpone DMA release when falling back to PIO")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Reported on r8a7790/lager using SCIFA1 on Debug Serial 1.
Tested on r8a7791/koelsch using SCIFA3 on EXIO-B.

This fixes a regression introduced in v4.19-rc1, so please queue for
v4.19.

Thanks!
---
 drivers/tty/serial/sh-sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b73b27dc45e60ffb..7e98a4f3ec77abbd 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1614,10 +1614,10 @@ static void sci_request_dma(struct uart_port *port)
 		hrtimer_init(&s->rx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 		s->rx_timer.function = rx_timer_fn;
 
+		s->chan_rx_saved = s->chan_rx = chan;
+
 		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
 			sci_submit_rx(s);
-
-		s->chan_rx_saved = s->chan_rx = chan;
 	}
 }
 
-- 
2.17.1
