From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 6/7] serial: exar: Move register defines from uapi header to consumer site
Date: Tue,  7 Feb 2017 17:10:03 +0100
Message-ID: <11a59bb45f2ee98d8337efd8d43212ca59360605.1486483804.git.jan.kiszka@siemens.com>
References: <cover.1486483803.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1486483803.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1486483803.git.jan.kiszka@siemens.com>
References: <cover.1486483803.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-serial@vger.kernel.org

None of these registers is relevant for the userspace API.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/tty/serial/8250/8250_exar.c | 13 +++++++++++++
 drivers/tty/serial/8250/8250_port.c |  6 ++++++
 include/uapi/linux/serial_reg.h     | 18 ------------------
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 623b9d0..13cc1da 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -34,6 +34,19 @@
 #define PCI_DEVICE_ID_EXAR_XR17V4358		0x4358
 #define PCI_DEVICE_ID_EXAR_XR17V8358		0x8358
 
+#define UART_EXAR_8XMODE	0x88	/* 8X sampling rate select */
+
+#define UART_EXAR_FCTR		0x08	/* Feature Control Register */
+#define UART_FCTR_EXAR_IRDA	0x10	/* IrDa data encode select */
+#define UART_FCTR_EXAR_485	0x20	/* Auto 485 half duplex dir ctl */
+#define UART_FCTR_EXAR_TRGA	0x00	/* FIFO trigger table A */
+#define UART_FCTR_EXAR_TRGB	0x60	/* FIFO trigger table B */
+#define UART_FCTR_EXAR_TRGC	0x80	/* FIFO trigger table C */
+#define UART_FCTR_EXAR_TRGD	0xc0	/* FIFO trigger table D programmable */
+
+#define UART_EXAR_TXTRG		0x0a	/* Tx FIFO trigger level write-only */
+#define UART_EXAR_RXTRG		0x0b	/* Rx FIFO trigger level write-only */
+
 #define UART_EXAR_MPIOINT_7_0	0x8f	/* MPIOINT[7:0] */
 #define UART_EXAR_MPIOLVL_7_0	0x90	/* MPIOLVL[7:0] */
 #define UART_EXAR_MPIO3T_7_0	0x91	/* MPIO3T[7:0] */
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index ec6b5e3..6119516 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -45,6 +45,12 @@
 #include "8250.h"
 
 /*
+ * These are definitions for the Exar XR17V35X and XR17(C|D)15X
+ */
+#define UART_EXAR_SLEEP		0x8b	/* Sleep mode */
+#define UART_EXAR_DVID		0x8d	/* Device identification */
+
+/*
  * Debugging.
  */
 #if 0
diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index 25b93a7..5db7688 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -367,24 +367,6 @@
 #define UART_OMAP_MDR1_DISABLE		0x07	/* Disable (default state) */
 
 /*
- * These are definitions for the Exar XR17V35X and XR17(C|D)15X
- */
-#define UART_EXAR_8XMODE	0x88	/* 8X sampling rate select */
-#define UART_EXAR_SLEEP		0x8b	/* Sleep mode */
-#define UART_EXAR_DVID		0x8d	/* Device identification */
-
-#define UART_EXAR_FCTR		0x08	/* Feature Control Register */
-#define UART_FCTR_EXAR_IRDA	0x10	/* IrDa data encode select */
-#define UART_FCTR_EXAR_485	0x20	/* Auto 485 half duplex dir ctl */
-#define UART_FCTR_EXAR_TRGA	0x00	/* FIFO trigger table A */
-#define UART_FCTR_EXAR_TRGB	0x60	/* FIFO trigger table B */
-#define UART_FCTR_EXAR_TRGC	0x80	/* FIFO trigger table C */
-#define UART_FCTR_EXAR_TRGD	0xc0	/* FIFO trigger table D programmable */
-
-#define UART_EXAR_TXTRG		0x0a	/* Tx FIFO trigger level write-only */
-#define UART_EXAR_RXTRG		0x0b	/* Rx FIFO trigger level write-only */
-
-/*
  * These are definitions for the Altera ALTR_16550_F32/F64/F128
  * Normalized from 0x100 to 0x40 because of shift by 2 (32 bit regs).
  */
-- 
2.1.4
