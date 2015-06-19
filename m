From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] serial: 8250: Do XR17V35X specific wakeup in serial8250_do_startup
Date: Fri, 19 Jun 2015 17:12:17 +0200
Message-ID: <1434726737-2585-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Peter Hurley <peter@hurleysoftware.com>, Michael Welling <mwelling@ieee.org>, Joe Schultz <jschultz@xes-inc.com>
List-Id: linux-serial@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

While debugging why my 8-port XR17V35X card does not work
with the in-kernel serial driver, I found that some chip
specific wakeup code is necessary to get it working.

Specificly the EFR_ECB bit needs to be set in the
chip-specific UART_XR_EFR register, so that writing to a
couple of other configuration bits is enabled.

Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Michael Welling <mwelling@ieee.org>
Cc: Joe Schultz <jschultz@xes-inc.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/tty/serial/8250/8250_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 4506e40..de34db3 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -2176,6 +2176,18 @@ int serial8250_do_startup(struct uart_port *port)
 	 */
 	enable_rsa(up);
 #endif
+
+	/*
+	 * Do this right before clearing the FIFOs to prevent
+	 * interrupt storm.
+	 */
+	if (port->type == PORT_XR17V35X) {
+		/* Wake up and initialize UART */
+		serial_port_out(port, UART_XR_EFR, UART_EFR_ECB);
+		serial_port_out(port, UART_IER, 0);
+		serial_port_out(port, UART_LCR, 0);
+	}
+
 	/*
 	 * Clear the FIFO buffers and disable them.
 	 * (they will be reenabled in set_termios())
-- 
1.8.4.5
