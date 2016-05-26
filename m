From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/4] serial: sh-sci: Clear RX, error, and break flags during reset
Date: Thu, 26 May 2016 20:18:37 +0200
Message-ID: <1464286718-10745-4-git-send-email-geert+renesas@glider.be>
References: <1464286718-10745-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1464286718-10745-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Setting the FIFO reset bits is not sufficient to reset the RX FIFO.
After this the status register's RDF flag bit may still be set, causing
the reception of one stale byte of data.

To fix this, clear all status flag bits related to reception, error, and
break handling, cfr. the initialization flowchart in the datasheet.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4d2f916f45277e20..549d799cb18fafe7 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2052,6 +2052,10 @@ static void sci_reset(struct uart_port *port)
 	reg = sci_getreg(port, SCFCR);
 	if (reg->size)
 		serial_port_out(port, SCFCR, SCFCR_RFRST | SCFCR_TFRST);
+
+	sci_clear_SCxSR(port,
+			SCxSR_RDxF_CLEAR(port) & SCxSR_ERROR_CLEAR(port) &
+			SCxSR_BREAK_CLEAR(port));
 }
 
 static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
-- 
1.9.1
