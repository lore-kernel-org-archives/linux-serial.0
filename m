From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH v2 7/7] ARM: zynq: DT: Migrate UART to Cadence binding
Date: Tue, 11 Mar 2014 08:48:47 -0700
Message-ID: <fbca0284-8a38-4767-bd17-8e5f52b21ef7@CH1EHSMHS005.ehs.local>
References: <1394487610-2419-1-git-send-email-soren.brinkmann@xilinx.com>
 <1394487610-2419-8-git-send-email-soren.brinkmann@xilinx.com>
 <62cd32ad-8743-4d49-a1b6-c178054a9756@CO9EHSMHS011.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:9165
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755133AbaCKPs5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Mar 2014 11:48:57 -0400
Content-Disposition: inline
In-Reply-To: <62cd32ad-8743-4d49-a1b6-c178054a9756@CO9EHSMHS011.ehs.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org

On Tue, 2014-03-11 at 09:52AM +0100, Michal Simek wrote:
> On 03/10/2014 10:40 PM, Soren Brinkmann wrote:
> > The Zynq UART is Cadence IP and the driver has been renamed accordi=
ngly.
> > Migrate the DT to use the new binding for the UART driver.
> >=20
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > Acked-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> > This change depends on 'tty: xuartps: Rebrand driver as Cadence UAR=
T',
> > which introduces the new clock-names.
> > ---
> >  arch/arm/boot/dts/zynq-7000.dtsi | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/z=
ynq-7000.dtsi
> > index 8b67b19392ec..0ed0d4b0579a 100644
> > --- a/arch/arm/boot/dts/zynq-7000.dtsi
> > +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> > @@ -67,19 +67,19 @@
> >  		};
> > =20
> >  		uart0: uart@e0000000 {
> > -			compatible =3D "xlnx,xuartps";
> > +			compatible =3D "xlnx,xuartps", "cdns,uart-r1p8";
> >  			status =3D "disabled";
> >  			clocks =3D <&clkc 23>, <&clkc 40>;
> > -			clock-names =3D "ref_clk", "aper_clk";
> > +			clock-names =3D "uart_clk", "pclk";
> >  			reg =3D <0xE0000000 0x1000>;
> >  			interrupts =3D <0 27 4>;
> >  		};
> > =20
> >  		uart1: uart@e0001000 {
> > -			compatible =3D "xlnx,xuartps";
> > +			compatible =3D "xlnx,xuartps", "cdns,uart-r1p8";
> >  			status =3D "disabled";
> >  			clocks =3D <&clkc 24>, <&clkc 41>;
> > -			clock-names =3D "ref_clk", "aper_clk";
> > +			clock-names =3D "uart_clk", "pclk";
> >  			reg =3D <0xE0001000 0x1000>;
> >  			interrupts =3D <0 50 4>;
> >  		};
>=20
> This should be at least the part of 5/7 because between 5/7 and 7/7
> driver will fail to probe.

The driver should never fail to probe. The old bindings will continue t=
o
work. So, only dependency for this is, the new clock names must be
merged in. So, it has to be rather late in the series.

	S=C3=B6ren


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
