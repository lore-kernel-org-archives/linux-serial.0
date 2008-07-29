From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [RFC] [PATCH 7/7] pcmcia: use pcmcia_loop_config in misc pcmcia
	drivers
Date: Tue, 29 Jul 2008 09:21:43 +0200
Message-ID: <20080729072143.GJ27385@comet.dominikbrodowski.net>
References: <20080729071539.GB27385@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:43274 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752801AbYG2HWM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Jul 2008 03:22:12 -0400
Content-Disposition: inline
In-Reply-To: <20080729071539.GB27385@comet.dominikbrodowski.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-pcmcia@lists.infradead.org
Cc: Harald Welte <laforge@gnumonks.org>, linux-parport@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>, Ed Okerson <eokerson@quicknet.net>, linux-serial@vger.kernel.org

Use the config loop helper in misc pcmcia drivers.

CC: Harald Welte <laforge@gnumonks.org>
CC: <linux-parport@lists.infradead.org>
CC: Russell King <rmk+kernel@arm.linux.org.uk>
CC: Ed Okerson <eokerson@quicknet.net>
CC: linux-serial@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/char/pcmcia/cm4000_cs.c |   73 ++++-------
 drivers/char/pcmcia/cm4040_cs.c |   76 +++++-------
 drivers/parport/parport_cs.c    |   73 +++++------
 drivers/serial/serial_cs.c      |  263 ++++++++++++++++-----------------------
 drivers/telephony/ixj_pcmcia.c  |   76 +++++------
 5 files changed, 231 insertions(+), 330 deletions(-)

diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index f070ae7..47adec4 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -1759,65 +1759,40 @@ static void cmm_cm4000_release(struct pcmcia_device * link)
 
 /*==== Interface to PCMCIA Layer =======================================*/
 
+static int cm4000_config_check(struct pcmcia_device *p_dev,
+			       cistpl_cftable_entry_t *cfg,
+			       void *priv_data)
+{
+	p_dev->conf.ConfigIndex = cfg->index;
+
+	if (!cfg->io.nwin)
+		return -ENODEV;
+
+	/* Get the IOaddr */
+	p_dev->io.BasePort1 = cfg->io.win[0].base;
+	p_dev->io.NumPorts1 = cfg->io.win[0].len;
+	p_dev->io.Attributes1 = IO_DATA_PATH_WIDTH_AUTO;
+	if (!(cfg->io.flags & CISTPL_IO_8BIT))
+		p_dev->io.Attributes1 = IO_DATA_PATH_WIDTH_16;
+	if (!(cfg->io.flags & CISTPL_IO_16BIT))
+		p_dev->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
+	p_dev->io.IOAddrLines = cfg->io.flags & CISTPL_IO_LINES_MASK;
+
+	return pcmcia_request_io(p_dev, &p_dev->io);
+}
+
 static int cm4000_config(struct pcmcia_device * link, int devno)
 {
 	struct cm4000_dev *dev;
-	tuple_t tuple;
-	cisparse_t parse;
-	u_char buf[64];
-	int fail_fn, fail_rc;
-	int rc;
 
 	/* read the config-tuples */
-	tuple.Attributes = 0;
-	tuple.TupleData = buf;
-	tuple.TupleDataMax = sizeof(buf);
-	tuple.TupleOffset = 0;
-
-	link->io.BasePort2 = 0;
-	link->io.NumPorts2 = 0;
-	link->io.Attributes2 = 0;
-	tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
-	for (rc = pcmcia_get_first_tuple(link, &tuple);
-	     rc == CS_SUCCESS; rc = pcmcia_get_next_tuple(link, &tuple)) {
-
-		rc = pcmcia_get_tuple_data(link, &tuple);
-		if (rc != CS_SUCCESS)
-			continue;
-		rc = pcmcia_parse_tuple(link, &tuple, &parse);
-		if (rc != CS_SUCCESS)
-			continue;
-
-		link->conf.ConfigIndex = parse.cftable_entry.index;
-
-		if (!parse.cftable_entry.io.nwin)
-			continue;
-
-		/* Get the IOaddr */
-		link->io.BasePort1 = parse.cftable_entry.io.win[0].base;
-		link->io.NumPorts1 = parse.cftable_entry.io.win[0].len;
-		link->io.Attributes1 = IO_DATA_PATH_WIDTH_AUTO;
-		if (!(parse.cftable_entry.io.flags & CISTPL_IO_8BIT))
-			link->io.Attributes1 = IO_DATA_PATH_WIDTH_16;
-		if (!(parse.cftable_entry.io.flags & CISTPL_IO_16BIT))
-			link->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
-		link->io.IOAddrLines = parse.cftable_entry.io.flags
-		    & CISTPL_IO_LINES_MASK;
-
-		rc = pcmcia_request_io(link, &link->io);
-		if (rc == CS_SUCCESS)
-			break;	/* we are done */
-	}
-	if (rc != CS_SUCCESS)
+	if (pcmcia_loop_config(link, cm4000_config_check, NULL))
 		goto cs_release;
 
 	link->conf.IntType = 00000002;
 
-	if ((fail_rc =
-	     pcmcia_request_configuration(link, &link->conf)) != CS_SUCCESS) {
-		fail_fn = RequestConfiguration;
+	if (pcmcia_request_configuration(link, &link->conf))
 		goto cs_release;
-	}
 
 	dev = link->priv;
 	sprintf(dev->node.dev_name, DEVICE_NAME "%d", devno);
diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_cs.c
index 0b5934b..e0f5d8c 100644
--- a/drivers/char/pcmcia/cm4040_cs.c
+++ b/drivers/char/pcmcia/cm4040_cs.c
@@ -526,65 +526,49 @@ static void cm4040_reader_release(struct pcmcia_device *link)
 	return;
 }
 
-static int reader_config(struct pcmcia_device *link, int devno)
+static int cm4040_config_check(struct pcmcia_device *p_dev,
+			       cistpl_cftable_entry_t *cfg,
+			       void *priv_data)
 {
-	struct reader_dev *dev;
-	tuple_t tuple;
-	cisparse_t parse;
-	u_char buf[64];
-	int fail_fn, fail_rc;
 	int rc;
+	p_dev->conf.ConfigIndex = cfg->index;
+
+	if (!cfg->io.nwin)
+		return -ENODEV;
 
-	tuple.Attributes = 0;
-	tuple.TupleData = buf;
-	tuple.TupleDataMax = sizeof(buf);
- 	tuple.TupleOffset = 0;
+	/* Get the IOaddr */
+	p_dev->io.BasePort1 = cfg->io.win[0].base;
+	p_dev->io.NumPorts1 = cfg->io.win[0].len;
+	p_dev->io.Attributes1 = IO_DATA_PATH_WIDTH_AUTO;
+	if (!(cfg->io.flags & CISTPL_IO_8BIT))
+		p_dev->io.Attributes1 = IO_DATA_PATH_WIDTH_16;
+	if (!(cfg->io.flags & CISTPL_IO_16BIT))
+		p_dev->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
+	p_dev->io.IOAddrLines = cfg->io.flags & CISTPL_IO_LINES_MASK;
+
+	rc = pcmcia_request_io(p_dev, &p_dev->io);
+	dev_printk(KERN_INFO, &handle_to_dev(p_dev),
+		   "pcmcia_request_io returned 0x%x\n", rc);
+	return rc;
+}
+
+
+static int reader_config(struct pcmcia_device *link, int devno)
+{
+	struct reader_dev *dev;
+	int fail_rc;
 
 	link->io.BasePort2 = 0;
 	link->io.NumPorts2 = 0;
 	link->io.Attributes2 = 0;
-	tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
-	for (rc = pcmcia_get_first_tuple(link, &tuple);
-	     rc == CS_SUCCESS;
-	     rc = pcmcia_get_next_tuple(link, &tuple)) {
-		rc = pcmcia_get_tuple_data(link, &tuple);
-		if (rc != CS_SUCCESS)
-			continue;
-		rc = pcmcia_parse_tuple(link, &tuple, &parse);
-		if (rc != CS_SUCCESS)
-			continue;
-
-		link->conf.ConfigIndex = parse.cftable_entry.index;
-
-		if (!parse.cftable_entry.io.nwin)
-			continue;
-
-		link->io.BasePort1 = parse.cftable_entry.io.win[0].base;
-		link->io.NumPorts1 = parse.cftable_entry.io.win[0].len;
-		link->io.Attributes1 = IO_DATA_PATH_WIDTH_AUTO;
-		if (!(parse.cftable_entry.io.flags & CISTPL_IO_8BIT))
-			link->io.Attributes1 = IO_DATA_PATH_WIDTH_16;
-		if (!(parse.cftable_entry.io.flags & CISTPL_IO_16BIT))
-			link->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
-		link->io.IOAddrLines = parse.cftable_entry.io.flags
-						& CISTPL_IO_LINES_MASK;
-		rc = pcmcia_request_io(link, &link->io);
-
-		dev_printk(KERN_INFO, &handle_to_dev(link), "foo");
-		if (rc == CS_SUCCESS)
-			break;
-		else
-			dev_printk(KERN_INFO, &handle_to_dev(link),
-				   "pcmcia_request_io failed 0x%x\n", rc);
-	}
-	if (rc != CS_SUCCESS)
+
+	if (pcmcia_loop_config(link, cm4040_config_check, NULL))
 		goto cs_release;
 
 	link->conf.IntType = 00000002;
 
 	if ((fail_rc = pcmcia_request_configuration(link,&link->conf))
 								!=CS_SUCCESS) {
-		fail_fn = RequestConfiguration;
 		dev_printk(KERN_INFO, &handle_to_dev(link),
 			   "pcmcia_request_configuration failed 0x%x\n",
 			   fail_rc);
diff --git a/drivers/parport/parport_cs.c b/drivers/parport/parport_cs.c
index 802a81d..4d94ed3 100644
--- a/drivers/parport/parport_cs.c
+++ b/drivers/parport/parport_cs.c
@@ -149,52 +149,49 @@ static void parport_detach(struct pcmcia_device *link)
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
+static int parport_config_check(struct pcmcia_device *p_dev,
+				cistpl_cftable_entry_t *cfg,
+				void *priv_data)
+{
+	cistpl_cftable_entry_t *dflt = priv_data;
+	if ((cfg->io.nwin > 0) || (dflt->io.nwin > 0)) {
+		cistpl_io_t *io = (cfg->io.nwin) ? &cfg->io : &dflt->io;
+		p_dev->conf.ConfigIndex = cfg->index;
+		if (epp_mode)
+			p_dev->conf.ConfigIndex |= FORCE_EPP_MODE;
+		p_dev->io.BasePort1 = io->win[0].base;
+		p_dev->io.NumPorts1 = io->win[0].len;
+		p_dev->io.IOAddrLines = io->flags & CISTPL_IO_LINES_MASK;
+		if (io->nwin == 2) {
+			p_dev->io.BasePort2 = io->win[1].base;
+			p_dev->io.NumPorts2 = io->win[1].len;
+		}
+		if (pcmcia_request_io(p_dev, &p_dev->io) != 0)
+			goto next_entry;
+		return 0;
+	}
+
+next_entry:
+	if (cfg->flags & CISTPL_CFTABLE_DEFAULT)
+		*dflt = *cfg;
+	return -ENODEV;
+}
+
 static int parport_config(struct pcmcia_device *link)
 {
     parport_info_t *info = link->priv;
-    tuple_t tuple;
-    u_short buf[128];
-    cisparse_t parse;
-    cistpl_cftable_entry_t *cfg = &parse.cftable_entry;
     cistpl_cftable_entry_t dflt = { 0 };
     struct parport *p;
     int last_ret, last_fn;
-    
+
     DEBUG(0, "parport_config(0x%p)\n", link);
-    
-    tuple.TupleData = (cisdata_t *)buf;
-    tuple.TupleOffset = 0; tuple.TupleDataMax = 255;
-    tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
-    tuple.Attributes = 0;
-    CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(link, &tuple));
-    while (1) {
-	if (pcmcia_get_tuple_data(link, &tuple) != 0 ||
-		pcmcia_parse_tuple(link, &tuple, &parse) != 0)
-	    goto next_entry;
-
-	if ((cfg->io.nwin > 0) || (dflt.io.nwin > 0)) {
-	    cistpl_io_t *io = (cfg->io.nwin) ? &cfg->io : &dflt.io;
-	    link->conf.ConfigIndex = cfg->index;
-	    if (epp_mode)
-		link->conf.ConfigIndex |= FORCE_EPP_MODE;
-	    link->io.BasePort1 = io->win[0].base;
-	    link->io.NumPorts1 = io->win[0].len;
-	    link->io.IOAddrLines = io->flags & CISTPL_IO_LINES_MASK;
-	    if (io->nwin == 2) {
-		link->io.BasePort2 = io->win[1].base;
-		link->io.NumPorts2 = io->win[1].len;
-	    }
-	    if (pcmcia_request_io(link, &link->io) != 0)
-		goto next_entry;
-	    /* If we've got this far, we're done */
-	    break;
-	}
-	
-    next_entry:
-	if (cfg->flags & CISTPL_CFTABLE_DEFAULT) dflt = *cfg;
-	CS_CHECK(GetNextTuple, pcmcia_get_next_tuple(link, &tuple));
+
+    last_ret = pcmcia_loop_config(link, parport_config_check, &dflt);
+    if (last_ret) {
+	    cs_error(link, RequestIO, last_ret);
+	    goto failed;
     }
-    
+
     CS_CHECK(RequestIRQ, pcmcia_request_irq(link, &link->irq));
     CS_CHECK(RequestConfiguration, pcmcia_request_configuration(link, &link->conf));
 
diff --git a/drivers/serial/serial_cs.c b/drivers/serial/serial_cs.c
index 164d2a4..f7d88bb 100644
--- a/drivers/serial/serial_cs.c
+++ b/drivers/serial/serial_cs.c
@@ -439,43 +439,56 @@ first_tuple(struct pcmcia_device *handle, tuple_t * tuple, cisparse_t * parse)
 	return pcmcia_parse_tuple(handle, tuple, parse);
 }
 
-static int
-next_tuple(struct pcmcia_device *handle, tuple_t * tuple, cisparse_t * parse)
+/*====================================================================*/
+
+static int simple_config_check(struct pcmcia_device *p_dev,
+			       cistpl_cftable_entry_t *cf,
+			       void *priv_data)
 {
-	int i;
-	i = pcmcia_get_next_tuple(handle, tuple);
-	if (i != CS_SUCCESS)
-		return CS_NO_MORE_ITEMS;
-	i = pcmcia_get_tuple_data(handle, tuple);
-	if (i != CS_SUCCESS)
-		return i;
-	return pcmcia_parse_tuple(handle, tuple, parse);
+	static const int size_table[2] = { 8, 16 };
+	unsigned long try = (unsigned long) priv_data;
+
+	if (cf->vpp1.present & (1 << CISTPL_POWER_VNOM))
+		p_dev->conf.Vpp =
+			cf->vpp1.param[CISTPL_POWER_VNOM] / 10000;
+
+	if ((cf->io.nwin > 0) && (cf->io.win[0].len == size_table[(try >> 1)])
+	    && (cf->io.win[0].base != 0)) {
+		p_dev->conf.ConfigIndex = cf->index;
+		p_dev->io.BasePort1 = cf->io.win[0].base;
+		p_dev->io.IOAddrLines = ((try & 0x1) == 0) ?
+			16 : cf->io.flags & CISTPL_IO_LINES_MASK;
+		if (!pcmcia_request_io(p_dev, &p_dev->io))
+			return 0;
+	}
+	return -EINVAL;
 }
 
-/*====================================================================*/
+static int simple_config_check_notpicky(struct pcmcia_device *p_dev,
+					cistpl_cftable_entry_t *cf,
+					void *priv_data)
+{
+	static const unsigned int base[5] = { 0x3f8, 0x2f8, 0x3e8, 0x2e8, 0x0 };
+	int j;
+
+	if ((cf->io.nwin > 0) && ((cf->io.flags & CISTPL_IO_LINES_MASK) <= 3)) {
+		p_dev->conf.ConfigIndex = cf->index;
+		for (j = 0; j < 5; j++) {
+			p_dev->io.BasePort1 = base[j];
+			p_dev->io.IOAddrLines = base[j] ? 16 : 3;
+			if (!pcmcia_request_io(p_dev, &p_dev->io))
+				return 0;
+		}
+	}
+	return -ENODEV;
+}
 
 static int simple_config(struct pcmcia_device *link)
 {
-	static const unsigned int base[5] = { 0x3f8, 0x2f8, 0x3e8, 0x2e8, 0x0 };
-	static const int size_table[2] = { 8, 16 };
 	struct serial_info *info = link->priv;
-	struct serial_cfg_mem *cfg_mem;
-	tuple_t *tuple;
-	u_char *buf;
-	cisparse_t *parse;
-	cistpl_cftable_entry_t *cf;
 	config_info_t config;
-	int i, j, try;
-	int s;
-
-	cfg_mem = kmalloc(sizeof(struct serial_cfg_mem), GFP_KERNEL);
-	if (!cfg_mem)
-		return -1;
-
-	tuple = &cfg_mem->tuple;
-	parse = &cfg_mem->parse;
-	cf = &parse->cftable_entry;
-	buf = cfg_mem->buf;
+	int i;
+	unsigned long try;
 
 	/* If the card is already configured, look up the port and irq */
 	i = pcmcia_get_configuration_info(link, &config);
@@ -490,70 +503,28 @@ static int simple_config(struct pcmcia_device *link)
 			info->slave = 1;
 		}
 		if (info->slave) {
-			kfree(cfg_mem);
 			return setup_serial(link, info, port, config.AssignedIRQ);
 		}
 	}
 
-	/* First pass: look for a config entry that looks normal. */
-	tuple->TupleData = (cisdata_t *) buf;
-	tuple->TupleOffset = 0;
-	tuple->TupleDataMax = 255;
-	tuple->Attributes = 0;
-	tuple->DesiredTuple = CISTPL_CFTABLE_ENTRY;
-	/* Two tries: without IO aliases, then with aliases */
-	for (s = 0; s < 2; s++) {
-		for (try = 0; try < 2; try++) {
-			i = first_tuple(link, tuple, parse);
-			while (i != CS_NO_MORE_ITEMS) {
-				if (i != CS_SUCCESS)
-					goto next_entry;
-				if (cf->vpp1.present & (1 << CISTPL_POWER_VNOM))
-					link->conf.Vpp =
-					    cf->vpp1.param[CISTPL_POWER_VNOM] / 10000;
-				if ((cf->io.nwin > 0) && (cf->io.win[0].len == size_table[s]) &&
-					    (cf->io.win[0].base != 0)) {
-					link->conf.ConfigIndex = cf->index;
-					link->io.BasePort1 = cf->io.win[0].base;
-					link->io.IOAddrLines = (try == 0) ?
-					    16 : cf->io.flags & CISTPL_IO_LINES_MASK;
-					i = pcmcia_request_io(link, &link->io);
-					if (i == CS_SUCCESS)
-						goto found_port;
-				}
-next_entry:
-				i = next_tuple(link, tuple, parse);
-			}
-		}
-	}
+	/* First pass: look for a config entry that looks normal.
+	 * Two tries: without IO aliases, then with aliases */
+	for (try = 0; try < 4; try++)
+		if(!pcmcia_loop_config(link, simple_config_check, (void *) try))
+			goto found_port;
+
 	/* Second pass: try to find an entry that isn't picky about
 	   its base address, then try to grab any standard serial port
 	   address, and finally try to get any free port. */
-	i = first_tuple(link, tuple, parse);
-	while (i != CS_NO_MORE_ITEMS) {
-		if ((i == CS_SUCCESS) && (cf->io.nwin > 0) &&
-		    ((cf->io.flags & CISTPL_IO_LINES_MASK) <= 3)) {
-			link->conf.ConfigIndex = cf->index;
-			for (j = 0; j < 5; j++) {
-				link->io.BasePort1 = base[j];
-				link->io.IOAddrLines = base[j] ? 16 : 3;
-				i = pcmcia_request_io(link, &link->io);
-				if (i == CS_SUCCESS)
-					goto found_port;
-			}
-		}
-		i = next_tuple(link, tuple, parse);
-	}
+	if (!pcmcia_loop_config(link, simple_config_check_notpicky, NULL))
+		goto found_port;
 
-      found_port:
-	if (i != CS_SUCCESS) {
-		printk(KERN_NOTICE
-		       "serial_cs: no usable port range found, giving up\n");
-		cs_error(link, RequestIO, i);
-		kfree(cfg_mem);
-		return -1;
-	}
+	printk(KERN_NOTICE
+	       "serial_cs: no usable port range found, giving up\n");
+	cs_error(link, RequestIO, i);
+	return -1;
 
+found_port:
 	i = pcmcia_request_irq(link, &link->irq);
 	if (i != CS_SUCCESS) {
 		cs_error(link, RequestIRQ, i);
@@ -571,86 +542,72 @@ next_entry:
 	i = pcmcia_request_configuration(link, &link->conf);
 	if (i != CS_SUCCESS) {
 		cs_error(link, RequestConfiguration, i);
-		kfree(cfg_mem);
 		return -1;
 	}
-	kfree(cfg_mem);
 	return setup_serial(link, info, link->io.BasePort1, link->irq.AssignedIRQ);
 }
 
-static int multi_config(struct pcmcia_device * link)
+static int multi_config_check(struct pcmcia_device *p_dev,
+			      cistpl_cftable_entry_t *cf,
+			      void *priv_data)
 {
-	struct serial_info *info = link->priv;
-	struct serial_cfg_mem *cfg_mem;
-	tuple_t *tuple;
-	u_char *buf;
-	cisparse_t *parse;
-	cistpl_cftable_entry_t *cf;
-	int i, rc, base2 = 0;
+	int *base2 = priv_data;
+
+	/* The quad port cards have bad CIS's, so just look for a
+	   window larger than 8 ports and assume it will be right */
+	if ((cf->io.nwin == 1) && (cf->io.win[0].len > 8)) {
+		p_dev->conf.ConfigIndex = cf->index;
+		p_dev->io.BasePort1 = cf->io.win[0].base;
+		p_dev->io.IOAddrLines = cf->io.flags & CISTPL_IO_LINES_MASK;
+		if (!pcmcia_request_io(p_dev, &p_dev->io)) {
+			*base2 = p_dev->io.BasePort1 + 8;
+			return 0;
+		}
+	}
+	return -ENODEV;
+}
 
-	cfg_mem = kmalloc(sizeof(struct serial_cfg_mem), GFP_KERNEL);
-	if (!cfg_mem)
-		return -1;
-	tuple = &cfg_mem->tuple;
-	parse = &cfg_mem->parse;
-	cf = &parse->cftable_entry;
-	buf = cfg_mem->buf;
+static int multi_config_check_notpicky(struct pcmcia_device *p_dev,
+				       cistpl_cftable_entry_t *cf,
+				       void *priv_data)
+{
+	int *base2 = priv_data;
+
+	if (cf->io.nwin == 2) {
+		p_dev->conf.ConfigIndex = cf->index;
+		p_dev->io.BasePort1 = cf->io.win[0].base;
+		p_dev->io.BasePort2 = cf->io.win[1].base;
+		p_dev->io.IOAddrLines = cf->io.flags & CISTPL_IO_LINES_MASK;
+		if (!pcmcia_request_io(p_dev, &p_dev->io)) {
+			*base2 = p_dev->io.BasePort2;
+			return 0;
+		}
+	}
+	return -ENODEV;
+}
 
-	tuple->TupleData = (cisdata_t *) buf;
-	tuple->TupleOffset = 0;
-	tuple->TupleDataMax = 255;
-	tuple->Attributes = 0;
-	tuple->DesiredTuple = CISTPL_CFTABLE_ENTRY;
+static int multi_config(struct pcmcia_device * link)
+{
+	struct serial_info *info = link->priv;
+	int i, base2 = 0;
 
 	/* First, look for a generic full-sized window */
 	link->io.NumPorts1 = info->multi * 8;
-	i = first_tuple(link, tuple, parse);
-	while (i != CS_NO_MORE_ITEMS) {
-		/* The quad port cards have bad CIS's, so just look for a
-		   window larger than 8 ports and assume it will be right */
-		if ((i == CS_SUCCESS) && (cf->io.nwin == 1) &&
-		    (cf->io.win[0].len > 8)) {
-			link->conf.ConfigIndex = cf->index;
-			link->io.BasePort1 = cf->io.win[0].base;
-			link->io.IOAddrLines =
-			    cf->io.flags & CISTPL_IO_LINES_MASK;
-			i = pcmcia_request_io(link, &link->io);
-			base2 = link->io.BasePort1 + 8;
-			if (i == CS_SUCCESS)
-				break;
-		}
-		i = next_tuple(link, tuple, parse);
-	}
-
-	/* If that didn't work, look for two windows */
-	if (i != CS_SUCCESS) {
+	if (pcmcia_loop_config(link, multi_config_check, &base2)) {
+		/* If that didn't work, look for two windows */
 		link->io.NumPorts1 = link->io.NumPorts2 = 8;
 		info->multi = 2;
-		i = first_tuple(link, tuple, parse);
-		while (i != CS_NO_MORE_ITEMS) {
-			if ((i == CS_SUCCESS) && (cf->io.nwin == 2)) {
-				link->conf.ConfigIndex = cf->index;
-				link->io.BasePort1 = cf->io.win[0].base;
-				link->io.BasePort2 = cf->io.win[1].base;
-				link->io.IOAddrLines =
-				    cf->io.flags & CISTPL_IO_LINES_MASK;
-				i = pcmcia_request_io(link, &link->io);
-				base2 = link->io.BasePort2;
-				if (i == CS_SUCCESS)
-					break;
-			}
-			i = next_tuple(link, tuple, parse);
+		if (pcmcia_loop_config(link, multi_config_check_notpicky,
+				       &base2)) {
+			printk(KERN_NOTICE "serial_cs: no usable port range"
+			       "found, giving up\n");
+			return -ENODEV;
 		}
 	}
 
-	if (i != CS_SUCCESS) {
-		cs_error(link, RequestIO, i);
-		rc = -1;
-		goto free_cfg_mem;
-	}
-
 	i = pcmcia_request_irq(link, &link->irq);
 	if (i != CS_SUCCESS) {
+		/* FIXME: comment does not fit, error handling does not fit */
 		printk(KERN_NOTICE
 		       "serial_cs: no usable port range found, giving up\n");
 		cs_error(link, RequestIRQ, i);
@@ -666,8 +623,7 @@ static int multi_config(struct pcmcia_device * link)
 	i = pcmcia_request_configuration(link, &link->conf);
 	if (i != CS_SUCCESS) {
 		cs_error(link, RequestConfiguration, i);
-		rc = -1;
-		goto free_cfg_mem;
+		return -ENODEV;
 	}
 
 	/* The Oxford Semiconductor OXCF950 cards are in fact single-port:
@@ -678,7 +634,8 @@ static int multi_config(struct pcmcia_device * link)
 				info->prodid == PRODID_POSSIO_GCC)) {
 		int err;
 
-		if (cf->index == 1 || cf->index == 3) {
+		if (link->conf.ConfigIndex == 1 ||
+		    link->conf.ConfigIndex == 3) {
 			err = setup_serial(link, info, base2,
 					link->irq.AssignedIRQ);
 			base2 = link->io.BasePort1;
@@ -695,18 +652,14 @@ static int multi_config(struct pcmcia_device * link)
 		if (info->quirk && info->quirk->wakeup)
 			info->quirk->wakeup(link);
 
-		rc = 0;
-		goto free_cfg_mem;
+		return 0;
 	}
 
 	setup_serial(link, info, link->io.BasePort1, link->irq.AssignedIRQ);
 	for (i = 0; i < info->multi - 1; i++)
 		setup_serial(link, info, base2 + (8 * i),
 				link->irq.AssignedIRQ);
-	rc = 0;
-free_cfg_mem:
-	kfree(cfg_mem);
-	return rc;
+	return 0;
 }
 
 /*======================================================================
diff --git a/drivers/telephony/ixj_pcmcia.c b/drivers/telephony/ixj_pcmcia.c
index ff9a29b..a9a9cab 100644
--- a/drivers/telephony/ixj_pcmcia.c
+++ b/drivers/telephony/ixj_pcmcia.c
@@ -124,65 +124,57 @@ static void ixj_get_serial(struct pcmcia_device * link, IXJ * j)
 	return;
 }
 
+static int ixj_config_check(struct pcmcia_device *p_dev,
+			    cistpl_cftable_entry_t *cfg,
+			    void *priv_data)
+{
+	cistpl_cftable_entry_t *dflt = priv_data;
+
+	if ((cfg->io.nwin > 0) || (dflt->io.nwin > 0)) {
+		cistpl_io_t *io = (cfg->io.nwin) ? &cfg->io : &dflt->io;
+		p_dev->conf.ConfigIndex = cfg->index;
+		p_dev->io.BasePort1 = io->win[0].base;
+		p_dev->io.NumPorts1 = io->win[0].len;
+		if (io->nwin == 2) {
+			p_dev->io.BasePort2 = io->win[1].base;
+			p_dev->io.NumPorts2 = io->win[1].len;
+		}
+		if (pcmcia_request_io(p_dev, &p_dev->io)) {
+			if (cfg->flags & CISTPL_CFTABLE_DEFAULT)
+				*dflt = *cfg;
+		} else
+			return 0;
+	}
+	return -ENODEV;
+}
+
 static int ixj_config(struct pcmcia_device * link)
 {
 	IXJ *j;
 	ixj_info_t *info;
-	tuple_t tuple;
-	u_short buf[128];
-	cisparse_t parse;
-	cistpl_cftable_entry_t *cfg = &parse.cftable_entry;
-	cistpl_cftable_entry_t dflt =
-	{
-		0
-	};
-	int last_ret, last_fn;
+	cistpl_cftable_entry_t dflt = { 0 };
+
 	info = link->priv;
 	DEBUG(0, "ixj_config(0x%p)\n", link);
-	tuple.TupleData = (cisdata_t *) buf;
-	tuple.TupleOffset = 0;
-	tuple.TupleDataMax = 255;
-	tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
-	tuple.Attributes = 0;
-	CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(link, &tuple));
-	while (1) {
-		if (pcmcia_get_tuple_data(link, &tuple) != 0 ||
-				pcmcia_parse_tuple(link, &tuple, &parse) != 0)
-			goto next_entry;
-		if ((cfg->io.nwin > 0) || (dflt.io.nwin > 0)) {
-			cistpl_io_t *io = (cfg->io.nwin) ? &cfg->io : &dflt.io;
-			link->conf.ConfigIndex = cfg->index;
-			link->io.BasePort1 = io->win[0].base;
-			link->io.NumPorts1 = io->win[0].len;
-			if (io->nwin == 2) {
-				link->io.BasePort2 = io->win[1].base;
-				link->io.NumPorts2 = io->win[1].len;
-			}
-			if (pcmcia_request_io(link, &link->io) != 0)
-				goto next_entry;
-			/* If we've got this far, we're done */
-			break;
-		}
-	      next_entry:
-		if (cfg->flags & CISTPL_CFTABLE_DEFAULT)
-			dflt = *cfg;
-		CS_CHECK(GetNextTuple, pcmcia_get_next_tuple(link, &tuple));
-	}
 
-	CS_CHECK(RequestConfiguration, pcmcia_request_configuration(link, &link->conf));
+	if (pcmcia_loop_config(link, ixj_config_check, &dflt))
+		goto cs_failed;
+
+	if (pcmcia_request_configuration(link, &link->conf))
+		goto cs_failed;
 
 	/*
  	 *	Register the card with the core.
- 	 */	
-	j=ixj_pcmcia_probe(link->io.BasePort1,link->io.BasePort1 + 0x10);
+	 */
+	j = ixj_pcmcia_probe(link->io.BasePort1,link->io.BasePort1 + 0x10);
 
 	info->ndev = 1;
 	info->node.major = PHONE_MAJOR;
 	link->dev_node = &info->node;
 	ixj_get_serial(link, j);
 	return 0;
+
       cs_failed:
-	cs_error(link, last_fn, last_ret);
 	ixj_cs_release(link);
 	return -ENODEV;
 }
-- 
1.5.4.3

