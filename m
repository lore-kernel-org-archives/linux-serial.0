From: Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH 3/5] mips: msp71xx/serial: convert to pr_foo() helpers
Date: Mon, 15 Aug 2011 10:17:53 +0100
Message-ID: <1313399875-11006-4-git-send-email-jamie@jamieiles.com>
References: <1313399875-11006-1-git-send-email-jamie@jamieiles.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45800 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674Ab1HOJSI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Aug 2011 05:18:08 -0400
Received: by wwf5 with SMTP id 5so4661742wwf.1
        for <linux-serial@vger.kernel.org>; Mon, 15 Aug 2011 02:18:07 -0700 (PDT)
In-Reply-To: <1313399875-11006-1-git-send-email-jamie@jamieiles.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: arnd@arndb.de, Jamie Iles <jamie@jamieiles.com>, Ralf Baechle <ralf@linux-mips.org>

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

