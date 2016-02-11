From: =?UTF-8?B?0JjQu9GM0Y/RgSDQk9Cw0YHQsNC90L7Qsg==?=
	<torso.nafi@gmail.com>
Subject: Re: [PATCH v8 3/3] tty: 8250_omap: Use software emulated RS485
 direction control
Date: Thu, 11 Feb 2016 19:40:14 +0300
Message-ID: <CAEo2pzv-kSy+34JzC1hOxMLX_j2EB1KkiHsao5Tpm2cKVz9Qrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, gnomes@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello,

2016-02-01 21:09 GMT+03:00 "Matwey V. Kornilov" <matwey@sai.msu.ru>:
> +static int omap_8250_rs485_config(struct uart_port *port,
> +                                 struct serial_rs485 *rs485)
> +{
> +       struct uart_8250_port *up = up_to_u8250p(port);
> +
> +       /* Clamp the delays to [0, 100ms] */
> +       rs485->delay_rts_before_send = min(rs485->delay_rts_before_send, 100U);
> +       rs485->delay_rts_after_send  = min(rs485->delay_rts_after_send, 100U);
> +
> +       port->rs485 = *rs485;
> +
> +       /*
> +        * Both serial8250_em485_init and serial8250_em485_destroy
> +        * are idempotent
> +        */
> +       if (rs485->flags & SER_RS485_ENABLED) {
> +               int ret = serial8250_em485_init(up);
> +
> +               if (ret) {
> +                       rs485->flags &= ~SER_RS485_ENABLED;
> +                       port->rs485.flags &= ~SER_RS485_ENABLED;
> +               }
> +               return ret;
> +       }
> +
> +       serial8250_em485_destroy(up);
> +
> +       return 0;
> +}

I think that an invocation of serial8250_em485_destroy() should be
performed inside omap8250_remove() as well. However there is a catch -
serial8250_get_port() is only reserved for suspend-resume power
management operations, and I am aware of no other means how to supply
an uart_8250_port to serial8250_em485_destroy() at that point.

Similarly, I got no idea on how to implement handling
"linux,rs485-enabled-at-boot-time" property without using
serial8250_get_port() directly (well, honestly I could try invoking
the corresponding ioctl somehow, but that's gonna be plain ugly at
least).

Regards,
Ilyas G.
