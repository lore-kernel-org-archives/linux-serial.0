From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 2/3] tty: Add software emulated RS485 support for 8250
Date: Sat, 23 Jan 2016 17:15:27 +0200
Message-ID: <CAHp75VeABMtpU41W62UFxnQgrUJi+PSQNuXHSGo3o4TVNPAPkQ@mail.gmail.com>
References: <1453235597-5078-1-git-send-email-matwey@sai.msu.ru>
	<1453235597-5078-3-git-send-email-matwey@sai.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453235597-5078-3-git-send-email-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 19, 2016 at 10:33 PM, Matwey V. Kornilov <matwey@sai.msu.ru=
> wrote:
> Implementation of software emulation of RS485 direction handling is b=
ased
> on omap_serial driver.
> Before and after transmission RTS is set to the appropriate value.
>
> Note that before calling serial8250_em485_init the caller has to
> ensure that UART will interrupt when shift register empty. Otherwise,
> emultaion cannot be used.
>
> Both serial8250_em485_init and serial8250_em485_destroy are
> idempotent functions.

Seems you have issues with kernel-doc and commentary styles.

=46unctions in kernel doc are marked as func(), so don't forget parens.

Multi-line comment blocks are going in the style like:

/*
 * Text line 1.
 * Line 2. New sentence.
 */

You may notice the periods at the end of sentences. There is no need
to keep more heading spaces.

> +
> +static void serial8250_em485_handle_start_tx(unsigned long arg);
> +static void serial8250_em485_handle_stop_tx(unsigned long arg);
> +

And you need forward declarations because of some cyclic dependency?

> +static void serial8250_start_tx(struct uart_port *port)
> +{
> +       struct uart_8250_port *up =3D up_to_u8250p(port);
> +
> +       serial8250_rpm_get_tx(up);
> +

> +       if (up->em485 &&
> +           up->em485->active_timer =3D=3D &up->em485->start_tx_timer=
)
> +               return;

struct uart_8250_em485 *em485 =3D up->em485;

if (em485 && em485->active_timer =3D=3D &em485->start_tx_timer)

?

Same for the rest of code.

> +
> +       if (up->em485)
> +               start_tx_rs485(port);
> +       else
> +               __start_tx(port);
> +}

> +struct uart_8250_em485 {
> +       struct timer_list       start_tx_timer;

=E2=80=A6/* "rs485 start tx" timer */

-> kernel-doc

> +       struct timer_list       stop_tx_timer;  /* "rs485 stop tx" ti=
mer */
> +       struct timer_list       *active_timer;  /* pointer to active =
timer */
> +};

--=20
With Best Regards,
Andy Shevchenko
