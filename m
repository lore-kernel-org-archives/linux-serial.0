From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH 2/2] serial: mrst_max3110: Fix race condition between spi transfers
Date: Wed,  9 Oct 2013 10:39:17 +0800
Message-ID: <1381286357-13346-2-git-send-email-feng.tang@intel.com>
References: <1381286357-13346-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37949 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756204Ab3JICrQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 8 Oct 2013 22:47:16 -0400
In-Reply-To: <1381286357-13346-1-git-send-email-feng.tang@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: Bin Gao <bin.gao@intel.com>, Feng Tang <feng.tang@intel.com>

From: Bin Gao <bin.gao@intel.com>

There is a race between termios configuration and xmit that can cause the
intel_mid_ssp_spi driver to stall.

Serializing spi transactions fixes the problem.

Signed-off-by: Bin Gao <bin.gao@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 drivers/tty/serial/mrst_max3110.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/mrst_max3110.c b/drivers/tty/serial/mrst_max3110.c
index ee77e73..565779d 100644
--- a/drivers/tty/serial/mrst_max3110.c
+++ b/drivers/tty/serial/mrst_max3110.c
@@ -61,6 +61,7 @@ struct uart_max3110 {
 	struct task_struct *main_thread;
 	struct task_struct *read_thread;
 	struct mutex thread_mutex;
+	struct mutex io_mutex;
 
 	u32 baud;
 	u16 cur_conf;
@@ -90,6 +91,7 @@ static int max3110_write_then_read(struct uart_max3110 *max,
 	struct spi_transfer	x;
 	int ret;
 
+	mutex_lock(&max->io_mutex);
 	spi_message_init(&message);
 	memset(&x, 0, sizeof x);
 	x.len = len;
@@ -104,6 +106,7 @@ static int max3110_write_then_read(struct uart_max3110 *max,
 
 	/* Do the i/o */
 	ret = spi_sync(spi, &message);
+	mutex_unlock(&max->io_mutex);
 	return ret;
 }
 
@@ -805,6 +808,7 @@ static int serial_m3110_probe(struct spi_device *spi)
 	max->irq = (u16)spi->irq;
 
 	mutex_init(&max->thread_mutex);
+	mutex_init(&max->io_mutex);
 
 	max->word_7bits = 0;
 	max->parity = 0;
-- 
1.7.0.4

