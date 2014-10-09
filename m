From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] u_serial.c - Force destroy tty_port in gserial_free_port
Date: Wed, 8 Oct 2014 20:06:42 -0500
Message-ID: <20141009010642.GB4178@saruman>
References: <5435D59F.3050704@analog.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45353 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036AbaJIBGr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Oct 2014 21:06:47 -0400
Content-Disposition: inline
In-Reply-To: <5435D59F.3050704@analog.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andre Wolokita <Andre.Wolokita@analog.com>
Cc: linux-usb@vger.kernel.org, balbi@ti.com, stern@rowland.harvard.edu, alan@linux.intel.com, linux-serial@vger.kernel.org

--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 09, 2014 at 11:23:59AM +1100, Andre Wolokita wrote:
> Issuing a modprobe -r g_serial command to the target
> over the gadget serial communications line causes
> modprobe to enter uninterruptable sleep, leaving the
> system in an unstable state.

does anybody know if this is a valid usecase ? I'd expect us to return
-EBUSY in such a case, no ? In any case, using g_serial to rmmod
g_serial is, from what I can tell, not supported.

Let's wait to hear from Alan Cox or somebody else.

> The associated tty_port.count won't drop to 0 because
> the command is issued over the very line being removed.
>=20
> Destroying the tty_port will ensure that resources are
> freed and modprobe will not hang.
>=20
> Signed-off-by: Andre Wolokita <Andre.Wolokita@analog.com>
> ---
>  drivers/usb/gadget/function/u_serial.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/=
function/u_serial.c
> index ad0aca8..db631c4 100644
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -1074,10 +1074,10 @@ static int gs_closed(struct gs_port *port)
>  static void gserial_free_port(struct gs_port *port)
>  {
>         tasklet_kill(&port->push);
> +       tty_port_destroy(&port->port);
>         /* wait for old opens to finish */
>         wait_event(port->port.close_wait, gs_closed(port));
>         WARN_ON(port->port_usb !=3D NULL);
> -       tty_port_destroy(&port->port);
>         kfree(port);
>  }
>=20
> --=20

--=20
balbi

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUNd+iAAoJEIaOsuA1yqREw8MP/j+v0sOHNIhkL5HdqMSN0XEv
EXTZ8gIXDjp1wX64BRxLvBbolCjzb25bqvWEpQ19vM69fZ8iXPc3K2FQoza99pHZ
7wOYsSQgxYyn3bYi7Acv/c9C8LmfE0knSzfvI5lDywJDLaXxwE+pGbGph7zFunTt
BpxHSbnpfFa8B55zUmzTZ4WDO1yjPkogDSvVPD1k+nKBErW6rKgQZmqRtcFK4itZ
WvCy7o+0Ykd7d07xjynF4m7drtkeDLdm31E88kktS26gToThVTkX/VM1Kn2Wq2na
o+ZTZd2Hg5kFqI3LTgQMfhF/rLxP5zwsyVo7J6o/bJzNNwXRNJ6brx3FsnXmfWLh
PxYrcpjovnHoR4w3CnW3j7PU7h1qbaXirtLIy5yZibemPCi9HAXkZBSB9Nd0jbmY
38I3mD01MrvdtVXTDTa73h3jaFV/QF/Shjp3CrqK9YXrxG+Cq/PKLNywH/Kc8bBP
ME+6K4/hL82fp4qR7572Ds5b9GHwz4YvHoJndyEChPKy5/4AXNuc6hsvfvxcI+SC
R6ydJ09efyBk4V8cNyXQ3vEL/87RS+3hlcIUW5IiX0dfSoyG1DWLZUJ+DMlv6Avs
Xe5S42wEzwU5JngDoT8cK456qNxZNXTHjwCHHegQbA8rYnBFNSxso6Wguzdx4U+f
L9UtKbi8l91G3eauu4MB
=AVf8
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
