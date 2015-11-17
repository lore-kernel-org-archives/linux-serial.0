From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 5/5] tty: Add software emulated RS485 support for 8250
Date: Tue, 17 Nov 2015 10:24:42 +0100
Message-ID: <20151117092442.GL22022@pengutronix.de>
References: <1447338836-8785-1-git-send-email-matwey@sai.msu.ru>
 <1447338836-8785-6-git-send-email-matwey@sai.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447338836-8785-6-git-send-email-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, peter@hurleysoftware.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello,

On Thu, Nov 12, 2015 at 05:33:56PM +0300, Matwey V. Kornilov wrote:
> +static void serial8250_start_tx(struct uart_port *port)
> +{
> +	struct uart_8250_port *up =3D up_to_u8250p(port);
> +	__u32 delay;
> +=09
> +	serial8250_rpm_get_tx(up);
> +
> +	if (timer_pending(&up->rs485_start_tx_timer))
> +		return;

I think this is wrong (or at least suboptimal). The .start_tx callback
can be called even if transmission is already ongoing. In this case you
don't want to restart the rs485_start_tx_timer.

> +	if ((delay =3D serial8250_rs485_start_tx(up))) {
> +		mod_timer(&up->rs485_start_tx_timer, jiffies + delay * HZ / 1000);
> +	} else {
> +		__start_tx(port);
> +	}
> +}
> +
> [...]
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.=
h
> index faa0e03..c4905e7 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -86,6 +86,8 @@ struct uart_8250_ops {
>  struct uart_8250_port {
>  	struct uart_port	port;
>  	struct timer_list	timer;		/* "no irq" timer */
> +	struct timer_list	rs485_start_tx_timer; /* "rs485 start tx" timer *=
/
> +	struct timer_list	rs485_stop_tx_timer; /* "rs485 stop tx" timer */

Do you really need two timers here? At each point in time there should
only be at most one of them active.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
