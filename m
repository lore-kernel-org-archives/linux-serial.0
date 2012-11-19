From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 1/3] OF: Add helper for matching against linux,stdout-path
Date: Mon, 19 Nov 2012 10:52:02 +0100
Message-ID: <20121119095202.GL4398@game.jcrosoft.org>
References: <1352971866-540-1-git-send-email-s.hauer@pengutronix.de>
 <1352971866-540-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1352971866-540-2-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On 10:31 Thu 15 Nov     , Sascha Hauer wrote:
> devicetrees may have a linux,stdout-path property in the chosen
> node describing the console device. This adds a helper function
> to match a device against this property so a driver can call
> add_preferred_console for a matching device.

I like it but I've an issue with it I cannot specify the option for

as example I need to set the uart at 38400n8 or 115200n8 regarless of wath the
booloader did

Best Regards,
J.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/of/base.c  |   28 ++++++++++++++++++++++++++++
>  include/linux/of.h |    7 +++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index af3b22a..737feb8 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1358,3 +1358,31 @@ const char *of_prop_next_string(struct property *prop, const char *cur)
>  	return curv;
>  }
>  EXPORT_SYMBOL_GPL(of_prop_next_string);
> +
> +/**
> + * of_device_is_stdout_path - check if a device node matches the
> + *                            linux,stdout-path property
> + *
> + * Check if this device node matches the linux,stdout-path property
> + * in the chosen node. return true if yes, false otherwise.
> + */
> +int of_device_is_stdout_path(struct device_node *dn)
> +{
> +	const char *name;
> +	struct device_node *dn_stdout;
> +	int is_stdout = 0;
> +
> +	name = of_get_property(of_chosen, "linux,stdout-path", NULL);
> +	if (name == NULL)
> +		return 0;
> +
> +	dn_stdout = of_find_node_by_path(name);
> +
> +	if (dn_stdout && dn_stdout == dn)
> +		is_stdout = 1;
> +
> +	of_node_put(dn_stdout);
> +
> +	return is_stdout;
> +}
> +EXPORT_SYMBOL_GPL(of_device_is_stdout_path);
> diff --git a/include/linux/of.h b/include/linux/of.h
> index b4e50d5..5f857b5 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -310,6 +310,8 @@ const char *of_prop_next_string(struct property *prop, const char *cur);
>  		s;						\
>  		s = of_prop_next_string(prop, s))
>  
> +int of_device_is_stdout_path(struct device_node *dn);
> +
>  #else /* CONFIG_OF */
>  
>  static inline const char* of_node_full_name(struct device_node *np)
> @@ -437,6 +439,11 @@ static inline int of_machine_is_compatible(const char *compat)
>  	return 0;
>  }
>  
> +static inline int of_device_is_stdout_path(struct device_node *dn)
> +{
> +	return 0;
> +}
> +
>  #define of_match_ptr(_ptr)	NULL
>  #define of_match_node(_matches, _node)	NULL
>  #define of_property_for_each_u32(np, propname, prop, p, u) \
> -- 
> 1.7.10.4
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
