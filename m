From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] serial: sh-sci: Support for HSCIF RX sampling point
 adjustment
Date: Wed, 15 Nov 2017 16:07:25 +0100
Message-ID: <20171115150724.tj46vdznx5ht6a3b@ninjato>
References: <1506690534-27302-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1506690534-27302-3-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bw7y2nwtmsz35qki"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1506690534-27302-3-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org, linux-serial@vger.kernel.org, magnus.damm@gmail.com
List-Id: linux-serial@vger.kernel.org


--bw7y2nwtmsz35qki
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2017 at 03:08:54PM +0200, Ulrich Hecht wrote:
> HSCIF has facilities that allow moving the RX sampling point by between
> -8 and 7 sampling cycles (one sampling cycles equals 1/15 of a bit
> by default) to improve the error margin in case of slightly mismatched
> bit rates between sender and receiver.
>=20
> This patch allows changing the default (0, meaning center) using the
> sysfs attribute "rx_sampling_point".
>=20
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Wasn't there a conclusion in a chat meeting we had how to move this
forward? How much effort would be implementing that?


--bw7y2nwtmsz35qki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloMWCwACgkQFA3kzBSg
KbZI+w/7BHMB3paOHn841ZPvcB6zvXdyT1wbGl6mdd1qIXRNV0HwpgFifWHdiDh4
Pq7TVL6+E5F0n2/i8QVhrneW8s+ICKVhnw0qhzSgl/EXBgzaMvEBcHfYCSrwmzLa
QPeeyD/BcMP2p0vuIEb80rBC5Hfv39gyL5rBnHsziP/787FyHI/4rkrBTEhweXYE
zESE6JA22quAMZAlcB1v2Y5yYqEmQklHxUlryZ6OzHKAP/5zSspoMfNQtfVYWW6j
0TdpmcgQSLo3EoZBzzxHRUvbddcmoS8UFna3f5IIwcmv4NwKbdpKJv4rTA++mAEV
7HIc80m9ng+DQAyDLNWBGKKp3RJ9CYZbR23UjZXgWBwaV3fhImitYkoEDRASe1oa
AcLMugQKSlaTf5ecqTcGQ4FSXT7N8/54wDTJX0u3QopIkMtaTmHcfAmTdvjY7Gsu
EAdyCxHSLVYuNyxRHDq8D767vBpKV/LtpsnPU+0x9/fXEkJz6E5kH33Zhy0jMy55
F7gHVbPJNfPs/eUkivqg8JHLW0WKluHhZyoVKiVGLPpyNXeP7UNrQtBgA7LGQfTt
qlNUr0L2t8xREInBgv0Wp5E+k9zK+T55rapTtmKQL6SLLwxMo172JMroZGJGmG5D
35o2/98BauPbqv49r7Y5aPaiN2NpqKG5/vgs+abYjUhSbq5/IeM=
=n+wu
-----END PGP SIGNATURE-----

--bw7y2nwtmsz35qki--
