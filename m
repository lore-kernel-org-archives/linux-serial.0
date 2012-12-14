From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH v3] mxs: uart: allow setting RTS from software
Date: Fri, 14 Dec 2012 10:27:24 +0800
Message-ID: <50CA8E8C.5060906@freescale.com>
References: <1355405263-29625-1-git-send-email-s.trumtrar@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1355405263-29625-1-git-send-email-s.trumtrar@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: linux-serial@vger.kernel.org, stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

=D3=DA 2012=C4=EA12=D4=C213=C8=D5 21:27, Steffen Trumtrar =D0=B4=B5=C0:
> With the patch "serial: mxs-auart: fix the wrong RTS hardware flow co=
ntrol" the
> mainline mxs-uart driver now sets RTSEN only when hardware flow contr=
ol is
> enabled via software. It is not possible any longer to set RTS manual=
ly via
> software. However, the manual modification is a valid operation.
> Regain the possibility to set RTS via software and only set RTSEN whe=
n hardware
> flow control is explicitly enabled via settermios cflag CRTSCTS.
>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  drivers/tty/serial/mxs-auart.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-=
auart.c
> index 6db23b0..9f63f88 100644
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
Reviewed-by: Huang Shijie <b32955@freescale.com>
