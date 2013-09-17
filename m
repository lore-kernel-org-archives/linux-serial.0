From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH] serial: samsung: add support for manual RTS setting
Date: Tue, 17 Sep 2013 12:18:50 +0200
Message-ID: <35383907.gKXZyKLrYq@amdc1227>
References: <1378894107-7904-1-git-send-email-jose.goncalves@inov.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:54689 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145Ab3IQKTA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Sep 2013 06:19:00 -0400
In-reply-to: <1378894107-7904-1-git-send-email-jose.goncalves@inov.pt>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?ISO-8859-1?Q?Jos=E9_Miguel_Gon=E7alves?= <jose.goncalves@inov.pt>
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Hi Jos=E9,

Please see my comments below.

On Wednesday 11 of September 2013 11:08:27 Jos=E9 Miguel Gon=E7alves wr=
ote:
> The Samsung serial driver currently does not support setting the
> RTS pin with an ioctl(TIOCMSET) call. This patch adds this support.
>=20
> Signed-off-by: Jos=E9 Miguel Gon=E7alves <jose.goncalves@inov.pt>
> ---
>  drivers/tty/serial/samsung.c |   17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsun=
g.c
> index f3dfa19..e5dd808 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -407,7 +407,14 @@ static unsigned int s3c24xx_serial_get_mctrl(str=
uct
> uart_port *port)
>=20
>  static void s3c24xx_serial_set_mctrl(struct uart_port *port, unsigne=
d
> int mctrl) {
> -	/* todo - possibly remove AFC and do manual CTS */
> +	unsigned int umcon =3D rd_regl(port, S3C2410_UMCON);
> +
> +	if (mctrl & TIOCM_RTS)
> +		umcon |=3D S3C2410_UMCOM_RTS_LOW;
> +	else
> +		umcon &=3D ~S3C2410_UMCOM_RTS_LOW;
> +
> +	wr_regl(port, S3C2410_UMCON, umcon);

I wonder if port capability shouldn't be considered here. Depending on =
SoC,=20
only selected ports provide modem control capability.

=46or example on S3C64xx only ports 0 and 1 support modem control, whil=
e=20
ports 2 and 3 don't.

>  }
>=20
>  static void s3c24xx_serial_break_ctl(struct uart_port *port, int
> break_state) @@ -774,8 +781,6 @@ static void
> s3c24xx_serial_set_termios(struct uart_port *port, if (termios->c_cfl=
ag
> & CSTOPB)
>  		ulcon |=3D S3C2410_LCON_STOPB;
>=20
> -	umcon =3D (termios->c_cflag & CRTSCTS) ? S3C2410_UMCOM_AFC : 0;
> -
>  	if (termios->c_cflag & PARENB) {
>  		if (termios->c_cflag & PARODD)
>  			ulcon |=3D S3C2410_LCON_PODD;
> @@ -792,6 +797,12 @@ static void s3c24xx_serial_set_termios(struct
> uart_port *port,
>=20
>  	wr_regl(port, S3C2410_ULCON, ulcon);
>  	wr_regl(port, S3C2410_UBRDIV, quot);
> +
> +	if (termios->c_cflag & CRTSCTS)
> +		umcon =3D S3C2410_UMCOM_AFC;

Is it correct to override the last manual RTS value set to this registe=
r=20
when activating manual flow control?

Shouldn't the code be more like the following:

	umcon =3D rd_regb(port, S3C2410_UMCON);
	if (termios->c_cflag & CRTSCTS)
		umcon |=3D S3C2410_UMCOM_AFC;
	else
		umcon &=3D ~S3C2410_UMCOM_AFC;
	wr_regl(port, S3C2410_UMCON, umcon);

Probably port capability should be considered here as well.

Best regards,
Tomasz

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
