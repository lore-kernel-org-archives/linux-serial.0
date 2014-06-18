From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 18/20] ARM: sunxi: Add earlyprintk
 support using R_UART (sun6i/sun8i)
Date: Wed, 18 Jun 2014 14:29:03 +0200
Message-ID: <20140618122903.GT19730@lukather>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-19-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q43QQdzFtqSKgsg+"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBS4MQ2OQKGQER66WV7Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403016777-15121-19-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Luc Verhaegen <libv-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


--Q43QQdzFtqSKgsg+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2014 at 10:52:55PM +0800, Chen-Yu Tsai wrote:
> sun6i/sun8i have a UART in the RTC block group, which can be used
> as an early console. This is most useful on sun8i as UART0 is muxed
> with MMC0, which is not available if we boot from MMC.
>=20
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--Q43QQdzFtqSKgsg+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJToYYPAAoJEBx+YmzsjxAgIQsP/2tedrS0v6LTLdvfngQkTDfg
/qlHdMkkyMY7cZwAamr1k/isVJ2GUrTAE8ERyY7Hq1wjc/DwTXVQIf9fI2xfSzjN
ePYhCwTPxDeEv0QZIjJHiWvIkteT9tsBCFm6X9Jp0v7tz3ZPx0EdslCCaaRhnTKL
jFSOS0nhUXBxn8RrOQ0fHkMlrAhjAqCiPzeksqEdwGOH8LeNQVduxm/j/dlF8mmu
9gUvF09ExtB+4g3fly/s4Tf5ki+R47uP6YTT3rjbkjQ4AXCa5l5vMlcjJSE2hPTt
vsK4Tq6O668xg9HbOqQaS5270wEgYIJdOJYaQCBMAa5a1C5om9nEFXwx52pr/KJ2
5fsfRu6jc4LuHk5A5m3DuDVmBImXPAMedPvLxTN3fDBWqQNrZf6VOHjt4D4FVMh7
nHNhis2UlFWwuarvODw5eOXPytlgsXJPP2DqFLyxgoWSVY463umLIjirRchx6ZGF
/YmC+pPf2tCiOjfLkdI281iagHg/l0v+sufVq1CSep5fZn7aPJYAv7BS+UZacLt5
I96H4yELqVA8+Apger5m7LHyTUuCHS0ybFEI5zEyRryyy5qoUjgIJZZ4WV+6odef
lfLFoUtXBTNyKkCkFr+WCKJLj/P2O8kLXbLvkZW632lokRIPkBMGCOgQ8825lnUa
ptj8vs559PfAekHd59k0
=Asgi
-----END PGP SIGNATURE-----

--Q43QQdzFtqSKgsg+--
