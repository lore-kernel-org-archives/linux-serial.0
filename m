From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH 2/5] serial: omap: Remove __init marking from early write
Date: Tue, 18 Jul 2017 14:02:55 +0800
Message-ID: <1500357778-23169-3-git-send-email-jeffy.chen@rock-chips.com>
References: <1500357778-23169-1-git-send-email-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500357778-23169-1-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, briannorris@chromium.org, dianders@chromium.org, peter@hurleysoftware.com, Jeffy Chen <jeffy.chen@rock-chips.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

The earlycon would be alive outside the init code in these cases:
1/ we have keep_bootcon in cmdline.
2/ we don't have a real console to switch to.

So remove the __init marking to avoid invalid memory access.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/tty/serial/omap-serial.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 1ea05ac..7754053 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1235,21 +1235,20 @@ static int serial_omap_poll_get_char(struct uart_port *port)
 #ifdef CONFIG_SERIAL_OMAP_CONSOLE
 
 #ifdef CONFIG_SERIAL_EARLYCON
-static unsigned int __init omap_serial_early_in(struct uart_port *port,
-						int offset)
+static unsigned int omap_serial_early_in(struct uart_port *port, int offset)
 {
 	offset <<= port->regshift;
 	return readw(port->membase + offset);
 }
 
-static void __init omap_serial_early_out(struct uart_port *port, int offset,
-					 int value)
+static void omap_serial_early_out(struct uart_port *port, int offset,
+				  int value)
 {
 	offset <<= port->regshift;
 	writew(value, port->membase + offset);
 }
 
-static void __init omap_serial_early_putc(struct uart_port *port, int c)
+static void omap_serial_early_putc(struct uart_port *port, int c)
 {
 	unsigned int status;
 
@@ -1262,8 +1261,8 @@ static void __init omap_serial_early_putc(struct uart_port *port, int c)
 	omap_serial_early_out(port, UART_TX, c);
 }
 
-static void __init early_omap_serial_write(struct console *console,
-					   const char *s, unsigned int count)
+static void early_omap_serial_write(struct console *console, const char *s,
+				    unsigned int count)
 {
 	struct earlycon_device *device = console->data;
 	struct uart_port *port = &device->port;
-- 
2.1.4
