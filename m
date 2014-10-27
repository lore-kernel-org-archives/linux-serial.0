From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] usb: gadget serial: Honour termios CLOCAL on
 disconnect
Date: Mon, 27 Oct 2014 10:46:18 -0500
Message-ID: <20141027154618.GC10814@saruman>
References: <1414346490-19307-1-git-send-email-kyosti.malkki@gmail.com>
 <1414346490-19307-3-git-send-email-kyosti.malkki@gmail.com>
 <20141027133837.GC8537@saruman>
 <544E680A.9010700@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <544E680A.9010700-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Ky=F6sti_M=E4lkki?= <kyosti.malkki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2014 at 05:43:06PM +0200, Ky=F6sti M=E4lkki wrote:
> On 10/27/2014 03:38 PM, Felipe Balbi wrote:
> >Hi,
> >
> >On Sun, Oct 26, 2014 at 08:01:30PM +0200, Ky=F6sti M=E4lkki wrote:
> >>There are applications where it is desirable to not hangup ttyGS* when
> >>USB disconnect is detected. USB host side of communication may
> >>power-cycle periodically or there may be the actual need to physically
> >>disconnect and reconnect USB cable temporarily.
> >>
> >>USB disconnects on serial gadget are comparable to loss of Carrier Dete=
ct
> >>of conventional UARTs. With the change, if ttyGS* has termios CLOCAL fl=
ag
> >>set, disconnect on USB does not hangup the TTY.
> >>
> >>Signed-off-by: Ky=F6sti M=E4lkki <kyosti.malkki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>---
> >>  drivers/usb/gadget/function/u_serial.c | 9 +++++++--
> >>  1 file changed, 7 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadge=
t/function/u_serial.c
> >>index 491082a..e68ffd7 100644
> >>--- a/drivers/usb/gadget/function/u_serial.c
> >>+++ b/drivers/usb/gadget/function/u_serial.c
> >>@@ -1254,8 +1254,13 @@ void gserial_disconnect(struct gserial *gser)
> >>  	gser->ioport =3D NULL;
> >>  	if (port->port.count > 0 || port->openclose) {
> >>  		wake_up_interruptible(&port->drain_wait);
> >>-		if (port->port.tty)
> >>-			tty_hangup(port->port.tty);
> >>+		struct tty_struct *tty =3D port->port.tty;
> >
> >declare above as Sergei said.
> >
> >>+		if (tty) {
> >
> >is there any situation where tty would be NULL here ?
> >
> >>+			if (tty->termios.c_cflag & CLOCAL)
> >>+				stop_tty(tty);
> >>+			else
> >>+				tty_hangup(tty);
> >
> >this I'll defer to Greg who also maintains tty.
> >
>=20
> My main concern is if someone runs getty on ttyACM without explicitly
> clearing CLOCAL. With the patch here login session would no longer get
> SIGHUP if cable is disconnected. And it is not possible to tell if it is =
the
> same cable that is plugged back in.

true, but woudln't the same thing happen with a real UART port using
8250.ko ?

--=20
balbi

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUTmjKAAoJEIaOsuA1yqREBIgP/1VkYGtQ8D8h97rQROAG6A46
lMwOD1w8hzmJHIt3aMMOzUcAYWD9cqnDs+J2KLPvnzlBPQwF/D7rO5n1fOt2y8VE
bBRi/+Hg8c9j4a/5NxQTSSTicwcl/HvT+VzMA6TBE0TBPlNJHNcLChoN4dNtgTYZ
Jhgzatkoym9iGPzMAGGaljds2Ficb/GfYxqB5K4Oxh4Sp4Thu8d1B7JUVvPR5lnT
wpZNALuIWx6rsFpxsHZh9oqTpLFH2dm0d8SPOrhWQqXA3sbmVvC//F6vmVWYP8jX
gQnaeT/vMjweDNVnqxOzESvRmKg1cFzD3yUPoR9O9BhrdfAOrWqvDU15D/sXRdZG
0hPEig5Xbvbx4dmUvQALUTYWWrqPiVoYAd2K+ORKZZ2CpscMdp1nu5rblb8XPnfz
qf3w8UZh+R1MTQWrOU51v95gwAMKraPa8p7Yn4dba8rWVzGnrQh8Ol1CySjkngzq
mMLmUgVTatqNuuNvwG5LozqRr3E4stvbj/qRdU3mBV3vVXr6JewYIZjOR/mr7APl
OTemSEn3uaHC/5uBwhcYADHeoJlkxltzQtAaDKF2/5pTtyZGclCEBZRGAUhEeHzj
6UJ8gDHMF8tRPpIqYdLx3Wr88mPiZunKOTNcEK0WySwnIeJE0AU1kJzGhHhtOkbx
CaUGjs5CyTWbBCW2mXN+
=ur1F
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
