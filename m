From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5/6] ARM: ks8695, serial: skip manual tx IRQ ack
Date: Mon, 15 Apr 2019 22:24:17 +0200
Message-ID: <20190415202501.941196-5-arnd@arndb.de>
References: <20190415202501.941196-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415202501.941196-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Ungerer <gerg@uclinux.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The TX interrupt is marked as edge triggered, so it will
already be acked by the top-level irq code, and does not
need the ack in the driver.

Removing this avoids a nasty dependency on the regs-irq.h
file that is otherwise reserved for the interrupt controller
driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/serial_ks8695.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/serial_ks8695.c b/drivers/tty/serial/serial_ks8695.c
index b461d791188c..6c5e9900e69d 100644
--- a/drivers/tty/serial/serial_ks8695.c
+++ b/drivers/tty/serial/serial_ks8695.c
@@ -21,7 +21,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/regs-uart.h>
-#include <mach/regs-irq.h>
 
 #if defined(CONFIG_SERIAL_KS8695_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
@@ -52,8 +51,6 @@
 #define UART_GET_BRDR(p)	__raw_readl((p)->membase + KS8695_URBD)
 #define UART_PUT_BRDR(p, c)	__raw_writel((c), (p)->membase + KS8695_URBD)
 
-#define KS8695_CLR_TX_INT()	__raw_writel(1 << KS8695_IRQ_UART_TX, KS8695_IRQ_VA + KS8695_INTST)
-
 #define UART_DUMMY_LSR_RX	0x100
 #define UART_PORT_SIZE		(KS8695_USR - KS8695_URRB + 4)
 
@@ -207,7 +204,6 @@ static irqreturn_t ks8695uart_tx_chars(int irq, void *dev_id)
 	unsigned int count;
 
 	if (port->x_char) {
-		KS8695_CLR_TX_INT();
 		UART_PUT_CHAR(port, port->x_char);
 		port->icount.tx++;
 		port->x_char = 0;
@@ -221,7 +217,6 @@ static irqreturn_t ks8695uart_tx_chars(int irq, void *dev_id)
 
 	count = 16;	/* fifo size */
 	while (!uart_circ_empty(xmit) && (count-- > 0)) {
-		KS8695_CLR_TX_INT();
 		UART_PUT_CHAR(port, xmit->buf[xmit->tail]);
 
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-- 
2.20.0
