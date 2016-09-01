From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: [PATCH 6/7] serial: 8250_fintek: Add F81866 Support
Date: Thu,  1 Sep 2016 11:39:55 +0800
Message-ID: <1472701196-14795-7-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1472701196-14795-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472701196-14795-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, ricardo.ribalda@gmail.com
Cc: arnd@arndb.de, peter@hurleysoftware.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Fintek F81866 is a LPC to 6 UARTs SuperIO. It has fully functional UARTs
likes F81216H. It's also need check the IRQ mode with system assigned,
but the configuration is not the same with F81216 series.

F81866 IRQ Mode setting:
	0xf0
		Bit1: IRQ_MODE0
		Bit0: Share mode (always on)
	0xf6
		Bit3: IRQ_MODE1

	Level/Low: IRQ_MODE0:0, IRQ_MODE1:0
	Edge/High: IRQ_MODE0:1, IRQ_MODE1:0

The following list is brief descriptions of F81866:

F81866 (1010)
	9Bit/High baud rate(not implements with mainline)
	RS485, 128Bytes FIFO (implemented)

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 75 ++++++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index a62cfdd..1194e57 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -21,6 +21,7 @@
 #define EXIT_KEY 0xAA
 #define CHIP_ID1  0x20
 #define CHIP_ID2  0x21
+#define CHIP_ID_F81866 0x1010
 #define CHIP_ID_F81216AD 0x1602
 #define CHIP_ID_F81216H 0x0501
 #define CHIP_ID_F81216 0x0802
@@ -50,6 +51,26 @@
 #define RXFTHR_MODE_MASK	(BIT(5) | BIT(4))
 #define RXFTHR_MODE_4X		BIT(5)
 
+#define F81216_LDN_LOW	0x0
+#define F81216_LDN_HIGH	0x4
+
+/*
+ * F81866 registers
+ *
+ * The IRQ setting mode of F81866 is not the same with F81216 series.
+ *	Level/Low: IRQ_MODE0:0, IRQ_MODE1:0
+ *	Edge/High: IRQ_MODE0:1, IRQ_MODE1:0
+ */
+#define F81866_IRQ_MODE		0xf0
+#define F81866_IRQ_SHARE	BIT(0)
+#define F81866_IRQ_MODE0	BIT(1)
+
+#define F81866_FIFO_CTRL	FIFO_CTRL
+#define F81866_IRQ_MODE1	BIT(3)
+
+#define F81866_LDN_LOW		0x10
+#define F81866_LDN_HIGH		0x16
+
 struct fintek_8250 {
 	u16 pid;
 	u16 base_port;
@@ -109,6 +130,7 @@ static int fintek_8250_check_id(struct fintek_8250 *pdata)
 	chip |= sio_read_reg(pdata, CHIP_ID2) << 8;
 
 	switch (chip) {
+	case CHIP_ID_F81866:
 	case CHIP_ID_F81216AD:
 	case CHIP_ID_F81216H:
 	case CHIP_ID_F81216:
@@ -121,6 +143,26 @@ static int fintek_8250_check_id(struct fintek_8250 *pdata)
 	return 0;
 }
 
+static int fintek_8250_get_ldn_range(struct fintek_8250 *pdata, int *min,
+				     int *max)
+{
+	switch (pdata->pid) {
+	case CHIP_ID_F81866:
+		*min = F81866_LDN_LOW;
+		*max = F81866_LDN_HIGH;
+		return 0;
+
+	case CHIP_ID_F81216AD:
+	case CHIP_ID_F81216H:
+	case CHIP_ID_F81216:
+		*min = F81216_LDN_LOW;
+		*max = F81216_LDN_HIGH;
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
 static int fintek_8250_rs485_config(struct uart_port *port,
 			      struct serial_rs485 *rs485)
 {
@@ -175,6 +217,7 @@ static void fintek_8250_set_max_fifo(struct fintek_8250 *pdata)
 	default: /* Default 16Bytes FIFO */
 		return;
 
+	case CHIP_ID_F81866:
 	case CHIP_ID_F81216H: /* 128Bytes FIFO */
 		sio_write_mask_reg(pdata, FIFO_CTRL,
 				   FIFO_MODE_MASK | RXFTHR_MODE_MASK,
@@ -186,9 +229,27 @@ static void fintek_8250_set_max_fifo(struct fintek_8250 *pdata)
 static void fintek_8250_set_irq_mode(struct fintek_8250 *pdata, bool is_level)
 {
 	sio_write_reg(pdata, LDN, pdata->index);
-	sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_SHARE, IRQ_SHARE);
-	sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_MODE_MASK,
-			   is_level ? IRQ_LEVEL_LOW : IRQ_EDGE_HIGH);
+
+	switch (pdata->pid) {
+	case CHIP_ID_F81866:
+		sio_write_mask_reg(pdata, F81866_FIFO_CTRL, F81866_IRQ_MODE1,
+				   0);
+		sio_write_mask_reg(pdata, F81866_IRQ_MODE, F81866_IRQ_SHARE,
+				   F81866_IRQ_SHARE);
+		sio_write_mask_reg(pdata, F81866_IRQ_MODE,
+				   F81866_IRQ_MODE0,
+				   is_level ? 0 : F81866_IRQ_MODE0);
+		break;
+
+	case CHIP_ID_F81216AD:
+	case CHIP_ID_F81216H:
+	case CHIP_ID_F81216:
+		sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_SHARE,
+				   IRQ_SHARE);
+		sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_MODE_MASK,
+				   is_level ? IRQ_LEVEL_LOW : IRQ_EDGE_HIGH);
+		break;
+	}
 }
 
 static int find_base_port(struct fintek_8250 *pdata, u16 io_address,
@@ -198,7 +259,7 @@ static int find_base_port(struct fintek_8250 *pdata, u16 io_address,
 	static const u8 keys[] = {0x77, 0xa0, 0x87, 0x67};
 	struct irq_data *irq_data;
 	bool level_mode = false;
-	int i, j, k;
+	int i, j, k, min, max;
 
 	for (i = 0; i < ARRAY_SIZE(addr); i++) {
 		for (j = 0; j < ARRAY_SIZE(keys); j++) {
@@ -207,12 +268,13 @@ static int find_base_port(struct fintek_8250 *pdata, u16 io_address,
 
 			if (fintek_8250_enter_key(addr[i], keys[j]))
 				continue;
-			if (fintek_8250_check_id(pdata)) {
+			if (fintek_8250_check_id(pdata) ||
+			    fintek_8250_get_ldn_range(pdata, &min, &max)) {
 				fintek_8250_exit_key(addr[i]);
 				continue;
 			}
 
-			for (k = 0; k < 4; k++) {
+			for (k = min; k < max; k++) {
 				u16 aux;
 
 				sio_write_reg(pdata, LDN, k);
@@ -250,6 +312,7 @@ static void fintek_8250_set_rs485_handler(struct uart_8250_port *uart)
 	default: /* No RS485 Auto direction functional */
 		break;
 
+	case CHIP_ID_F81866:
 	case CHIP_ID_F81216AD:
 	case CHIP_ID_F81216H:
 		uart->port.rs485_config = fintek_8250_rs485_config;
-- 
1.9.1
