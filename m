From: Jerome Brunet <jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 6/7] ARM: dts: meson8: switch to new bindings for
 UART nodes
Date: Mon, 12 Jun 2017 11:13:43 +0200
Message-ID: <1497258823.3086.6.camel@baylibre.com>
References: <1497001756-942-1-git-send-email-narmstrong@baylibre.com>
         <1497001756-942-7-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1497001756-942-7-git-send-email-narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: hgkr.klein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2017-06-09 at 11:49 +0200, Neil Armstrong wrote:
> Switch to the stable UART bindings by adding a XTAL node and using the
> proper compatible strings.
> 
> Signed-off-by: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  arch/arm/boot/dts/meson8.dtsi | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)

I think this is clashing with the recent change from Martin on meson8 clock
driver. Kevin just applied it : 

https://lkml.kernel.org/r/m2d1ad9g38.fsf-rdvid1DuHRBWk0Htik3J/w@public.gmane.org

<&clk81> no longer exists ...

> 
> diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
> index 6993077..a2ea112 100644
> --- a/arch/arm/boot/dts/meson8.dtsi
> +++ b/arch/arm/boot/dts/meson8.dtsi
> @@ -83,6 +83,13 @@
>  		};
>  	};
>  
> +	xtal: xtal-clk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		clock-output-names = "xtal";
> +		#clock-cells = <0>;
> +	};
> +
>  	clk81: clk@0 {
>  		#clock-cells = <0>;
>  		compatible = "fixed-clock";
> @@ -199,17 +206,25 @@
>  };
>  
>  &uart_AO {
> -	clocks = <&clk81>;
> +	compatible = "amlogic,meson8-uart", "amlogic,meson-ao-uart";
> +	clocks = <&xtal>, <&clk81>, <&clk81>;
> +	clock-names = "xtal", "pclk", "baud";
>  };
>  
>  &uart_A {
> -	clocks = <&clk81>;
> +	compatible = "amlogic,meson8-uart";
> +	clocks = <&xtal>, <&clk81>, <&clk81>;
> +	clock-names = "xtal", "pclk", "baud";
>  };
>  
>  &uart_B {
> -	clocks = <&clk81>;
> +	compatible = "amlogic,meson8-uart";
> +	clocks = <&xtal>, <&clk81>, <&clk81>;
> +	clock-names = "xtal", "pclk", "baud";
>  };
>  
>  &uart_C {
> -	clocks = <&clk81>;
> +	compatible = "amlogic,meson8-uart";
> +	clocks = <&xtal>, <&clk81>, <&clk81>;
> +	clock-names = "xtal", "pclk", "baud";
>  };

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
