From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 1/2] tty/serial: Add explicit PORT_TEGRA type
Date: Tue, 17 May 2011 16:12:36 -0600
Message-ID: <1305670357-4291-1-git-send-email-swarren@nvidia.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-l3A5Bk7waGM@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Tegra's UART is currently auto-detected as PORT_XSCALE due to register
bit UART_IER.UUE being writable. However, the Tegra documentation states
that this register bit is reserved. Hence, we should not program it.

Instead, the documentation specifies that the UART is 16550 compatible.
However, Tegra does need register bit UART_IER.RTOIE set, which is not
enabled by any 16550 port type. This was not noticed before, since
PORT_XSCALE enables CAP_UUE, which conflates both UUE and RTOIE bit
programming.

This change defines PORT_TEGRA that doesn't set UART_CAP_UUE, but does
set UART_CAP_RTOIE, which is a new capability indicating that the RTOIE
bit needs to be enabled.

Based-on-code-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/tty/serial/8250.c   |   14 ++++++++++++--
 drivers/tty/serial/8250.h   |    1 +
 include/linux/serial_core.h |    3 ++-
 include/linux/serial_reg.h  |    1 +
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index 54482d7..a5e290d 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -271,7 +271,7 @@ static const struct serial8250_config uart_config[] = {
 		.fifo_size	= 32,
 		.tx_loadsz	= 32,
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
-		.flags		= UART_CAP_FIFO | UART_CAP_UUE,
+		.flags		= UART_CAP_FIFO | UART_CAP_UUE | UART_CAP_RTOIE,
 	},
 	[PORT_RM9000] = {
 		.name		= "RM9000",
@@ -301,6 +301,14 @@ static const struct serial8250_config uart_config[] = {
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
 	},
+	[PORT_TEGRA] = {
+		.name		= "Tegra",
+		.fifo_size	= 32,
+		.tx_loadsz	= 8,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01 |
+				  UART_FCR_T_TRIG_01,
+		.flags		= UART_CAP_FIFO | UART_CAP_RTOIE,
+	},
 };
 
 #if defined(CONFIG_MIPS_ALCHEMY)
@@ -2403,7 +2411,9 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 			UART_ENABLE_MS(&up->port, termios->c_cflag))
 		up->ier |= UART_IER_MSI;
 	if (up->capabilities & UART_CAP_UUE)
-		up->ier |= UART_IER_UUE | UART_IER_RTOIE;
+		up->ier |= UART_IER_UUE;
+	if (up->capabilities & UART_CAP_RTOIE)
+		up->ier |= UART_IER_RTOIE;
 
 	serial_out(up, UART_IER, up->ier);
 
diff --git a/drivers/tty/serial/8250.h b/drivers/tty/serial/8250.h
index d13b586..6edf4a6 100644
--- a/drivers/tty/serial/8250.h
+++ b/drivers/tty/serial/8250.h
@@ -42,6 +42,7 @@ struct serial8250_config {
 #define UART_CAP_SLEEP	(1 << 10)	/* UART has IER sleep */
 #define UART_CAP_AFE	(1 << 11)	/* MCR-based hw flow control */
 #define UART_CAP_UUE	(1 << 12)	/* UART needs IER bit 6 set (Xscale) */
+#define UART_CAP_RTOIE	(1 << 13)	/* UART needs IER bit 4 set (Xscale, Tegra) */
 
 #define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
 #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 95d479b..a5c3114 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -45,7 +45,8 @@
 #define PORT_OCTEON	17	/* Cavium OCTEON internal UART */
 #define PORT_AR7	18	/* Texas Instruments AR7 internal UART */
 #define PORT_U6_16550A	19	/* ST-Ericsson U6xxx internal UART */
-#define PORT_MAX_8250	19	/* max port ID */
+#define PORT_TEGRA	20	/* NVIDIA Tegra internal UART */
+#define PORT_MAX_8250	20	/* max port ID */
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed
diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index 3ecb71a..5f66e84 100644
--- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -57,6 +57,7 @@
  * ST16C654:	 8  16  56  60		 8  16  32  56	PORT_16654
  * TI16C750:	 1  16  32  56		xx  xx  xx  xx	PORT_16750
  * TI16C752:	 8  16  56  60		 8  16  32  56
+ * Tegra:	 1   4   8  14		16   8   4   1	PORT_TEGRA
  */
 #define UART_FCR_R_TRIG_00	0x00
 #define UART_FCR_R_TRIG_01	0x40
-- 
1.7.0.4
