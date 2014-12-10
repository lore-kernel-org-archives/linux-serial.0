From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH 3/6] serial: s3c: add missing register definitions
Date: Wed, 10 Dec 2014 12:49:24 +0100
Message-ID: <1418212167-28992-4-git-send-email-r.baldyga@samsung.com>
References: <1418212167-28992-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1418212167-28992-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, akpm@linux-foundation.org, kgene.kim@samsung.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, l.czerwinski@samsung.com, s.nawrocki@samsung.com, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-serial@vger.kernel.org

This macro definitions are necessary to implement DMA transfers
is samsung serial driver.

Based on previous work of Sylwester Nawrocki and Lukasz Czerwinski.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 include/linux/serial_s3c.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
index e6fc956..a7f004a 100644
--- a/include/linux/serial_s3c.h
+++ b/include/linux/serial_s3c.h
@@ -104,6 +104,31 @@
 				   S3C2410_UCON_RXIRQMODE | \
 				   S3C2410_UCON_RXFIFO_TOI)
 
+#define S3C64XX_UCON_TXBURST_1          (0<<20)
+#define S3C64XX_UCON_TXBURST_4          (1<<20)
+#define S3C64XX_UCON_TXBURST_8          (2<<20)
+#define S3C64XX_UCON_TXBURST_16         (3<<20)
+#define S3C64XX_UCON_TXBURST_MASK       (0xf<<20)
+#define S3C64XX_UCON_RXBURST_1          (0<<16)
+#define S3C64XX_UCON_RXBURST_4          (1<<16)
+#define S3C64XX_UCON_RXBURST_8          (2<<16)
+#define S3C64XX_UCON_RXBURST_16         (3<<16)
+#define S3C64XX_UCON_RXBURST_MASK       (0xf<<16)
+#define S3C64XX_UCON_TIMEOUT_SHIFT      (12)
+#define S3C64XX_UCON_TIMEOUT_MASK       (0xf<<12)
+#define S3C64XX_UCON_EMPTYINT_EN        (1<<11)
+#define S3C64XX_UCON_DMASUS_EN          (1<<10)
+#define S3C64XX_UCON_TXINT_LEVEL        (1<<9)
+#define S3C64XX_UCON_RXINT_LEVEL        (1<<8)
+#define S3C64XX_UCON_TIMEOUT_EN         (1<<7)
+#define S3C64XX_UCON_ERRINT_EN          (1<<6)
+#define S3C64XX_UCON_TXMODE_DMA         (2<<2)
+#define S3C64XX_UCON_TXMODE_CPU         (1<<2)
+#define S3C64XX_UCON_TXMODE_MASK        (3<<2)
+#define S3C64XX_UCON_RXMODE_DMA         (2<<0)
+#define S3C64XX_UCON_RXMODE_CPU         (1<<0)
+#define S3C64XX_UCON_RXMODE_MASK        (3<<0)
+
 #define S3C2410_UFCON_FIFOMODE	  (1<<0)
 #define S3C2410_UFCON_TXTRIG0	  (0<<6)
 #define S3C2410_UFCON_RXTRIG8	  (1<<4)
@@ -155,6 +180,7 @@
 #define S3C2440_UFSTAT_TXMASK	  (63<<8)
 #define S3C2440_UFSTAT_RXMASK	  (63)
 
+#define S3C2410_UTRSTAT_TIMEOUT   (1<<3)
 #define S3C2410_UTRSTAT_TXE	  (1<<2)
 #define S3C2410_UTRSTAT_TXFE	  (1<<1)
 #define S3C2410_UTRSTAT_RXDR	  (1<<0)
@@ -179,8 +205,10 @@
 #define S3C64XX_UINTM		0x38
 
 #define S3C64XX_UINTM_RXD	(0)
+#define S3C64XX_UINTM_ERROR     (1)
 #define S3C64XX_UINTM_TXD	(2)
 #define S3C64XX_UINTM_RXD_MSK	(1 << S3C64XX_UINTM_RXD)
+#define S3C64XX_UINTM_ERR_MSK   (1 << S3C64XX_UINTM_ERROR)
 #define S3C64XX_UINTM_TXD_MSK	(1 << S3C64XX_UINTM_TXD)
 
 /* Following are specific to S5PV210 */
-- 
1.9.1
