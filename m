From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] usb: gadget serial: Honour termios CLOCAL on
 disconnect
Date: Mon, 27 Oct 2014 08:38:37 -0500
Message-ID: <20141027133837.GC8537@saruman>
References: <1414346490-19307-1-git-send-email-kyosti.malkki@gmail.com>
 <1414346490-19307-3-git-send-email-kyosti.malkki@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1414346490-19307-3-git-send-email-kyosti.malkki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Ky=F6sti_M=E4lkki?= <kyosti.malkki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 26, 2014 at 08:01:30PM +0200, Ky=F6sti M=E4lkki wrote:
> There are applications where it is desirable to not hangup ttyGS* when
> USB disconnect is detected. USB host side of communication may
> power-cycle periodically or there may be the actual need to physically
> disconnect and reconnect USB cable temporarily.
>=20
> USB disconnects on serial gadget are comparable to loss of Carrier Detect
> of conventional UARTs. With the change, if ttyGS* has termios CLOCAL flag
> set, disconnect on USB does not hangup the TTY.
>=20
> Signed-off-by: Ky=F6sti M=E4lkki <kyosti.malkki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/usb/gadget/function/u_serial.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/=
function/u_serial.c
> index 491082a..e68ffd7 100644
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -1254,8 +1254,13 @@ void gserial_disconnect(struct gserial *gser)
>  	gser->ioport =3D NULL;
>  	if (port->port.count > 0 || port->openclose) {
>  		wake_up_interruptible(&port->drain_wait);
> -		if (port->port.tty)
> -			tty_hangup(port->port.tty);
> +		struct tty_struct *tty =3D port->port.tty;

declare above as Sergei said.

> +		if (tty) {

is there any situation where tty would be NULL here ?

> +			if (tty->termios.c_cflag & CLOCAL)
> +				stop_tty(tty);
> +			else
> +				tty_hangup(tty);

this I'll defer to Greg who also maintains tty.

--=20
balbi

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUTkrdAAoJEIaOsuA1yqREN4AQAISqF4byHstBv/3gHMfjnjRb
DzLfdz+uZLGugydubjkvtuTUul+fFz3OO3od88tEDEL0PGwyqAzQP+fYjlvabXwt
hQhuV7trKlA2jaMCd2xuuLQTdqtAYHLwF+2SxqQlOMytGkwVKWTUZlX669MUbv79
7s2zLPPut6UvyaLObKaMLy4vkwdBUg3wuNkZv+Zsqd+X5H+um9Y1rfuCXNmXj0Ei
r2s4IvRdIT2UfbfDMyS/SwCkgvnPzdlSQw1/HbKNXqXxHlHv/3gtBmir6hmo4MLI
Q02knZ5oh3ClEGwaLR+fYuPHenlanjE8T1pciU9lJX7LfFvw7zwbOSdQzr22e37l
Ete2fQLaJ3S6Xc0PVeZhVU49zae8q7ZS6Suprzat4eIcmt8W7VLV3UR+/5C4+iWJ
l8f2IEyakPFcucYyeO+PDMgx5jLAJ5hCtLjn/H5+JUhChJKOcXsYrqdiMQNlWrBK
R+ShT1FkJcpl0kFMHrzm6N03jZ1/nQdKyokn5veZaeGbAOvwuyEbingZGn05zbXm
z0BrPBF7c3bzYruAqy0COysyOUhcqht5Er1NY6MyU46UcUg8SWBYXcfY6h9aJnN2
AtGjGxsNGzHjYKJuWB9Kv4mWbxHd8BC04oaWFuKcTyA/JUJZGemZXkRB4lYO50rt
Jxg6ukQmbSJ8D6cnQIMt
=ma+p
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
