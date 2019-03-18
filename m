From: Nguyen An Hoan <na-hoan@jinso.co.jp>
Subject: [PATCH] serial: sh-sci: Fix setting SCSCR_TIE while transferring data
Date: Mon, 18 Mar 2019 18:26:32 +0900
Message-ID: <1552901192-29748-1-git-send-email-na-hoan@jinso.co.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, geert+renesas@glider.be
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, ulrich.hecht+renesas@gmail.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com, magnus.damm@gmail.com, yoshihiro.shimoda.uh@renesas.com, h-inayoshi@jinso.co.jp, nv-dung@jinso.co.jp, na-hoan@jinso.co.jp, cv-dong@jinso.co.jp
List-Id: linux-serial@vger.kernel.org

From: Hoan Nguyen An <na-hoan@jinso.co.jp>

We disable transmission interrupt (clear SCSCR_TIE) after all data has been transmitted
(if uart_circ_empty(xmit)). While transmitting, if the data is still in the tty buffer,
re-enable the SCSCR_TIE bit, which was done at sci_start_tx().
This is unnecessary processing, wasting CPU operation if the data transmission length is large.
And further, transmit end, FIFO empty bits disabling have also been performed in the step above.

Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>
---
 drivers/tty/serial/sh-sci.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 64bbeb7..93bd90f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -838,19 +838,9 @@ static void sci_transmit_chars(struct uart_port *port)
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
-	if (uart_circ_empty(xmit)) {
+	if (uart_circ_empty(xmit))
 		sci_stop_tx(port);
-	} else {
-		ctrl = serial_port_in(port, SCSCR);
-
-		if (port->type != PORT_SCI) {
-			serial_port_in(port, SCxSR); /* Dummy read */
-			sci_clear_SCxSR(port, SCxSR_TDxE_CLEAR(port));
-		}
 
-		ctrl |= SCSCR_TIE;
-		serial_port_out(port, SCSCR, ctrl);
-	}
 }
 
 /* On SH3, SCIF may read end-of-break as a space->mark char */
-- 
2.7.4
