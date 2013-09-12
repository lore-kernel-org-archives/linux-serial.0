From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/3] serial: 8250_pci: remove unnecessary pci_set_drvdata()
Date: Thu, 12 Sep 2013 15:33:48 +0900
Message-ID: <000e01ceaf82$0a2fff10$1e8ffd30$%han@samsung.com>
References: <000d01ceaf81$a9910aa0$fcb31fe0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59132 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab3ILGdv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Sep 2013 02:33:51 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MT000FQD266I3H0@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 12 Sep 2013 15:33:49 +0900 (KST)
In-reply-to: <000d01ceaf81$a9910aa0$fcb31fe0$%han@samsung.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Ian Abbott' <abbotti@mev.co.uk>, 'Wang YanQing' <udknight@gmail.com>, 'Stephen Chivers' <schivers@csc.com>, 'Stephen Hurd' <shurd@broadcom.com>

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/8250/8250_pci.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index c810da7..515fd0f 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -3520,8 +3520,6 @@ static void pciserial_remove_one(struct pci_dev *dev)
 {
 	struct serial_private *priv = pci_get_drvdata(dev);
 
-	pci_set_drvdata(dev, NULL);
-
 	pciserial_remove_ports(priv);
 
 	pci_disable_device(dev);
-- 
1.7.10.4


