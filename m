From: Josh Cartwright <josh.cartwright-acOepvfBmUk@public.gmane.org>
Subject: Re: [PATCH 2/8] ARM: zynq: move ttc timer code to drivers/clocksource
Date: Mon, 5 Nov 2012 15:47:53 -0600
Message-ID: <20121105214753.GB1254@beefymiracle.amer.corp.natinst.com>
References: <cover.1351721190.git.josh.cartwright@ni.com>
 <c0347788fbad559a249a25128a23f40c85d9cbda.1351721190.git.josh.cartwright@ni.com>
 <CAHTX3d++0fGSw7GQHcc-S1X1Qh-rfekpr-E8Jkg2_vFqdCFFTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6776083213139229172=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAHTX3d++0fGSw7GQHcc-S1X1Qh-rfekpr-E8Jkg2_vFqdCFFTg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, John Stultz <johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mike Turquette <mturquette-l0cyMroinI0@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


--===============6776083213139229172==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 05, 2012 at 12:22:55PM +0100, Michal Simek wrote:
> 2012/10/29 Josh Cartwright <josh.cartwright-acOepvfBmUk@public.gmane.org>:
> > Suggested cleanup by Arnd Bergmann.  Move the ttc timer.c code to
> > drivers/clocksource, and out of the mach-zynq directory.
> >
> > The common.h (which only held the timer declaration) was renamed to
> > xilinx_ttc.h and moved into include/linux.
> >
> > Signed-off-by: Josh Cartwright <josh.cartwright-acOepvfBmUk@public.gmane.org>
> > Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> > ---
> >  arch/arm/mach-zynq/Makefile                                    | 2 +-
> >  arch/arm/mach-zynq/common.c                                    | 2 +-
> >  drivers/clocksource/Makefile                                   | 1 +
> >  arch/arm/mach-zynq/timer.c => drivers/clocksource/xilinx_ttc.c | 1 -
> >  arch/arm/mach-zynq/common.h => include/linux/xilinx_ttc.h      | 4 ++--
> >  5 files changed, 5 insertions(+), 5 deletions(-)
> >  rename arch/arm/mach-zynq/timer.c => drivers/clocksource/xilinx_ttc.c (99%)
> >  rename arch/arm/mach-zynq/common.h => include/linux/xilinx_ttc.h (91%)
>
> Not going to apply this patch till there is clean way how to move all
> drivers there.  Especially I don't like to add xilinx_ttc.h to
> include/linux folder.

Okay;  I think it's best to defer the moving of the ttc driver from this
patchset.  It is not a dependency of the clk driver support stuff.
If you agree, I can spin up a v2 of the patchset w/o this change, and
without the serial CONFIG_OF stuff.  Should v2 contain the patches
you've already pulled into testing?

I'll give Rob's irqchip-like suggestion a spin and see how that works
out in parallel.

Thanks,

  Josh

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQmDQJAAoJEEef0niEbw+lxMoP/AoAAAJVkxDC33NFPtqLVnTp
v8NZdPf7Yf62YFRr4c9uYzX91FH9Ksz8qmxGSlRLSLvsneeuIqt0rSXXLa72I370
ufAFpusrK1JMEZCX9SKOp34M6QUVqFAe6RdnRUrHku+uCKlVuD1s38uScRacnJpQ
udEblFpV9dZ+UYyvXUv6RpUP8EZI0Xh7ftSlvTU/Tq4237VCJb52nsocJaicZJbO
2oBiamHS2zxIX2gEzfRdOSzGgWeUwuoijwB//r5pEUTvqcGWRQpFfJ3PM9+6L67g
qBwvb+xtxkfI7LqU88k2gwAYD8pJgVKVrLGTrv3/1EXRD2INWkNrGABJBbHdSrHu
91m7rBPNpcs6Q5Tw6F2hsYv9WH0bgN/Tb/RcYuNLSheVjiFBl28MHh/jweB5fIwB
T6YgKrLfD+0bfYlV9V3Um2PVaw0Z2wrY5kSbsRT613d2T6TUiKFnUGE+OpA+8+b2
vebLx/i5lPV37yX19c0ATrAy5EoTzLs7O7S8c5Fw9r7N8LI3akSEu989RH+I1Hjk
ck3ezZq2nE41kicwNM+yi6vb2WnxBdMZ1lS0efxYVNZtWDSEXcpsTJkg++AYwHGr
FSGhXppIs3bzEPmj0mPxAQVC19SZpBHsU5bpgDOxRtzHco+su/v7oefkTxeD//Ep
kZSyWIpq+NYJkNXnD9Kw
=H11z
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--

--===============6776083213139229172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============6776083213139229172==--
