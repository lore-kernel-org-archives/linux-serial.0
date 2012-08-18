From: Emil Goode <emilgoode@gmail.com>
Subject: [PATCH 2/2] tty: serial: Remove explicit use of devm_kfree
Date: Sat, 18 Aug 2012 18:12:49 +0200
Message-ID: <1345306369-10407-2-git-send-email-emilgoode@gmail.com>
References: <1345306369-10407-1-git-send-email-emilgoode@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:55057 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755920Ab2HRQJa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 18 Aug 2012 12:09:30 -0400
In-Reply-To: <1345306369-10407-1-git-send-email-emilgoode@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Emil Goode <emilgoode@gmail.com>

There is no reason to explicitly call devm_kfree
in probe or remove functions.

Signed-off-by: Emil Goode <emilgoode@gmail.com>
---
 drivers/tty/serial/max310x.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 06ff5ad..2bc28a5 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1198,7 +1198,6 @@ err_freq:
 
 err_out:
 	dev_set_drvdata(dev, NULL);
-	devm_kfree(dev, s);
 
 	return ret;
 }
@@ -1234,8 +1233,6 @@ static int __devexit max310x_remove(struct spi_device *spi)
 	if (s->pdata->exit)
 		s->pdata->exit();
 
-	devm_kfree(dev, s);
-
 	return ret;
 }
 
-- 
1.7.10.4

