From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 0/5] Serial slave device bus
Date: Tue, 31 Jan 2017 06:44:15 +0100
Message-ID: <20170131054415.eiboj4ivumanxgso@earth>
References: <20170125202343.30923-1-robh@kernel.org>
 <20170131030241.kehmuuxsbnbk5nnt@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mvym7qs4yl5uwgha"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170131030241.kehmuuxsbnbk5nnt@earth>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


--mvym7qs4yl5uwgha
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 31, 2017 at 04:02:41AM +0100, Sebastian Reichel wrote:
> On Wed, Jan 25, 2017 at 02:23:38PM -0600, Rob Herring wrote:
> > Here's V3 of the serdev bus support with all the review feedback so far
> > incorporated. Greg applied the first 4 patches already. I also found a
> > problem in the tty_port_wakeup changes and have fixed that.
> >=20
> > I've added serdev support to the BT hci_ll.c driver as it turns out it =
works
> > on newer TI chips too, but just needed firmware loading. That avoids the
> > impossible mess of cleaning up the TI-ST driver, and it's in a much clo=
ser
> > state to being ready for upstream. I've sent that out separately.
> >=20
> > Changelog is in individual patches. Previous versions are here[1][2]. T=
his
> > series and the mentioned drivers can be found here[3].
> >=20
> > Rob
> >=20
> > [1] http://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg1304151=
=2Ehtml
> > [2] http://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg1311650=
=2Ehtml
> > [3] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git serial=
-bus-v4
>=20
> I rebased my nokia bluetooth driver on top of [3]. It's not yet
> working, but everything added by this patchset (and
> "bluetooth: hci_uart: add serdev driver support library") seems
> to work as expected, so for the whole series:
>=20
> Tested-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

FWIW, I got bluetooth on top of your patchset working on N950. N900
is not yet tested and probably does not yet work (it's more picky
about flow control and usage of the wakeup gpios). You can find a
branch with the additional patches @ [4]. I had to add serdev
functions to wait for TX buffer depletion and checking CTS. Apart
=66rom that flow control only worked correctly when also taking care
of RTS (like hci_uart_set_flow_control does).

I noticed, that you did not yet write any DT bindings for your
bluetooth slaves. Did you already decide for a location?

[4] git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-n900.git serial=
-bus-v4-nokia-bt

-- Sebastian

--mvym7qs4yl5uwgha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliQJCkACgkQ2O7X88g7
+ppqmw//Y68DsR1dMtQhXY+zBO/SpGDspAxvhspeyMkB9V6YdRpd4QRdwa8ZkxKZ
p8jC0xSHj70uupNlYdhIV6y7ZdDPBskXbr/1VirlqteTnjSFoA84SpdDdiwIHb6I
Ld/KRAZI6WTY2WqZnrPQ2RFcDOwPYj1AEeJn4CWFk8zCY6VrCF4IYHPUvUHj8WX8
O7FQOLRzyKhkHCQSHIJh5T+M4B8C9gDnDVmqHJX7+NZr7zrqvBXhxChs3NVJltVQ
B6V6lLQn1v4Bku99Ty+t4wswm35lZPOOO4vlnyCYPwyBoWjg23X3jMwuMMAt67kd
u0MfvYAhImxEoMKiYAy9oSflffX8tl+6HGzEXjs/L1gRtOjhG/NqmAaTdIOAj1dh
FyAYBWTrEZX7mqtrJl8h+YmmDa1ksqJ759fibkFEp1K8ODepnQbNGLwKLLcrViib
b8rPomeDKO/YCvx2gYJC1nL1gvm4bxHVkdqw9sa2xGr49KGervc2z5pqtRMUel75
fDklog04S2mtKpwLwMwRBjzIUoVAAEJDASd4dPidprLtFf5jgRwZCgSGtik9WMmP
W3hf5qy2UcOQH4xEoCLsISWEt1/9x9233rybtGrsSX8UuuqUmKAl6YIKAsHD406C
QdZJQ2T1lJzJ7b9z0u/dxiW6rwBYWO2vDBo2WPn+sgJsj5nW62o=
=3JsV
-----END PGP SIGNATURE-----

--mvym7qs4yl5uwgha--
