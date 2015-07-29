From: Jose Manuel Abuin Mosquera <abuinjm@gmail.com>
Subject: [PATCH 1/1] Changed some lines according to coding style in drivers/tty/serial/jsm
Date: Wed, 29 Jul 2015 08:59:32 +0200
Message-ID: <1438153172-17881-1-git-send-email-abuinjm@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Changed some lines according to coding style in drivers/tty/serial/jsm.

Some lines passing 80 characters are left

Signed-off-by: Jose Manuel Abuin Mosquera <abuinjm@gmail.com>
---
 drivers/tty/serial/jsm/jsm_tty.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index 524e86a..c96b0a2 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -124,6 +124,7 @@ static void jsm_tty_set_mctrl(struct uart_port *port, unsigned int mctrl)
 static void jsm_tty_write(struct uart_port *port)
 {
 	struct jsm_channel *channel;
+
 	channel = container_of(port, struct jsm_channel, uart_port);
 	channel->ch_bd->bd_ops->copy_data_from_queue_to_uart(channel);
 }
@@ -399,6 +400,7 @@ int jsm_tty_init(struct jsm_board *brd)
 			 * interrupt context, and there are no locks held.
 			 */
 			brd->channels[i] = kzalloc(sizeof(struct jsm_channel), GFP_KERNEL);
+
 			if (!brd->channels[i]) {
 				jsm_dbg(CORE, &brd->pci_dev,
 					"%s:%d Unable to allocate memory for channel struct\n",
@@ -468,18 +470,19 @@ int jsm_uart_port_init(struct jsm_board *brd)
 		brd->channels[i]->uart_port.ops = &jsm_ops;
 		line = find_first_zero_bit(linemap, MAXLINES);
 		if (line >= MAXLINES) {
-			printk(KERN_INFO "jsm: linemap is full, added device failed\n");
+			pr_info("jsm: linemap is full, added device failed\n");
 			continue;
 		} else
 			set_bit(line, linemap);
 		brd->channels[i]->uart_port.line = line;
-		rc = uart_add_one_port (&jsm_uart_driver, &brd->channels[i]->uart_port);
-		if (rc){
-			printk(KERN_INFO "jsm: Port %d failed. Aborting...\n", i);
+		rc = uart_add_one_port(&jsm_uart_driver, &brd->channels[i]->uart_port);
+
+		if (rc) {
+			pr_info("jsm: Port %d failed. Aborting...\n", i);
 			return rc;
+		} else {
+			pr_info("jsm: Port %d added\n", i);
 		}
-		else
-			printk(KERN_INFO "jsm: Port %d added\n", i);
 	}
 
 	jsm_dbg(INIT, &brd->pci_dev, "finish\n");
@@ -542,7 +545,7 @@ void jsm_input(struct jsm_channel *ch)
 	tp = port->tty;
 
 	bd = ch->ch_bd;
-	if(!bd)
+	if (!bd)
 		return;
 
 	spin_lock_irqsave(&ch->ch_lock, lock_flags);
@@ -570,7 +573,7 @@ void jsm_input(struct jsm_channel *ch)
 	 *input data and return immediately.
 	 */
 	if (!tp ||
-		!(tp->termios.c_cflag & CREAD) ) {
+		!(tp->termios.c_cflag & CREAD)) {
 
 		jsm_dbg(READ, &ch->ch_bd->pci_dev,
 			"input. dropping %d bytes on port %d...\n",
@@ -625,14 +628,14 @@ void jsm_input(struct jsm_channel *ch)
 				 * Give the Linux ld the flags in the
 				 * format it likes.
 				 */
-				if (*(ch->ch_equeue +tail +i) & UART_LSR_BI)
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i),  TTY_BREAK);
-				else if (*(ch->ch_equeue +tail +i) & UART_LSR_PE)
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_PARITY);
-				else if (*(ch->ch_equeue +tail +i) & UART_LSR_FE)
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_FRAME);
+				if (*(ch->ch_equeue + tail + i) & UART_LSR_BI)
+					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i),  TTY_BREAK);
+				else if (*(ch->ch_equeue + tail + i) & UART_LSR_PE)
+					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i), TTY_PARITY);
+				else if (*(ch->ch_equeue + tail + i) & UART_LSR_FE)
+					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i), TTY_FRAME);
 				else
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_NORMAL);
+					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i), TTY_NORMAL);
 			}
 		} else {
 			tty_insert_flip_string(port, ch->ch_rqueue + tail, s);
@@ -763,7 +766,9 @@ void jsm_check_queue_flow_control(struct jsm_channel *ch)
 	int qleft;
 
 	/* Store how much space we have left in the queue */
-	if ((qleft = ch->ch_r_tail - ch->ch_r_head - 1) < 0)
+	qleft = ch->ch_r_tail - ch->ch_r_head - 1;
+
+	if (qleft < 0)
 		qleft += RQUEUEMASK + 1;
 
 	/*
@@ -784,7 +789,7 @@ void jsm_check_queue_flow_control(struct jsm_channel *ch)
 	if (qleft < 256) {
 		/* HWFLOW */
 		if (ch->ch_c_cflag & CRTSCTS) {
-			if(!(ch->ch_flags & CH_RECEIVER_OFF)) {
+			if (!(ch->ch_flags & CH_RECEIVER_OFF)) {
 				bd_ops->disable_receiver(ch);
 				ch->ch_flags |= (CH_RECEIVER_OFF);
 				jsm_dbg(READ, &ch->ch_bd->pci_dev,
-- 
2.4.6
