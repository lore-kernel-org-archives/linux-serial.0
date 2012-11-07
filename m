From: Jun Chen <jun.d.chen@intel.com>
Subject: [PATCH] serial: ifx6x60: ifx_spi_write don't need to do
 mrdy_assert when fifo is not empty
Date: Wed, 07 Nov 2012 12:04:04 -0500
Message-ID: <1352307844.4332.63.camel@chenjun-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:37668 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673Ab2KGJBb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Nov 2012 04:01:31 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Bi Chao <chao.bi@intel.com>, serial <linux-serial@vger.kernel.org>, "russ.gorby" <russ.gorby@intel.com>, Jun Chen <jun.d.chen@intel.com>


This patch check whether the fifo lenth is empty before writing new data to fifo.If condition
is true,ifx_spi_write need to trigger one mrdy_assert. If condition is false,the mrdy_assert
will be trigger by the next ifx_spi_io.
Cc: Bi Chao <chao.bi@intel.com>
Signed-off-by: Chen Jun <jun.d.chen@intel.com>
---
 drivers/tty/serial/ifx6x60.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index a688f8f..4a21f5e 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -520,9 +520,16 @@ static int ifx_spi_write(struct tty_struct *tty, const unsigned char *buf,
 {
 	struct ifx_spi_device *ifx_dev = tty->driver_data;
 	unsigned char *tmp_buf = (unsigned char *)buf;
-	int tx_count = kfifo_in_locked(&ifx_dev->tx_fifo, tmp_buf, count,
-				   &ifx_dev->fifo_lock);
-	mrdy_assert(ifx_dev);
+	unsigned long flags;
+	bool is_fifo_empty;
+
+	spin_lock_irqsave(&ifx_dev->fifo_lock, flags);
+	is_fifo_empty = kfifo_is_empty(&ifx_dev->tx_fifo);
+	int tx_count = kfifo_in(&ifx_dev->tx_fifo, tmp_buf, count);
+	spin_unlock_irqrestore(&ifx_dev->fifo_lock, flags);
+	if (is_fifo_empty)
+		mrdy_assert(ifx_dev);
+
 	return tx_count;
 }
 
-- 
1.7.4.1



