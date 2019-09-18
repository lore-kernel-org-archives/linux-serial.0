From: Lanqing Liu <liuhhome@gmail.com>
Subject: [PATCH] serial: sprd: Add polling IO support
Date: Wed, 18 Sep 2019 16:15:05 +0800
Message-ID: <a634860d9194cc235298d6d8bbd2282bf6f853c4.1568793195.git.liuhhome@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: baolin.wang@linaro.org, lanqing.liu@unisoc.com, liuhhome@gmail.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, orsonzhai@gmail.com, zhang.lyra@gmail.com
List-Id: linux-serial@vger.kernel.org

In order to access the UART without the interrupts, the kernel uses
the basic polling methods for IO with the device. With these methods
implemented, it is now possible to enable kgdb during early boot over serial.

Signed-off-by: Lanqing Liu <liuhhome@gmail.com>
---
 drivers/tty/serial/sprd_serial.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 73d71a4..579ab41 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -911,6 +911,24 @@ static void sprd_pm(struct uart_port *port, unsigned int state,
 	}
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+static int sprd_poll_get_char(struct uart_port *port)
+{
+	while (!(serial_in(port, SPRD_STS1) & SPRD_RX_FIFO_CNT_MASK))
+		cpu_relax();
+
+	return serial_in(port, SPRD_RXD);
+}
+
+static void sprd_poll_put_char(struct uart_port *port, unsigned char ch)
+{
+	while (serial_in(port, SPRD_STS1) & SPRD_TX_FIFO_CNT_MASK)
+		cpu_relax();
+
+	serial_out(port, SPRD_TXD, ch);
+}
+#endif
+
 static const struct uart_ops serial_sprd_ops = {
 	.tx_empty = sprd_tx_empty,
 	.get_mctrl = sprd_get_mctrl,
@@ -928,6 +946,10 @@ static void sprd_pm(struct uart_port *port, unsigned int state,
 	.config_port = sprd_config_port,
 	.verify_port = sprd_verify_port,
 	.pm = sprd_pm,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char	= sprd_poll_get_char,
+	.poll_put_char	= sprd_poll_put_char,
+#endif
 };
 
 #ifdef CONFIG_SERIAL_SPRD_CONSOLE
-- 
1.9.1
