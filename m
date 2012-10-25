From: chao bi <chao.bi@intel.com>
Subject: [PATCH] serial:ifx6x60:different SPI word width configure requires
 different swap process
Date: Thu, 25 Oct 2012 09:02:32 +0800
Message-ID: <1351126952.18855.103.camel@bichao>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50364 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243Ab2JYAsN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Oct 2012 20:48:13 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, richardx.r.gorby@intel.com, chuansheng.liu@intel.com, jun.d.chen@intel.com


SPI protocol driver only provide one function (swap_buf()) to swap SPI data
into big endian format, which is only available when SPI controller's word width
is 16 bits. But word width could be configured as 8/16/32 bits, different word
width configure should be mapped to different swap methods.This patch is to make
SPI protocol driver choose the right swap function corresponding to SPI word
width configuration.

cc: liu chuansheng <chuansheng.liu@intel.com>
cc: Chen Jun <jun.d.chen@intel.com>
Signed-off-by: channing <chao.bi@intel.com>
---
 drivers/tty/serial/ifx6x60.c |   70 ++++++++++++++++++++++++++++++++++++------
 drivers/tty/serial/ifx6x60.h |    1 +
 2 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 5b9bc19..2d2bcbd 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -152,26 +152,67 @@ ifx_spi_power_state_clear(struct ifx_spi_device *ifx_dev, unsigned char val)
 }
 
 /**
- *	swap_buf
+ *	swap_buf_8
  *	@buf: our buffer
  *	@len : number of bytes (not words) in the buffer
  *	@end: end of buffer
  *
  *	Swap the contents of a buffer into big endian format
  */
-static inline void swap_buf(u16 *buf, int len, void *end)
+static inline void swap_buf_8(unsigned char *buf, int len, void *end)
+{
+	/* don't swap buffer if SPI word width is 8 bits */
+	return;
+}
+
+/**
+ *	swap_buf_16
+ *	@buf: our buffer
+ *	@len : number of bytes (not words) in the buffer
+ *	@end: end of buffer
+ *
+ *	Swap the contents of a buffer into big endian format
+ */
+static inline void swap_buf_16(unsigned char *buf, int len, void *end)
 {
 	int n;
 
+	u16 *buf_16 = (u16 *)buf;
 	len = ((len + 1) >> 1);
-	if ((void *)&buf[len] > end) {
-		pr_err("swap_buf: swap exceeds boundary (%p > %p)!",
-		       &buf[len], end);
+	if ((void *)&buf_16[len] > end) {
+		pr_err("swap_buf_16: swap exceeds boundary (%p > %p)!",
+		       &buf_16[len], end);
 		return;
 	}
 	for (n = 0; n < len; n++) {
-		*buf = cpu_to_be16(*buf);
-		buf++;
+		*buf_16 = cpu_to_be16(*buf_16);
+		buf_16++;
+	}
+}
+
+/**
+ *	swap_buf_32
+ *	@buf: our buffer
+ *	@len : number of bytes (not words) in the buffer
+ *	@end: end of buffer
+ *
+ *	Swap the contents of a buffer into big endian format
+ */
+static inline void swap_buf_32(unsigned char *buf, int len, void *end)
+{
+	int n;
+
+	u32 *buf_32 = (u32 *)buf;
+	len = (len + 3) >> 2;
+
+	if ((void *)&buf_32[len] > end) {
+		pr_err("swap_buf_32: swap exceeds boundary (%p > %p)!\n",
+		       &buf_32[len], end);
+		return;
+	}
+	for (n = 0; n < len; n++) {
+		*buf_32 = cpu_to_be32(*buf_32);
+		buf_32++;
 	}
 }
 
@@ -449,7 +490,7 @@ static int ifx_spi_prepare_tx_buffer(struct ifx_spi_device *ifx_dev)
 					tx_count-IFX_SPI_HEADER_OVERHEAD,
 					ifx_dev->spi_more);
 	/* swap actual data in the buffer */
-	swap_buf((u16 *)(ifx_dev->tx_buffer), tx_count,
+	ifx_dev->swap_buf((ifx_dev->tx_buffer), tx_count,
 		&ifx_dev->tx_buffer[IFX_SPI_TRANSFER_SIZE]);
 	return tx_count;
 }
@@ -617,7 +658,7 @@ static void ifx_spi_complete(void *ctx)
 
 	if (!ifx_dev->spi_msg.status) {
 		/* check header validity, get comm flags */
-		swap_buf((u16 *)ifx_dev->rx_buffer, IFX_SPI_HEADER_OVERHEAD,
+		ifx_dev->swap_buf(ifx_dev->rx_buffer, IFX_SPI_HEADER_OVERHEAD,
 			&ifx_dev->rx_buffer[IFX_SPI_HEADER_OVERHEAD]);
 		decode_result = ifx_spi_decode_spi_header(ifx_dev->rx_buffer,
 				&length, &more, &cts);
@@ -636,7 +677,8 @@ static void ifx_spi_complete(void *ctx)
 
 		actual_length = min((unsigned int)length,
 					ifx_dev->spi_msg.actual_length);
-		swap_buf((u16 *)(ifx_dev->rx_buffer + IFX_SPI_HEADER_OVERHEAD),
+		ifx_dev->swap_buf(
+			(ifx_dev->rx_buffer + IFX_SPI_HEADER_OVERHEAD),
 			 actual_length,
 			 &ifx_dev->rx_buffer[IFX_SPI_TRANSFER_SIZE]);
 		ifx_spi_insert_flip_string(
@@ -1001,6 +1043,14 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
+	/* init swap_buf function according to word width configuration */
+	if (spi->bits_per_word == 32)
+		ifx_dev->swap_buf = swap_buf_32;
+	else if (spi->bits_per_word == 16)
+		ifx_dev->swap_buf = swap_buf_16;
+	else
+		ifx_dev->swap_buf = swap_buf_8;
+
 	/* ensure SPI protocol flags are initialized to enable transfer */
 	ifx_dev->spi_more = 0;
 	ifx_dev->spi_slave_cts = 0;
diff --git a/drivers/tty/serial/ifx6x60.h b/drivers/tty/serial/ifx6x60.h
index e8464ba..d8869f5 100644
--- a/drivers/tty/serial/ifx6x60.h
+++ b/drivers/tty/serial/ifx6x60.h
@@ -124,6 +124,7 @@ struct ifx_spi_device {
 #define MR_INPROGRESS	1
 #define MR_COMPLETE	2
 	wait_queue_head_t mdm_reset_wait;
+	void (*swap_buf)(unsigned char *buf, int len, void *end);
 };
 
 #endif /* _IFX6X60_H */
-- 
1.7.1



