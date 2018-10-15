From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] serial: sh-sci: Fix receive on SCIFA/SCIFB variants with
 DMA
Date: Mon, 15 Oct 2018 13:49:20 +0200
Message-ID: <20181015114920.hx4rtzr2fo5naorj@ninjato>
References: <20181009174158.4476-1-geert+renesas@glider.be>
 <20181012121908.sbwsojs7vvhiztbb@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k4uzfupmzauvxy5n"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181012121908.sbwsojs7vvhiztbb@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ulrich Hecht <uli+renesas@fpond.eu>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--k4uzfupmzauvxy5n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Fixes: 2c4ee23530ffc022 ("serial: sh-sci: Postpone DMA release when fal=
ling back to PIO")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> > ---
> > Reported on r8a7790/lager using SCIFA1 on Debug Serial 1.
>=20
> I hope to test this on Lager this weekend. I am quite sure it will work
> now, but then we have this formally checked, too.

Done now:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--k4uzfupmzauvxy5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvEfsAACgkQFA3kzBSg
KbYh1w//eqA65zYJZAZkilUKm28PvurMC2FWvglvInAhI5uzUpL1BZL8UTRJstCo
Gh8fTQ+TNRv8qtjXTNLLd+5bZO4jD6lS/jIimQyqRYi4zP87azqlnhkxcD31ZTXc
zg+cpvGvdUymH/20hpbHPaQjrFCdV37kRr6Pr3EEHCjZh7N8A3P8TKjZfnC3E8pC
DOeG65bCCJO8b/I7+MbE48M/YDrARpyBblCVt6UO9a5PCKBsGmcj7pVUUws7cGW9
jAFTNk64r1pMoF/O8+Fv21UD8qwSyg/mPuLT6QSJQY2ZYJ5oMMeXL1S+ao7EMnnF
ba2kbc5rc/kd+S221nCEc/QRa9xr2v+fnibNn/PKHa4pLYlcpAaxJ94xpIfmZazZ
axKEpgoPPUMp1VdSkJLKLGI5An9ZVWLUQ13DhBh/8iOmXfSpFExtmqNgRcm+/EDq
mRgsQbAjkK6kQqjdlv0NiKXyHwtA8MEQj105SvdNne84R1M3pKBz9diQbDjRxCIP
srsMpPFQ9gSvSSyh+AjQlcKbXCiyyx80hlXSixbrFddjPHiJzU52CWU47dLWNU1p
Tt6NNKnTJyCHmShjw5w3pH9t1lNi2ZHjG/0vBpTvRaMq5061hGBBBrjecrkbCLy0
I7GCOvfznSeeO/GL9N/uwgxfIQXwS6FnOKXt4QnYkM3Je+YNvi4=
=c8BO
-----END PGP SIGNATURE-----

--k4uzfupmzauvxy5n--
