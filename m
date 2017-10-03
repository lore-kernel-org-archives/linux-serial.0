From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: [PATCH V1 2/3] serial: 8250_fintek: UART dynamic clocksource on Fintek F81216H
Date: Tue,  3 Oct 2017 11:08:34 +0800
Message-ID: <1507000116-13682-3-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1507000116-13682-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507000116-13682-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: rel+kernel@agilox.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

The F81216H had 4 clocksource 1.8432/18.432/14.769/24MHzand  baud rates can
be up to 1.5Mbits with 24MHz. The register value and mask is the same with
F81866. But F81866 register address is F2h, F81216H is F0h.

We'll implements the dynamic clocksource in fintek_8250_set_termios().

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 53ea353..f3b622f 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -40,6 +40,16 @@
 #define IRQ_LEVEL_LOW	0
 #define IRQ_EDGE_HIGH	BIT(5)
 
+/*
+ * F81216H clock source register, the value and mask is the same with F81866,
+ * but it's on F0h.
+ *
+ * Clock speeds for UART (register F0h)
+ * 00: 1.8432MHz.
+ * 01: 18.432MHz.
+ * 10: 24MHz.
+ * 11: 14.769MHz.
+ */
 #define RS485  0xF0
 #define RTS_INVERT BIT(5)
 #define RS485_URA BIT(4)
@@ -293,11 +303,28 @@ void fintek_8250_set_termios(struct uart_port *port, struct ktermios *termios,
 	struct fintek_8250 *pdata = port->private_data;
 	unsigned int baud = tty_termios_baud_rate(termios);
 	int i;
+	u8 reg;
 	static u32 baudrate_table[] = {115200, 921600, 1152000, 1500000};
 	static u8 clock_table[] = { F81866_UART_CLK_1_8432MHZ,
 			F81866_UART_CLK_14_769MHZ, F81866_UART_CLK_18_432MHZ,
 			F81866_UART_CLK_24MHZ };
 
+	switch (pdata->pid) {
+	case CHIP_ID_F81216H:
+		reg = RS485;
+		break;
+	case CHIP_ID_F81866:
+		reg = F81866_UART_CLK;
+		break;
+	default:
+		/* Don't change clocksource with unknown PID */
+		dev_warn(port->dev,
+			"%s: pid: %x Not support. use default set_termios.\n",
+			__func__, pdata->pid);
+		serial8250_do_set_termios(port, termios, old);
+		return;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(baudrate_table); ++i) {
 		if (baud > baudrate_table[i] || baudrate_table[i] % baud != 0)
 			continue;
@@ -311,8 +338,8 @@ void fintek_8250_set_termios(struct uart_port *port, struct ktermios *termios,
 		port->uartclk = baudrate_table[i] * 16;
 
 		sio_write_reg(pdata, LDN, pdata->index);
-		sio_write_mask_reg(pdata, F81866_UART_CLK,
-				F81866_UART_CLK_MASK, clock_table[i]);
+		sio_write_mask_reg(pdata, reg, F81866_UART_CLK_MASK,
+				clock_table[i]);
 
 		fintek_8250_exit_key(pdata->base_port);
 		break;
@@ -331,6 +358,7 @@ static void fintek_8250_set_termios_handler(struct uart_8250_port *uart)
 	struct fintek_8250 *pdata = uart->port.private_data;
 
 	switch (pdata->pid) {
+	case CHIP_ID_F81216H:
 	case CHIP_ID_F81866:
 		uart->port.set_termios = fintek_8250_set_termios;
 		break;
-- 
1.9.1
