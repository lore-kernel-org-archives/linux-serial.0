From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 17/79] mips: msp71xx/serial: convert to pr_foo() helpers
Date: Wed, 26 Oct 2011 14:12:22 +0200
Message-ID: <1319631204-23262-17-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60942 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932854Ab1JZMNf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:35 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jamie Iles <jamie@jamieiles.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jamie Iles <jamie@jamieiles.com>

Convert to pr_foo() helpers rather than printk(KERN_.*).

Acked-by: Ralf Baechle <ralf@linux-mips.org>
Acked-by: Anoop P A<Anoop_P.A@pmc-sierra.com>
Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
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
1.7.7

