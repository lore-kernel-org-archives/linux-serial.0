From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 3/7] serial: exar: Fix feature control register constants
Date: Tue,  7 Feb 2017 17:10:00 +0100
Message-ID: <2d1b9f9a78033664ee1afcd55b708602bc262c2e.1486483803.git.jan.kiszka@siemens.com>
References: <cover.1486483803.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1486483803.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1486483803.git.jan.kiszka@siemens.com>
References: <cover.1486483803.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-serial@vger.kernel.org

According to the XR17V352 manual, bit 4 is IrDA control and bit 5 for
485. Fortunately, no driver used them so far.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/uapi/linux/serial_reg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index 274d8fc..25b93a7 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -374,8 +374,8 @@
 #define UART_EXAR_DVID		0x8d	/* Device identification */
 
 #define UART_EXAR_FCTR		0x08	/* Feature Control Register */
-#define UART_FCTR_EXAR_IRDA	0x08	/* IrDa data encode select */
-#define UART_FCTR_EXAR_485	0x10	/* Auto 485 half duplex dir ctl */
+#define UART_FCTR_EXAR_IRDA	0x10	/* IrDa data encode select */
+#define UART_FCTR_EXAR_485	0x20	/* Auto 485 half duplex dir ctl */
 #define UART_FCTR_EXAR_TRGA	0x00	/* FIFO trigger table A */
 #define UART_FCTR_EXAR_TRGB	0x60	/* FIFO trigger table B */
 #define UART_FCTR_EXAR_TRGC	0x80	/* FIFO trigger table C */
-- 
2.1.4
