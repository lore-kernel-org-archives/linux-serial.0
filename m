From: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Subject: [PATCH v2 2/4] serial: 8250: Add new port type for TI DA8xx/OMAPL13x/AM17xx/AM18xx/C66x
Date: Wed,  4 Jan 2017 14:30:12 -0600
Message-ID: <1483561814-21953-3-git-send-email-david@lechnology.com>
References: <1483561814-21953-1-git-send-email-david@lechnology.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1483561814-21953-1-git-send-email-david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Axel Haslam <ahaslam-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This adds a new UART port type for TI DA8xx/OMAPL13x/AM17xx/AM18xx/C66x.
These SoCs have standard 8250 registers plus some extra non-standard
registers.

The UART will not function unless the non-standard Power and Emulation
Management Register (PWREMU_MGMT) is configured correctly. This is
currently handled in arch/arm/mach-davinci/serial.c for non-device-tree
boards. Making this part of the UART driver will allow UART to work on
device-tree boards as well and the mach code can eventually be removed.

Signed-off-by: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
---

v2 changes:
* Added C66x to list of SoCs


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
index fe4399b..61dd806 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -273,6 +273,15 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 4, 8, 14},
 		.flags		= UART_CAP_FIFO,
 	},
+	[PORT_DA830] = {
+		.name		= "TI DA8xx/OMAPL13x/AM17xx/AM18xx/C66x",
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
index 99dbed8..1265918 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -56,7 +56,8 @@
 #define PORT_ALTR_16550_F128 28 /* Altera 16550 UART with 128 FIFOs */
 #define PORT_RT2880	29	/* Ralink RT2880 internal UART */
 #define PORT_16550A_FSL64 30	/* Freescale 16550 UART with 64 FIFOs */
-#define PORT_MAX_8250	30	/* max port ID */
+#define PORT_DA830	31	/* TI DA8xx/OMAP13x/AM17xx/AM18xx/C66x */
+#define PORT_MAX_8250	31	/* max port ID */
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed
diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index b4c0484..84606d8 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -327,6 +327,14 @@
 #define SERIAL_RSA_BAUD_BASE (921600)
 #define SERIAL_RSA_BAUD_BASE_LO (SERIAL_RSA_BAUD_BASE / 8)
 
+/* Extra registers for TI DA8xx/OMAP13x/AM17xx/AM18xx/C66x */
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
