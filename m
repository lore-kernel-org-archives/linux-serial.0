From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: [PATCH V2 2/6] serial: 8250_fintek: Set IRQ Mode when port probed
Date: Tue,  4 Oct 2016 16:28:00 +0800
Message-ID: <1475569684-10930-3-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1475569684-10930-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475569684-10930-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, ricardo.ribalda@gmail.com
Cc: arnd@arndb.de, peter@hurleysoftware.com, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Set IRQ Mode when port probed in probe_setup_port()

It should hold the IO port premission via fintek_8250_enter_key() and
release via fintek_8250_exit_key() when we configure the SuperIO.

This patch will move all SuperIO configure operations to
probe_setup_port() to reduce fintek_8250_enter_key() and
fintek_8250_exit_key() usage.

Suggested-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 45 +++++++++++++++++------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 2ae846e..deccd0e 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -154,10 +154,21 @@ static int fintek_8250_rs485_config(struct uart_port *port,
 	return 0;
 }
 
-static int find_base_port(struct fintek_8250 *pdata, u16 io_address)
+static void fintek_8250_set_irq_mode(struct fintek_8250 *pdata, bool is_level)
+{
+	sio_write_reg(pdata, LDN, pdata->index);
+	sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_SHARE, IRQ_SHARE);
+	sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_MODE_MASK,
+			   is_level ? IRQ_LEVEL_LOW : IRQ_EDGE_HIGH);
+}
+
+static int probe_setup_port(struct fintek_8250 *pdata, u16 io_address,
+			  unsigned int irq)
 {
 	static const u16 addr[] = {0x4e, 0x2e};
 	static const u8 keys[] = {0x77, 0xa0, 0x87, 0x67};
+	struct irq_data *irq_data;
+	bool level_mode = false;
 	int i, j, k;
 
 	for (i = 0; i < ARRAY_SIZE(addr); i++) {
@@ -181,9 +192,16 @@ static int find_base_port(struct fintek_8250 *pdata, u16 io_address)
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
 
@@ -194,31 +212,12 @@ static int find_base_port(struct fintek_8250 *pdata, u16 io_address)
 	return -ENODEV;
 }
 
-static int fintek_8250_set_irq_mode(struct fintek_8250 *pdata, bool level_mode)
-{
-	int status;
-
-	status = fintek_8250_enter_key(pdata->base_port, pdata->key);
-	if (status)
-		return status;
-
-	sio_write_reg(pdata, LDN, pdata->index);
-	sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_SHARE, IRQ_SHARE);
-	sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_MODE_MASK,
-			   level_mode ? IRQ_LEVEL_LOW : IRQ_EDGE_HIGH);
-
-	fintek_8250_exit_key(pdata->base_port);
-	return 0;
-}
-
 int fintek_8250_probe(struct uart_8250_port *uart)
 {
 	struct fintek_8250 *pdata;
 	struct fintek_8250 probe_data;
-	struct irq_data *irq_data = irq_get_irq_data(uart->port.irq);
-	bool level_mode = irqd_is_level_type(irq_data);
 
-	if (find_base_port(&probe_data, uart->port.iobase))
+	if (probe_setup_port(&probe_data, uart->port.iobase, uart->port.irq))
 		return -ENODEV;
 
 	pdata = devm_kzalloc(uart->port.dev, sizeof(*pdata), GFP_KERNEL);
@@ -229,5 +228,5 @@ int fintek_8250_probe(struct uart_8250_port *uart)
 	uart->port.rs485_config = fintek_8250_rs485_config;
 	uart->port.private_data = pdata;
 
-	return fintek_8250_set_irq_mode(pdata, level_mode);
+	return 0;
 }
-- 
1.9.1
