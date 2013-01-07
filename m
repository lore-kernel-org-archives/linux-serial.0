From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3] mxs: uart: allow setting RTS from software
Date: Mon, 07 Jan 2013 10:43:38 +0100
Message-ID: <50EA98CA.1060303@pengutronix.de>
References: <1355405263-29625-1-git-send-email-s.trumtrar@pengutronix.de> <50CA8E8C.5060906@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig104547F1DADB7B09D44B1483"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <50CA8E8C.5060906@freescale.com>
Sender: stable-owner@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig104547F1DADB7B09D44B1483
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

On 12/14/2012 03:27 AM, Huang Shijie wrote:
> =D3=DA 2012=C4=EA12=D4=C213=C8=D5 21:27, Steffen Trumtrar =D0=B4=B5=C0:=

>> With the patch "serial: mxs-auart: fix the wrong RTS hardware flow con=
trol" the
>> mainline mxs-uart driver now sets RTSEN only when hardware flow contro=
l is
>> enabled via software. It is not possible any longer to set RTS manuall=
y via
>> software. However, the manual modification is a valid operation.
>> Regain the possibility to set RTS via software and only set RTSEN when=
 hardware
>> flow control is explicitly enabled via settermios cflag CRTSCTS.
>>
>> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>> ---
>>  drivers/tty/serial/mxs-auart.c |    4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-a=
uart.c
>> index 6db23b0..9f63f88 100644
>> --- a/drivers/tty/serial/mxs-auart.c
>> +++ b/drivers/tty/serial/mxs-auart.c
>> @@ -412,10 +412,12 @@ static void mxs_auart_set_mctrl(struct uart_port=
 *u, unsigned mctrl)
>> =20
>>  	u32 ctrl =3D readl(u->membase + AUART_CTRL2);
>> =20
>> -	ctrl &=3D ~AUART_CTRL2_RTSEN;
>> +	ctrl &=3D ~(AUART_CTRL2_RTSEN | AUART_CTRL2_RTS);
>>  	if (mctrl & TIOCM_RTS) {
>>  		if (tty_port_cts_enabled(&u->state->port))
>>  			ctrl |=3D AUART_CTRL2_RTSEN;
>> +		else
>> +			ctrl |=3D AUART_CTRL2_RTS;
>>  	}
>> =20
>>  	s->ctrl =3D mctrl;
> Reviewed-by: Huang Shijie <b32955@freescale.com>

This patch is not not in today's next. What's the current status? Who
will take it?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig104547F1DADB7B09D44B1483
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDqmM8ACgkQjTAFq1RaXHPpoQCeINw17Fd/78wKWLgyXGswMDb1
fncAn18iREtoC7ierWtB+++uenGm/9lu
=yfUb
-----END PGP SIGNATURE-----

--------------enig104547F1DADB7B09D44B1483--
