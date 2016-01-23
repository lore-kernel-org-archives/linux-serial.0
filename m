From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 3/3] tty: 8250_omap: Use software emulated RS485
 direction control
Date: Sat, 23 Jan 2016 17:20:27 +0200
Message-ID: <CAHp75Vch_CDNdRpK1perqZuvK894t+cYi6KY8chb7xfF3p7kYQ@mail.gmail.com>
References: <1453235597-5078-1-git-send-email-matwey@sai.msu.ru>
	<1453235597-5078-4-git-send-email-matwey@sai.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453235597-5078-4-git-send-email-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 19, 2016 at 10:33 PM, Matwey V. Kornilov <matwey@sai.msu.ru> wrote:
> Use software emulated RS485 direction control to provide RS485 API existed in
> omap_serial driver. Note that 8250_omap issues interrupt on shift register
> empty which is single prerequesite for using software emulated RS485.


> +static int omap_8250_rs485_config(struct uart_port *port, struct serial_rs485 *rs485)
> +{
> +       struct uart_8250_port *up = up_to_u8250p(port);
> +
> +       /* Clamp the delays to [0, 100ms] */

It's not exactly clamping but rather cutting extra as I can see below.

> +       rs485->delay_rts_before_send = min(rs485->delay_rts_before_send, 100U);
> +       rs485->delay_rts_after_send  = min(rs485->delay_rts_after_send, 100U);

> +       /* Both serial8250_em485_* functions are idempotent */

Better to decode what functions do you mean here.

> +       if (rs485->flags & SER_RS485_ENABLED) {
> +               int ret = serial8250_em485_init(up);
> +               if (ret) {
> +                       rs485->flags &= ~SER_RS485_ENABLED;
> +                       port->rs485.flags &= ~SER_RS485_ENABLED;
> +               }

> +               return ret;
> +       } else

You have to do } else { in multi-line branches, but luckily there is
redundant else keyword.

And checkpatch.pl doesn't tell you anything?

> +               serial8250_em485_destroy(up);
> +
> +       return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko
