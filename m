From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/4] OF: Add helper for matching against linux,stdout-path
Date: Wed, 21 Nov 2012 18:03:29 +0000
Message-ID: <CACxGe6tyPpjx4OtjHmhB9Cvnb7OwAjPEE4=K+wgWKYHcAV-ESQ@mail.gmail.com>
References: <20121121155312.GX4398@game.jcrosoft.org> <1353513428-25697-1-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:45154 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755353Ab2KUSK5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Nov 2012 13:10:57 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so1923991vbb.19
        for <linux-serial@vger.kernel.org>; Wed, 21 Nov 2012 10:10:56 -0800 (PST)
In-Reply-To: <1353513428-25697-1-git-send-email-plagnioj@jcrosoft.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <kernel@pengutronix.de>, Alan Cox <alan@linux.intel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>

On Wed, Nov 21, 2012 at 3:57 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
>
> devicetrees may have a linux,stdout-path or stdout-path property
> in the chosen node describing the console device. This adds a helper
> function to match a device against this property and retrieve the options
> so a driver can call add_preferred_console for a matching device.

NIce. Looks like the right behaviour, but is a little inefficient.
Since the stdout property doesn't change this code could be called
once right after the tree is unflattened and then cache the pointer to
the node and arguments. Can you add the code to of_alias_scan()?

g.

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
>         return curv;
>  }
>  EXPORT_SYMBOL_GPL(of_prop_next_string);
> +
> +/**
> + * of_device_is_stdout_path - check if a device node matches the
> + *                           linux,stdout-path property
> + * @np:                Pointer to the given device_node
> + * @option:    parsed option
> + *
> + * Check if this device node matches the linux,stdout-path property
> + * in the chosen node. return true if yes, false otherwise.
> + */
> +int of_device_is_stdout_path(struct device_node *dn, char **option)
> +{
> +       const char *name;
> +       struct device_node *dn_stdout;
> +       bool is_stdout = 0;
> +       const char *tmp;
> +       const char *tmp_option;
> +
> +       name = of_get_property(of_chosen, "linux,stdout-path", NULL);
> +       if (name == NULL)
> +               name = of_get_property(of_chosen, "stdout-path", NULL);
> +
> +       if (name == NULL)
> +               return 0;
> +
> +       tmp_option = strchr(name, ':');
> +
> +       tmp = kstrndup(name, strlen(name) - strlen(tmp_option), GFP_KERNEL);
> +       if (!tmp)
> +               return 0;
> +
> +       dn_stdout = of_find_node_by_path(tmp);
> +
> +       if (dn_stdout && dn_stdout == dn) {
> +               is_stdout = 1;
> +               tmp_option++;
> +               *option = kstrdup(tmp_option, GFP_KERNEL);
> +       }
> +
> +       of_node_put(dn_stdout);
> +
> +       kfree(tmp);
> +
> +       return is_stdout;
> +}
> +EXPORT_SYMBOL_GPL(of_device_is_stdout_path);
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 681a6c8..6a82e3f 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -323,6 +323,8 @@ const char *of_prop_next_string(struct property *prop, const char *cur);
>                 s;                                              \
>                 s = of_prop_next_string(prop, s))
>
> +int of_device_is_stdout_path(struct device_node *dn, char **option);
> +
>  #else /* CONFIG_OF */
>
>  static inline const char* of_node_full_name(struct device_node *np)
> @@ -450,6 +452,11 @@ static inline int of_machine_is_compatible(const char *compat)
>         return 0;
>  }
>
> +static inline int of_device_is_stdout_path(struct device_node *dn, char **option)
> +{
> +       return 0;
> +}
> +
>  #define of_match_ptr(_ptr)     NULL
>  #define of_match_node(_matches, _node) NULL
>  #define of_property_for_each_u32(np, propname, prop, p, u) \
> --
> 1.7.10.4
>



--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
