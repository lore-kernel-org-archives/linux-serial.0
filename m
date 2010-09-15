From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 1/3] pcmcia serial_cs.c: fix multifunction card handling
Date: Wed, 15 Sep 2010 18:25:55 +0200
Message-ID: <1284567957-15709-1-git-send-email-linux@dominikbrodowski.net>
References: <20100915162503.GA15043@comet.dominikbrodowski.net>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from isilmar-3.linta.de ([188.40.101.200]:36627 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753784Ab0IOQaH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Sep 2010 12:30:07 -0400
In-Reply-To: <20100915162503.GA15043@comet.dominikbrodowski.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-pcmcia@lists.infradead.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-serial@vger.kernel.org

We shouldn't overwrite pre-set values, and we should also
set the port address to the beginning, and not the end of
the 8-port range.

CC: linux-serial@vger.kernel.org
Reported-by: Komuro <komurojun-mbn@nifty.com>
Hardware-supplied-by: Jochen Frieling <j.frieling@pengutronix.de>
Tested-by: Wolfram Sang <w.sang@pengutronix.de>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/serial/serial_cs.c |   62 +++++++++++++++++++++++++------------------
 1 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/serial/serial_cs.c b/drivers/serial/serial_cs.c
index 141c695..7d475b2 100644
--- a/drivers/serial/serial_cs.c
+++ b/drivers/serial/serial_cs.c
@@ -335,8 +335,6 @@ static int serial_probe(struct pcmcia_device *link)
 	info->p_dev = link;
 	link->priv = info;
 
-	link->resource[0]->flags |= IO_DATA_PATH_WIDTH_8;
-	link->resource[0]->end = 8;
 	link->conf.Attributes = CONF_ENABLE_IRQ;
 	if (do_sound) {
 		link->conf.Attributes |= CONF_ENABLE_SPKR;
@@ -411,6 +409,27 @@ static int setup_serial(struct pcmcia_device *handle, struct serial_info * info,
 
 /*====================================================================*/
 
+static int pfc_config(struct pcmcia_device *p_dev)
+{
+	unsigned int port = 0;
+	struct serial_info *info = p_dev->priv;
+
+	if ((p_dev->resource[1]->end != 0) &&
+		(resource_size(p_dev->resource[1]) == 8)) {
+		port = p_dev->resource[1]->start;
+		info->slave = 1;
+	} else if ((info->manfid == MANFID_OSITECH) &&
+		(resource_size(p_dev->resource[0]) == 0x40)) {
+		port = p_dev->resource[0]->start + 0x28;
+		info->slave = 1;
+	}
+	if (info->slave)
+		return setup_serial(p_dev, info, port, p_dev->irq);
+
+	dev_warn(&p_dev->dev, "no usable port range found, giving up\n");
+	return -ENODEV;
+}
+
 static int simple_config_check(struct pcmcia_device *p_dev,
 			       cistpl_cftable_entry_t *cf,
 			       cistpl_cftable_entry_t *dflt,
@@ -461,23 +480,8 @@ static int simple_config(struct pcmcia_device *link)
 	struct serial_info *info = link->priv;
 	int i = -ENODEV, try;
 
-	/* If the card is already configured, look up the port and irq */
-	if (link->function_config) {
-		unsigned int port = 0;
-		if ((link->resource[1]->end != 0) &&
-			(resource_size(link->resource[1]) == 8)) {
-			port = link->resource[1]->end;
-			info->slave = 1;
-		} else if ((info->manfid == MANFID_OSITECH) &&
-			(resource_size(link->resource[0]) == 0x40)) {
-			port = link->resource[0]->start + 0x28;
-			info->slave = 1;
-		}
-		if (info->slave) {
-			return setup_serial(link, info, port,
-					    link->irq);
-		}
-	}
+	link->resource[0]->flags |= IO_DATA_PATH_WIDTH_8;
+	link->resource[0]->end = 8;
 
 	/* First pass: look for a config entry that looks normal.
 	 * Two tries: without IO aliases, then with aliases */
@@ -491,8 +495,7 @@ static int simple_config(struct pcmcia_device *link)
 	if (!pcmcia_loop_config(link, simple_config_check_notpicky, NULL))
 		goto found_port;
 
-	printk(KERN_NOTICE
-	       "serial_cs: no usable port range found, giving up\n");
+	dev_warn(&link->dev, "no usable port range found, giving up\n");
 	return -1;
 
 found_port:
@@ -558,6 +561,7 @@ static int multi_config(struct pcmcia_device *link)
 	int i, base2 = 0;
 
 	/* First, look for a generic full-sized window */
+	link->resource[0]->flags |= IO_DATA_PATH_WIDTH_8;
 	link->resource[0]->end = info->multi * 8;
 	if (pcmcia_loop_config(link, multi_config_check, &base2)) {
 		/* If that didn't work, look for two windows */
@@ -565,15 +569,14 @@ static int multi_config(struct pcmcia_device *link)
 		info->multi = 2;
 		if (pcmcia_loop_config(link, multi_config_check_notpicky,
 				       &base2)) {
-			printk(KERN_NOTICE "serial_cs: no usable port range"
+			dev_warn(&link->dev, "no usable port range "
 			       "found, giving up\n");
 			return -ENODEV;
 		}
 	}
 
 	if (!link->irq)
-		dev_warn(&link->dev,
-			"serial_cs: no usable IRQ found, continuing...\n");
+		dev_warn(&link->dev, "no usable IRQ found, continuing...\n");
 
 	/*
 	 * Apply any configuration quirks.
@@ -675,6 +678,7 @@ static int serial_config(struct pcmcia_device * link)
 	   multifunction cards that ask for appropriate IO port ranges */
 	if ((info->multi == 0) &&
 	    (link->has_func_id) &&
+	    (link->socket->pcmcia_pfc == 0) &&
 	    ((link->func_id == CISTPL_FUNCID_MULTI) ||
 	     (link->func_id == CISTPL_FUNCID_SERIAL)))
 		pcmcia_loop_config(link, serial_check_for_multi, info);
@@ -685,7 +689,13 @@ static int serial_config(struct pcmcia_device * link)
 	if (info->quirk && info->quirk->multi != -1)
 		info->multi = info->quirk->multi;
 
-	if (info->multi > 1)
+	dev_info(&link->dev,
+		"trying to set up [0x%04x:0x%04x] (pfc: %d, multi: %d, quirk: %p)\n",
+		link->manf_id, link->card_id,
+		link->socket->pcmcia_pfc, info->multi, info->quirk);
+	if (link->socket->pcmcia_pfc)
+		i = pfc_config(link);
+	else if (info->multi > 1)
 		i = multi_config(link);
 	else
 		i = simple_config(link);
@@ -704,7 +714,7 @@ static int serial_config(struct pcmcia_device * link)
 	return 0;
 
 failed:
-	dev_warn(&link->dev, "serial_cs: failed to initialize\n");
+	dev_warn(&link->dev, "failed to initialize\n");
 	serial_remove(link);
 	return -ENODEV;
 }
-- 
1.7.0.4

