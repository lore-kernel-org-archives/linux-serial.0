From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH] 8250: Don't restore NS16550 mode when console suspend
	is disabled
Date: Wed, 13 May 2009 00:08:07 +0200
Message-ID: <20090512220807.GA26588@rere.qmqm.pl>
References: <20090512210015.GA25540@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757105AbZELWIZ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090512210015.GA25540@plexity.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Deepak Saxena <dsaxena@plexity.net>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
List-Id: linux-serial@vger.kernel.org

On Tue, May 12, 2009 at 09:00:16PM +0000, Deepak Saxena wrote:
> Commit b5b82df6, from May 2007, breaks no_console_suspend on the OLPC=
=20
> XO laptop. Basically what happens is that upon returning from resume,=
=20
> serial8250_resume_port() will reconfigure the port for high speed
> mode and all console output will be garbled, making debug of the=20
> resume path painful. This patch modifies serial8250_resume_port() to=20
> not touch the port in the case where it is the console port and conso=
le=20
> suspend is disabled.
[cut]
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -2887,7 +2887,8 @@ void serial8250_resume_port(int line)
>  {
>  	struct uart_8250_port *up =3D &serial8250_ports[line];
> =20
> -	if (up->capabilities & UART_NATSEMI) {
> +	if ((up->capabilities & UART_NATSEMI) &&=20
> +	     (!uart_console(&up->port) && console_suspend_enabled)) {

Shouldn't this be || instead of && - as in: if it is NOT a console port
OR console suspend is enabled?

Best Regards,
Micha=B3 Miros=B3aw
