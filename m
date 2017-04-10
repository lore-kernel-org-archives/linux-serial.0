From: Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>
Subject: [PATCH v3 1/2] serial: 8250: Add flag so drivers can avoid THRE probe
Date: Mon, 10 Apr 2017 13:33:59 +0930
Message-ID: <20170410040400.5509-2-joel@jms.id.au>
References: <20170410040400.5509-1-joel@jms.id.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170410040400.5509-1-joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Jeremy Kerr <jk-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

The probing of THRE irq behaviour assumes the other end will be reading
bytes out of the buffer in order to probe the port at driver init. In
some cases the other end cannot be relied upon to read these bytes, so
provide a flag for them to skip this step.

Bit 19 was chosen as the flags are a int and the top bits are taken.

Acked-by: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Signed-off-by: Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>

---
v3:
 - Correct the bit number in the changelog

v2:
 - No change

 drivers/tty/serial/8250/8250_port.c | 2 +-
 include/linux/serial_core.h         | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 6119516ef5fc..60a6c247340f 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2229,7 +2229,7 @@ int serial8250_do_startup(struct uart_port *port)
 		}
 	}
 
-	if (port->irq) {
+	if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
 		unsigned char iir1;
 		/*
 		 * Test for UARTs that do not reassert THRE when the
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 58484fb35cc8..260245deec94 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -195,6 +195,7 @@ struct uart_port {
 #define UPF_NO_TXEN_TEST	((__force upf_t) (1 << 15))
 #define UPF_MAGIC_MULTIPLIER	((__force upf_t) ASYNC_MAGIC_MULTIPLIER /* 16 */ )
 
+#define UPF_NO_THRE_TEST	((__force upf_t) (1 << 19))
 /* Port has hardware-assisted h/w flow control */
 #define UPF_AUTO_CTS		((__force upf_t) (1 << 20))
 #define UPF_AUTO_RTS		((__force upf_t) (1 << 21))
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
