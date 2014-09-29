From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RESEND] tty: serial: omap: Remove probe error message
Date: Mon, 29 Sep 2014 09:03:51 -0500
Message-ID: <20140929140351.GE32403@saruman>
References: <1411975782-23709-1-git-send-email-mpa@pengutronix.de>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5xSkJheCpeK0RUEJ"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45344 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165AbaI2OEe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 29 Sep 2014 10:04:34 -0400
Content-Disposition: inline
In-Reply-To: <1411975782-23709-1-git-send-email-mpa@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2014 at 09:29:42AM +0200, Markus Pargmann wrote:
> This error message is not necessary. The driver core code will print all
> probe error messages. It also resolves some error codes to proper error
> messages. For example -EPROBE_DEFER will only be printed as an info messa=
ge.
>=20
> This patch removes the error message as the core prints the same
> information.
>=20
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

fine by me:

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--5xSkJheCpeK0RUEJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKWbHAAoJEIaOsuA1yqREJEgQAIUlTIS4ftVcz2EW/br9oXn4
scuV0Liw09W7VppmDBt9cPdmn4kMCLK8H3YdLcaAkdyFnc23pJ7kvJrfkxJyqd6p
8t3jOd2pETd/090hRqlDCrN2/S580obPZweM92gfknfNzRq4H/hppHW33H4bJpmH
kfrrw0qQyIc08XpRdcP/41wne5AUSqTf0zuZsjHbnvlRRxE29ov16g/qeaNdJOn6
n8KW6fRNrUZCq0FlneO+cxa13EpPR/l0SidHdrVjPt34UqDnaBNXpQLvnmBjvJkp
oR6/I4AY1nybh0Aj5F7iexPkoUHS4h2Swhk+DLGS4Hhm4q795nNTXVwi+Pp7mOjV
ahzxjRXtRJ/78GYCJ+jI/UJJvmjMeafN6iQXxB2V/g6GHBsLUISDyhx+Bx+ltmuZ
JgbIMUvcTBYmUJ62Q+KFMJiq2+F6lyFJuZQiGoOPpzDqaUp2NoKr91zz/1JI8vB/
5ZkyE1S2xV+rakG2NfGM9ESyRseouX/FWIIq5yWZfZV6GZz3vwzmNxYT6Kq7ta6r
uJMLu0wL+OBqyYLqieGg6NOUBsvxErmEoM8Lc7wA/4Jtzyy3xnjbdRMnzyUwxe5r
UiCTLl8OMyAwsd+4RCDndR+y9hI4OHu157P08nDaOxrjKksBSSLxs9HTsMwNg4Fu
iM04hfKR8RooOwcRW+iR
=QYV/
-----END PGP SIGNATURE-----

--5xSkJheCpeK0RUEJ--
