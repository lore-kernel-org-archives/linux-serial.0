From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: [PATCH V2 4/6] serial: 8250_fintek: Add F81216 Support
Date: Tue,  4 Oct 2016 16:28:02 +0800
Message-ID: <1475569684-10930-5-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1475569684-10930-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475569684-10930-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, ricardo.ribalda@gmail.com
Cc: arnd@arndb.de, peter@hurleysoftware.com, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Fintek F81216 is a LPC to 4 UARTs device. It's the F81216 series but
support less functional than F81216AD/F81216H

The following list is brief descriptions of F81216 series:

F81216H (0105)
	9Bit/High baud rate(not implements with mainline)
	RS485, 128Bytes FIFO (implemented)

F81216AD (0216)
	9Bit(not implements with mainline)
	RS485(implemented)

F81216 (0208)
	basically 16550A

Suggested-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index e039a33..523d873 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -23,6 +23,7 @@
 #define CHIP_ID2  0x21
 #define CHIP_ID_F81216AD 0x1602
 #define CHIP_ID_F81216H 0x0501
+#define CHIP_ID_F81216 0x0802
 #define VENDOR_ID1 0x23
 #define VENDOR_ID1_VAL 0x19
 #define VENDOR_ID2 0x24
@@ -107,8 +108,14 @@ static int fintek_8250_check_id(struct fintek_8250 *pdata)
 	chip = sio_read_reg(pdata, CHIP_ID1);
 	chip |= sio_read_reg(pdata, CHIP_ID2) << 8;
 
-	if (chip != CHIP_ID_F81216AD && chip != CHIP_ID_F81216H)
+	switch (chip) {
+	case CHIP_ID_F81216AD:
+	case CHIP_ID_F81216H:
+	case CHIP_ID_F81216:
+		break;
+	default:
 		return -ENODEV;
+	}
 
 	pdata->pid = chip;
 	return 0;
@@ -235,6 +242,21 @@ static int probe_setup_port(struct fintek_8250 *pdata, u16 io_address,
 	return -ENODEV;
 }
 
+static void fintek_8250_set_rs485_handler(struct uart_8250_port *uart)
+{
+	struct fintek_8250 *pdata = uart->port.private_data;
+
+	switch (pdata->pid) {
+	case CHIP_ID_F81216AD:
+	case CHIP_ID_F81216H:
+		uart->port.rs485_config = fintek_8250_rs485_config;
+		break;
+
+	default: /* No RS485 Auto direction functional */
+		break;
+	}
+}
+
 int fintek_8250_probe(struct uart_8250_port *uart)
 {
 	struct fintek_8250 *pdata;
@@ -248,8 +270,8 @@ int fintek_8250_probe(struct uart_8250_port *uart)
 		return -ENOMEM;
 
 	memcpy(pdata, &probe_data, sizeof(probe_data));
-	uart->port.rs485_config = fintek_8250_rs485_config;
 	uart->port.private_data = pdata;
+	fintek_8250_set_rs485_handler(uart);
 
 	return 0;
 }
-- 
1.9.1
