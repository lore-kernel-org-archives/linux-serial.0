From: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH] tty: Remove leftover dependencies on PPC_OF
Date: Fri, 17 Apr 2015 16:14:48 +0800
Message-ID: <20150417081448.GK6256@pek-khao-d1.corp.ad.wrs.com>
References: <1429248059-18461-1-git-send-email-linux@roeck-us.net>
 <20150417060104.GH6256@pek-khao-d1.corp.ad.wrs.com>
 <CACxGe6tVLha4wS3=La1Wji7pa_X3WXnmkM-GYxETFj5Cti=u7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lR6P3/j+HGelbRkf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACxGe6tVLha4wS3=La1Wji7pa_X3WXnmkM-GYxETFj5Cti=u7A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
List-Id: linux-serial@vger.kernel.org


--lR6P3/j+HGelbRkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2015 at 07:58:10AM +0100, Grant Likely wrote:
> On Fri, Apr 17, 2015 at 7:01 AM, Kevin Hao <haokexin@gmail.com> wrote:
> > On Thu, Apr 16, 2015 at 10:20:59PM -0700, Guenter Roeck wrote:
> >> powerpc qemu runs fail with the current upstream kernel.
> >> Bisect points to commit 52d996270032 ("powerpc: kill PPC_OF").
> >> Unfortunately, that commit did not remove all instances of PPC_OF.
> >> Practical impact is that the serial driver used by powerpc qemu
> >> targets is no longer built into the test kernel.
> >
> > Sorry for the break. This is a dependency issue. The patch 213dce3c17a6
> > ("tty: kconfig: remove the superfluous dependency on PPC_OF") has alrea=
dy
> > been merged into tty-next, but still not propagate to upstream yet. I f=
ailed
> > to reminder Michael of this when the pulling request is sent to Linus.
>=20
> This means you're doing it wrong.

Definitely.

> If there are dependencies between
> patches, then they *must* all be in the same tree. You cannot depend
> on the order that branches get merged because it breaks bisecting.

We don't try to depend on the order that branches get merged. We just want =
to
merge the patch which kill the PPC_OF completely only after all the patches=
 for
the specific drivers have been merged. I should took the responsibility to
make sure of this, but of course I missed something. Yes. putting all the
patches into the same tree should be a better plan. I will make sure of this
next time. :-)

>=20
> Or, to put it another way, every branch must compile on it's own
> without needing to be merged into mainline or linux-next first.

This issue doesn't break compile. That is another reason we didn't find it
earlier.

Thanks,
Kevin

>=20
> There are two ways to handle this. The easiest is to commit all the
> patches to a single branch. Then there is guaranteed to be no
> problems. However, if the patches really need to be split up between
> several branches, then the way to handle it is to put the prerequisite
> patches into a new clean branch, and then merge that branch into each
> tree that needs the prerequisite. That way every single tree includes
> the required commit without committing it more than once or breaking
> bisectability.
>=20
> g.
>=20
> >
> > Thanks,
> > Kevin
> >>
> >> Fixes: 52d996270032 ("powerpc: kill PPC_OF")
> >> Cc: Kevin Hao <haokexin@gmail.com>
> >> Cc: Michael Ellerman <mpe@ellerman.id.au>
> >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >> ---
> >>  drivers/tty/serial/Kconfig | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> >> index d2501f01cd03..77471d3db8d3 100644
> >> --- a/drivers/tty/serial/Kconfig
> >> +++ b/drivers/tty/serial/Kconfig
> >> @@ -835,7 +835,7 @@ config SERIAL_MCF_CONSOLE
> >>
> >>  config SERIAL_PMACZILOG
> >>       tristate "Mac or PowerMac z85c30 ESCC support"
> >> -     depends on (M68K && MAC) || (PPC_OF && PPC_PMAC)
> >> +     depends on (M68K && MAC) || PPC_PMAC
> >>       select SERIAL_CORE
> >>       help
> >>         This driver supports the Zilog z85C30 serial ports found on
> >> @@ -1153,7 +1153,7 @@ config SERIAL_OMAP_CONSOLE
> >>
> >>  config SERIAL_OF_PLATFORM_NWPSERIAL
> >>       tristate "NWP serial port driver"
> >> -     depends on PPC_OF && PPC_DCR
> >> +     depends on PPC_DCR
> >>       select SERIAL_OF_PLATFORM
> >>       select SERIAL_CORE_CONSOLE
> >>       select SERIAL_CORE
> >> --
> >> 2.1.0
> >>

--lR6P3/j+HGelbRkf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVMMD4AAoJEJNY7TDerrFxguQIAJ62XTE/bmosGu8BjLjbKLb3
FP7KeIyS8pRk6XPmloFpcrzuIOcEjBfkMEFpTr+6j9tREUSiHMcf7ArfgbBspK1K
57Hs4XHpoimRwwG7ax4VM09ZVMkrONN7jZ9sHyv48ZGujvL+9r0b+p3sLlShKK6l
m7nYzcVRbfOgYUB/RuIlYR2BuXpbRgCd3K57HRgNbe9TUeXUJ8pMlUH+52Fa+wSB
kvtSUYpUvI+7DoEntfD03Vbl4WdPnmnuZJaZh3Q7GSJjDthVaTaN3hHGc5ZJIxwj
1v98Y9hDjotmo6O+QhfquKSJJrL8KwfX09VdUr/0Cca8gJYGvafSUFX6+MNt99w=
=QZJc
-----END PGP SIGNATURE-----

--lR6P3/j+HGelbRkf--
