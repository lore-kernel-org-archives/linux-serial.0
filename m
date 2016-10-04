From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: [PATCH V2 3/6] serial: 8250_fintek: Set maximum FIFO of F81216H
Date: Tue,  4 Oct 2016 16:28:01 +0800
Message-ID: <1475569684-10930-4-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1475569684-10930-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475569684-10930-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, ricardo.ribalda@gmail.com
Cc: arnd@arndb.de, peter@hurleysoftware.com, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

The Fintek F81216H had maximum 128Bytes FIFO, but some BIOS configurated
as normal 16Bytes FIFO. This patch will set 128Bytes FIFO and trigger
level multiplier as 4x when F81216H detected.

Default 16550A trigger level is 8Bytes. When this patch applied, the
trigger level will change to 8Byte x 4 = 32Byte. It can be reduce the RX
incoming interrupts.

Suggested-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index deccd0e..e039a33 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -21,8 +21,8 @@
 #define EXIT_KEY 0xAA
 #define CHIP_ID1  0x20
 #define CHIP_ID2  0x21
-#define CHIP_ID_0 0x1602
-#define CHIP_ID_1 0x0501
+#define CHIP_ID_F81216AD 0x1602
+#define CHIP_ID_F81216H 0x0501
 #define VENDOR_ID1 0x23
 #define VENDOR_ID1_VAL 0x19
 #define VENDOR_ID2 0x24
@@ -43,7 +43,14 @@
 #define RXW4C_IRA BIT(3)
 #define TXW4C_IRA BIT(2)
 
+#define FIFO_CTRL		0xF6
+#define FIFO_MODE_MASK		(BIT(1) | BIT(0))
+#define FIFO_MODE_128		(BIT(1) | BIT(0))
+#define RXFTHR_MODE_MASK	(BIT(5) | BIT(4))
+#define RXFTHR_MODE_4X		BIT(5)
+
 struct fintek_8250 {
+	u16 pid;
 	u16 base_port;
 	u8 index;
 	u8 key;
@@ -100,9 +107,10 @@ static int fintek_8250_check_id(struct fintek_8250 *pdata)
 	chip = sio_read_reg(pdata, CHIP_ID1);
 	chip |= sio_read_reg(pdata, CHIP_ID2) << 8;
 
-	if (chip != CHIP_ID_0 && chip != CHIP_ID_1)
+	if (chip != CHIP_ID_F81216AD && chip != CHIP_ID_F81216H)
 		return -ENODEV;
 
+	pdata->pid = chip;
 	return 0;
 }
 
@@ -162,6 +170,20 @@ static void fintek_8250_set_irq_mode(struct fintek_8250 *pdata, bool is_level)
 			   is_level ? IRQ_LEVEL_LOW : IRQ_EDGE_HIGH);
 }
 
+static void fintek_8250_set_max_fifo(struct fintek_8250 *pdata)
+{
+	switch (pdata->pid) {
+	case CHIP_ID_F81216H: /* 128Bytes FIFO */
+		sio_write_mask_reg(pdata, FIFO_CTRL,
+				   FIFO_MODE_MASK | RXFTHR_MODE_MASK,
+				   FIFO_MODE_128 | RXFTHR_MODE_4X);
+		break;
+
+	default: /* Default 16Bytes FIFO */
+		break;
+	}
+}
+
 static int probe_setup_port(struct fintek_8250 *pdata, u16 io_address,
 			  unsigned int irq)
 {
@@ -200,6 +222,7 @@ static int probe_setup_port(struct fintek_8250 *pdata, u16 io_address,
 						irqd_is_level_type(irq_data);
 
 				fintek_8250_set_irq_mode(pdata, level_mode);
+				fintek_8250_set_max_fifo(pdata);
 				fintek_8250_exit_key(addr[i]);
 
 				return 0;
-- 
1.9.1
