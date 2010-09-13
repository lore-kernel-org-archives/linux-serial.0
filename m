From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Re: Re: Re: [PATCH 11/18] pcmcia: do not use io_req_t when
 calling pcmcia_request_io()
Date: Mon, 13 Sep 2010 21:53:53 +0200
Message-ID: <20100913195353.GA6999@comet.dominikbrodowski.net>
References: <20100904174334.GA955@isilmar-3.linta.de>
 <20100904105415.GC16589@isilmar-3.linta.de>
 <20100830062724.GA2387@comet.dominikbrodowski.net>
 <13928942.191731283256326809.komurojun-mbn@nifty.com>
 <29547163.98341283601820252.komurojun-mbn@nifty.com>
 <8520532.194511283862270702.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from isilmar-3.linta.de ([188.40.101.200]:41865 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755374Ab0IMTyD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Sep 2010 15:54:03 -0400
Content-Disposition: inline
In-Reply-To: <8520532.194511283862270702.komurojun-mbn@nifty.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Komuro <komurojun-mbn@nifty.com>
Cc: linux-pcmcia@lists.infradead.org, linux-serial@vger.kernel.org

Dear Komuro,

does the attached patch help with 2.6.36-rc4?

Best,
	Dominik

commit 1852d6b8c3fa2d1765f66cd7d96a8c6bf9f01997
Author: Dominik Brodowski <linux@dominikbrodowski.net>
Date:   Mon Aug 30 08:18:54 2010 +0200

    pcmcia serial_cs.c: fix multifunction card handling
    
    We shouldn't overwrite pre-set values, and we should also
    set the port address to the beginning, and not the end of
    the 8-port range.
    
    Reported-by: Komuro <komurojun-mbn@nifty.com>
    Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

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
