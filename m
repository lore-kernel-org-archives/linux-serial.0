From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [STLinux Kernel] [PATCH 7/8] ARM: dts: STiH407-family: Use new
 Pinctrl groups
Date: Wed, 25 Jan 2017 11:54:26 +0000
Message-ID: <20170125115426.GH5680@griffinp-ThinkPad-X1-Carbon-2nd>
References: <20170124134310.27512-1-lee.jones@linaro.org>
 <20170124134310.27512-8-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170124134310.27512-8-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com
List-Id: linux-serial@vger.kernel.org

Hi Lee,

On Tue, 24 Jan 2017, Lee Jones wrote:

> Having just defined some new Pinctrl groups for when when HW flow-
> control is {en,dis}abled, let's reference them for use within the
> driver.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Same as previous comment, your enabling hw flow control for all
stih407 family boards. I've not checked the schematics for them
but as hw flow control is dependent on board wiring, IMO this
should be added in board specific file.

regards,

Peter.

> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index c8b2944..9789978 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -222,8 +222,9 @@
>  			compatible = "st,asc";
>  			reg = <0x9830000 0x2c>;
>  			interrupts = <GIC_SPI 122 IRQ_TYPE_NONE>;
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&pinctrl_serial0>;
> +			pinctrl-names = "default", "manual-rts";
> +			pinctrl-0 = <&pinctrl_serial0_flowctrl>;
> +			pinctrl-1 = <&pinctrl_serial0>;
>  			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
>  
>  			status = "disabled";
