From: Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v2] serial: meson: add Magic SysRq support
Date: Wed,  6 Sep 2017 21:52:39 +0800
Message-ID: <20170906135239.29531-1-dlan@gentoo.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>, linux-serial@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>
List-Id: linux-serial@vger.kernel.org

This dirver try to implement the Magic SysRq support[1] for
Amlogic Inc's meson platfo
>From the hardware perspective, the UART IP can't detect the 'BREAK' command
clearly via the status register. Instead, we rely on the combination of
'FRAME_ERR bit && ch == 0', and it works fine.

[1] Documentation/admin-guide/sysrq.rst

Signed-off-by: Yixun Lan <dlan@gentoo.org>

---
Changes since v1 at [0]:
- add changelog & a few more comments

[0] https://patchwork.kernel.org/patch/9728475/
---
 drivers/tty/serial/meson_uart.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 42e4a4c7597f..3fea24bafd80 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -14,6 +14,10 @@
  *
  */
 
+#if defined(CONFIG_SERIAL_MESON_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/delay.h>
@@ -183,12 +187,12 @@ static void meson_receive_chars(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
 	char flag;
-	u32 status, ch, mode;
+	u32 ostatus, status, ch, mode;
 
 	do {
 		flag = TTY_NORMAL;
 		port->icount.rx++;
-		status = readl(port->membase + AML_UART_STATUS);
+		ostatus = status = readl(port->membase + AML_UART_STATUS);
 
 		if (status & AML_UART_ERR) {
 			if (status & AML_UART_TX_FIFO_WERR)
@@ -216,6 +220,16 @@ static void meson_receive_chars(struct uart_port *port)
 		ch = readl(port->membase + AML_UART_RFIFO);
 		ch &= 0xff;
 
+		if ((ostatus & AML_UART_FRAME_ERR) && (ch == 0)) {
+			port->icount.brk++;
+			flag = TTY_BREAK;
+			if (uart_handle_break(port))
+				continue;
+		}
+
+		if (uart_handle_sysrq_char(port, ch))
+			continue;
+
 		if ((status & port->ignore_status_mask) == 0)
 			tty_insert_flip_char(tport, ch, flag);
 
-- 
2.14.1
