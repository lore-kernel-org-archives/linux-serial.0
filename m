From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 3/3] serial: txx9: remove unnecessary pci_set_drvdata()
Date: Thu, 12 Sep 2013 15:35:01 +0900
Message-ID: <000f01ceaf82$352d3ed0$9f87bc70$%han@samsung.com>
References: <000d01ceaf81$a9910aa0$fcb31fe0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59413 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab3ILGfG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Sep 2013 02:35:06 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MT000FQD266I3H0@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 12 Sep 2013 15:35:01 +0900 (KST)
In-reply-to: <000d01ceaf81$a9910aa0$fcb31fe0$%han@samsung.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/serial_txx9.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index 440a962..90a080b 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -1220,8 +1220,6 @@ static void pciserial_txx9_remove_one(struct pci_dev *dev)
 {
 	struct uart_txx9_port *up = pci_get_drvdata(dev);
 
-	pci_set_drvdata(dev, NULL);
-
 	if (up) {
 		serial_txx9_unregister_port(up->port.line);
 		pci_disable_device(dev);
-- 
1.7.10.4


