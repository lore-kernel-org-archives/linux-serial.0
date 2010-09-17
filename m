From: Komuro <komurojun-mbn@nifty.com>
Subject: Re: Re: Re: Re: Re: [PATCH 11/18] pcmcia: do not use io_req_t when calling pcmcia_request_io()
Date: Fri, 17 Sep 2010 22:06:51 +0900 (JST)
Message-ID: <31800273.194401284728811871.komurojun-mbn@nifty.com>
References: <20100913195353.GA6999@comet.dominikbrodowski.net>
 <20100904174334.GA955@isilmar-3.linta.de>
 <20100904105415.GC16589@isilmar-3.linta.de>
 <20100830062724.GA2387@comet.dominikbrodowski.net>
 <13928942.191731283256326809.komurojun-mbn@nifty.com>
 <29547163.98341283601820252.komurojun-mbn@nifty.com>
 <8520532.194511283862270702.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_2012_18643948.1284728811853"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nfmsa302g.nifmail.jp ([210.131.2.174]:8568 "EHLO
	nfmsa302g.nifmail.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790Ab0IQNHY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Sep 2010 09:07:24 -0400
In-Reply-To: <20100913195353.GA6999@comet.dominikbrodowski.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pcmcia@lists.infradead.org, linux-serial@vger.kernel.org

------=_Part_2012_18643948.1284728811853
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

Hi,

Xircom multi-function card still does not work.

Please see the attached dmesg log.


Best Regards
Komuro

----- Original Message -----
>Date: Mon, 13 Sep 2010 21:53:53 +0200
>From: Dominik Brodowski <linux@dominikbrodowski.net>
>To: Komuro <komurojun-mbn@nifty.com>
>Cc: linux-pcmcia@lists.infradead.org, linux-serial@vger.kernel.org
>Subject: Re: Re: Re: Re: [PATCH 11/18] pcmcia: do not use io_req_t when
> calling pcmcia_request_io()
>
>
>Dear Komuro,
>
>does the attached patch help with 2.6.36-rc4?
>
>Best,
>	Dominik
>
>commit 1852d6b8c3fa2d1765f66cd7d96a8c6bf9f01997
>Author: Dominik Brodowski <linux@dominikbrodowski.net>
>Date:   Mon Aug 30 08:18:54 2010 +0200
>
>    pcmcia serial_cs.c: fix multifunction card handling
>    
>    We shouldn't overwrite pre-set values, and we should also
>    set the port address to the beginning, and not the end of
>    the 8-port range.
>    
>    Reported-by: Komuro <komurojun-mbn@nifty.com>
>    Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
>
>diff --git a/drivers/serial/serial_cs.c b/drivers/serial/serial_cs.c
>index 141c695..7d475b2 100644
>--- a/drivers/serial/serial_cs.c
>+++ b/drivers/serial/serial_cs.c
>@@ -335,8 +335,6 @@ static int serial_probe(struct pcmcia_device *link)
> 	info->p_dev = link;
> 	link->priv = info;
> 
>-	link->resource[0]->flags |= IO_DATA_PATH_WIDTH_8;
>-	link->resource[0]->end = 8;
> 	link->conf.Attributes = CONF_ENABLE_IRQ;
> 	if (do_sound) {
> 		link->conf.Attributes |= CONF_ENABLE_SPKR;
>@@ -411,6 +409,27 @@ static int setup_serial(struct pcmcia_device *handle, st
ruct serial_info * info,
> 
> /*====================================================================*/
> 
>+static int pfc_config(struct pcmcia_device *p_dev)
>+{
>+	unsigned int port = 0;
>+	struct serial_info *info = p_dev->priv;
>+
>+	if ((p_dev->resource[1]->end != 0) &&
>+		(resource_size(p_dev->resource[1]) == 8)) {
>+		port = p_dev->resource[1]->start;
>+		info->slave = 1;
>+	} else if ((info->manfid == MANFID_OSITECH) &&
>+		(resource_size(p_dev->resource[0]) == 0x40)) {
>+		port = p_dev->resource[0]->start + 0x28;
>+		info->slave = 1;
>+	}
>+	if (info->slave)
>+		return setup_serial(p_dev, info, port, p_dev->irq);
>+
>+	dev_warn(&p_dev->dev, "no usable port range found, giving up\n");
>+	return -ENODEV;
>+}
>+
> static int simple_config_check(struct pcmcia_device *p_dev,
> 			       cistpl_cftable_entry_t *cf,
> 			       cistpl_cftable_entry_t *dflt,
>@@ -461,23 +480,8 @@ static int simple_config(struct pcmcia_device *link)
> 	struct serial_info *info = link->priv;
> 	int i = -ENODEV, try;
> 
>-	/* If the card is already configured, look up the port and irq */
>-	if (link->function_config) {
>-		unsigned int port = 0;
>-		if ((link->resource[1]->end != 0) &&
>-			(resource_size(link->resource[1]) == 8)) {
>-			port = link->resource[1]->end;
>-			info->slave = 1;
>-		} else if ((info->manfid == MANFID_OSITECH) &&
>-			(resource_size(link->resource[0]) == 0x40)) {
>-			port = link->resource[0]->start + 0x28;
>-			info->slave = 1;
>-		}
>-		if (info->slave) {
>-			return setup_serial(link, info, port,
>-					    link->irq);
>-		}
>-	}
>+	link->resource[0]->flags |= IO_DATA_PATH_WIDTH_8;
>+	link->resource[0]->end = 8;
> 
> 	/* First pass: look for a config entry that looks normal.
> 	 * Two tries: without IO aliases, then with aliases */
>@@ -491,8 +495,7 @@ static int simple_config(struct pcmcia_device *link)
> 	if (!pcmcia_loop_config(link, simple_config_check_notpicky, NULL))
> 		goto found_port;
> 
>-	printk(KERN_NOTICE
>-	       "serial_cs: no usable port range found, giving up\n");
>+	dev_warn(&link->dev, "no usable port range found, giving up\n");
> 	return -1;
> 
> found_port:
>@@ -558,6 +561,7 @@ static int multi_config(struct pcmcia_device *link)
> 	int i, base2 = 0;
> 
> 	/* First, look for a generic full-sized window */
>+	link->resource[0]->flags |= IO_DATA_PATH_WIDTH_8;
> 	link->resource[0]->end = info->multi * 8;
> 	if (pcmcia_loop_config(link, multi_config_check, &base2)) {
> 		/* If that didn't work, look for two windows */
>@@ -565,15 +569,14 @@ static int multi_config(struct pcmcia_device *link)
> 		info->multi = 2;
> 		if (pcmcia_loop_config(link, multi_config_check_notpicky,
> 				       &base2)) {
>-			printk(KERN_NOTICE "serial_cs: no usable port range"
>+			dev_warn(&link->dev, "no usable port range "
> 			       "found, giving up\n");
> 			return -ENODEV;
> 		}
> 	}
> 
> 	if (!link->irq)
>-		dev_warn(&link->dev,
>-			"serial_cs: no usable IRQ found, continuing...\n");
>+		dev_warn(&link->dev, "no usable IRQ found, continuing...\n");
> 
> 	/*
> 	 * Apply any configuration quirks.
>@@ -675,6 +678,7 @@ static int serial_config(struct pcmcia_device * link)
> 	   multifunction cards that ask for appropriate IO port ranges */
> 	if ((info->multi == 0) &&
> 	    (link->has_func_id) &&
>+	    (link->socket->pcmcia_pfc == 0) &&
> 	    ((link->func_id == CISTPL_FUNCID_MULTI) ||
> 	     (link->func_id == CISTPL_FUNCID_SERIAL)))
> 		pcmcia_loop_config(link, serial_check_for_multi, info);
>@@ -685,7 +689,13 @@ static int serial_config(struct pcmcia_device * link)
> 	if (info->quirk && info->quirk->multi != -1)
> 		info->multi = info->quirk->multi;
> 
>-	if (info->multi > 1)
>+	dev_info(&link->dev,
>+		"trying to set up [0x%04x:0x%04x] (pfc: %d, multi: %d, quirk: %p)\n",
>+		link->manf_id, link->card_id,
>+		link->socket->pcmcia_pfc, info->multi, info->quirk);
>+	if (link->socket->pcmcia_pfc)
>+		i = pfc_config(link);
>+	else if (info->multi > 1)
> 		i = multi_config(link);
> 	else
> 		i = simple_config(link);
>@@ -704,7 +714,7 @@ static int serial_config(struct pcmcia_device * link)
> 	return 0;
> 
> failed:
>-	dev_warn(&link->dev, "serial_cs: failed to initialize\n");
>+	dev_warn(&link->dev, "failed to initialize\n");
> 	serial_remove(link);
> 	return -ENODEV;
> }

------=_Part_2012_18643948.1284728811853
Content-Type: application/octet-stream; name=serial_cs.log
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*=serial%5fcs.log

pcmcia_socket pcmcia_socket0: pccard: PCMCIA card inserted into slot 0
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x0, 2)
pcmcia_socket pcmcia_socket0:   0x01 0x02 0xf7 0xc0 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x4, 2)
pcmcia_socket pcmcia_socket0:   0x17 0x02 0xf7 0xc0 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x8, 2)
pcmcia_socket pcmcia_socket0:   0x15 0x30 0xf7 0xc0 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x3a, 2)
pcmcia_socket pcmcia_socket0:   0x88 0x08 0xf7 0xc0 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x44, 2)
pcmcia_socket pcmcia_socket0:   0x20 0x05 0xf7 0xc0 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x46, 5)
pcmcia_socket pcmcia_socket0:   0x05 0x01 0x0a 0x11 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x4b, 2)
pcmcia_socket pcmcia_socket0:   0x44 0x04 0xf7 0x00 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x51, 2)
pcmcia_socket pcmcia_socket0:   0x1a 0x05 0xf7 0x00 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x58, 2)
pcmcia_socket pcmcia_socket0:   0x1b 0x14 0xf7 0x00 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x6e, 2)
pcmcia_socket pcmcia_socket0:   0x1b 0x07 0xf7 0x00 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x77, 2)
pcmcia_socket pcmcia_socket0:   0x1b 0x07 0xf7 0x00 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x80, 2)
pcmcia_socket pcmcia_socket0:   0x1b 0x07 0xf7 0x00 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x89, 2)
pcmcia_socket pcmcia_socket0:   0x1b 0x03 0xf7 0x00 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x8e, 2)
pcmcia_socket pcmcia_socket0:   0x21 0x02 0xf7 0x00 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x92, 2)
pcmcia_socket pcmcia_socket0:   0x22 0x04 0xf7 0x00 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x98, 2)
pcmcia_socket pcmcia_socket0:   0x22 0x0c 0xf7 0x00 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0xa6, 2)
pcmcia_socket pcmcia_socket0:   0x22 0x08 0xf7 0x00 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0xb0, 2)
pcmcia_socket pcmcia_socket0:   0x21 0x02 0xf7 0x00 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0xb4, 2)
pcmcia_socket pcmcia_socket0:   0x22 0x08 0xf7 0x00 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0xbe, 2)
pcmcia_socket pcmcia_socket0:   0x8a 0x0c 0xf7 0x00 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0xcc, 2)
pcmcia_socket pcmcia_socket0:   0x8b 0x04 0xf7 0x00 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0xd2, 2)
pcmcia_socket pcmcia_socket0:   0x14 0x00 0xf7 0x00 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0xd4, 2)
pcmcia_socket pcmcia_socket0:   0xff 0xff 0xf7 0x00 ...
adding device to 0, function 0
pcmcia 0.0: devname is pcmcia0.0
pcmcia 0.0: creating config_t
pcmcia 0.0: pcmcia: registering new device pcmcia0.0 (IRQ: 18)
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x90, 2)
pcmcia_socket pcmcia_socket0:   0x02 0x00 0x0a 0x11 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0xa, 48)
pcmcia_socket pcmcia_socket0:   0x05 0x00 0x58 0x69 ...
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: this is a pseudo-multi-function device
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to serial_cs
pcmcia 0.0: trying to match to xirc2ps_cs
pcmcia 0.0: trying to match to xirc2ps_cs
pcmcia 0.0: trying to match to xirc2ps_cs
pcmcia 0.0: trying to match to xirc2ps_cs
pcmcia 0.0: trying to match to xirc2ps_cs
pcmcia 0.0: trying to match to xirc2ps_cs
pcmcia 0.0: this is a pseudo-multi-function device
pcmcia 0.0: matched to xirc2ps_cs
xirc2ps_cs 0.0: trying to bind to xirc2ps_cs
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x53, 5)
pcmcia_socket pcmcia_socket0:   0x01 0x3f 0x80 0xff ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x94, 4)
pcmcia_socket pcmcia_socket0:   0x00 0x02 0x0f 0x5c ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x9a, 12)
pcmcia_socket pcmcia_socket0:   0x02 0x06 0x00 0x3f ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0xa8, 8)
pcmcia_socket pcmcia_socket0:   0x13 0x06 0x00 0x0b ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0xb6, 8)
pcmcia_socket pcmcia_socket0:   0x04 0x06 0x00 0x10 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x5a, 20)
pcmcia_socket pcmcia_socket0:   0xe7 0xc1 0x9d 0x0f ...
pcmcia_socket pcmcia_socket0: pcmcia_request_io: [io  0x0300-0x0010] , [io  0x02e8-0x0008]
pcmcia_socket pcmcia_socket0: alloc_io_space request for [io  0x0300-0x0010], 10 lines
pcmcia_socket pcmcia_socket0: alloc_io_space request result 0: [io  0x0300-0x030f]
pcmcia_socket pcmcia_socket0: alloc_io_space request for [io  0x02e8-0x0008], 10 lines
pcmcia_socket pcmcia_socket0: alloc_io_space request result 0: [io  0x02e8-0x02ef]
pcmcia_socket pcmcia_socket0: pcmcia_request_io succeeded: [io  0x0300-0x030f] , [io  0x02e8-0x02ef]
pcmcia_socket pcmcia_socket0: pcmcia_write_cis_mem(1, 0x7fc0, 1)
pcmcia_socket pcmcia_socket0: pcmcia_write_cis_mem(1, 0x7fc1, 1)
pcmcia_socket pcmcia_socket0: pcmcia_write_cis_mem(1, 0x7fc2, 1)
pcmcia_socket pcmcia_socket0: pcmcia_write_cis_mem(1, 0x7fc5, 1)
pcmcia_socket pcmcia_socket0: pcmcia_write_cis_mem(1, 0x7fc6, 1)
pcmcia_request_configuration
pcmcia_write iobase_0 = 2e8
pcmcia_socket pcmcia_socket0: pcmcia_write_cis_mem(1, 0x7fc0, 1)
pcmcia_socket pcmcia_socket0: pcmcia_write_cis_mem(1, 0x7fc5, 1)
pcmcia_socket pcmcia_socket0: pcmcia_write_cis_mem(1, 0x7fc6, 1)
pcmcia_socket pcmcia_socket0: request_window results in [mem 0xa0001000-0xa0001fff]
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x2, 2)
pcmcia_socket pcmcia_socket0:   0x00 0xff 0x00 0x00 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x6, 2)
pcmcia_socket pcmcia_socket0:   0x00 0xff 0x00 0x00 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x3c, 8)
pcmcia_socket pcmcia_socket0:   0x02 0xdb 0xf3 0x00 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x4d, 4)
pcmcia_socket pcmcia_socket0:   0xd7 0xa8 0x7f 0x26 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x70, 7)
pcmcia_socket pcmcia_socket0:   0x1f 0x08 0xea 0x60 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x79, 7)
pcmcia_socket pcmcia_socket0:   0x17 0x08 0xea 0x60 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x82, 7)
pcmcia_socket pcmcia_socket0:   0x0f 0x08 0xea 0x60 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0x8b, 3)
pcmcia_socket pcmcia_socket0:   0x3f 0x08 0x63 0x00 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0xb2, 2)
pcmcia_socket pcmcia_socket0:   0x06 0x00 0x00 0x00 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0xc0, 12)
pcmcia_socket pcmcia_socket0:   0x39 0x30 0x30 0x31 ...
pcmcia_socket pcmcia_socket0: pcmcia_read_cis_mem(1, 0xce, 4)
pcmcia_socket pcmcia_socket0:   0x01 0x00 0x00 0x00 ...
eth%d: autonegotiation failed; using 10mbs
eth%d: MII selected
eth%d: media 10BaseT, silicon revision 5
eth0: Xircom: port 0x300, irq 18, hwaddr 00:10:a4:f3:db:02
adding device to 0, function 0
pcmcia 0.1: devname is pcmcia0.1
pcmcia 0.1: pcmcia: registering new device pcmcia0.1 (IRQ: 18)
pcmcia 0.1: trying to match to serial_cs
pcmcia 0.1: trying to match to serial_cs
pcmcia 0.1: trying to match to serial_cs
pcmcia 0.1: trying to match to serial_cs
pcmcia 0.1: trying to match to serial_cs
pcmcia 0.1: trying to match to serial_cs
pcmcia 0.1: trying to match to serial_cs
pcmcia 0.1: trying to match to serial_cs
pcmcia 0.1: trying to match to serial_cs
pcmcia 0.1: trying to match to serial_cs
pcmcia 0.1: trying to match to serial_cs
pcmcia 0.1: trying to match to serial_cs
pcmcia 0.1: trying to match to serial_cs
pcmcia 0.1: trying to match to serial_cs
pcmcia 0.1: trying to match to serial_cs
pcmcia 0.1: trying to match to serial_cs
pcmcia 0.1: trying to match to serial_cs
pcmcia 0.1: trying to match to serial_cs
pcmcia 0.1: trying to match to serial_cs
pcmcia 0.1: trying to match to serial_cs
pcmcia 0.1: trying to match to serial_cs
pcmcia 0.1: trying to match to serial_cs
pcmcia 0.1: this is a pseudo-multi-function device
pcmcia 0.1: matched to serial_cs
serial_cs 0.1: trying to bind to serial_cs
serial_cs 0.1: trying to set up [0x0105:0x110a] (pfc: 1, multi: 0, quirk: (null))
0.1: ttyS3 at I/O 0x2e8 (irq = 18) is a 16550A
adding device to 0, function 0
eth0: autonegotiation failed; using 10mbs
eth0: MII selected
eth0: media 10BaseT, silicon revision 5

------=_Part_2012_18643948.1284728811853--

