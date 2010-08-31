From: Komuro <komurojun-mbn@nifty.com>
Subject: Re: Re: [PATCH 11/18] pcmcia: do not use io_req_t when calling pcmcia_request_io()
Date: Tue, 31 Aug 2010 21:05:26 +0900 (JST)
Message-ID: <13928942.191731283256326809.komurojun-mbn@nifty.com>
References: <20100830062724.GA2387@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nfmsa303g.nifmail.jp ([210.131.2.172]:31100 "EHLO
	nfmsa303g.nifmail.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab0HaMF7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 31 Aug 2010 08:05:59 -0400
In-Reply-To: <20100830062724.GA2387@comet.dominikbrodowski.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pcmcia@lists.infradead.org, linux-serial@vger.kernel.org

Hi,

The serial part still does not work.


>does this patch help? If not, could you please enable dynamic debug by
>issuing

I will try it later.


>
>Hey,
>
>does this patch help? If not, could you please enable dynamic debug by
>issuing
>
>$ echo "module pcmcia +p" > /sys/kernel/debug/dynamic_debug/control
>
>Thanks,
>	Dominik
>
>
>From: Dominik Brodowski <linux@dominikbrodowski.net>
>Date: Mon, 30 Aug 2010 08:18:54 +0200
>Subject: [PATCH] pcmcia: fix multifunction card handling in serial_cs.c
>
>We shouldn't overwrite pre-set values, and we should also
>set the port address to the beginning, and not the end of
>the 8-port range.
>
>Reported-by: Komuro <komurojun-mbn@nifty.com>
>Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
>
>diff --git a/drivers/serial/serial_cs.c b/drivers/serial/serial_cs.c
>index 141c695..dd0fa12 100644
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
>@@ -466,7 +464,7 @@ static int simple_config(struct pcmcia_device *link)
> 		unsigned int port = 0;
> 		if ((link->resource[1]->end != 0) &&
> 			(resource_size(link->resource[1]) == 8)) {
>-			port = link->resource[1]->end;
>+			port = link->resource[1]->start;
> 			info->slave = 1;
> 		} else if ((info->manfid == MANFID_OSITECH) &&
> 			(resource_size(link->resource[0]) == 0x40)) {
>@@ -479,6 +477,9 @@ static int simple_config(struct pcmcia_device *link)
> 		}
> 	}
> 
>+	link->resource[0]->flags |= IO_DATA_PATH_WIDTH_8;
>+	link->resource[0]->end = 8;
>+
> 	/* First pass: look for a config entry that looks normal.
> 	 * Two tries: without IO aliases, then with aliases */
> 	for (try = 0; try < 4; try++)
>@@ -558,6 +559,7 @@ static int multi_config(struct pcmcia_device *link)
> 	int i, base2 = 0;
> 
> 	/* First, look for a generic full-sized window */
>+	link->resource[0]->flags |= IO_DATA_PATH_WIDTH_8;
> 	link->resource[0]->end = info->multi * 8;
> 	if (pcmcia_loop_config(link, multi_config_check, &base2)) {
> 		/* If that didn't work, look for two windows */

