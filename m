From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH] mxs: uart: allow setting RTS from software
Date: Thu, 13 Dec 2012 10:20:27 +0800
Message-ID: <50C93B6B.7090206@freescale.com>
References: <1355329913-27666-1-git-send-email-s.trumtrar@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1355329913-27666-1-git-send-email-s.trumtrar@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: linux-serial@vger.kernel.org, stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

=D3=DA 2012=C4=EA12=D4=C213=C8=D5 00:31, Steffen Trumtrar =D0=B4=B5=C0:
> With the patch "serial: mxs-auart: fix the wrong RTS hardware flow co=
ntrol" the
> mainline mxs-uart driver now sets RTSEN only when hardware flow contr=
ol is
> enabled via software. It is not possible any longer to set RTS manual=
ly via
> software. However, the manual modification is a valid operation.
> Regain the possibility to set RTS via software and only set RTSEN whe=
n hardware
Is there any user case to set the RTS via software?
I am confused at this.
> flow control is explicitly enabled via settermios cflag CRTSCTS.
>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  drivers/tty/serial/mxs-auart.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-=
auart.c
> index 6db23b0..9b62c4b 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -412,10 +412,12 @@ static void mxs_auart_set_mctrl(struct uart_por=
t *u, unsigned mctrl)
> =20
>  	u32 ctrl =3D readl(u->membase + AUART_CTRL2);
> =20
> -	ctrl &=3D ~AUART_CTRL2_RTSEN;
> +	ctrl &=3D ~(AUART_CTRL2_RTSEN | AUART_CTRL2_RTS);
>  	if (mctrl & TIOCM_RTS) {
>  		if (tty_port_cts_enabled(&u->state->port))
>  			ctrl |=3D AUART_CTRL2_RTSEN;
> +		else
> +			ctrl |=3D AUART_CTRL2_RTS;
>  	}
> =20
>  	s->ctrl =3D mctrl;
> @@ -678,6 +680,10 @@ static void mxs_auart_settermios(struct uart_por=
t *u,
>  		}
>  		ctrl2 |=3D AUART_CTRL2_CTSEN | AUART_CTRL2_RTSEN;
>  	} else {
> +		u->flags |=3D ASYNC_CTS_FLOW;
> +		ctrl2 |=3D AUART_CTRL2_CTSEN | AUART_CTRL2_RTSEN;
> +	} else {
> +		u->flags &=3D ~ASYNC_CTS_FLOW;
bug.

Your code adds TWO "else" here.

thanks
Huang Shijie
>  		ctrl2 &=3D ~(AUART_CTRL2_CTSEN | AUART_CTRL2_RTSEN);
>  	}
> =20
