From: Komuro <komurojun-mbn@nifty.com>
Subject: Re: [PATCH 11/18] pcmcia: do not use io_req_t when calling
	pcmcia_request_io()
Date: Sat, 21 Aug 2010 10:49:04 +0900 (JST)
Message-ID: <3446357.27821282355344343.komurojun-mbn@nifty.com>
References: <1281046014-7585-11-git-send-email-linux@dominikbrodowski.net>
	<20100805220511.GA7040@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
In-Reply-To: <1281046014-7585-11-git-send-email-linux@dominikbrodowski.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia/>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pcmcia@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi

>--- a/drivers/serial/serial_cs.c
>+++ b/drivers/serial/serial_cs.c
>@@static int serial_probe(struct pcmcia_device *link)
> 	info->p_dev = link;
> 	link->priv = info;
> 
>-	link->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
>-	link->io.NumPorts1 = 8;
>+	link->resource[0]->flags |= IO_DATA_PATH_WIDTH_8;
>+	link->resource[0]->end = 8;

resource[0]->end should be end of port-address?


@@ -463,13 +463,13 @@ static int simple_config(struct pcmcia_device *link)
 	/* If the card is already configured, look up the port and irq */
 	if (link->function_config) {
 		unsigned int port = 0;
-		if ((link->io.BasePort2 != 0) &&
-		    (link->io.NumPorts2 == 8)) {
-			port = link->io.BasePort2;
+		if ((link->resource[1]->end != 0) &&
+			(resource_size(link->resource[1]) == 8)) {
+			port = link->resource[1]->end;
 			info->slave = 1;

It should be link->resource[0];
			(resource_size(link->resource[0]) == 8)) {
			port = link->resource[0]->end;
 

 
>static int multi_config(struct pcmcia_device *link)
> 	int i, base2 = 0;
> 
> 	/* First, look for a generic full-sized window */
>-	link->io.NumPorts1 = info->multi * 8;
>+	link->resource[0]->end = info->multi * 8;
> 	if (pcmcia_loop_config(link, multi_config_check, &base2)) {
> 		/* If that didn't work, look for two windows */
>-		link->io.NumPorts1 = link->io.NumPorts2 = 8;
>+		link->resource[0]->end = link->resource[1]->end = 8;
> 		info->multi = 2;
> 		if (pcmcia_loop_config(link, multi_config_check_notpicky,
> 				       &base2)) {


resource[0]->end , link->resource[1]->end should be end of port-address?
