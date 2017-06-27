From: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH v3 4/9] serial: atmel: Use common rs485 device tree
 parsing function
Date: Tue, 27 Jun 2017 09:41:23 +0200
Message-ID: <bac50abd-9c55-c9cb-7d10-24ef8efbdb53@microchip.com>
References: <20170626090803.10981-1-u.kleine-koenig@pengutronix.de>
 <20170626090803.10981-5-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170626090803.10981-5-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 26/06/2017 at 11:07, Uwe Kleine-König wrote:
> From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> We just got a common helper for parsing the rs485 specific
> device tree properties. Use it and drop the open coded parser.
> 
> Note that there is a small difference between the removed and the now
> used implementation: The former cleared flags to 0 if rs485-rts-delay
> was given, the common helper clears SER_RS485_RX_DURING_TX and
> SER_RS485_ENABLED only but always which makes more sense.

Sure:
Acked-by: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>

Thanks Sasha and Uwe!

> Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> [ukleinek: point out semantic change in commit log]
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/tty/serial/atmel_serial.c | 25 +------------------------
>  1 file changed, 1 insertion(+), 24 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 937d67f22fba..245d9c227ad5 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1684,29 +1684,6 @@ static void atmel_init_property(struct atmel_uart_port *atmel_port,
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
> @@ -2390,7 +2367,7 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
>  	atmel_init_property(atmel_port, pdev);
>  	atmel_set_ops(port);
>  
> -	atmel_init_rs485(port, pdev);
> +	of_get_rs485_mode(pdev->dev.of_node, &port->rs485);
>  
>  	port->iotype		= UPIO_MEM;
>  	port->flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP;
> 


-- 
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
