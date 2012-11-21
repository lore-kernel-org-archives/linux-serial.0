From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/4] OF: Add helper for matching against linux,stdout-path
Date: Wed, 21 Nov 2012 18:26:31 +0100
Message-ID: <20121121172631.GV10369@pengutronix.de>
References: <20121121155312.GX4398@game.jcrosoft.org>
 <1353513428-25697-1-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58720 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174Ab2KUR0k (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Nov 2012 12:26:40 -0500
Content-Disposition: inline
In-Reply-To: <1353513428-25697-1-git-send-email-plagnioj@jcrosoft.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, Alan Cox <alan@linux.intel.com>, Grant Likely <grant.likely@secretlab.ca>, Nicolas Ferre <nicolas.ferre@atmel.com>

On Wed, Nov 21, 2012 at 04:57:05PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> devicetrees may have a linux,stdout-path or stdout-path property
> in the chosen node describing the console device. This adds a helper
> function to match a device against this property and retrieve the options
> so a driver can call add_preferred_console for a matching device.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: linux-serial@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: kernel@pengutronix.de
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/of/base.c  |   46 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of.h |    7 +++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index f2f63c8..72c49ce 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1470,3 +1470,49 @@ const char *of_prop_next_string(struct property *prop, const char *cur)
>  	return curv;
>  }
>  EXPORT_SYMBOL_GPL(of_prop_next_string);
> +
> +/**
> + * of_device_is_stdout_path - check if a device node matches the
> + *			      linux,stdout-path property
> + * @np:		Pointer to the given device_node
> + * @option:	parsed option
> + *
> + * Check if this device node matches the linux,stdout-path property
> + * in the chosen node. return true if yes, false otherwise.
> + */
> +int of_device_is_stdout_path(struct device_node *dn, char **option)
> +{
> +	const char *name;
> +	struct device_node *dn_stdout;
> +	bool is_stdout = 0;
> +	const char *tmp;
> +	const char *tmp_option;
> +
> +	name = of_get_property(of_chosen, "linux,stdout-path", NULL);
> +	if (name == NULL)
> +		name = of_get_property(of_chosen, "stdout-path", NULL);
> +
> +	if (name == NULL)
> +		return 0;
> +
> +	tmp_option = strchr(name, ':');
> +
> +	tmp = kstrndup(name, strlen(name) - strlen(tmp_option), GFP_KERNEL);

tmp_option may be NULL.

> +	if (!tmp)
> +		return 0;
> +
> +	dn_stdout = of_find_node_by_path(tmp);
> +
> +	if (dn_stdout && dn_stdout == dn) {
> +		is_stdout = 1;
> +		tmp_option++;
> +		*option = kstrdup(tmp_option, GFP_KERNEL);
> +	}
> +
> +	of_node_put(dn_stdout);

dn_stdout may be NULL aswell.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
