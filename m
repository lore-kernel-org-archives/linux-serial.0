From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH 18/39] pcmcia: remove remaining in-kernel
	pcmcia_get_configuration_info() users
Date: Tue, 19 Aug 2008 11:06:31 +0200
Message-ID: <20080819090631.GA11115@ds.suse.cz>
References: <20080818185025.GA11647@comet.dominikbrodowski.net> <1219085610-12289-18-git-send-email-linux@dominikbrodowski.net>
Reply-To: dsterba@suse.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:58120 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751566AbYHSJGd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Aug 2008 05:06:33 -0400
Content-Disposition: inline
In-Reply-To: <1219085610-12289-18-git-send-email-linux@dominikbrodowski.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pcmcia@lists.infradead.org, linux-serial@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, David Sterba <dsterba@suse.cz>

On Mon, Aug 18, 2008 at 08:53:09PM +0200, Dominik Brodowski wrote:
> Remove the three remaining pcmcia_get_configuration_info() users:
> - pcmciamtd is marked broken anyway.
> - serial_cs.c can access the relevant structs directly
> - ipwireless didn't use the output
> 
> CC: linux-serial@vger.kernel.org
> CC: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: David Sterba <dsterba@suse.cz>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> ---
>  drivers/char/pcmcia/ipwireless/main.c |   10 ----------
>  drivers/mtd/maps/pcmciamtd.c          |   12 +-----------
>  drivers/serial/serial_cs.c            |   18 +++++++++---------
>  3 files changed, 10 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/char/pcmcia/ipwireless/main.c b/drivers/char/pcmcia/ipwireless/main.c
> index 5eca7a9..1f520e5 100644
> --- a/drivers/char/pcmcia/ipwireless/main.c
> +++ b/drivers/char/pcmcia/ipwireless/main.c
> @@ -83,7 +83,6 @@ static int config_ipwireless(struct ipw_dev *ipw)
>  {
>  	struct pcmcia_device *link = ipw->link;
>  	int ret;
> -	config_info_t conf;
>  	tuple_t tuple;
>  	unsigned short buf[64];
>  	cisparse_t parse;
> @@ -297,15 +296,6 @@ static int config_ipwireless(struct ipw_dev *ipw)
>  		goto exit3;
>  	}
>  
> -	/* Look up current Vcc */
> -
> -	ret = pcmcia_get_configuration_info(link, &conf);
> -
> -	if (ret != CS_SUCCESS) {
> -		cs_error(link, GetConfigurationInfo, ret);
> -		goto exit4;
> -	}
> -
>  	printk(KERN_INFO IPWIRELESS_PCCARD_NAME ": Card type %s\n",
>  			ipw->is_v2_card ? "V2/V3" : "V1");
>  	printk(KERN_INFO IPWIRELESS_PCCARD_NAME
> diff --git a/drivers/mtd/maps/pcmciamtd.c b/drivers/mtd/maps/pcmciamtd.c
> index 90924fb..8861ca4 100644
> --- a/drivers/mtd/maps/pcmciamtd.c
> +++ b/drivers/mtd/maps/pcmciamtd.c
> @@ -493,7 +493,6 @@ static int pcmciamtd_config(struct pcmcia_device *link)
>  	int last_ret = 0, last_fn = 0;
>  	int ret;
>  	int i;
> -	config_info_t t;
>  	static char *probes[] = { "jedec_probe", "cfi_probe" };
>  	int new_name = 0;
>  
> @@ -571,10 +570,7 @@ static int pcmciamtd_config(struct pcmcia_device *link)
>  	dev->pcmcia_map.map_priv_1 = (unsigned long)dev;
>  	dev->pcmcia_map.map_priv_2 = (unsigned long)link->win;
>  
> -	DEBUG(2, "Getting configuration");
> -	CS_CHECK(GetConfigurationInfo, pcmcia_get_configuration_info(link, &t));
> -	DEBUG(2, "Vcc = %d Vpp1 = %d Vpp2 = %d", t.Vcc, t.Vpp1, t.Vpp2);
> -	dev->vpp = (vpp) ? vpp : t.Vpp1;
> +	dev->vpp = (vpp) ? vpp : link->socket.socket.Vpp;
>  	link->conf.Attributes = 0;
>  	if(setvpp == 2) {
>  		link->conf.Vpp = dev->vpp;
> @@ -583,13 +579,7 @@ static int pcmciamtd_config(struct pcmcia_device *link)
>  	}
>  
>  	link->conf.IntType = INT_MEMORY;
> -	link->conf.ConfigBase = t.ConfigBase;
> -	link->conf.Status = t.Status;
> -	link->conf.Pin = t.Pin;
> -	link->conf.Copy = t.Copy;
> -	link->conf.ExtStatus = t.ExtStatus;
>  	link->conf.ConfigIndex = 0;
> -	link->conf.Present = t.Present;
>  	DEBUG(2, "Setting Configuration");
>  	ret = pcmcia_request_configuration(link, &link->conf);
>  	if(ret != CS_SUCCESS) {
> diff --git a/drivers/serial/serial_cs.c b/drivers/serial/serial_cs.c
> index 2427eee..4fed877 100644
> --- a/drivers/serial/serial_cs.c
> +++ b/drivers/serial/serial_cs.c
> @@ -488,23 +488,23 @@ static int simple_config_check_notpicky(struct pcmcia_device *p_dev,
>  static int simple_config(struct pcmcia_device *link)
>  {
>  	struct serial_info *info = link->priv;
> -	config_info_t config;
> -	int i, try;
> +	int i = -ENODEV, try;
>  
>  	/* If the card is already configured, look up the port and irq */
> -	i = pcmcia_get_configuration_info(link, &config);
> -	if ((i == CS_SUCCESS) && (config.Attributes & CONF_VALID_CLIENT)) {
> +	if (link->function_config) {
>  		unsigned int port = 0;
> -		if ((config.BasePort2 != 0) && (config.NumPorts2 == 8)) {
> -			port = config.BasePort2;
> +		if ((link->io.BasePort2 != 0) &&
> +		    (link->io.NumPorts2 == 8)) {
> +			port = link->io.BasePort2;
>  			info->slave = 1;
>  		} else if ((info->manfid == MANFID_OSITECH) &&
> -			   (config.NumPorts1 == 0x40)) {
> -			port = config.BasePort1 + 0x28;
> +			   (link->io.NumPorts1 == 0x40)) {
> +			port = link->io.BasePort1 + 0x28;
>  			info->slave = 1;
>  		}
>  		if (info->slave) {
> -			return setup_serial(link, info, port, config.AssignedIRQ);
> +			return setup_serial(link, info, port,
> +					    link->irq.AssignedIRQ);
>  		}
>  	}
>  
> -- 
> 1.5.4.3
> 
