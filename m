From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 10/22] clk: sunxi: Add support for PLL6 pre-divider on
 AHB1 clock
Date: Sun, 25 May 2014 21:02:11 +0200
Message-ID: <20140525190211.GT10768@lukather>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-11-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6834947533470021502=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400831485-28576-11-git-send-email-wens@csie.org>
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


--===============6834947533470021502==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v15hXiddb3kq3Bam"
Content-Disposition: inline


--v15hXiddb3kq3Bam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2014 at 03:51:13PM +0800, Chen-Yu Tsai wrote:
> On the A31 and A23, the PLL6 input to the AHB1 clock has a 2 bit wide
> pre-divider. This was verified from the A23 user manual and A31/A23 SDK
> sources.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>


No, it should be part of the AHB1 clock code itself. It's internal
clock logic, isn't a clock per se, and as such, shouldn't be
reprensented as a separate clock.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--v15hXiddb3kq3Bam
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTgj4zAAoJEBx+YmzsjxAgioEP/iybxpcK3inAnC6ucveb0h+/
ND25GBTBrQwCOGJSwU66vX0o6g8wQAzig8Pbq2Kids7GT1BB5xHCP9uwlOwJc2rj
h4LZWWPOG8rVi0p1/c8yMLfJF8DQbVyFJf9/jeYjpd+/rvf37A/n+RYlPT+fkJ+e
pS0T93Bj4/BBUN+uf1G0uoi7ROC45zj/wqTuYYCpczdahcT2BFzTAwpsZEhJQEPA
5r8OomsTGPz5MFAG4QpFfXb4jsyCoWd+PXM97KF5MXS5QfUYVIVUWmaXQKrjZ1mi
r6DPRGVE8EHA/pJzbKaWr7s+sRBuZKcJ0xYTwK6dvIsYYAbQRnLiPK5DWEX9JRBX
C2l7wLvZpCzuNm7IuEbKALmTcQsec8mH6Hj5Za9cW8mcFL6FiwB8nEXtGyempBly
6LiJUbcO4SmXgDYrc2a7k4A+dtgVrkH91Qg4ln7xWJedKYhd3+OelvSP6HrpWx7g
HTtrkgz5+tY2Vm+9m/ABlOtyQq5Zl6LMnsM+OuZinhqfeqfT6ONqa+jdhN475qmi
DGRmBmsmjBGuEp79wx8rUrV6N+yqL94Aak5UAI76kcVcAnK5Q2seU/NaBrXMiJLm
4tgWNt1pmHb4A3K1NstpkQ1wFOqNUYZeYSaAAuuv1BpeanswfI1SbvUgJct7fMg2
lrbMeo4HRlmMepWXIqBm
=VxaK
-----END PGP SIGNATURE-----

--v15hXiddb3kq3Bam--


--===============6834947533470021502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6834947533470021502==--
