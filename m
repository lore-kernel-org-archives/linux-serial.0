From: Jun Chen <jun.d.chen@intel.com>
Subject: [PATCH] serial: ifx6x60: ifx_spi_write don't need to do
 mrdy_assert when fifo is not empty.
Date: Tue, 06 Nov 2012 04:28:54 -0500
Message-ID: <1352194134.4332.47.camel@chenjun-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:14819 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754638Ab2KFB0X (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Nov 2012 20:26:23 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: serial <linux-serial@vger.kernel.org>, "russ.gorby" <russ.gorby@intel.com>, chao.bi@intel.com, jun.d.chen@intel.com


This patch check whether the kfifo lenth equal to the count of write data.If condition
is true,ifx_spi_write need to trigger one mrdy_assert. If condition is false,the mrdy_assert
will be triggered by the next ifx_spi_io.
Cc: Bi Chao <chao.bi@intel.com>
Signed-off-by: Chen Jun <jun.d.chen@intel.com>
---
 drivers/tty/serial/ifx6x60.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index ac718e1..b52ef8d 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -522,7 +522,8 @@ static int ifx_spi_write(struct tty_struct *tty, const unsigned char *buf,
 	unsigned char *tmp_buf = (unsigned char *)buf;
 	int tx_count = kfifo_in_locked(&ifx_dev->tx_fifo, tmp_buf, count,
 				   &ifx_dev->fifo_lock);
-	mrdy_assert(ifx_dev);
+	if (kfifo_len(&ifx_dev->tx_fifo) == count)
+		mrdy_assert(ifx_dev);
 	return tx_count;
 }
 
-- 
1.7.4.1



