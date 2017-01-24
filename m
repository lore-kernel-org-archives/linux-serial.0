From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/8] serial: st-asc: Ignore the parity error bit if 8-bit mode is enabled
Date: Tue, 24 Jan 2017 13:43:03 +0000
Message-ID: <20170124134310.27512-2-lee.jones@linaro.org>
References: <20170124134310.27512-1-lee.jones@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170124134310.27512-1-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The datasheet states:

"If the MODE field selects an 8-bit frame then this [parity error] bit
 is undefined. Software should ignore this bit when reading 8-bit frames."

Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/tty/serial/st-asc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 379e5bd..69e6232 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -287,9 +287,19 @@ static void asc_transmit_chars(struct uart_port *port)
 static void asc_receive_chars(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
-	unsigned long status;
+	unsigned long status, mode;
 	unsigned long c = 0;
 	char flag;
+	bool ignore_pe = false;
+
+	/*
+	 * Datasheet states: If the MODE field selects an 8-bit frame then
+	 * this [parity error] bit is undefined. Software should ignore this
+	 * bit when reading 8-bit frames.
+	 */
+	mode = asc_in(port, ASC_CTL) & ASC_CTL_MODE_MSK;
+	if (mode == ASC_CTL_MODE_8BIT || mode == ASC_CTL_MODE_8BIT_PAR)
+		ignore_pe = true;
 
 	if (port->irq_wake)
 		pm_wakeup_event(tport->tty->dev, 0);
@@ -299,8 +309,8 @@ static void asc_receive_chars(struct uart_port *port)
 		flag = TTY_NORMAL;
 		port->icount.rx++;
 
-		if ((c & (ASC_RXBUF_FE | ASC_RXBUF_PE)) ||
-			status & ASC_STA_OE) {
+		if (status & ASC_STA_OE || c & ASC_RXBUF_FE ||
+		    (c & ASC_RXBUF_PE && !ignore_pe)) {
 
 			if (c & ASC_RXBUF_FE) {
 				if (c == (ASC_RXBUF_FE | ASC_RXBUF_DUMMY_RX)) {
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
