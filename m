From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [RFC PATCH 4/5] serial: 8250_ingenic: Remove __init marking from early write
Date: Tue, 18 Jul 2017 12:30:02 +0800
Message-ID: <1500352203-21513-5-git-send-email-jeffy.chen@rock-chips.com>
References: <1500352203-21513-1-git-send-email-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500352203-21513-1-git-send-email-jeffy.chen@rock-chips.com>
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

 drivers/tty/serial/8250/8250_ingenic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 4d9dc10..464389b 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -50,17 +50,17 @@ static const struct of_device_id of_match[];
 
 static struct earlycon_device *early_device;
 
-static uint8_t __init early_in(struct uart_port *port, int offset)
+static uint8_t early_in(struct uart_port *port, int offset)
 {
 	return readl(port->membase + (offset << 2));
 }
 
-static void __init early_out(struct uart_port *port, int offset, uint8_t value)
+static void early_out(struct uart_port *port, int offset, uint8_t value)
 {
 	writel(value, port->membase + (offset << 2));
 }
 
-static void __init ingenic_early_console_putc(struct uart_port *port, int c)
+static void ingenic_early_console_putc(struct uart_port *port, int c)
 {
 	uint8_t lsr;
 
@@ -71,7 +71,7 @@ static void __init ingenic_early_console_putc(struct uart_port *port, int c)
 	early_out(port, UART_TX, c);
 }
 
-static void __init ingenic_early_console_write(struct console *console,
+static void ingenic_early_console_write(struct console *console,
 					      const char *s, unsigned int count)
 {
 	uart_console_write(&early_device->port, s, count,
-- 
2.1.4
