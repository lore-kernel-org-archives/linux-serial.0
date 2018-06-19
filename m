From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] serial: mps2-uart: Initialize early console
Date: Mon, 18 Jun 2018 21:54:57 -0700
Message-ID: <1529384097-1631-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Vladimir Murzin <vladimir.murzin@arm.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-serial@vger.kernel.org

The early console code for mps2-uart assumes that the serial hardware is
enabled for transmit when the system boots. However, this is not the case
after reset. This results in a hang in mps2_early_putchar() if the serial
transmitter is not enabled by a boot loader or ROM monitor.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/tty/serial/mps2-uart.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 9f8f63719126..0743a0551ce1 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -448,6 +448,14 @@ static struct console mps2_uart_console = {
 
 #define MPS2_SERIAL_CONSOLE (&mps2_uart_console)
 
+static void mps2_early_init(struct uart_port *port)
+{
+	u8 control = readb(port->membase + UARTn_CTRL);
+
+	control |= UARTn_CTRL_TX_ENABLE;
+	writeb(control, port->membase + UARTn_CTRL);
+}
+
 static void mps2_early_putchar(struct uart_port *port, int ch)
 {
 	while (readb(port->membase + UARTn_STATE) & UARTn_STATE_TX_FULL)
@@ -469,6 +477,7 @@ static int __init mps2_early_console_setup(struct earlycon_device *device,
 	if (!device->port.membase)
 		return -ENODEV;
 
+	mps2_early_init(&device->port);
 	device->con->write = mps2_early_write;
 
 	return 0;
-- 
2.7.4
