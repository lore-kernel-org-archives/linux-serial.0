From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 1/2] tty/serial: atmel: remove atmel_default_console_device handling
Date: Tue, 13 Jun 2017 15:40:37 +0200
Message-ID: <20170613134038.5545-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

atmel_default_console_device was only used by AVR32, in particular
arch/avr32/mach-at32ap/at32ap700x.c which is now gone. Remove it from the
driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/tty/serial/atmel_serial.c | 43 ---------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index c355ac9abafc..906e2b91bf57 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2460,8 +2460,6 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 	return 0;
 }
 
-struct platform_device *atmel_default_console_device;	/* the serial console device */
-
 #ifdef CONFIG_SERIAL_ATMEL_CONSOLE
 static void atmel_console_putchar(struct uart_port *port, int ch)
 {
@@ -2594,47 +2592,6 @@ static struct console atmel_console = {
 
 #define ATMEL_CONSOLE_DEVICE	(&atmel_console)
 
-/*
- * Early console initialization (before VM subsystem initialized).
- */
-static int __init atmel_console_init(void)
-{
-	int ret;
-	if (atmel_default_console_device) {
-		struct atmel_uart_data *pdata =
-			dev_get_platdata(&atmel_default_console_device->dev);
-		int id = pdata->num;
-		struct atmel_uart_port *atmel_port = &atmel_ports[id];
-
-		atmel_port->backup_imr = 0;
-		atmel_port->uart.line = id;
-
-		add_preferred_console(ATMEL_DEVICENAME, id, NULL);
-		ret = atmel_init_port(atmel_port, atmel_default_console_device);
-		if (ret)
-			return ret;
-		register_console(&atmel_console);
-	}
-
-	return 0;
-}
-
-console_initcall(atmel_console_init);
-
-/*
- * Late console initialization.
- */
-static int __init atmel_late_console_init(void)
-{
-	if (atmel_default_console_device
-	    && !(atmel_console.flags & CON_ENABLED))
-		register_console(&atmel_console);
-
-	return 0;
-}
-
-core_initcall(atmel_late_console_init);
-
 static inline bool atmel_is_console_port(struct uart_port *port)
 {
 	return port->cons && port->cons->index == port->line;
-- 
2.11.0
