From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 02/22] clk: sunxi: register clock gates with clkdev
Date: Sun, 25 May 2014 20:47:11 +0200
Message-ID: <20140525184711.GO10768@lukather>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-3-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/+Vq7w28QOSGzSM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1400831485-28576-3-git-send-email-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mike Turquette <mturquette@linaro.org>, Emilio Lopez <emilio@elopez.com.ar>, Linus Walleij <linus.walleij@linaro.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Luc Verhaegen <libv@skynet.be>
List-Id: linux-serial@vger.kernel.org


--2/+Vq7w28QOSGzSM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2014 at 03:51:05PM +0800, Chen-Yu Tsai wrote:
> The new important clock protect code requires the clocks be
> registered with clkdev. This was missing for sunxi_gates
> type clocks.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--2/+Vq7w28QOSGzSM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTgjqvAAoJEBx+YmzsjxAgh0cP/17zY8NyjohxTAb7AQLl747G
IlaoShdR0aAtbwvKlK+PHze4oPnfcXK/ZHDb0TQkb2tIaA1hSmm+u/WmappQldRb
6VH+h2t2bGUKqqTt0mIzyu7aW764ZisxUpOV7F0m2WvRKF33uBN4pDeV+/9qX4tb
eXeNegkLra6WKQ+HKZYdprrCq7xnHIinGekzweIQKYUl5CBprzWGl5uU52aBCnwg
iONiQBSdNL/Kae2xcoptaSGdSoL+37eZP7NeP4/AMCBIwPtFmP0qzd9srWaEHp3Q
ozIryELEHROOXi1lR07RMUgTyvDFrBTUYweEudl6n9oUNt1aKjCFOM7iqevDFRup
bmVTCWsXdyAMespEco1+qNKGTsmoeq3PSTD40d0S3e5N0sGzG/l3WBnINwGoSUpM
zu6fT+iN8c9r52wtm5nG6CdBLW5o3UAWvo92G5Vp40YMdhAc/7Kj2CIY6iWLwImP
KJN5u0zEvJGtYv0rmYSwAd1l9gvu/wQW9gKNppxFfPZxBEZU08yJThGwEwNM1fid
5Jl/sWW4k0rvWpnaHeC+MpLvrFC8zUsdvLqhhogzKw2uG7KJJ5hweQrJZo88mr37
XSHQa4873dKE9ucOO9Fg+wJW6WVeTah8wmCMCmBcFqN7PniZN9Zxq1tZY7aOWQuR
7aWfhb1VPIVveA0JXXgp
=Yw5I
-----END PGP SIGNATURE-----

--2/+Vq7w28QOSGzSM--
