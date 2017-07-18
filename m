From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [RFC PATCH 5/5] serial: 8250_early: Remove __init marking from early write
Date: Tue, 18 Jul 2017 12:30:03 +0800
Message-ID: <1500352203-21513-6-git-send-email-jeffy.chen@rock-chips.com>
References: <1500352203-21513-1-git-send-email-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500352203-21513-1-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, briannorris@chromium.org, dianders@chromium.org, peter@hurleysoftware.com, Jeffy Chen <jeffy.chen@rock-chips.com>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The earlycon would be alive outside the init code in these cases:
1/ we have keep_bootcon in cmdline.
2/ we don't have a real console to switch to.

So remove the __init marking to avoid invalid memory access.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/tty/serial/8250/8250_early.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 82fc48e..af72ec3 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -37,7 +37,7 @@
 #include <asm/io.h>
 #include <asm/serial.h>
 
-static unsigned int __init serial8250_early_in(struct uart_port *port, int offset)
+static unsigned int serial8250_early_in(struct uart_port *port, int offset)
 {
 	int reg_offset = offset;
 	offset <<= port->regshift;
@@ -60,7 +60,7 @@ static unsigned int __init serial8250_early_in(struct uart_port *port, int offse
 	}
 }
 
-static void __init serial8250_early_out(struct uart_port *port, int offset, int value)
+static void serial8250_early_out(struct uart_port *port, int offset, int value)
 {
 	int reg_offset = offset;
 	offset <<= port->regshift;
@@ -89,7 +89,7 @@ static void __init serial8250_early_out(struct uart_port *port, int offset, int
 
 #define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
 
-static void __init serial_putc(struct uart_port *port, int c)
+static void serial_putc(struct uart_port *port, int c)
 {
 	unsigned int status;
 
@@ -103,7 +103,7 @@ static void __init serial_putc(struct uart_port *port, int c)
 	}
 }
 
-static void __init early_serial8250_write(struct console *console,
+static void early_serial8250_write(struct console *console,
 					const char *s, unsigned int count)
 {
 	struct earlycon_device *device = console->data;
-- 
2.1.4
