From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 6/6] ARM: sun8i: Add PRCM clock and reset
 controller nodes to the DTSI
Date: Tue, 15 Jul 2014 08:54:30 +0200
Message-ID: <20140715065430.GD3745@lukather>
References: <1404892479-12222-1-git-send-email-wens@csie.org>
 <1404892479-12222-7-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBTFASOPAKGQEUXLMVZI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404892479-12222-7-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-serial@vger.kernel.org


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2014 at 03:54:39PM +0800, Chen-Yu Tsai wrote:
> With sun8i PRCM support available, we can add the PRCM clock and
> reset controller nodes to the DTSI. Also update R_UART's clock
> phandle and add it's reset control phandle.
>=20
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Applied, thanks!

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTxNAmAAoJEBx+YmzsjxAgdZUP/0GVy6iVbS06Xh/ZgUOLCk4v
I+Fah2qzuc/Q+/s1ROgA29D7wBOzLkmW8lsZeTFFELTY7BQnxQJJqsmxOtIreLEz
fMT5PkIVSG8nsypEny0UF/Hb0sZ0TCftv6CgDlDl7ypmA6p0bgpPtF+fKNaAIdxQ
Z7WJ0EsZWYLATaqw7i+dtGczL96Sd0YFKVkpkxMDJyWkdhdiypQmPgqTzO/bPV4F
kFO2UcYFQLgIRqLGH+LqFUAxZXICMoWBqJHva2TelyHf7HELYNT9ydL5P5ekRAYq
1wRuZiBdDxM8Shuzn+6V/8TOWyUU11KEflbNDBYSWGPddzOaxA4X2QzmDPSzU5XU
ORwtVD7GmUu3gj2ULeIyiIVDl3bFZtj+eJ1TQXJmOilruVSJvPHVnskJoUtmza14
czPOPszCMioBTlHB9na200cQU1KaeLKr34RT8QZuh4OMfnRw7eneENgmq31qgT5C
752sxYEU5b/SEqTs2dS1iC+2nmHEFk/RvyMYGN8Pqvzxb8L91j5K7HQPcUBc+DY2
XvFypu3po/cob6BIT7OVl7rkKdCdNWCTL7GkmP834kOq4DUjHMJ2ehcXTUi02JLp
/adNn4EsMUiDvZLEEkYaZ0FMz4LLUEA5yTgZ+Frb3iqBib+spGcUkcmrvuHc5L4d
pEA5dLex/QLhkndkhV35
=laAR
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--
