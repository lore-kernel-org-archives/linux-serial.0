From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 06/22] clk: sunxi: Support factor clocks with N
 multiplier factor starting from 1
Date: Sun, 25 May 2014 20:43:51 +0200
Message-ID: <20140525184351.GM10768@lukather>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-7-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8283276908360595758=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400831485-28576-7-git-send-email-wens@csie.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Emilio Lopez <emilio@elopez.com.ar>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Luc Verhaegen <libv@skynet.be>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


--===============8283276908360595758==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WuedheRyq6FDfQ9j"
Content-Disposition: inline


--WuedheRyq6FDfQ9j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2014 at 03:51:09PM +0800, Chen-Yu Tsai wrote:
> The PLLs on newer Allwinner SoC's, such as the A31 and A23, have a
> N multiplier factor that starts from 1, not 0.
>=20
> This patch adds an option to the clock driver's config data structures
> to define the difference.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--WuedheRyq6FDfQ9j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTgjnmAAoJEBx+YmzsjxAg5EAP/j8uuZJzA81AIufXGPuQUdXM
V7ocnrWndGKFVMuKSelUDumgOTeKylAIgoHeyCqRWFbZxf4/NDFP8t7BMZ2sWy+w
fNVsnehloauIgwJptrw5PpEM6Dj2y2xYccJQjDqi5LyGynPo/yxF+EvpHWq85/gJ
QtfXOMUADjUh4UdGcRYpgVqrUkS8HYYVHUpQMSq1QEnnGuRZk8118gckIFnnaHUa
RMwfEm2TyGqK2HbFVBfKWSdV+1i7+Vloku2wx/whA6S6W0XAhX9gsJDRUq4ngpMh
aTac53vhlm0Cii1RYBODgpgI96QPC84NJWxa16CrSRrGBYqFbTeLW1BUgQdkGIu4
eToXJYUx1VgaFnYIlK/818q9x6aImfUOx+Xe4TcvhrdvTmJ2dgSMzU/e1JFEuKPu
JkY91mXhgPlRJ3i6YG4TWgSa7RADkiUjmNHNYTFY0sPN4HWshmUByfh6F0WAXDcN
rEhiCXXTagx+EpNkIQ8DKZuz92BffVYLO7dLuxA/OPOer132iHVDEFX7NE/cNRUn
/beaFF9BP86UAHQMtCnq0WtYVkUEKfL1NNyCNHKq8OxMI4d3wo8nQPWQoK2aKHkN
E0NVZvU25lFu2EUfFTOIZ0fQZKWrR+VRIek595e2Ihl69VRWsoqOQgCr8u/rmlnK
KS0darkophFXROgXEVRs
=qVSG
-----END PGP SIGNATURE-----

--WuedheRyq6FDfQ9j--


--===============8283276908360595758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8283276908360595758==--
