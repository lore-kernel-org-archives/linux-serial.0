From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH 1/2] serial: mrst_max3110: Check the irq number before enable/disabe irq in PM hooks
Date: Wed,  9 Oct 2013 10:39:16 +0800
Message-ID: <1381286357-13346-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37949 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755376Ab3JICrP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 8 Oct 2013 22:47:15 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: Feng Tang <feng.tang@intel.com>

We should check the validity of the irq number before calling
disable_irq() and enable_irq() in the suspend/resume function,
as "max->irq == 0" means the irq is not enabled for max3110
device, otherwise it will hurt device whose irq number is really 0.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 drivers/tty/serial/mrst_max3110.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mrst_max3110.c b/drivers/tty/serial/mrst_max3110.c
index a67e708..ee77e73 100644
--- a/drivers/tty/serial/mrst_max3110.c
+++ b/drivers/tty/serial/mrst_max3110.c
@@ -749,7 +749,8 @@ static int serial_m3110_suspend(struct device *dev)
 	struct spi_device *spi = to_spi_device(dev);
 	struct uart_max3110 *max = spi_get_drvdata(spi);
 
-	disable_irq(max->irq);
+	if (max->irq > 0)
+		disable_irq(max->irq);
 	uart_suspend_port(&serial_m3110_reg, &max->port);
 	max3110_out(max, max->cur_conf | WC_SW_SHDI);
 	return 0;
@@ -762,7 +763,8 @@ static int serial_m3110_resume(struct device *dev)
 
 	max3110_out(max, max->cur_conf);
 	uart_resume_port(&serial_m3110_reg, &max->port);
-	enable_irq(max->irq);
+	if (max->irq > 0)
+		enable_irq(max->irq);
 	return 0;
 }
 
-- 
1.7.0.4

