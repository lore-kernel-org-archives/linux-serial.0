From: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 3/9] serial/arc: Remove the workaround for legacy ISS
Date: Thu, 12 Jun 2014 16:01:33 +0530
Message-ID: <1402569099-9900-4-git-send-email-vgupta@synopsys.com>
References: <1402569099-9900-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1402569099-9900-1-git-send-email-vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Francois.Bedard-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
---
 drivers/tty/serial/arc_uart.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 4d971281e3d9..a6da10f84293 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -102,7 +102,6 @@
 struct arc_uart_port {
 	struct uart_port port;
 	unsigned long baud;
-	int is_emulated;	/* H/w vs. Instruction Set Simulator */
 };
 
 #define to_arc_port(uport)  container_of(uport, struct arc_uart_port, port)
@@ -387,17 +386,6 @@ arc_serial_set_termios(struct uart_port *port, struct ktermios *new,
 	uartl = hw_val & 0xFF;
 	uarth = (hw_val >> 8) & 0xFF;
 
-	/*
-	 * UART ISS(Instruction Set simulator) emulation has a subtle bug:
-	 * A existing value of Baudh = 0 is used as a indication to startup
-	 * it's internal state machine.
-	 * Thus if baudh is set to 0, 2 times, it chokes.
-	 * This happens with BAUD=115200 and the formaula above
-	 * Until that is fixed, when running on ISS, we will set baudh to !0
-	 */
-	if (uart->is_emulated)
-		uarth = 1;
-
 	spin_lock_irqsave(&port->lock, flags);
 
 	UART_ALL_IRQ_DISABLE(port);
@@ -520,8 +508,6 @@ arc_uart_init_one(struct platform_device *pdev, int dev_id)
 	if (!plat_data)
 		return -ENODEV;
 
-	uart->is_emulated = !!plat_data[0];	/* workaround ISS bug */
-
 	if (is_early_platform_device(pdev)) {
 		port->uartclk = plat_data[1];
 		uart->baud = plat_data[2];
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
