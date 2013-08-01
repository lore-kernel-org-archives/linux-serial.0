From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] serial: sh-sci: use dev_get_platdata()
Date: Thu, 01 Aug 2013 18:17:45 +0900
Message-ID: <000201ce8e97$fbf311e0$f3d935a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:50179 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab3HAJRs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Aug 2013 05:17:48 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQU003E0HTM8YS0@mailout2.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 01 Aug 2013 18:17:47 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/sh-sci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 72ca870..5377502 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2469,7 +2469,7 @@ static int sci_probe_single(struct platform_device *dev,
 
 static int sci_probe(struct platform_device *dev)
 {
-	struct plat_sci_port *p = dev->dev.platform_data;
+	struct plat_sci_port *p = dev_get_platdata(&dev->dev);
 	struct sci_port *sp = &sci_ports[dev->id];
 	int ret;
 
-- 
1.7.10.4


