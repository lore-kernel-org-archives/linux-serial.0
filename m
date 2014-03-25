From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] serial: efm32: use $vendor,$device scheme for
 compatible string
Date: Tue, 25 Mar 2014 17:19:16 +0100
Message-ID: <20140325161916.GA6374@katana>
References: <1395755954-18988-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1395759192-10797-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:40448 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753421AbaCYQTU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Mar 2014 12:19:20 -0400
Content-Disposition: inline
In-Reply-To: <1395759192-10797-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, linux-serial@vger.kernel.org, devicetree@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2014 at 03:53:12PM +0100, Uwe Kleine-K=F6nig wrote:
> Wolfgang Sang pointed out that "efm32,$device" is non-standard. So use the

"Wolfram", please. BTW, you could also use this to describe that :)

Reported-by: Wolfram Sang <wsa@the-dreams.de>

No need to resend from my side, though.

> common scheme and prefix device with "efm32-". The old compatible string
> is left in place until arch/arm/boot/dts/efm32* is fixed.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTMayEAAoJEBQN5MwUoCm2CVQP/0R3kJeZ0PEnCWSvV6BbuQVh
IFA9rcDquAGEs5A8EpOYWZhjBzDdMPCchyyrna6Mj8II2NDjrieJkoboyV6cX6rw
NE/EU2QYEU5hLRS5TLpWqxldbx7SBgxAFSlPGXpjiEmXn2oB8/qV764KequFGrH+
sG5cp48CGh0TTsKuK2CSk33l5LeZvDthhTyZOxLTT90aPPqDbtnzbsMwtvaNFLuN
FBSu+FXCnebg/y4PqX7YkZ9tDJ0b9njPdxPcXa7dlsCi+DnxYJp48y1FwHK7C31Y
bGiOkckKY8G5nPQDIrAt9+/KKb1TIy0xjA63ldtakLJsyEr12JrqgCpEPrQSCPSj
gc0Y2J4GkJ8nXYqutfXQjdIrPApab3jf7Cv7H0p7XNmvrKnGbAs+1LHlQfHkDUaJ
P0Om5R905muU2AGYC3Fi83BapaDRumPklP6+XdRWgzqvE7Al89IVMz5PGIqgtiXt
NWJXtbDrub6ZTWOUISz8NcqfU7AMKxixySWH0sH9clF0BWgeyYdNzTorDuvR4+qN
YxRhsO0PNQIA992EF9RALRWHq9+xg1rMPQ2wkYng7GOH5fRiXiis1MRY0EA3BCmS
4UydfDGAHBKUTdbLS82sZ0dpbGHw8QgGLUHCQX9f3TOjIbM8b3/4sYPJyXE8i37V
XLB0wZHk4BNR9zIojjlz
=qVuW
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
