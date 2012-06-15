From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 2/2] serial: mxs-auart: Allow device tree probing
Date: Sat, 16 Jun 2012 00:06:37 +0800
Message-ID: <20120615160635.GP31565@S2101-09.ap.freescale.net>
References: <1339774557-23588-1-git-send-email-fabio.estevam@freescale.com>
 <1339774557-23588-2-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:13321
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752265Ab2FOQGb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Jun 2012 12:06:31 -0400
Content-Disposition: inline
In-Reply-To: <1339774557-23588-2-git-send-email-fabio.estevam@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, marex@denx.de, matt@grid-net.com, snijsure@grid-net.com, rob.herring@calxeda.com, Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

On Fri, Jun 15, 2012 at 12:35:57PM -0300, Fabio Estevam wrote:
> +static struct platform_device_id mxs_auart_devtype[] = {
> +	{
> +		.name = "mxs-auart",
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(platform, mxs_auart_devtype);
...
> +		.id_table = mxs_auart_devtype,

I do not think we need these.

-- 
Regards,
Shawn

