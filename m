From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 12/16] pcmcia: use dynamic debug infrastructure, deprecate CS_CHECK (serial_cs)
Date: Sat, 24 Oct 2009 21:43:02 +0200
Message-ID: <1256413386-20501-12-git-send-email-linux@dominikbrodowski.net>
References: <20091024194219.GA19546@comet.dominikbrodowski.net>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:55650 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751676AbZJXTnM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 24 Oct 2009 15:43:12 -0400
In-Reply-To: <20091024194219.GA19546@comet.dominikbrodowski.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-pcmcia@lists.infradead.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-serial@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>

Convert PCMCIA drivers to use the dynamic debug infrastructure, instead of
requiring manual settings of PCMCIA_DEBUG.

Also, remove all usages of the CS_CHECK macro and replace them with proper
Linux style calling and return value checking. The extra error reporting may
be dropped, as the PCMCIA core already complains about any (non-driver-author)
errors.

CC: linux-serial@vger.kernel.org
CC: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/serial/serial_cs.c |   53 ++++++++++++++-----------------------------
 1 files changed, 17 insertions(+), 36 deletions(-)

diff --git a/drivers/serial/serial_cs.c b/drivers/serial/serial_cs.c
index 7bf02cf..3b31bee 100644
--- a/drivers/serial/serial_cs.c
+++ b/drivers/serial/serial_cs.c
@@ -54,14 +54,6 @@
 
 #include "8250.h"
 
-#ifdef PCMCIA_DEBUG
-static int pc_debug = PCMCIA_DEBUG;
-module_param(pc_debug, int, 0644);
-#define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
-static char *version = "serial_cs.c 1.134 2002/05/04 05:48:53 (David Hinds)";
-#else
-#define DEBUG(n, args...)
-#endif
 
 /*====================================================================*/
 
@@ -121,24 +113,20 @@ static void quirk_setup_brainboxes_0104(struct pcmcia_device *link, struct uart_
 static int quirk_post_ibm(struct pcmcia_device *link)
 {
 	conf_reg_t reg = { 0, CS_READ, 0x800, 0 };
-	int last_ret, last_fn;
+	int ret;
+
+	ret = pcmcia_access_configuration_register(link, &reg);
+	if (ret)
+		goto failed;
 
-	last_ret = pcmcia_access_configuration_register(link, &reg);
-	if (last_ret) {
-		last_fn = AccessConfigurationRegister;
-		goto cs_failed;
-	}
 	reg.Action = CS_WRITE;
 	reg.Value = reg.Value | 1;
-	last_ret = pcmcia_access_configuration_register(link, &reg);
-	if (last_ret) {
-		last_fn = AccessConfigurationRegister;
-		goto cs_failed;
-	}
+	ret = pcmcia_access_configuration_register(link, &reg);
+	if (ret)
+		goto failed;
 	return 0;
 
- cs_failed:
-	cs_error(link, last_fn, last_ret);
+ failed:
 	return -ENODEV;
 }
 
@@ -283,7 +271,7 @@ static void serial_remove(struct pcmcia_device *link)
 	struct serial_info *info = link->priv;
 	int i;
 
-	DEBUG(0, "serial_release(0x%p)\n", link);
+	dev_dbg(&link->dev, "serial_release\n");
 
 	/*
 	 * Recheck to see if the device is still configured.
@@ -334,7 +322,7 @@ static int serial_probe(struct pcmcia_device *link)
 {
 	struct serial_info *info;
 
-	DEBUG(0, "serial_attach()\n");
+	dev_dbg(&link->dev, "serial_attach()\n");
 
 	/* Create new serial device */
 	info = kzalloc(sizeof (*info), GFP_KERNEL);
@@ -370,7 +358,7 @@ static void serial_detach(struct pcmcia_device *link)
 {
 	struct serial_info *info = link->priv;
 
-	DEBUG(0, "serial_detach(0x%p)\n", link);
+	dev_dbg(&link->dev, "serial_detach\n");
 
 	/*
 	 * Ensure any outstanding scheduled tasks are completed.
@@ -507,15 +495,13 @@ static int simple_config(struct pcmcia_device *link)
 
 	printk(KERN_NOTICE
 	       "serial_cs: no usable port range found, giving up\n");
-	cs_error(link, RequestIO, i);
 	return -1;
 
 found_port:
 	i = pcmcia_request_irq(link, &link->irq);
-	if (i != 0) {
-		cs_error(link, RequestIRQ, i);
+	if (i != 0)
 		link->irq.AssignedIRQ = 0;
-	}
+
 	if (info->multi && (info->manfid == MANFID_3COM))
 		link->conf.ConfigIndex &= ~(0x08);
 
@@ -526,10 +512,8 @@ found_port:
 		info->quirk->config(link);
 
 	i = pcmcia_request_configuration(link, &link->conf);
-	if (i != 0) {
-		cs_error(link, RequestConfiguration, i);
+	if (i != 0)
 		return -1;
-	}
 	return setup_serial(link, info, link->io.BasePort1, link->irq.AssignedIRQ);
 }
 
@@ -598,7 +582,6 @@ static int multi_config(struct pcmcia_device *link)
 		/* FIXME: comment does not fit, error handling does not fit */
 		printk(KERN_NOTICE
 		       "serial_cs: no usable port range found, giving up\n");
-		cs_error(link, RequestIRQ, i);
 		link->irq.AssignedIRQ = 0;
 	}
 
@@ -609,10 +592,8 @@ static int multi_config(struct pcmcia_device *link)
 		info->quirk->config(link);
 
 	i = pcmcia_request_configuration(link, &link->conf);
-	if (i != 0) {
-		cs_error(link, RequestConfiguration, i);
+	if (i != 0)
 		return -ENODEV;
-	}
 
 	/* The Oxford Semiconductor OXCF950 cards are in fact single-port:
 	 * 8 registers are for the UART, the others are extra registers.
@@ -682,7 +663,7 @@ static int serial_config(struct pcmcia_device * link)
 	struct serial_info *info = link->priv;
 	int i;
 
-	DEBUG(0, "serial_config(0x%p)\n", link);
+	dev_dbg(&link->dev, "serial_config\n");
 
 	/* Is this a compliant multifunction card? */
 	info->multi = (link->socket->functions > 1);
-- 
1.6.0.4

