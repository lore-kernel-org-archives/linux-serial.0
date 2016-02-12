From: =?UTF-8?B?0JjQu9GM0Y/RgSDQk9Cw0YHQsNC90L7Qsg==?=
	<torso.nafi@gmail.com>
Subject: Re: [PATCH v8 3/3] tty: 8250_omap: Use software emulated RS485
 direction control
Date: Fri, 12 Feb 2016 12:39:39 +0300
Message-ID: <CAEo2pzsRdhqiFiHOc8BxFsiJwJ9WTru3dGaWgfssJLWQ5FCTyg@mail.gmail.com>
References: <CAEo2pzv-kSy+34JzC1hOxMLX_j2EB1KkiHsao5Tpm2cKVz9Qrg@mail.gmail.com>
	<CAJs94EZNi=g5D08c9-m0aGQFTDUSksaJNsrcT6RYsyd_az75Qg@mail.gmail.com>
	<CAEo2pzs7mTUFpUGvsyrzt5cYPXsWLiBLaoQ==SypBm5fKjkFjA@mail.gmail.com>
	<CAJs94Ea-3Lvfmh=72EOnDhXKawBfBbM3Ue2tuW-OLemXSFTZfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJs94Ea-3Lvfmh=72EOnDhXKawBfBbM3Ue2tuW-OLemXSFTZfA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

2016-02-12 10:57 GMT+03:00 Matwey V. Kornilov <matwey@sai.msu.ru>:
> up->em485 is always pointer, however you are right, that
> serial8250_em485_init stores pointer to up when the timers are inited.
> More complex issue here that serial8250_em485_init need to set RTS to
> proper state and probably can't do that before
> serial8250_register_8250_port. So omap8250_probe should directly or
> indirectly use serial8250_get_port(priv->line) after
> serial8250_register_8250_port. As for me, possible solution could be
> to add a wrapper:
>
> int serial8250_em485_init_by_line(int line) {
>     struct uart_8250_port *uart = &serial8250_ports[line];
>     int ret;
>     unsigned long flags;
>
>     spin_lock_irqsave(&uart->port.lock, flags);
>     ret = serial8250_em485_init(uart).
>     spin_unlock_irqrestore(&uart->port.lock, flags);
>
>     return ret;
> }

Also, I noticed that in 8250_core.c the em485 tx handlers change the
MCR register itself. But in the case when RTS signal is itself
emulated, say by flipping a GPIO, a more generic approach would be
necessary, such as get_mctrl/set_mctrl, so that the use of helpers in
serial_mctrl_gpio.c is straightforward.

For example, in our design the RS232<->RS485 direction switch is
driven by a pin which cannot be pinmuxed as UART RTS but can be a
GPIO. Since it is already in production, making incompatible changes
to the design (and getting away with it) is not inherently feasible.


Regards,
Ilyas G.
