From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: [PATCH V2 1/6] serial: 8250_fintek: Refactoring read/write method
Date: Tue,  4 Oct 2016 16:27:59 +0800
Message-ID: <1475569684-10930-2-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1475569684-10930-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475569684-10930-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, ricardo.ribalda@gmail.com
Cc: arnd@arndb.de, peter@hurleysoftware.com, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

If we need to access SuperIO registers, It should write register offset
to base_addr and read/write value to base_addr + 1 to perform read/write.
We can make it more simply with write/read functions.

This patch add sio_read_reg()/sio_write_reg()/sio_write_mask_reg() to
reduce SuperIO register operation with lot of outb()/inb().

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 73 ++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 0facc78..2ae846e 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -49,6 +49,27 @@ struct fintek_8250 {
 	u8 key;
 };
 
+static u8 sio_read_reg(struct fintek_8250 *pdata, u8 reg)
+{
+	outb(reg, pdata->base_port + ADDR_PORT);
+	return inb(pdata->base_port + DATA_PORT);
+}
+
+static void sio_write_reg(struct fintek_8250 *pdata, u8 reg, u8 data)
+{
+	outb(reg, pdata->base_port + ADDR_PORT);
+	outb(data, pdata->base_port + DATA_PORT);
+}
+
+static void sio_write_mask_reg(struct fintek_8250 *pdata, u8 reg, u8 mask,
+			       u8 data)
+{
+	u8 tmp;
+
+	tmp = (sio_read_reg(pdata, reg) & ~mask) | (mask & data);
+	sio_write_reg(pdata, reg, tmp);
+}
+
 static int fintek_8250_enter_key(u16 base_port, u8 key)
 {
 	if (!request_muxed_region(base_port, 2, "8250_fintek"))
@@ -66,22 +87,18 @@ static void fintek_8250_exit_key(u16 base_port)
 	release_region(base_port + ADDR_PORT, 2);
 }
 
-static int fintek_8250_check_id(u16 base_port)
+static int fintek_8250_check_id(struct fintek_8250 *pdata)
 {
 	u16 chip;
 
-	outb(VENDOR_ID1, base_port + ADDR_PORT);
-	if (inb(base_port + DATA_PORT) != VENDOR_ID1_VAL)
+	if (sio_read_reg(pdata, VENDOR_ID1) != VENDOR_ID1_VAL)
 		return -ENODEV;
 
-	outb(VENDOR_ID2, base_port + ADDR_PORT);
-	if (inb(base_port + DATA_PORT) != VENDOR_ID2_VAL)
+	if (sio_read_reg(pdata, VENDOR_ID2) != VENDOR_ID2_VAL)
 		return -ENODEV;
 
-	outb(CHIP_ID1, base_port + ADDR_PORT);
-	chip = inb(base_port + DATA_PORT);
-	outb(CHIP_ID2, base_port + ADDR_PORT);
-	chip |= inb(base_port + DATA_PORT) << 8;
+	chip = sio_read_reg(pdata, CHIP_ID1);
+	chip |= sio_read_reg(pdata, CHIP_ID2) << 8;
 
 	if (chip != CHIP_ID_0 && chip != CHIP_ID_1)
 		return -ENODEV;
@@ -128,10 +145,8 @@ static int fintek_8250_rs485_config(struct uart_port *port,
 	if (fintek_8250_enter_key(pdata->base_port, pdata->key))
 		return -EBUSY;
 
-	outb(LDN, pdata->base_port + ADDR_PORT);
-	outb(pdata->index, pdata->base_port + DATA_PORT);
-	outb(RS485, pdata->base_port + ADDR_PORT);
-	outb(config, pdata->base_port + DATA_PORT);
+	sio_write_reg(pdata, LDN, pdata->index);
+	sio_write_reg(pdata, RS485, config);
 	fintek_8250_exit_key(pdata->base_port);
 
 	port->rs485 = *rs485;
@@ -147,10 +162,12 @@ static int find_base_port(struct fintek_8250 *pdata, u16 io_address)
 
 	for (i = 0; i < ARRAY_SIZE(addr); i++) {
 		for (j = 0; j < ARRAY_SIZE(keys); j++) {
+			pdata->base_port = addr[i];
+			pdata->key = keys[j];
 
 			if (fintek_8250_enter_key(addr[i], keys[j]))
 				continue;
-			if (fintek_8250_check_id(addr[i])) {
+			if (fintek_8250_check_id(pdata)) {
 				fintek_8250_exit_key(addr[i]);
 				continue;
 			}
@@ -158,19 +175,13 @@ static int find_base_port(struct fintek_8250 *pdata, u16 io_address)
 			for (k = 0; k < 4; k++) {
 				u16 aux;
 
-				outb(LDN, addr[i] + ADDR_PORT);
-				outb(k, addr[i] + DATA_PORT);
-
-				outb(IO_ADDR1, addr[i] + ADDR_PORT);
-				aux = inb(addr[i] + DATA_PORT);
-				outb(IO_ADDR2, addr[i] + ADDR_PORT);
-				aux |= inb(addr[i] + DATA_PORT) << 8;
+				sio_write_reg(pdata, LDN, k);
+				aux = sio_read_reg(pdata, IO_ADDR1);
+				aux |= sio_read_reg(pdata, IO_ADDR2) << 8;
 				if (aux != io_address)
 					continue;
 
 				fintek_8250_exit_key(addr[i]);
-				pdata->key = keys[j];
-				pdata->base_port = addr[i];
 				pdata->index = k;
 
 				return 0;
@@ -186,24 +197,16 @@ static int find_base_port(struct fintek_8250 *pdata, u16 io_address)
 static int fintek_8250_set_irq_mode(struct fintek_8250 *pdata, bool level_mode)
 {
 	int status;
-	u8 tmp;
 
 	status = fintek_8250_enter_key(pdata->base_port, pdata->key);
 	if (status)
 		return status;
 
-	outb(LDN, pdata->base_port + ADDR_PORT);
-	outb(pdata->index, pdata->base_port + DATA_PORT);
-
-	outb(FINTEK_IRQ_MODE, pdata->base_port + ADDR_PORT);
-	tmp = inb(pdata->base_port + DATA_PORT);
-
-	tmp &= ~IRQ_MODE_MASK;
-	tmp |= IRQ_SHARE;
-	if (!level_mode)
-		tmp |= IRQ_EDGE_HIGH;
+	sio_write_reg(pdata, LDN, pdata->index);
+	sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_SHARE, IRQ_SHARE);
+	sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_MODE_MASK,
+			   level_mode ? IRQ_LEVEL_LOW : IRQ_EDGE_HIGH);
 
-	outb(tmp, pdata->base_port + DATA_PORT);
 	fintek_8250_exit_key(pdata->base_port);
 	return 0;
 }
-- 
1.9.1
