From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [STLinux Kernel] [PATCH 7/8] ARM: dts: STiH407-family: Use new
 Pinctrl groups
Date: Fri, 27 Jan 2017 11:29:12 +0000
Message-ID: <20170127112912.isoir2bfhhc4wihn@dell>
References: <20170124134310.27512-1-lee.jones@linaro.org>
 <20170124134310.27512-8-lee.jones@linaro.org>
 <20170125115426.GH5680@griffinp-ThinkPad-X1-Carbon-2nd>
 <20170127110304.qitnkupjqe42tby7@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170127110304.qitnkupjqe42tby7@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com
List-Id: linux-serial@vger.kernel.org

On Fri, 27 Jan 2017, Lee Jones wrote:

> On Wed, 25 Jan 2017, Peter Griffin wrote:
> 
> > Hi Lee,
> > 
> > On Tue, 24 Jan 2017, Lee Jones wrote:
> > 
> > > Having just defined some new Pinctrl groups for when when HW flow-
> > > control is {en,dis}abled, let's reference them for use within the
> > > driver.
> > > 
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > 
> > Same as previous comment, your enabling hw flow control for all
> > stih407 family boards. I've not checked the schematics for them
> > but as hw flow control is dependent on board wiring, IMO this
> > should be added in board specific file.
> 
> Fair shout.
> 
> On the B2120 UART0 is hooked up to the Smart Card Reader.
> 
> Will fix.

Actually, the comment above is in regards to the st,hw-flow-control
property [8/8].  The UART0 Pinctrl settings here are correct for all
supported STiH407-family boards.

Will not fix.

> > > ---
> > >  arch/arm/boot/dts/stih407-family.dtsi | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> > > index c8b2944..9789978 100644
> > > --- a/arch/arm/boot/dts/stih407-family.dtsi
> > > +++ b/arch/arm/boot/dts/stih407-family.dtsi
> > > @@ -222,8 +222,9 @@
> > >  			compatible = "st,asc";
> > >  			reg = <0x9830000 0x2c>;
> > >  			interrupts = <GIC_SPI 122 IRQ_TYPE_NONE>;
> > > -			pinctrl-names = "default";
> > > -			pinctrl-0 = <&pinctrl_serial0>;
> > > +			pinctrl-names = "default", "manual-rts";
> > > +			pinctrl-0 = <&pinctrl_serial0_flowctrl>;
> > > +			pinctrl-1 = <&pinctrl_serial0>;
> > >  			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> > >  
> > >  			status = "disabled";
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
