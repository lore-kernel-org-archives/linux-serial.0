From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/2] serial: sccnxp: Do not override device name
Date: Sat, 13 Apr 2013 08:46:57 +0400
Message-ID: <1365828418-1920-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp3.mail.ru ([94.100.176.131]:52887 "EHLO smtp3.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155Ab3DMErH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Apr 2013 00:47:07 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/sccnxp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 08dbfb8..b1d04aa 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -789,8 +789,6 @@ static int sccnxp_probe(struct platform_device *pdev)
 		return -EADDRNOTAVAIL;
 	}
 
-	dev_set_name(&pdev->dev, SCCNXP_NAME);
-
 	s = devm_kzalloc(&pdev->dev, sizeof(struct sccnxp_port), GFP_KERNEL);
 	if (!s) {
 		dev_err(&pdev->dev, "Error allocating port structure\n");
-- 
1.8.1.5

