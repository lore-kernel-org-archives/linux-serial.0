From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: [PATCH V2 6/6] serial: 8250_fintek: Add F81865 Support
Date: Tue,  4 Oct 2016 16:28:04 +0800
Message-ID: <1475569684-10930-7-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1475569684-10930-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475569684-10930-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, ricardo.ribalda@gmail.com
Cc: arnd@arndb.de, peter@hurleysoftware.com, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Fintek F81865 is a LPC to 6 UARTs SuperIO. It has less functional UARTs
likes F81866. It's also need check the IRQ mode with system assigned,
but the configuration is not the same with F81216 series.

F81865 IRQ Mode setting:
    0xf0
            Bit1: IRQ_MODE0
            Bit0: Share mode (always on)

    Level/Low: IRQ_MODE0:0
    Edge/High: IRQ_MODE0:1

The following list is brief descriptions of F81865:

F81865 (0704)
    9Bit(not implements with mainline)
    RS485(implemented)

Suggested-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index ff4286b..b67e7a5 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -21,6 +21,7 @@
 #define EXIT_KEY 0xAA
 #define CHIP_ID1  0x20
 #define CHIP_ID2  0x21
+#define CHIP_ID_F81865 0x0407
 #define CHIP_ID_F81866 0x1010
 #define CHIP_ID_F81216AD 0x1602
 #define CHIP_ID_F81216H 0x0501
@@ -130,6 +131,7 @@ static int fintek_8250_check_id(struct fintek_8250 *pdata)
 	chip |= sio_read_reg(pdata, CHIP_ID2) << 8;
 
 	switch (chip) {
+	case CHIP_ID_F81865:
 	case CHIP_ID_F81866:
 	case CHIP_ID_F81216AD:
 	case CHIP_ID_F81216H:
@@ -147,6 +149,7 @@ static int fintek_8250_get_ldn_range(struct fintek_8250 *pdata, int *min,
 				     int *max)
 {
 	switch (pdata->pid) {
+	case CHIP_ID_F81865:
 	case CHIP_ID_F81866:
 		*min = F81866_LDN_LOW;
 		*max = F81866_LDN_HIGH;
@@ -219,6 +222,8 @@ static void fintek_8250_set_irq_mode(struct fintek_8250 *pdata, bool is_level)
 	case CHIP_ID_F81866:
 		sio_write_mask_reg(pdata, F81866_FIFO_CTRL, F81866_IRQ_MODE1,
 				   0);
+		/* fall through */
+	case CHIP_ID_F81865:
 		sio_write_mask_reg(pdata, F81866_IRQ_MODE, F81866_IRQ_SHARE,
 				   F81866_IRQ_SHARE);
 		sio_write_mask_reg(pdata, F81866_IRQ_MODE, F81866_IRQ_MODE0,
@@ -311,6 +316,7 @@ static void fintek_8250_set_rs485_handler(struct uart_8250_port *uart)
 	case CHIP_ID_F81216AD:
 	case CHIP_ID_F81216H:
 	case CHIP_ID_F81866:
+	case CHIP_ID_F81865:
 		uart->port.rs485_config = fintek_8250_rs485_config;
 		break;
 
-- 
1.9.1
