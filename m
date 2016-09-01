From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: [PATCH 4/7] serial: 8250_fintek: Rearrange function
Date: Thu,  1 Sep 2016 11:39:53 +0800
Message-ID: <1472701196-14795-5-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1472701196-14795-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472701196-14795-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, ricardo.ribalda@gmail.com
Cc: arnd@arndb.de, peter@hurleysoftware.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

We change the position of fintek_8250_set_irq_mode() above the
find_base_port() to eliminate the prototype define.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 5625203..921f742 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -56,9 +56,6 @@ struct fintek_8250 {
 	u8 key;
 };
 
-static void fintek_8250_set_irq_mode(struct fintek_8250 *pdata,
-				     bool level_mode);
-
 static u8 sio_read_reg(struct fintek_8250 *pdata, u8 reg)
 {
 	outb(reg, pdata->base_port + ADDR_PORT);
@@ -179,6 +176,14 @@ static void fintek_8250_set_max_fifo(struct fintek_8250 *pdata)
 	}
 }
 
+static void fintek_8250_set_irq_mode(struct fintek_8250 *pdata, bool is_level)
+{
+	sio_write_reg(pdata, LDN, pdata->index);
+	sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_SHARE, IRQ_SHARE);
+	sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_MODE_MASK,
+			   is_level ? IRQ_LEVEL_LOW : IRQ_EDGE_HIGH);
+}
+
 static int find_base_port(struct fintek_8250 *pdata, u16 io_address,
 			  unsigned int irq)
 {
@@ -230,14 +235,6 @@ static int find_base_port(struct fintek_8250 *pdata, u16 io_address,
 	return -ENODEV;
 }
 
-static void fintek_8250_set_irq_mode(struct fintek_8250 *pdata, bool is_level)
-{
-	sio_write_reg(pdata, LDN, pdata->index);
-	sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_SHARE, IRQ_SHARE);
-	sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_MODE_MASK,
-			   is_level ? IRQ_LEVEL_LOW : IRQ_EDGE_HIGH);
-}
-
 int fintek_8250_probe(struct uart_8250_port *uart)
 {
 	struct fintek_8250 *pdata;
-- 
1.9.1
