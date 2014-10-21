From: Jingchang Lu <jingchang.lu@freescale.com>
Subject: [PATCH] serial: of-serial: fix uninitialized kmalloc variable
Date: Tue, 21 Oct 2014 16:50:21 +0800
Message-ID: <1413881421-9554-1-git-send-email-jingchang.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-by2on0124.outbound.protection.outlook.com ([207.46.100.124]:2784
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751688AbaJUJiI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Oct 2014 05:38:08 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: josephl@nvidia.com, peter@hurleysoftware.com, arnd@arndb.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jingchang Lu <jingchang.lu@freescale.com>

The info pointer points to an uninitialized kmalloced space.
If a device doesn't have clk property, then info->clk may
have unpredicated value and cause call trace. So use kzalloc
to make sure it is NULL initialized.

Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
---
 drivers/tty/serial/of_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 8bc2563..56982da4 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -158,7 +158,7 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 	if (of_find_property(ofdev->dev.of_node, "used-by-rtas", NULL))
 		return -EBUSY;
 
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (info == NULL)
 		return -ENOMEM;
 
-- 
1.8.0

