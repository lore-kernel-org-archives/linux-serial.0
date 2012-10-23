From: chao bi <chao.bi@intel.com>
Subject: Subject: [PATCH] serial:ifx6x60:add swap_buf_32 function in case
 SPI word width is 32 bits
Date: Tue, 23 Oct 2012 16:32:50 +0800
Message-ID: <1350981170.18855.83.camel@bichao>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:29361 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756657Ab2JWISb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Oct 2012 04:18:31 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, richardx.r.gorby@intel.com, jun.d.chen@intel.com, chuansheng.liu@intel.com


SPI protocol driver only provide one function (swap_buf()) to swap SPI data
into big endian format, which is only available when SPI controller's word width
is 16 bits. But per our experiment and validation on medfield platform, 16 bit
word width cannot cover all scenarioes, 32 bits word width is a better choice
to avoid SPI FIFO overrun. Therefore, SPI controller is likely to configure its
word width as either 16 bits or 32 bits. This patch is to implement 2 functions
(swap_buf_16() and swap_buf_32()) to adapt the two configurations.

cc: liu chuansheng <chuansheng.liu@intel.com>
cc: Chen Jun <jun.d.chen@intel.com>
Signed-off-by: channing <chao.bi@intel.com>
---
 drivers/tty/serial/ifx6x60.c |   51 +++++++++++++++++++++++++++++++++--------
 1 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 5b9bc19..ad718ec 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -151,29 +151,60 @@ ifx_spi_power_state_clear(struct ifx_spi_device *ifx_dev, unsigned char val)
 	spin_unlock_irqrestore(&ifx_dev->power_lock, flags);
 }
 
+#ifdef SPI_CONTROLLER_USE_32_BITS_PER_WORD
+#define SWAP_BUF swap_buf_32
 /**
- *	swap_buf
+ *	swap_buf_32
  *	@buf: our buffer
  *	@len : number of bytes (not words) in the buffer
  *	@end: end of buffer
  *
  *	Swap the contents of a buffer into big endian format
  */
-static inline void swap_buf(u16 *buf, int len, void *end)
+static inline void swap_buf_32(unsigned char *buf, int len, void *end)
 {
 	int n;
 
+	u32 *buf_32 = (u32 *)buf;
+	len = (0 == (len&0x03)) ? (len >> 2) : ((len >> 2) + 1);
+
+	if ((void *)&buf_32[len] > end) {
+		pr_err("swap_buf_32: swap exceeds boundary (%p > %p)!\n",
+		       &buf_32[len], end);
+		return;
+	}
+	for (n = 0; n < len; n++) {
+		*buf_32 = cpu_to_be32(*buf_32);
+		buf_32++;
+	}
+}
+#else
+#define SWAP_BUF swap_buf_16
+/**
+ *	swap_buf_16
+ *	@buf: our buffer
+ *	@len : number of bytes (not words) in the buffer
+ *	@end: end of buffer
+ *
+ *	Swap the contents of a buffer into big endian format
+ */
+static inline void swap_buf_16(unsigned char *buf, int len, void *end)
+{
+	int n;
+
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
 	}
 }
+#endif
 
 /**
  *	mrdy_assert		-	assert MRDY line
@@ -449,7 +480,7 @@ static int ifx_spi_prepare_tx_buffer(struct ifx_spi_device *ifx_dev)
 					tx_count-IFX_SPI_HEADER_OVERHEAD,
 					ifx_dev->spi_more);
 	/* swap actual data in the buffer */
-	swap_buf((u16 *)(ifx_dev->tx_buffer), tx_count,
+	SWAP_BUF((ifx_dev->tx_buffer), tx_count,
 		&ifx_dev->tx_buffer[IFX_SPI_TRANSFER_SIZE]);
 	return tx_count;
 }
@@ -617,7 +648,7 @@ static void ifx_spi_complete(void *ctx)
 
 	if (!ifx_dev->spi_msg.status) {
 		/* check header validity, get comm flags */
-		swap_buf((u16 *)ifx_dev->rx_buffer, IFX_SPI_HEADER_OVERHEAD,
+		SWAP_BUF(ifx_dev->rx_buffer, IFX_SPI_HEADER_OVERHEAD,
 			&ifx_dev->rx_buffer[IFX_SPI_HEADER_OVERHEAD]);
 		decode_result = ifx_spi_decode_spi_header(ifx_dev->rx_buffer,
 				&length, &more, &cts);
@@ -636,7 +667,7 @@ static void ifx_spi_complete(void *ctx)
 
 		actual_length = min((unsigned int)length,
 					ifx_dev->spi_msg.actual_length);
-		swap_buf((u16 *)(ifx_dev->rx_buffer + IFX_SPI_HEADER_OVERHEAD),
+		SWAP_BUF((ifx_dev->rx_buffer + IFX_SPI_HEADER_OVERHEAD),
 			 actual_length,
 			 &ifx_dev->rx_buffer[IFX_SPI_TRANSFER_SIZE]);
 		ifx_spi_insert_flip_string(
-- 
1.7.1



