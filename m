From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 1/3] tty: mxser: Remove ASYNC_CLOSING
Date: Sun, 10 Jan 2016 14:51:38 -0800
Message-ID: <1452466300-4372-2-git-send-email-peter@hurleysoftware.com>
References: <1449956976-4784-1-git-send-email-peter@hurleysoftware.com>
 <1452466300-4372-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452466300-4372-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The tty core no longer provides ASYNC_CLOSING. Use private flag for
same purpose, which is to clear the fifos at each and every interrupt
during driver close(). The driver uses this sledgehammer approach because
its close/shutdown sequence is hopelessly borked.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/mxser.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index e9600ce..9a0791e 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -254,6 +254,7 @@ struct mxser_port {
 	int xmit_head;
 	int xmit_tail;
 	int xmit_cnt;
+	int closing;
 
 	struct ktermios normal_termios;
 
@@ -1081,6 +1082,7 @@ static void mxser_close(struct tty_struct *tty, struct file *filp)
 		return;
 	if (tty_port_close_start(port, tty, filp) == 0)
 		return;
+	info->closing = 1;
 	mutex_lock(&port->mutex);
 	mxser_close_port(port);
 	mxser_flush_buffer(tty);
@@ -1091,6 +1093,7 @@ static void mxser_close(struct tty_struct *tty, struct file *filp)
 	mxser_shutdown_port(port);
 	clear_bit(ASYNCB_INITIALIZED, &port->flags);
 	mutex_unlock(&port->mutex);
+	info->closing = 0;
 	/* Right now the tty_port set is done outside of the close_end helper
 	   as we don't yet have everyone using refcounts */	
 	tty_port_close_end(port, tty);
@@ -2253,10 +2256,8 @@ static irqreturn_t mxser_interrupt(int irq, void *dev_id)
 					break;
 				iir &= MOXA_MUST_IIR_MASK;
 				tty = tty_port_tty_get(&port->port);
-				if (!tty ||
-						(port->port.flags & ASYNC_CLOSING) ||
-						!(port->port.flags &
-							ASYNC_INITIALIZED)) {
+				if (!tty || port->closing ||
+				    !(port->port.flags & ASYNC_INITIALIZED)) {
 					status = inb(port->ioaddr + UART_LSR);
 					outb(0x27, port->ioaddr + UART_FCR);
 					inb(port->ioaddr + UART_MSR);
-- 
2.7.0
