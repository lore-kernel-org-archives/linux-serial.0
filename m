From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 3/9] serial: Add common rs485 device tree parsing
 function
Date: Sun, 30 Jul 2017 07:49:47 -0700
Message-ID: <20170730144947.GA18707@kroah.com>
References: <20170718105948.21986-1-u.kleine-koenig@pengutronix.de>
 <20170718105948.21986-4-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170718105948.21986-4-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 18, 2017 at 12:59:42PM +0200, Uwe Kleine-König wrote:
> From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> Several drivers have the same device tree parsing code. Create
> a common helper function for it.
> 
> Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> [ukl: implement default <0 0> for rts-delay, unset unspecified flags]
> Acked-by: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/tty/serial/Kconfig  |  4 ++++
>  drivers/tty/serial/Makefile |  2 ++
>  drivers/tty/serial/of.c     | 47 +++++++++++++++++++++++++++++++++++++++++++++

Why is this a separate file, with a Kconfig option that is always
enabled?  Why not just add the single function to the serial core?

> +/**
> + * of_get_rs485_mode() - Implement parsing rs485 properties
> + * @np: uart node
> + * @rs485conf: output parameter
> + *
> + * This function implements the device tree binding described in
> + * Documentation/devicetree/bindings/serial/rs485.txt.
> + *
> + * Return: 0 on success, 1 if the node doesn't contain rs485 stuff.

1 is not an error code :(

Return a proper error please.


> + */
> +int of_get_rs485_mode(struct device_node *np, struct serial_rs485 *rs485conf)
> +{
> +	u32 rs485_delay[2];
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_OF) || !np)
> +		return 1;
> +
> +	ret = of_property_read_u32_array(np, "rs485-rts-delay", rs485_delay, 2);
> +	if (!ret) {
> +		rs485conf->delay_rts_before_send = rs485_delay[0];
> +		rs485conf->delay_rts_after_send = rs485_delay[1];
> +	} else {
> +		rs485conf->delay_rts_before_send = 0;
> +		rs485conf->delay_rts_after_send = 0;
> +	}
> +
> +	/*
> +	 * clear full-duplex and enabled flags to get to a defined state with
> +	 * the two following properties.
> +	 */
> +	rs485conf->flags &= ~(SER_RS485_RX_DURING_TX | SER_RS485_ENABLED);
> +
> +	if (of_property_read_bool(np, "rs485-rx-during-tx"))
> +		rs485conf->flags |= SER_RS485_RX_DURING_TX;
> +
> +	if (of_property_read_bool(np, "linux,rs485-enabled-at-boot-time"))
> +		rs485conf->flags |= SER_RS485_ENABLED;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_get_rs485_mode);
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 1775500294bb..3a89e8925722 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -501,4 +501,17 @@ static inline int uart_handle_break(struct uart_port *port)
>  					 (cflag) & CRTSCTS || \
>  					 !((cflag) & CLOCAL))
>  
> +/*
> + * Common device tree parsing helpers
> + */
> +#ifdef CONFIG_OF_SERIAL
> +int of_get_rs485_mode(struct device_node *np, struct serial_rs485 *rs485conf);
> +#else
> +static inline int of_get_rs485_mode(struct device_node *np,
> +				    struct serial_rs485 *rs485conf)
> +{
> +	return 1;

Again, a real error.

And why not have a "generic" firmware function for this that defaults to
the of_ for that platform type if present?  What's the odds that acpi
will need/want this soon anyway?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
