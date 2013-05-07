From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 12/15] serial: sccnxp: remove unnecessary platform_set_drvdata()
Date: Tue, 07 May 2013 17:05:59 +0900
Message-ID: <009101ce4af9$b5b7d940$21278bc0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:47285 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756632Ab3EGIGE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 May 2013 04:06:04 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMF00EIT55VZIK0@mailout2.samsung.com> for
 linux-serial@vger.kernel.org; Tue, 07 May 2013 17:06:00 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Alexander Shiyan <shc_work@mail.ru>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/sccnxp.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index c773041..9855517 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -997,8 +997,6 @@ static int sccnxp_probe(struct platform_device *pdev)
 	}
 
 err_out:
-	platform_set_drvdata(pdev, NULL);
-
 	return ret;
 }
 
@@ -1016,7 +1014,6 @@ static int sccnxp_remove(struct platform_device *pdev)
 		uart_remove_one_port(&s->uart, &s->port[i]);
 
 	uart_unregister_driver(&s->uart);
-	platform_set_drvdata(pdev, NULL);
 
 	if (!IS_ERR(s->regulator))
 		return regulator_disable(s->regulator);
-- 
1.7.2.5


