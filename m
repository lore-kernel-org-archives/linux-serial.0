From: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/7] USB: serial: add generic wait_until_sent implementation
Date: Sun,  5 May 2013 20:32:28 +0200
Message-ID: <1367778753-22297-3-git-send-email-jhovold@gmail.com>
References: <20130505182913.GE16818@localhost>
 <1367778753-22297-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1367778753-22297-1-git-send-email-jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Stas Sergeev <stsp-cmBhpYW9OiY@public.gmane.org>, Jarkko Huijts <jarkko.huijts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Caylan Van Larson <i@caylan.net>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Add generic wait_until_sent implementation which polls for empty
hardware buffers using the new port-operation tx_empty.

The generic implementation will be used for all sub-drivers that
implement tx_empty but does not define wait_until_sent.

Signed-off-by: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/serial/generic.c    | 29 +++++++++++++++++++++++++++++
 drivers/usb/serial/usb-serial.c |  2 ++
 include/linux/usb/serial.h      |  3 +++
 3 files changed, 34 insertions(+)

diff --git a/drivers/usb/serial/generic.c b/drivers/usb/serial/generic.c
index 297665f..70ae019 100644
--- a/drivers/usb/serial/generic.c
+++ b/drivers/usb/serial/generic.c
@@ -253,6 +253,35 @@ int usb_serial_generic_chars_in_buffer(struct tty_struct *tty)
 }
 EXPORT_SYMBOL_GPL(usb_serial_generic_chars_in_buffer);
 
+void usb_serial_generic_wait_until_sent(struct tty_struct *tty, long timeout)
+{
+	struct usb_serial_port *port = tty->driver_data;
+	unsigned int bps;
+	unsigned long period;
+	unsigned long expire;
+
+	/*
+	 * Use a poll-period of roughly the time it takes to send one
+	 * character or at least one jiffy.
+	 */
+	bps =  tty_get_baud_rate(tty);
+	period = max_t(unsigned long, (10 * HZ / bps), 1);
+	period = min_t(unsigned long, period, timeout);
+
+	dev_dbg(&port->dev, "%s - timeout = %u ms, period = %u ms\n",
+					__func__, jiffies_to_msecs(timeout),
+					jiffies_to_msecs(period));
+	expire = jiffies + timeout;
+	while (!port->serial->type->tx_empty(port)) {
+		schedule_timeout_interruptible(period);
+		if (signal_pending(current))
+			break;
+		if (time_after(jiffies, expire))
+			break;
+	}
+}
+EXPORT_SYMBOL_GPL(usb_serial_generic_wait_until_sent);
+
 static int usb_serial_generic_submit_read_urb(struct usb_serial_port *port,
 						int index, gfp_t mem_flags)
 {
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 31d2768..60caf9c 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1333,6 +1333,8 @@ static void usb_serial_operations_init(struct usb_serial_driver *device)
 	set_to_generic_if_null(device, close);
 	set_to_generic_if_null(device, write_room);
 	set_to_generic_if_null(device, chars_in_buffer);
+	if (device->tx_empty)
+		set_to_generic_if_null(device, wait_until_sent);
 	set_to_generic_if_null(device, read_bulk_callback);
 	set_to_generic_if_null(device, write_bulk_callback);
 	set_to_generic_if_null(device, process_read_urb);
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index afbb7ee..302ddf5 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -269,6 +269,7 @@ struct usb_serial_driver {
 	void (*break_ctl)(struct tty_struct *tty, int break_state);
 	int  (*chars_in_buffer)(struct tty_struct *tty);
 	void (*wait_until_sent)(struct tty_struct *tty, long timeout);
+	bool (*tx_empty)(struct usb_serial_port *port);
 	void (*throttle)(struct tty_struct *tty);
 	void (*unthrottle)(struct tty_struct *tty);
 	int  (*tiocmget)(struct tty_struct *tty);
@@ -328,6 +329,8 @@ extern void usb_serial_generic_close(struct usb_serial_port *port);
 extern int usb_serial_generic_resume(struct usb_serial *serial);
 extern int usb_serial_generic_write_room(struct tty_struct *tty);
 extern int usb_serial_generic_chars_in_buffer(struct tty_struct *tty);
+extern void usb_serial_generic_wait_until_sent(struct tty_struct *tty,
+								long timeout);
 extern void usb_serial_generic_read_bulk_callback(struct urb *urb);
 extern void usb_serial_generic_write_bulk_callback(struct urb *urb);
 extern void usb_serial_generic_throttle(struct tty_struct *tty);
-- 
1.8.2.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
