From: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 4/9] serial: atmel: Use common rs485 device tree
 parsing function
Date: Fri, 23 Jun 2017 11:58:37 +0200
Message-ID: <CACQ1gAh3jpcyPLexNgEU7KV0qX1Wor2dsLRV8LJYpA-1Wmp9SA@mail.gmail.com>
References: <20170623094945.31908-1-u.kleine-koenig@pengutronix.de> <20170623094945.31908-5-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170623094945.31908-5-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

2017-06-23 11:49 GMT+02:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutron=
ix.de>:
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
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
> Changes since v1:
>  - as I dropped my two atmel patches and used Alexandre Belloni's (that a=
re
>    already in next) instead, there are a few changes that are necessary t=
o
>    adapt to the new base.
>
>  drivers/tty/serial/atmel_serial.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
>
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel=
_serial.c
> index 937d67f22fba..357570a216ad 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1689,22 +1689,7 @@ static void atmel_init_rs485(struct uart_port *por=
t,
>  {
>         struct device_node *np =3D pdev->dev.of_node;
>
> -       struct serial_rs485 *rs485conf =3D &port->rs485;
> -       u32 rs485_delay[2];
> -
> -       /* rs485 properties */
> -       if (of_property_read_u32_array(np, "rs485-rts-delay",
> -                                      rs485_delay, 2) =3D=3D 0) {
> -               rs485conf->delay_rts_before_send =3D rs485_delay[0];
> -               rs485conf->delay_rts_after_send =3D rs485_delay[1];
> -               rs485conf->flags =3D 0;
> -       }
> -
> -       if (of_get_property(np, "rs485-rx-during-tx", NULL))
> -               rs485conf->flags |=3D SER_RS485_RX_DURING_TX;
> -
> -       if (of_get_property(np, "linux,rs485-enabled-at-boot-time", NULL)=
)
> -               rs485conf->flags |=3D SER_RS485_ENABLED;
> +       of_get_rs485_mode(np, &port->rs485);
>  }

as atmel_init_rs485() is only used once in the code, what do you think of
getting rid of it and just have something like:
of_get_rs485_mode(pdev->dev.of_node, &port->rs485);
in atmel_init_port() ?
(possibly with a little comment)

regards,
Richard.
>
>  static void atmel_set_ops(struct uart_port *port)
> --
> 2.11.0
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
