From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 4/8] pwm: atmel-hlcdc: fix struct clk pointer comparing
Date: Wed, 11 Mar 2015 11:54:23 +0100
Message-ID: <20150311105422.GC22149@ulmo.nvidia.com>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-5-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1890710781=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1424876018-17852-5-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, Mike Turquette <mturquette@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


--===============1890710781==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2015 at 10:53:34PM +0800, Shawn Guo wrote:
> Since commit 035a61c314eb ("clk: Make clk API return per-user struct clk
> instances"), clk API users can no longer check if two struct clk
> pointers are pointing to the same hardware clock, i.e. struct clk_hw, by
> simply comparing two pointers.  That's because with the per-user clk
> change, a brand new struct clk is created whenever clients try to look
> up the clock by calling clk_get() or sister functions like clk_get_sys()
> and of_clk_get().  This changes the original behavior where the struct
> clk is only created for once when clock driver registers the clock to
> CCF in the first place.  The net change here is before commit
> 035a61c314eb the struct clk pointer is unique for given hardware
> clock, while after the commit the pointers returned by clk lookup calls
> become different for the same hardware clock.
>=20
> That said, the struct clk pointer comparing in the code doesn't work any
> more.  Call helper function clk_is_match() instead to fix the problem.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/pwm/pwm-atmel-hlcdc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVAB7eAAoJEN0jrNd/PrOh9YcP/RkPCXu45VwcVdVStHzH6Cn8
N9QkZdfN7ZoImawBuqzvkJJTgSDH078ztV1Xy11A65axi5c4NuaByqe4lC+4gNUZ
EqeCaIG/EzDg26/YTb78p1TdTux8y2cfJSpFUQAdpojHxH8nKpQ33kcrjS5eYwi6
J3rk3nt1OAR/15cIFfvp41TTIXPouINmiTnUkvx56u6ptSonn3sJulwJUiPN+tpB
r4uRv2TVI0pLF82PmCX3R0wxyGaBj8d3CTyb1X5IXoMs5YVmPG501OYMi9Sp7uKR
Q2Lx+++LBZl9La9EPHEVMZ/2GXBeougzTo2bCmZ/AGcHBVEQZNPgFCr0bn4nY6QO
Dp2FCi9Xaiqey2Z5hvIR5u7Jgj1HVtL3yFAZBcsErq1BPDJel/NSErY+OmPpMJJx
0msm7wn9DVNEU5AehHaD81PjnCtHcf2TI8OjkwDlU1cLDFet5czNHAEK/d2dezwO
x5IfE4pbjkrj1K4Hek5Q5WHpP0KcomOtzglQAsVihi6P8qdCSyfh6+XP3u3pXcLS
so0dEJLg5isTO2zuLt9Wekfz5ho4Kc/oh23p1cbIhWlNoAo6f9kQ9GGKL9w2DAUk
IOjyJij5ZeFRQY6T/djwNBAePIlwl455hvaEOPyiyjWUNJudi4RjDbkjSk3fnT+R
Hoyt2z4Qi6cIJEdu1kew
=1SFi
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--

--===============1890710781==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============1890710781==--
