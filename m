From: Joel Stanley <joel@jms.id.au>
Subject: [PATCH] serial: 8250: Add Nuvoton NPCM UART
Date: Mon, 12 Feb 2018 15:18:10 +1030
Message-ID: <20180212044810.23547-1-joel@jms.id.au>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Tomer Maimon <tomer.maimon@nuvoton.com>, Avi Fishman <Avi.Fishman@nuvoton.com>, Jeremy Kerr <jk@ozlabs.org>
List-Id: linux-serial@vger.kernel.org

The Nuvoton UART is almost compatible with the 8250 driver when probed
via the 8250_of driver, however it requires some extra configuration
at startup.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 Documentation/devicetree/bindings/serial/8250.txt |  1 +
 drivers/tty/serial/8250/8250_of.c                 |  1 +
 drivers/tty/serial/8250/8250_port.c               | 30 +++++++++++++++++++++++
 include/uapi/linux/serial_core.h                  |  3 +++
 include/uapi/linux/serial_reg.h                   |  5 ++++
 5 files changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
index dad3b2ec66d4..aeb6db4e35c3 100644
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -24,6 +24,7 @@ Required properties:
 	- "ti,da830-uart"
 	- "aspeed,ast2400-vuart"
 	- "aspeed,ast2500-vuart"
+	- "nuvoton,npcm750-uart"
 	- "serial" if the port type is unknown.
 - reg : offset and length of the register set for the device.
 - interrupts : should contain uart interrupt.
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 160b8906d9b9..9835b1c1cbe1 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -316,6 +316,7 @@ static const struct of_device_id of_platform_serial_table[] = {
 	{ .compatible = "mrvl,mmp-uart",
 		.data = (void *)PORT_XSCALE, },
 	{ .compatible = "ti,da830-uart", .data = (void *)PORT_DA830, },
+	{ .compatible = "nuvoton,npcm750-uart", .data = (void *)PORT_NPCM, },
 	{ /* end of list */ },
 };
 MODULE_DEVICE_TABLE(of, of_platform_serial_table);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1328c7e70108..c2e7fc111338 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -293,6 +293,16 @@ static const struct serial8250_config uart_config[] = {
 				  UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
 		.flags		= UART_CAP_FIFO,
 	},
+	[PORT_NPCM] = {
+		.name		= "Nuvoton 16550",
+		.fifo_size	= 16,
+		.tx_loadsz	= 16,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10 |
+				  UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
+		.rxtrig_bytes	= {1, 4, 8, 14},
+		.flags		= UART_CAP_FIFO,
+
+	},
 };
 
 /* Uart divisor latch read */
@@ -2140,6 +2150,15 @@ int serial8250_do_startup(struct uart_port *port)
 				UART_DA830_PWREMU_MGMT_FREE);
 	}
 
+	if (port->type == PORT_NPCM) {
+		/*
+		 * Nuvoton calls the scratch register 'UART_TOR' (timeout
+		 * register). Enable it, and set TIOC (timeout interrupt
+		 * comparator) to be 0x20 for correct operation.
+		 */
+		serial_port_out(port, UART_NPCM_TOR, UART_NPCM_TOIE | 0x20);
+	}
+
 #ifdef CONFIG_SERIAL_8250_RSA
 	/*
 	 * If this is an RSA port, see if we can kick it up to the
@@ -2462,6 +2481,15 @@ static unsigned int xr17v35x_get_divisor(struct uart_8250_port *up,
 	return quot_16 >> 4;
 }
 
+/* Nuvoton NPCM UARTs have a custom divisor calculation */
+static unsigned int npcm_get_divisor(struct uart_8250_port *up,
+		unsigned int baud)
+{
+	struct uart_port *port = &up->port;
+
+	return DIV_ROUND_CLOSEST(port->uartclk, 16 * baud + 2) - 2;
+}
+
 static unsigned int serial8250_get_divisor(struct uart_8250_port *up,
 					   unsigned int baud,
 					   unsigned int *frac)
@@ -2482,6 +2510,8 @@ static unsigned int serial8250_get_divisor(struct uart_8250_port *up,
 		quot = 0x8002;
 	else if (up->port.type == PORT_XR17V35X)
 		quot = xr17v35x_get_divisor(up, baud, frac);
+	else if (up->port.type == PORT_NPCM)
+		quot = npcm_get_divisor(up, baud);
 	else
 		quot = uart_get_divisor(port, baud);
 
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 1c8413f93e3d..3890ca4c5985 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -278,4 +278,7 @@
 /* MediaTek BTIF */
 #define PORT_MTK_BTIF	117
 
+/* Nuvoton UART */
+#define PORT_NPCM	118
+
 #endif /* _UAPILINUX_SERIAL_CORE_H */
diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index be07b5470f4b..f82f3c869df9 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -376,5 +376,10 @@
 #define UART_ALTR_EN_TXFIFO_LW	0x01	/* Enable the TX FIFO Low Watermark */
 #define UART_ALTR_TX_LOW	0x41	/* Tx FIFO Low Watermark */
 
+
+/* Nuvoton NPCM timeout register */
+#define UART_NPCM_TOR		7
+#define UART_NPCM_TOIE		BIT(7)	/* Timeout Interrupt Enable */
+
 #endif /* _LINUX_SERIAL_REG_H */
 
-- 
2.15.1
