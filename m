From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 4/9] serial: atmel: Use common rs485 device tree
 parsing function
Date: Sun, 30 Jul 2017 07:50:07 -0700
Message-ID: <20170730145007.GB18707@kroah.com>
References: <20170718105948.21986-1-u.kleine-koenig@pengutronix.de>
 <20170718105948.21986-5-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170718105948.21986-5-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 18, 2017 at 12:59:43PM +0200, Uwe Kleine-König wrote:
> From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> We just got a common helper for parsing the rs485 specific
> device tree properties. Use it and drop the open coded parser.
> 
> Note that there is a small difference between the removed and the now
> used implementation: The former cleared flags to 0 if rs485-rts-delay
> was given, the common helper clears SER_RS485_RX_DURING_TX and
> SER_RS485_ENABLED only but always which makes more sense.
> 
> Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> [ukleinek: point out semantic change in commit log]
> Acked-by: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
> Acked-by: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/tty/serial/atmel_serial.c | 25 +------------------------
>  1 file changed, 1 insertion(+), 24 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 7551cab438ff..04e55f010894 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1667,29 +1667,6 @@ static void atmel_init_property(struct atmel_uart_port *atmel_port,
>  	}
>  }
>  
> -static void atmel_init_rs485(struct uart_port *port,
> -				struct platform_device *pdev)
> -{
> -	struct device_node *np = pdev->dev.of_node;
> -
> -	struct serial_rs485 *rs485conf = &port->rs485;
> -	u32 rs485_delay[2];
> -
> -	/* rs485 properties */
> -	if (of_property_read_u32_array(np, "rs485-rts-delay",
> -				       rs485_delay, 2) == 0) {
> -		rs485conf->delay_rts_before_send = rs485_delay[0];
> -		rs485conf->delay_rts_after_send = rs485_delay[1];
> -		rs485conf->flags = 0;
> -	}
> -
> -	if (of_get_property(np, "rs485-rx-during-tx", NULL))
> -		rs485conf->flags |= SER_RS485_RX_DURING_TX;
> -
> -	if (of_get_property(np, "linux,rs485-enabled-at-boot-time", NULL))
> -		rs485conf->flags |= SER_RS485_ENABLED;
> -}
> -
>  static void atmel_set_ops(struct uart_port *port)
>  {
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> @@ -2373,7 +2350,7 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
>  	atmel_init_property(atmel_port, pdev);
>  	atmel_set_ops(port);
>  
> -	atmel_init_rs485(port, pdev);
> +	of_get_rs485_mode(pdev->dev.of_node, &port->rs485);

No error checking?

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
