From: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 3/4] TTY: clean up port drain-delay handling
Date: Tue, 26 Feb 2013 12:14:31 +0100
Message-ID: <1361877272-6074-4-git-send-email-jhovold@gmail.com>
References: <1361877272-6074-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1361877272-6074-1-git-send-email-jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Move port drain-delay handling to a separate function.

Signed-off-by: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/tty/tty_port.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 2c4fea6..ce4b591 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -405,6 +405,20 @@ int tty_port_block_til_ready(struct tty_port *port,
 }
 EXPORT_SYMBOL(tty_port_block_til_ready);
 
+static void tty_port_drain_delay(struct tty_port *port, struct tty_struct *tty)
+{
+	unsigned int bps = tty_get_baud_rate(tty);
+	long timeout;
+
+	if (bps > 1200) {
+		timeout = (HZ * 10 * port->drain_delay) / bps;
+		timeout = max_t(long, timeout, HZ / 10);
+	} else {
+		timeout = 2 * HZ;
+	}
+	schedule_timeout_interruptible(timeout);
+}
+
 int tty_port_close_start(struct tty_port *port,
 				struct tty_struct *tty, struct file *filp)
 {
@@ -443,17 +457,8 @@ int tty_port_close_start(struct tty_port *port,
 	if (test_bit(ASYNCB_INITIALIZED, &port->flags) &&
 			port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
 		tty_wait_until_sent_from_close(tty, port->closing_wait);
-	if (port->drain_delay) {
-		unsigned int bps = tty_get_baud_rate(tty);
-		long timeout;
