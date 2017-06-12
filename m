From: Jerome Brunet <jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 5/7] ARM: dts: meson6: switch to new bindings for
 UART nodes
Date: Mon, 12 Jun 2017 11:42:57 +0200
Message-ID: <1497260577.3086.11.camel@baylibre.com>
References: <1497001756-942-1-git-send-email-narmstrong@baylibre.com>
         <1497001756-942-6-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1497001756-942-6-git-send-email-narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: hgkr.klein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2017-06-09 at 11:49 +0200, Neil Armstrong wrote:
> Switch to the stable UART bindings by adding a XTAL node and using the
> proper compatible strings.
> 
> Signed-off-by: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

Shouldn't this patch be squashed with patch 4 ?


> ---
>  arch/arm/boot/dts/meson6.dtsi | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
> index b0fc91f..a334fbe 100644
> --- a/arch/arm/boot/dts/meson6.dtsi
> +++ b/arch/arm/boot/dts/meson6.dtsi
> @@ -70,9 +70,37 @@
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
>  		clock-frequency = <200000000>;
>  	};
>  }; /* end of / */
> +
> +
> +&uart_AO {
> +	clocks = <&xtal>, <&clk81>, <&clk81>;
> +	clock-names = "xtal", "pclk", "baud";
> +};
> +
> +&uart_A {
> +	clocks = <&xtal>, <&clk81>, <&clk81>;
> +	clock-names = "xtal", "pclk", "baud";
> +};
> +
> +&uart_B {
> +	clocks = <&xtal>, <&clk81>, <&clk81>;
> +	clock-names = "xtal", "pclk", "baud";
> +};
> +
> +&uart_C {
> +	clocks = <&xtal>, <&clk81>, <&clk81>;
> +	clock-names = "xtal", "pclk", "baud";
> +};

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
