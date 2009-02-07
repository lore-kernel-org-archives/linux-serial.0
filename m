From: Komuro <komurojun-mbn@nifty.com>
Subject: [PATCH] serial_cs:  support 3com 3C562 lan&modem multi-function
 card
Date: Sat, 7 Feb 2009 16:02:50 +0900
Message-ID: <20090207160250.bdebfb66.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from defg501.nifty.com ([202.248.238.128]:61307 "EHLO
	defg501.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbZBGHQJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 7 Feb 2009 02:16:09 -0500
Received: from userg500.nifty.com (userg500p.nifty.com [172.22.128.80])by defg501.nifty.com with ESMTP id n1778jEn007496
	for <linux-serial@vger.kernel.org>; Sat, 7 Feb 2009 16:08:45 +0900
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: komurojun-mbn@nifty.com


serial_cs:
  	fix serial_cs to support 3com 3C562 lan&modem multi-function
        pcmcia-card again.

        This code was deleted by Dominik(2006/12/05),
	  but actually it is necessary for this card
        to get the correct configuration register information.

Signed-off-by: Komuro <komurojun-mbn@nifty.com>

---

--- linux-2.6.28-stock/drivers/serial/serial_cs.c.orig	2009-01-01 08:03:42.000000000 +0900
+++ linux-2.6.28-stock/drivers/serial/serial_cs.c	2009-01-01 09:55:37.000000000 +0900
@@ -681,7 +681,7 @@ static int serial_config(struct pcmcia_d
 	u_char *buf;
 	cisparse_t *parse;
 	cistpl_cftable_entry_t *cf;
-	int i;
+	int i, last_ret, last_fn;
 
 	DEBUG(0, "serial_config(0x%p)\n", link);
 
@@ -699,6 +699,17 @@ static int serial_config(struct pcmcia_d
 	tuple->TupleDataMax = 255;
 	tuple->Attributes = 0;
 
+	/* Get configuration register information */
+	tuple->DesiredTuple = CISTPL_CONFIG;
+	last_ret = first_tuple(link, tuple, parse);
+	if (last_ret != 0) {
+		last_fn = ParseTuple;
+		goto cs_failed;
+   	}
+    	link->conf.ConfigBase = parse->config.base;
+   	link->conf.Present = parse->config.rmask[0];
+
+
 	/* Is this a compliant multifunction card? */
 	tuple->DesiredTuple = CISTPL_LONGLINK_MFC;
 	tuple->Attributes = TUPLE_RETURN_COMMON | TUPLE_RETURN_LINK;
@@ -761,7 +772,9 @@ static int serial_config(struct pcmcia_d
 	kfree(cfg_mem);
 	return 0;
 
- failed:
+cs_failed:
+	cs_error(link, last_fn, last_ret);
+failed:
 	serial_remove(link);
 	kfree(cfg_mem);
 	return -ENODEV;
