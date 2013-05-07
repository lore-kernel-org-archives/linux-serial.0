From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 09/15] serial: pmac_zilog: remove unnecessary
 platform_set_drvdata()
Date: Tue, 07 May 2013 17:04:27 +0900
Message-ID: <008e01ce4af9$7ed7ff40$7c87fdc0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:31592 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756632Ab3EGIE3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 May 2013 04:04:29 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMF00DXQ51G02F0@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Tue, 07 May 2013 17:04:28 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/pmac_zilog.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index b1785f5..f87f1a0 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1798,7 +1798,6 @@ static int __exit pmz_detach(struct platform_device *pdev)
 
 	uart_remove_one_port(&pmz_uart_reg, &uap->port);
 
-	platform_set_drvdata(pdev, NULL);
 	uap->port.dev = NULL;
 
 	return 0;
-- 
1.7.2.5


