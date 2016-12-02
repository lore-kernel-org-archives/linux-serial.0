From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 3/3] serial: st-asc: Ignore the parity error bit if 8-bit mode is enabled
Date: Fri,  2 Dec 2016 14:11:46 +0000
Message-ID: <20161202141146.31281-3-lee.jones@linaro.org>
References: <20161202141146.31281-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161202141146.31281-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, patrice.chotard@st.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, linux-serial@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-serial@vger.kernel.org

The datasheet states:

"If the MODE field selects an 8-bit frame then this [parity error] bit
 is undefined. Software should ignore this bit when reading 8-bit frames."

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/st-asc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index ce46898..7008eb7 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -289,9 +289,19 @@ static void asc_transmit_chars(struct uart_port *port)
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
@@ -301,8 +311,8 @@ static void asc_receive_chars(struct uart_port *port)
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
