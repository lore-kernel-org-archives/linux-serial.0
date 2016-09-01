From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: [PATCH 2/7] serial: 8250_fintek: Set IRQ Mode when port probed
Date: Thu,  1 Sep 2016 11:39:51 +0800
Message-ID: <1472701196-14795-3-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1472701196-14795-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472701196-14795-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, ricardo.ribalda@gmail.com
Cc: arnd@arndb.de, peter@hurleysoftware.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Set IRQ Mode when port probed in find_base_port()

It should hold the IO port premission via fintek_8250_enter_key() and
release via fintek_8250_exit_key() when we configure the SuperIO.

This patch will move all SuperIO configure operations to find_base_port()
to reduce fintek_8250_enter_key()/fintek_8250_exit_key() usage.

Suggested-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 36 ++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 2ae846e..cd8903f 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -49,6 +49,9 @@ struct fintek_8250 {
 	u8 key;
 };
 
+static void fintek_8250_set_irq_mode(struct fintek_8250 *pdata,
+				     bool level_mode);
+
 static u8 sio_read_reg(struct fintek_8250 *pdata, u8 reg)
 {
 	outb(reg, pdata->base_port + ADDR_PORT);
@@ -154,10 +157,13 @@ static int fintek_8250_rs485_config(struct uart_port *port,
 	return 0;
 }
 
-static int find_base_port(struct fintek_8250 *pdata, u16 io_address)
+static int find_base_port(struct fintek_8250 *pdata, u16 io_address,
+			  unsigned int irq)
 {
 	static const u16 addr[] = {0x4e, 0x2e};
 	static const u8 keys[] = {0x77, 0xa0, 0x87, 0x67};
+	struct irq_data *irq_data;
+	bool level_mode = false;
 	int i, j, k;
 
 	for (i = 0; i < ARRAY_SIZE(addr); i++) {
@@ -181,9 +187,16 @@ static int find_base_port(struct fintek_8250 *pdata, u16 io_address)
 				if (aux != io_address)
 					continue;
 
-				fintek_8250_exit_key(addr[i]);
 				pdata->index = k;
 
+				irq_data = irq_get_irq_data(irq);
+				if (irq_data)
+					level_mode =
+						irqd_is_level_type(irq_data);
+
+				fintek_8250_set_irq_mode(pdata, level_mode);
+				fintek_8250_exit_key(addr[i]);
+
 				return 0;
 			}
 
@@ -194,31 +207,20 @@ static int find_base_port(struct fintek_8250 *pdata, u16 io_address)
 	return -ENODEV;
 }
 
-static int fintek_8250_set_irq_mode(struct fintek_8250 *pdata, bool level_mode)
+static void fintek_8250_set_irq_mode(struct fintek_8250 *pdata, bool is_level)
 {
-	int status;
-
-	status = fintek_8250_enter_key(pdata->base_port, pdata->key);
-	if (status)
-		return status;
-
 	sio_write_reg(pdata, LDN, pdata->index);
 	sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_SHARE, IRQ_SHARE);
 	sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_MODE_MASK,
-			   level_mode ? IRQ_LEVEL_LOW : IRQ_EDGE_HIGH);
-
-	fintek_8250_exit_key(pdata->base_port);
-	return 0;
+			   is_level ? IRQ_LEVEL_LOW : IRQ_EDGE_HIGH);
 }
 
 int fintek_8250_probe(struct uart_8250_port *uart)
 {
 	struct fintek_8250 *pdata;
 	struct fintek_8250 probe_data;
-	struct irq_data *irq_data = irq_get_irq_data(uart->port.irq);
-	bool level_mode = irqd_is_level_type(irq_data);
 
-	if (find_base_port(&probe_data, uart->port.iobase))
+	if (find_base_port(&probe_data, uart->port.iobase, uart->port.irq))
 		return -ENODEV;
 
 	pdata = devm_kzalloc(uart->port.dev, sizeof(*pdata), GFP_KERNEL);
@@ -229,5 +231,5 @@ int fintek_8250_probe(struct uart_8250_port *uart)
 	uart->port.rs485_config = fintek_8250_rs485_config;
 	uart->port.private_data = pdata;
 
-	return fintek_8250_set_irq_mode(pdata, level_mode);
+	return 0;
 }
-- 
1.9.1
