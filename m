From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 1/9] serial_cs: use pcmcia_loop_config() and pre-determined values
Date: Mon, 19 Oct 2009 01:07:27 +0200
Message-ID: <1255907255-28297-1-git-send-email-linux@dominikbrodowski.net>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:52296 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752196AbZJRXIH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 18 Oct 2009 19:08:07 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-pcmcia@lists.infradead.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-serial@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>

As the PCMCIA core already determines the multifunction count, the
ConfigBase address and the Present value, we can use them directly
instead of parsing the CIS again. By making use of pcmcia_loop_config(),
we can further remove the remaining call to pcmcia_get_first_tuple()
and friends.

CC: linux-serial@vger.kernel.org
CC: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/serial/serial_cs.c |   87 ++++++++++++--------------------------------
 1 files changed, 23 insertions(+), 64 deletions(-)

diff --git a/drivers/serial/serial_cs.c b/drivers/serial/serial_cs.c
index ff4617e..7bf02cf 100644
--- a/drivers/serial/serial_cs.c
+++ b/drivers/serial/serial_cs.c
@@ -426,21 +426,6 @@ static int setup_serial(struct pcmcia_device *handle, struct serial_info * info,
 
 /*====================================================================*/
 
-static int
-first_tuple(struct pcmcia_device *handle, tuple_t * tuple, cisparse_t * parse)
-{
-	int i;
-	i = pcmcia_get_first_tuple(handle, tuple);
-	if (i != 0)
-		return i;
-	i = pcmcia_get_tuple_data(handle, tuple);
-	if (i != 0)
-		return i;
-	return pcmcia_parse_tuple(tuple, parse);
-}
-
-/*====================================================================*/
-
 static int simple_config_check(struct pcmcia_device *p_dev,
 			       cistpl_cftable_entry_t *cf,
 			       cistpl_cftable_entry_t *dflt,
@@ -665,6 +650,25 @@ static int multi_config(struct pcmcia_device *link)
 	return 0;
 }
 
+static int serial_check_for_multi(struct pcmcia_device *p_dev,
+				  cistpl_cftable_entry_t *cf,
+				  cistpl_cftable_entry_t *dflt,
+				  unsigned int vcc,
+				  void *priv_data)
+{
+	struct serial_info *info = p_dev->priv;
+
+	if ((cf->io.nwin == 1) && (cf->io.win[0].len % 8 == 0))
+		info->multi = cf->io.win[0].len >> 3;
+
+	if ((cf->io.nwin == 2) && (cf->io.win[0].len == 8) &&
+		(cf->io.win[1].len == 8))
+		info->multi = 2;
+
+	return 0; /* break */
+}
+
+
 /*======================================================================
 
     serial_config() is scheduled to run after a CARD_INSERTION event
@@ -676,46 +680,14 @@ static int multi_config(struct pcmcia_device *link)
 static int serial_config(struct pcmcia_device * link)
 {
 	struct serial_info *info = link->priv;
-	struct serial_cfg_mem *cfg_mem;
-	tuple_t *tuple;
-	u_char *buf;
-	cisparse_t *parse;
-	cistpl_cftable_entry_t *cf;
-	int i, last_ret, last_fn;
+	int i;
 
 	DEBUG(0, "serial_config(0x%p)\n", link);
 
-	cfg_mem = kmalloc(sizeof(struct serial_cfg_mem), GFP_KERNEL);
-	if (!cfg_mem)
-		goto failed;
-
-	tuple = &cfg_mem->tuple;
-	parse = &cfg_mem->parse;
-	cf = &parse->cftable_entry;
-	buf = cfg_mem->buf;
-
-	tuple->TupleData = (cisdata_t *) buf;
-	tuple->TupleOffset = 0;
-	tuple->TupleDataMax = 255;
-	tuple->Attributes = 0;
-
-	/* Get configuration register information */
-	tuple->DesiredTuple = CISTPL_CONFIG;
-	last_ret = first_tuple(link, tuple, parse);
-	if (last_ret != 0) {
-		last_fn = ParseTuple;
-		goto cs_failed;
-	}
-	link->conf.ConfigBase = parse->config.base;
-	link->conf.Present = parse->config.rmask[0];
-
 	/* Is this a compliant multifunction card? */
-	tuple->DesiredTuple = CISTPL_LONGLINK_MFC;
-	tuple->Attributes = TUPLE_RETURN_COMMON | TUPLE_RETURN_LINK;
-	info->multi = (first_tuple(link, tuple, parse) == 0);
+	info->multi = (link->socket->functions > 1);
 
 	/* Is this a multiport card? */
-	tuple->DesiredTuple = CISTPL_MANFID;
 	info->manfid = link->manf_id;
 	info->prodid = link->card_id;
 
@@ -730,20 +702,11 @@ static int serial_config(struct pcmcia_device * link)
 
 	/* Another check for dual-serial cards: look for either serial or
 	   multifunction cards that ask for appropriate IO port ranges */
-	tuple->DesiredTuple = CISTPL_FUNCID;
 	if ((info->multi == 0) &&
 	    (link->has_func_id) &&
 	    ((link->func_id == CISTPL_FUNCID_MULTI) ||
-	     (link->func_id == CISTPL_FUNCID_SERIAL))) {
-		tuple->DesiredTuple = CISTPL_CFTABLE_ENTRY;
-		if (first_tuple(link, tuple, parse) == 0) {
-			if ((cf->io.nwin == 1) && (cf->io.win[0].len % 8 == 0))
-				info->multi = cf->io.win[0].len >> 3;
-			if ((cf->io.nwin == 2) && (cf->io.win[0].len == 8) &&
-			    (cf->io.win[1].len == 8))
-				info->multi = 2;
-		}
-	}
+	     (link->func_id == CISTPL_FUNCID_SERIAL)))
+		pcmcia_loop_config(link, serial_check_for_multi, info);
 
 	/*
 	 * Apply any multi-port quirk.
@@ -768,14 +731,10 @@ static int serial_config(struct pcmcia_device * link)
 			goto failed;
 
 	link->dev_node = &info->node[0];
-	kfree(cfg_mem);
 	return 0;
 
-cs_failed:
-	cs_error(link, last_fn, last_ret);
 failed:
 	serial_remove(link);
-	kfree(cfg_mem);
 	return -ENODEV;
 }
 
-- 
1.6.0.4

