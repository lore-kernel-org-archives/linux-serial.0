From: Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH 3/5] mips: msp71xx/serial: convert to pr_foo() helpers
Date: Thu, 16 Jun 2011 10:19:59 +0100
Message-ID: <1308216001-5299-4-git-send-email-jamie@jamieiles.com>
References: <1308216001-5299-1-git-send-email-jamie@jamieiles.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54149 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757334Ab1FPJUO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Jun 2011 05:20:14 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so1330937wwa.1
        for <linux-serial@vger.kernel.org>; Thu, 16 Jun 2011 02:20:13 -0700 (PDT)
In-Reply-To: <1308216001-5299-1-git-send-email-jamie@jamieiles.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jamie Iles <jamie@jamieiles.com>, Ralf Baechle <ralf@linux-mips.org>

Convert to pr_foo() helpers rather than printk(KERN_.*).

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/mips/pmc-sierra/msp71xx/msp_serial.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pmc-sierra/msp71xx/msp_serial.c b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
index f726162..c3247b5 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_serial.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
@@ -65,7 +65,7 @@ void __init msp_serial_setup(void)
 	up.line         = 0;
 	up.private_data		= (void*)UART0_STATUS_REG;
 	if (early_serial_setup(&up))
-		printk(KERN_ERR "Early serial init of port 0 failed\n");
+		pr_err("Early serial init of port 0 failed\n");
 
 	/* Initialize the second serial port, if one exists */
 	switch (mips_machtype) {
@@ -89,5 +89,5 @@ void __init msp_serial_setup(void)
 	up.line         = 1;
 	up.private_data		= (void*)UART1_STATUS_REG;
 	if (early_serial_setup(&up))
-		printk(KERN_ERR "Early serial init of port 1 failed\n");
+		pr_err("Early serial init of port 1 failed\n");
 }
-- 
1.7.4.1

