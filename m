From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH] earlycon: Allow specifying a uartclk in options
Date: Thu,  1 Mar 2018 11:20:28 -0700
Message-ID: <20180301182028.237856-1-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: adurbin@chromium.org, briannorris@chromium.org, Daniel Kurtz <djkurtz@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Currently when an earlycon is registered, the uartclk is assumed to be
BASE_BAUD * 16 = 1843200.  If a baud rate is specified in the earlycon
options, then 8250_early's init_port will program the UART clock divider
registers based on this assumed uartclk.

However, not all uarts have a UART clock of 1843200.  For example, the
8250_dw uart in AMD's CZ/ST uses a fixed 48 MHz clock (as specified in
cz_uart_desc in acpi_apd.c).  Thus, specifying a baud when using earlycon
on such a device will result in incorrect divider values and a wrong UART
clock.

Fix this by extending the earlycon options parameter to allow specification
of a uartclk, like so:

 earlycon=uart,mmio32,0xfedc6000,115200,48000000

If none is specified, fall-back to prior behavior - 1843200.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/tty/serial/earlycon.c | 8 ++++++--
 include/linux/serial_core.h   | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 870e84fb6e39..c9b38f520057 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -115,12 +115,17 @@ static int __init parse_options(struct earlycon_device *device, char *options)
 	}
 
 	if (options) {
-		device->baud = simple_strtoul(options, NULL, 0);
+		char *uartclk;
+		device->baud = simple_strtoul(options, &uartclk, 0);
+		if (*uartclk++ == ',')
+			port->uartclk = simple_strtoul(uartclk, NULL, 0);
 		length = min(strcspn(options, " ") + 1,
 			     (size_t)(sizeof(device->options)));
 		strlcpy(device->options, options, length);
 	}
 
+	port->uartclk = (port->uartclk) ?: BASE_BAUD * 16;
+
 	return 0;
 }
 
@@ -134,7 +139,6 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
 		buf = NULL;
 
 	spin_lock_init(&port->lock);
-	port->uartclk = BASE_BAUD * 16;
 	if (port->mapbase)
 		port->membase = earlycon_map(port->mapbase, 64);
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index b32df49a3bd5..b772f0d20b18 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -343,7 +343,7 @@ static inline int uart_poll_timeout(struct uart_port *port)
 struct earlycon_device {
 	struct console *con;
 	struct uart_port port;
-	char options[16];		/* e.g., 115200n8 */
+	char options[32];		/* e.g., 115200n8,48000000 */
 	unsigned int baud;
 };
 
-- 
2.16.2.395.g2e18187dfd-goog
