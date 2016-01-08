From: Rich Felker <dalias@libc.org>
Subject: [PATCH] serial-uartlite: fix missing locking in isr
Date: Fri, 8 Jan 2016 15:33:50 -0500
Message-ID: <20160108203350.GA23919@brightrain.aerifal.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Rich Felker <dalias@libc.org>

The uartlite driver suffers from missing/duplicate/corrupted character
data when the interrupt handler runs concurrently with access to the
device from another cpu. Take the port spinlock to exclude concurrent
access.

Signed-off-by: Rich Felker <dalias@libc.org>

---

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 189f52e..3b818ec 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -194,7 +194,9 @@ static irqreturn_t ulite_isr(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
 	int busy, n = 0;
+	unsigned long flags;
 
+	spin_lock_irqsave(&port->lock, flags);
 	do {
 		int stat = uart_in32(ULITE_STATUS, port);
 		busy  = ulite_receive(port, stat);
@@ -202,6 +204,8 @@ static irqreturn_t ulite_isr(int irq, void *dev_id)
 		n++;
 	} while (busy);
 
+	spin_unlock_irqrestore(&port->lock, flags);
+
 	/* work done? */
 	if (n > 1) {
 		tty_flip_buffer_push(&port->state->port);
