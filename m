From: David Lechner <david@lechnology.com>
Subject: [PATCH 2/3] serial: 8250: Add new port type for TI DA8xx/OMAPL13x/AM17xx/AM18xx
Date: Tue, 20 Dec 2016 14:23:03 -0600
Message-ID: <1482265384-715-3-git-send-email-david@lechnology.com>
References: <1482265384-715-1-git-send-email-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482265384-715-1-git-send-email-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Axel Haslam <ahaslam@baylibre.com>, Alexandre Bailon <abailon@baylibre.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This adds a new UART port type for TI DA8xx/OMAPL13x/AM17xx/AM18xx. These
SoCs have standard 8250 registers plus some extra non-standard registers.

The UART will not function unless the non-standard Power and Emulation
Management Register (PWREMU_MGMT) is configured correctly. This is
currently handled in arch/arm/mach-davinci/serial.c for non-device-tree
boards. Making this part of the UART driver will allow UART to work on
device-tree boards as well and the mach code can eventually be removed.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/tty/serial/8250/8250_of.c   |  1 +
 drivers/tty/serial/8250/8250_port.c | 22 ++++++++++++++++++++++
 include/uapi/linux/serial_core.h    |  3 ++-
 include/uapi/linux/serial_reg.h     |  8 ++++++++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index d25ab1c..5281252 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -332,6 +332,7 @@ static const struct of_device_id of_platform_serial_table[] = {
 		.data = (void *)PORT_ALTR_16550_F128, },
 	{ .compatible = "mrvl,mmp-uart",
 		.data = (void *)PORT_XSCALE, },
+	{ .compatible = "ti,da830-uart", .data = (void *)PORT_DA830, },
 	{ /* end of list */ },
 };
 MODULE_DEVICE_TABLE(of, of_platform_serial_table);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index fe4399b..ea854054 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -273,6 +273,15 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 4, 8, 14},
 		.flags		= UART_CAP_FIFO,
 	},
+	[PORT_DA830] = {
+		.name		= "TI DA8xx/OMAPL13x/AM17xx/AM18xx",
+		.fifo_size	= 16,
+		.tx_loadsz	= 16,
+		.fcr		= UART_FCR_DMA_SELECT | UART_FCR_ENABLE_FIFO |
+				  UART_FCR_R_TRIG_10,
+		.rxtrig_bytes	= {1, 4, 8, 14},
+		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
+	},
 };
 
 /* Uart divisor latch read */
@@ -2118,6 +2127,19 @@ int serial8250_do_startup(struct uart_port *port)
 		serial_port_out(port, UART_LCR, 0);
 	}
 
+	if (port->type == PORT_DA830) {
+		/* Reset the port */
+		serial_port_out(port, UART_IER, 0);
+		serial_port_out(port, UART_DA830_PWREMU_MGMT, 0);
+		mdelay(10);
+
+		/* Enable Tx, Rx and free run mode */
+		serial_port_out(port, UART_DA830_PWREMU_MGMT,
+				UART_DA830_PWREMU_MGMT_UTRST |
+				UART_DA830_PWREMU_MGMT_URRST |
+				UART_DA830_PWREMU_MGMT_FREE);
+	}
+
 #ifdef CONFIG_SERIAL_8250_RSA
 	/*
 	 * If this is an RSA port, see if we can kick it up to the
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 99dbed8..a126d05 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -56,7 +56,8 @@
 #define PORT_ALTR_16550_F128 28 /* Altera 16550 UART with 128 FIFOs */
 #define PORT_RT2880	29	/* Ralink RT2880 internal UART */
 #define PORT_16550A_FSL64 30	/* Freescale 16550 UART with 64 FIFOs */
-#define PORT_MAX_8250	30	/* max port ID */
+#define PORT_DA830	31	/* TI DA8xx/OMAP13x/AM17xx/AM18xx */
+#define PORT_MAX_8250	31	/* max port ID */
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed
diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index b4c0484..0e72eeb 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -327,6 +327,14 @@
 #define SERIAL_RSA_BAUD_BASE (921600)
 #define SERIAL_RSA_BAUD_BASE_LO (SERIAL_RSA_BAUD_BASE / 8)
 
+/* Extra registers for TI DA8xx/OMAP13x/AM17xx/AM18xx */
+#define UART_DA830_PWREMU_MGMT	12
+
+/* PWREMU_MGMT register bits */
+#define UART_DA830_PWREMU_MGMT_FREE	(1 << 0)  /* Free-running mode */
+#define UART_DA830_PWREMU_MGMT_URRST	(1 << 13) /* Receiver reset/enable */
+#define UART_DA830_PWREMU_MGMT_UTRST	(1 << 14) /* Transmitter reset/enable */
+
 /*
  * Extra serial register definitions for the internal UARTs
  * in TI OMAP processors.
-- 
2.7.4
