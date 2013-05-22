From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] serial: vt8500: Remove redundant use of of_match_ptr macro
Date: Wed, 22 May 2013 17:06:29 +0530
Message-ID: <1369222589-18121-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:61030 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174Ab3EVL4p (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 May 2013 07:56:45 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb11so336207pad.37
        for <linux-serial@vger.kernel.org>; Wed, 22 May 2013 04:56:45 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux@prisktech.co.nz, gregkh@linuxfoundation.org, sachin.kamat@linaro.org

'wmt_dt_ids' is always compiled in. Hence of_match_ptr is not
necessary.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/tty/serial/vt8500_serial.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 1a8bc22..48af43d 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -648,7 +648,7 @@ static struct platform_driver vt8500_platform_driver = {
 	.driver = {
 		.name = "vt8500_serial",
 		.owner = THIS_MODULE,
-		.of_match_table = of_match_ptr(wmt_dt_ids),
+		.of_match_table = wmt_dt_ids,
 	},
 };
 
-- 
1.7.9.5

