From: Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] tty: serial: don't do termios for BTIF
Date: Thu, 13 Dec 2018 14:24:03 +0800
Message-ID: <972976519be8e28ee600651fe14d1f6d5f23e697.1544679557.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>, Roy Luo <cheng-hao.luo@mediatek.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Ryder Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-serial@vger.kernel.org

The MediaTek BTIF controller doesn't need to set termios so add
a new capability 'UART_CAP_NMOD' for the unsupported case.


Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/tty/serial/8250/8250.h      | 1 +
 drivers/tty/serial/8250/8250_port.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index ebfb0bd..2b9ba39 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -80,6 +80,7 @@ struct serial8250_config {
 #define UART_CAP_MINI	(1 << 17)	/* Mini UART on BCM283X family lacks:
 					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
 					 */
+#define UART_CAP_NMOD	(1 << 18)	/* UART doesn't do termios */
 
 #define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
 #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index c39482b..e4a69a0 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -297,7 +297,7 @@
 		.tx_loadsz	= 16,
 		.fcr		= UART_FCR_ENABLE_FIFO |
 				  UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
-		.flags		= UART_CAP_FIFO,
+		.flags		= UART_CAP_FIFO | UART_CAP_NMOD,
 	},
 	[PORT_NPCM] = {
 		.name		= "Nuvoton 16550",
@@ -2663,6 +2663,11 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
 	unsigned long flags;
 	unsigned int baud, quot, frac = 0;
 
+	if (up->capabilities & UART_CAP_NMOD) {
+		termios->c_cflag = 0;
+		return;
+	}
+
 	if (up->capabilities & UART_CAP_MINI) {
 		termios->c_cflag &= ~(CSTOPB | PARENB | PARODD | CMSPAR);
 		if ((termios->c_cflag & CSIZE) == CS5 ||
-- 
1.9.1
