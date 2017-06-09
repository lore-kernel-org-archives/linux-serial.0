From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH v4 6/7] ARM: dts: meson8: switch to new bindings for UART nodes
Date: Sat, 10 Jun 2017 00:37:09 +0200
Message-ID: <CAFBinCD6_nGdqBSOJwyj0XQe8H05nw-r52pctY7ADJu0EqMb2A@mail.gmail.com>
References: <1497001756-942-1-git-send-email-narmstrong@baylibre.com> <1497001756-942-7-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1497001756-942-7-git-send-email-narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hgkr.klein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Neil,

On Fri, Jun 9, 2017 at 11:49 AM, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> wrote:
> Switch to the stable UART bindings by adding a XTAL node and using the
> proper compatible strings.
unfortunately this won't apply now that Kevin has merged my "ARM: dts:
meson8: add and use the real clock controller"
on the other hand this will make the patch easier as you can now do
the same changes as in meson8b.dtsi

> Signed-off-by: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  arch/arm/boot/dts/meson8.dtsi | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
> index 6993077..a2ea112 100644
> --- a/arch/arm/boot/dts/meson8.dtsi
> +++ b/arch/arm/boot/dts/meson8.dtsi
> @@ -83,6 +83,13 @@
>                 };
>         };
>
> +       xtal: xtal-clk {
> +               compatible = "fixed-clock";
> +               clock-frequency = <24000000>;
> +               clock-output-names = "xtal";
> +               #clock-cells = <0>;
> +       };
> +
>         clk81: clk@0 {
>                 #clock-cells = <0>;
>                 compatible = "fixed-clock";
> @@ -199,17 +206,25 @@
>  };
>
>  &uart_AO {
> -       clocks = <&clk81>;
> +       compatible = "amlogic,meson8-uart", "amlogic,meson-ao-uart";
> +       clocks = <&xtal>, <&clk81>, <&clk81>;
> +       clock-names = "xtal", "pclk", "baud";
>  };
>
>  &uart_A {
> -       clocks = <&clk81>;
> +       compatible = "amlogic,meson8-uart";
> +       clocks = <&xtal>, <&clk81>, <&clk81>;
> +       clock-names = "xtal", "pclk", "baud";
>  };
>
>  &uart_B {
> -       clocks = <&clk81>;
> +       compatible = "amlogic,meson8-uart";
> +       clocks = <&xtal>, <&clk81>, <&clk81>;
> +       clock-names = "xtal", "pclk", "baud";
>  };
>
>  &uart_C {
> -       clocks = <&clk81>;
> +       compatible = "amlogic,meson8-uart";
> +       clocks = <&xtal>, <&clk81>, <&clk81>;
> +       clock-names = "xtal", "pclk", "baud";
>  };
> --
> 1.9.1
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
