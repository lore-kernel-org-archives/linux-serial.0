From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 3/4] serial: sh-sci: Clear RX, error, and break flags during reset
Date: Fri, 24 Jun 2016 16:59:15 +0200
Message-ID: <1466780356-12623-4-git-send-email-geert+renesas@glider.be>
References: <1466780356-12623-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1466780356-12623-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <damm+renesas@opensource.se>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Setting the FIFO reset bits is not sufficient to reset the RX FIFO.
After this the status register's RDF flag bit may still be set, causing
the reception of one stale byte of data.

To fix this, clear all status flag bits related to reception, error, and
break handling, cfr. the initialization flowchart in the datasheet.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 drivers/tty/serial/sh-sci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index eecace576c3b758f..0a2be5d293220e08 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2055,6 +2055,10 @@ static void sci_reset(struct uart_port *port)
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

