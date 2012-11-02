From: Josh Cartwright <josh.cartwright@ni.com>
Subject: Re: [PATCH 5/8] ARM: zynq: add COMMON_CLK support
Date: Fri, 2 Nov 2012 09:28:26 -0600
Message-ID: <20121102152826.GQ5190@beefymiracle.amer.corp.natinst.com>
References: <cover.1351721190.git.josh.cartwright@ni.com>
 <94af5ee92c2d68f245eb902de74909aadf159be1.1351721190.git.josh.cartwright@ni.com>
 <50939378.2050500@metafoo.de>
 <20121102133850.GO5190@beefymiracle.amer.corp.natinst.com>
 <5093E2D5.2000304@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8268079967215480304=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5093E2D5.2000304@metafoo.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michal Simek <monstr@monstr.eu>, Russell King <linux@arm.linux.org.uk>, John Stultz <johnstul@us.ibm.com>, devicetree-discuss@lists.ozlabs.org, Michal Simek <michal.simek@xilinx.com>, Rob Herring <rob.herring@calxeda.com>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>, John Linn <John.Linn@xilinx.com>, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@ti.com>
List-Id: linux-serial@vger.kernel.org


--===============8268079967215480304==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bZ2MuwyI/0uB8yuJ"
Content-Disposition: inline


--bZ2MuwyI/0uB8yuJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 02, 2012 at 04:12:21PM +0100, Lars-Peter Clausen wrote:
> On 11/02/2012 02:38 PM, Josh Cartwright wrote:
> > On Fri, Nov 02, 2012 at 10:33:44AM +0100, Lars-Peter Clausen wrote:
> >> On 10/31/2012 07:58 PM, Josh Cartwright wrote:
[...]
> >>> +static void __init zynq_periph_clk_setup(struct device_node *np)
> >>> +{
> >>> +	struct zynq_periph_clk *periph;
> >>> +	const char *parent_names[3];
> >>> +	struct clk_init_data init;
> >>> +	struct clk *clk;
> >>> +	int err;
> >>> +	u32 reg;
> >>> +	int i;
> >>> +
> >>> +	err = of_property_read_u32(np, "reg", &reg);
> >>> +	WARN_ON(err);
> >>
> >> Shouldn't the function abort if a error happens somewhere? Continuing here
> >> will lead to undefined behavior. Same is probably true for the other WARN_ONs.
> >
> > The way I see it is: the kernel is will be left in a bad state in the
> > case of any failure, regardless of if we bail out or continue.  AFAICT,
> > there is no clean way to recover from a failure this early.
> >
> > Given that, it seems simpler (albeit marginally so) just to continue; so
> > that's what I chose to do.  I'm not opposed to bailing out, just not
> > convinced it does anything for us.
> >
> The issue with this approach is that, while you get a warning, unexpected
> seemingly unrelated side-effects may happen later on. E.g. if no reg
> property for the clock is specified the reg variable will be uninitialized
> and contain whatever was on the stack before. The clock will be registered
> nonetheless and the boot process continues. Now if the clock is enabled a
> bit in a random register will be modified, which could result in strange and
> abnormal behavior, which can be very hard to track down.

Okay.....but any reasonable person would start their debugging quest at
the source of the WARN_ON.  If someone sees the WARN_ON message but
stupidly chooses to ignore it, they deserves to spend the time trying to
track down abnormal behavior, so I'm still not convinced.

  Josh

--bZ2MuwyI/0uB8yuJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQk+aaAAoJEEef0niEbw+lWcgQAMTdcIdNLeov4zNXCFyWaHRP
Rc+pPQEfJzvX6Z61ashVfUdMu/rq3LosFutrfmKshDnjut7JGunhazAhhRedHeTK
ImoPNlAdjW8stnTuauch9/gCpuOCWxqormemU/SLcs0FNjgPivqiK32E967RQb+7
dAk4kF2ZmAjJY9vsfRCfuKXcKKMK4O128pqK9LsKRM3zqECv/fOjl6n/ik4P8CIH
YXUnMTF9LaAR+Gm0E4fesg+N9E3wt/44BGZ9GpyoRp0U5W/FcUqE80lqJkRgBLNb
FMgBqC1zO5zW6crHKRUVoGb1oOjPpR4bLXRlH7ug2rz4kSx1GrziC1IpFypjvjjr
ezdoSeW+A3YdHb26aYqVfK7ISfvGGrky9PylWVt+YP6P5wfsUAL+/EBfeIWhkQV7
9DSswBLBctSAyFsN/RQBoTjU0vJ8vTg3H2ApxNKwKTBqPA0kRobRcRdkORjDyNs/
1om0myGGqwj0xxyzPUqbZ0l4mM72NTgBP5YV2YiqUsYfThslHSlr4LLBKL7x1mJW
x82fmJVQOcfEtWRiNcBzpZxWBz6+1pGAXWg2JJ15Qa2WIxOtBFtYOOQwGJUnXSOt
p/G7Id+Dv/6hH6+PN8lgmyZ14U9eZRzbhrmht443dCtH1pItLA1UA7ok2ulXJ4Lu
XLsad0R5wCL8YrGf0pK6
=7OXW
-----END PGP SIGNATURE-----

--bZ2MuwyI/0uB8yuJ--


--===============8268079967215480304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8268079967215480304==--
