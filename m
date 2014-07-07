From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 2/9] clk: sunxi: Fix gate indexing for
 sun6i-a31-apb0-gates
Date: Mon, 7 Jul 2014 10:54:11 +0200
Message-ID: <20140707085411.GE16262@lukather>
References: <1404399349-20237-1-git-send-email-wens@csie.org>
 <1404399349-20237-3-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FEz7ebHBGB6b2e8X"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:55090 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752048AbaGGIzE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Jul 2014 04:55:04 -0400
Content-Disposition: inline
In-Reply-To: <1404399349-20237-3-git-send-email-wens@csie.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Emilio Lopez <emilio@elopez.com.ar>, Mike Turquette <mturquette@linaro.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-sunxi@googlegroups.com


--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2014 at 10:55:42PM +0800, Chen-Yu Tsai wrote:
> sun6i-a31-apb0-gates supports using clock-indices for holes between
> individual gates. However, the driver passes the number of gates
> registered in clk_data->clk_num, which of_clk_src_onecell_get uses
> to recognize the range of valid indices a consumer can use.
>=20
> This patch makes the driver pass the maximum gate index + 1, so
> of_clk_src_onecell_get does not complain about indices greater
> than gates registered.
>=20
> This was tested on the A23 SoC, which has a similar APB0 clock,
> but has holes for gates to removed IP blocks.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied, thanks!

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--FEz7ebHBGB6b2e8X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTumAzAAoJEBx+YmzsjxAgsioP/3n6MRCTcmiyia1fnSbYggxM
WlrlrVXfVmxRPR+PPYe7PHJOz515tE3WIHu5ZDagtLI3yKJpiblI4xBX1A5s+l65
/zHNjOi7ILVbwEzVHMcQEDf3WexYgArWZ6miilF4XF2QwrnTDSMqOfPvX0qndSBw
dIRNwVDVJLFt6dWECeJbMWpXQgn64NryPt6s7WslEV9fen9FiYzCAWk3Y+mOPxRh
HgP+nXLlXXoHK6a3q+lbtxAty5z1JlspTL9fpJZ2e3Tb7i7LRaV0UF6Z1eqcKeEf
TMUI9d/ykBu7PNtMFpdzLoos9XBvscgBi9mqzktL/yElM1PWMerf4F/1qTq1LKV4
4A448GnRR5HjVc9QuG9AZUKjbfYkYBve3Kh+0nImIDSId36dIc14gMQkSe2Pb7jk
YQB75+rgy7oIPxS5dv6vOxJz8gG7e+iFm7QsjYTnCvDYQBxqItBjbaWi1R767Fco
P2S4NJ3iEkDJAnD0j9adaGR2/b/qYXyL0o5Dva1j1M1hROp+lic0Ml9+l63t7fnh
g5GRdJ/qLK8ic4zzcPivzxakXviezhS9ANP4WiNEH0zzc2pED1gxM0lOv62ushHo
bqgCXG201l6nHLopeKdBz1r7zKdCG4jjRpCbDULVIpDu+mvni4KEM35xuHxYA4a1
uNqiRLR4A5BKivTV75o8
=300N
-----END PGP SIGNATURE-----

--FEz7ebHBGB6b2e8X--
