From: Komuro <komurojun-mbn@nifty.com>
Subject: Re: Re: [PATCH 11/18] pcmcia: do not use io_req_t when calling pcmcia_request_io()
Date: Sat, 21 Aug 2010 13:34:02 +0900 (JST)
Message-ID: <15035991.48241282365242613.komurojun-mbn@nifty.com>
References: <3446357.27821282355344343.komurojun-mbn@nifty.com>
 <1281046014-7585-11-git-send-email-linux@dominikbrodowski.net>
	<20100805220511.GA7040@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nfmsa303g.nifmail.jp ([210.131.2.172]:62973 "EHLO
	nfmsa303g.nifmail.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab0HUEed (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 21 Aug 2010 00:34:33 -0400
In-Reply-To: <3446357.27821282355344343.komurojun-mbn@nifty.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pcmcia@lists.infradead.org, linux-serial@vger.kernel.org


Hi

>@@ -463,13 +463,13 @@ static int simple_config(struct pcmcia_device *link)
> 	/* If the card is already configured, look up the port and irq */
> 	if (link->function_config) {
> 		unsigned int port = 0;
>-		if ((link->io.BasePort2 != 0) &&
>-		    (link->io.NumPorts2 == 8)) {
>-			port = link->io.BasePort2;
>+		if ((link->resource[1]->end != 0) &&
>+			(resource_size(link->resource[1]) == 8)) {
>+			port = link->resource[1]->end;
> 			info->slave = 1;

sorry,
It should be link->resource[1]->start;
			(resource_size(link->resource[1]) == 8)) {
			port = link->resource[1]->start;  << HERE!!
 

 
