From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH/RFC] serial: sh-sci: Add device tree support for r8a7779
Date: Fri, 25 Apr 2014 09:05:50 +0200
Message-ID: <1922942.7jvlviEDpf@avalon>
References: <1398322484-3630-1-git-send-email-horms+renesas@verge.net.au> <1418731.YSFS18bIMD@avalon> <20140425002641.GB31164@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20140425002641.GB31164@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Simon,

On Friday 25 April 2014 09:26:42 Simon Horman wrote:
> On Fri, Apr 25, 2014 at 01:33:29AM +0200, Laurent Pinchart wrote:
> > Hi Simon,
> > 
> > Thank you for the patch.
> > 
> > On Thursday 24 April 2014 15:54:44 Simon Horman wrote:
> > > According to the platform data for the legacy-C initialisation of sh-sci
> > > for the r8a7779 SoC and my own testing the SCIx_SH4_SCIF_REGTYPE bit of
> > > scscr needs to be set.
> > > 
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > 
> > > ---
> > > 
> > > With the approach taken by this patch sh-sci may be initialised using
> > > the "renesas,scif-r8a7779" compat string but not the generic
> > > "renesas,scif" compat string.  An alternate approach would be to add a
> > > binding to allow setting of this bit to be controlled directly from DT.
> > 
> > Handling the SCSCR bits properly with DT has been on my to-do list for
> > some time. Thank you for volunteering to implement that :-D
> > 
> > The CKE bits control both the behaviour of the SCK pin and the SCIF input
> > clock selection. The SCIF can use various internal and external clocks,
> > with up to two baud rate generators (programmable dividers) chained.
> > Whether the SoC is provided with an external clock for its serial ports
> > is a board property, not an SoC property. I would thus like to implement
> > support for this feature properly and avoid hardcoding the CKE bits like
> > done below.
> > 
> > The Marzen board has an external clock generator connected to the SCIF_SCK
> > pin that can be used as a clock source, but I don't really see a reason
> > why we couldn't use the internal P clock instead. I don't want to delay
> > integration of SCIF DT support until we have a proper solution to handle
> > clock configuration, but couldn't we use the internal P clock on the
> > Marzen board in the meantime ?
> 
> I think that approach sounds reasonable and I seem to have it working
> without any driver changes. Could you confirm that the following
> DT snippet is what you have in mind? (I intend to update it as per any
> relevant changes you make when reposting your DT sci patch for the
> r8a7791.)

That's what I have in mind, but please see below for a small comment.

> diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
> index e924f96..3e9cca4 100644
> --- a/arch/arm/boot/dts/r8a7779.dtsi
> +++ b/arch/arm/boot/dts/r8a7779.dtsi
> @@ -203,6 +203,66 @@
>  		status = "disabled";
>  	};
> 
> +	scif0: serial@ffe40000 {
> +		compatible = "renesas,scif", "renesas,scif-r8a7779";
> +		reg = <0xffe40000 265>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cpg_clocks R8A7779_CLK_P>;
> +		clock-names = "sci_ick";

Clock handling in the sh-sci driver should probably be improved. The driver 
currently requires an "sci_ick" interface clock and supports an optional 
"sci_fck" functional clock. In practice, as far as I can see, platforms that 
provide both sci_ick and sci_fck set the two clocks to the same source. 
Furthermore, some SCI* instances support a second internal clock source for 
the baud rate generator. We don't support that at the moment.

This leads me to believe that we should merge the "sci_ick" and "sci_fck" 
clocks for the DT case into a single clock that I would call "fck" (no need 
for a "sci_" prefix), and later add support for the second baud rate clock. 
This would require a small driver change. I can try to submit patches in the 
next couple of days if you agree with the approach.

> +		status = "disabled";
> +	};
> +
> +	scif1: serial@ffe41000 {
> +		compatible = "renesas,scif", "renesas,scif-r8a7779";
> +		reg = <0xffe41000 265>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cpg_clocks R8A7779_CLK_P>;
> +		clock-names = "sci_ick";
> +		status = "disabled";
> +	};
> +
> +	scif2: serial@ffe42000 {
> +		compatible = "renesas,scif", "renesas,scif-r8a7779";
> +		reg = <0xffe42000 265>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cpg_clocks R8A7779_CLK_P>;
> +		clock-names = "sci_ick";
> +		status = "disabled";
> +	};
> +
> +	scif3: serial@ffe43000 {
> +		compatible = "renesas,scif", "renesas,scif-r8a7779";
> +		reg = <0xffe43000 265>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 91 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cpg_clocks R8A7779_CLK_P>;
> +		clock-names = "sci_ick";
> +		status = "disabled";
> +	};
> +
> +	scif4: serial@ffe44000 {
> +		compatible = "renesas,scif", "renesas,scif-r8a7779";
> +		reg = <0xffe44000 265>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 92 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cpg_clocks R8A7779_CLK_P>;
> +		clock-names = "sci_ick";
> +		status = "disabled";
> +	};
> +
> +	scif5: serial@ffe45000 {
> +		compatible = "renesas,scif", "renesas,scif-r8a7779";
> +		reg = <0xffe45000 265>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 93 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cpg_clocks R8A7779_CLK_P>;
> +		clock-names = "sci_ick";
> +		status = "disabled";
> +	};
> +
>  	pfc: pfc@fffc0000 {
>  		compatible = "renesas,pfc-r8a7779";
>  		reg = <0xfffc0000 0x23c>;

-- 
Regards,

Laurent Pinchart

