From: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [STLinux Kernel] [PATCH v2 09/10] ARM: dts: STiH407-family: Use
 new Pinctrl groups
Date: Wed, 1 Feb 2017 15:02:53 +0000
Message-ID: <20170201150253.GF28760@griffinp-ThinkPad-X1-Carbon-2nd>
References: <20170201143145.31962-1-lee.jones@linaro.org>
 <20170201143145.31962-10-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170201143145.31962-10-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, 01 Feb 2017, Lee Jones wrote:

> Having just defined some new Pinctrl groups for when HW flow-control
> is {en,dis}abled, let's reference them for use within the driver.

Acked-by: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> 
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 3 +--
>  arch/arm/boot/dts/stih410-b2260.dts   | 5 ++++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index c8b2944..e480e32 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -222,9 +222,8 @@
>  			compatible = "st,asc";
>  			reg = <0x9830000 0x2c>;
>  			interrupts = <GIC_SPI 122 IRQ_TYPE_NONE>;
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&pinctrl_serial0>;
>  			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> +			/* Pinctrl moved out to a per-board configuration */
>  
>  			status = "disabled";
>  		};
> diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
> index fa16aba..cbcbcb4 100644
> --- a/arch/arm/boot/dts/stih410-b2260.dts
> +++ b/arch/arm/boot/dts/stih410-b2260.dts
> @@ -62,8 +62,11 @@
>  		/* Low speed expansion connector */
>  		uart0: serial@9830000 {
>  			label = "LS-UART0";
> -			status = "okay";
> +			pinctrl-names = "default", "no-hw-flowctrl";
> +			pinctrl-0 = <&pinctrl_serial0_hw_flowctrl>;
> +			pinctrl-1 = <&pinctrl_serial0>;
>  			rts-gpios = <&pio17 3 GPIO_ACTIVE_LOW>;
> +			status = "okay";
>  		};
>  
>  		/* Low speed expansion connector */
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
