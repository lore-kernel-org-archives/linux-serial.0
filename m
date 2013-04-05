From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] serial: max3100: use spi_get_drvdata() and spi_set_drvdata()
Date: Fri, 05 Apr 2013 10:54:05 +0900
Message-ID: <000a01ce31a0$74724fa0$5d56eee0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:42478 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071Ab3DEByH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Apr 2013 21:54:07 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MKR0060OEM2QSC0@mailout1.samsung.com> for
 linux-serial@vger.kernel.org; Fri, 05 Apr 2013 10:54:06 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Use the wrapper functions for getting and setting the driver data using
spi_device instead of using dev_{get|set}_drvdata with &spi->dev, so we
can directly pass a struct spi_device.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/max3100.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 57da9bb..35866d5 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -778,7 +778,7 @@ static int max3100_probe(struct spi_device *spi)
 	max3100s[i]->spi = spi;
 	max3100s[i]->irq = spi->irq;
 	spin_lock_init(&max3100s[i]->conf_lock);
-	dev_set_drvdata(&spi->dev, max3100s[i]);
+	spi_set_drvdata(spi, max3100s[i]);
 	pdata = spi->dev.platform_data;
 	max3100s[i]->crystal = pdata->crystal;
 	max3100s[i]->loopback = pdata->loopback;
@@ -819,7 +819,7 @@ static int max3100_probe(struct spi_device *spi)
 
 static int max3100_remove(struct spi_device *spi)
 {
-	struct max3100_port *s = dev_get_drvdata(&spi->dev);
+	struct max3100_port *s = spi_get_drvdata(spi);
 	int i;
 
 	mutex_lock(&max3100s_lock);
-- 
1.7.2.5


