From: Josh Cartwright <josh.cartwright@ni.com>
Subject: Re: [PATCH 7/8] serial: xilinx_uartps: get clock rate info from dts
Date: Fri, 2 Nov 2012 07:39:29 -0600
Message-ID: <20121102133929.GP5190@beefymiracle.amer.corp.natinst.com>
References: <cover.1351721190.git.josh.cartwright@ni.com>
 <23a299ee5e89cfd17bb9affd8fbb9f41b79cfd46.1351721190.git.josh.cartwright@ni.com>
 <50939061.9060201@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5677360756366201045=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <50939061.9060201@metafoo.de>
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


--===============5677360756366201045==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sMZCuqyhuhd4ycTi"
Content-Disposition: inline


--sMZCuqyhuhd4ycTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 02, 2012 at 10:20:33AM +0100, Lars-Peter Clausen wrote:
> On 10/31/2012 08:28 PM, Josh Cartwright wrote:
> > Add support for specifying clock information for the uart clk via the
> > device tree.  This eliminates the need to hardcode rates in the device
> > tree.
> >=20
> > Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> > ---
> >  arch/arm/boot/dts/zynq-7000.dtsi   |  4 ++--
> >  drivers/tty/serial/xilinx_uartps.c | 30 +++++++++++++++++-------------
> >  2 files changed, 19 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-=
7000.dtsi
> > index bb3085c..5fb763f 100644
> > --- a/arch/arm/boot/dts/zynq-7000.dtsi
> > +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> > @@ -44,14 +44,14 @@
> >  			compatible =3D "xlnx,xuartps";
> >  			reg =3D <0xE0000000 0x1000>;
> >  			interrupts =3D <0 27 4>;
> > -			clock =3D <50000000>;
> > +			clocks =3D <&uart_clk 0>;
> >  		};
> > =20
> >  		uart1: uart@e0001000 {
> >  			compatible =3D "xlnx,xuartps";
> >  			reg =3D <0xE0001000 0x1000>;
> >  			interrupts =3D <0 50 4>;
> > -			clock =3D <50000000>;
> > +			clocks =3D <&uart_clk 0>;
>=20
> Shouldn't this be <&uart_clk 1>?

Yes, indeed.

Thanks,
  Josh

--sMZCuqyhuhd4ycTi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQk80RAAoJEEef0niEbw+lVz8QAIgrOMIAe4j45xbHk3FISYvp
tKczq+rVKoS89bCR8Y1SwCHZ95vxR22UulCer3Ipc60KyIY/Zi1EOj/CNDauOz84
mteTZ77kv6bL4BNdh5xw6mDBwkFPDq/QgYt8+rcHVDzAUwwG4GX2U8kPCuBrgnOF
Xp5UrScOSRj+LwpSz50+g2y1aJmu9aI2fM6nlEwYxb85PqV7ujfXxAoT3dkdyITu
PkZiWL4YPLq8pfOZ7qBLkIVu0oKShnLQXBQHOr3x6sNV+ICNj1HuB56cmMSrBJkd
3rvPf2d7pjXAI5H5i7TygEKlLgl4ikpo/N2auelM2lYg7WeRAf5Gpe1F9l0gBrC8
E06ilrcyF04OzdKSMIdRVYkLJSjq9KEqPeYAtITkdLnfZCu7KdQDnNlkQgEOzsMd
FKvDmEfTg0QNY50X6KTCKlnb00XQ+NY4opgWjr/DLc+GzfKJgaexLaV9UtCh4Xqa
2AgPa9R9Xafr4mAiw2eKkHydr84QX04xKVc9BznIlJ694EP4bi+F0URtP7BstCTs
G8qWBaqP6Bw+rvYz1+6qragDGjBJ9wo6gavln7N94yy7CHMO28P9RS0GPKqrSdjZ
h94E7RF13W5QzFqUgIxfyR6AgXhaIgpri+Nw8R3T5UgBIZLk7ZZHHmNmqAK9X+a5
HnO8jrmKse7aV4OG8mrK
=Tx3u
-----END PGP SIGNATURE-----

--sMZCuqyhuhd4ycTi--


--===============5677360756366201045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5677360756366201045==--
