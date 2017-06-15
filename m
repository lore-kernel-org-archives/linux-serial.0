From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC 4/4] ARM: dts: blanche: add SCIF1 and MAX9260 deserializer
Date: Thu, 15 Jun 2017 08:05:23 -0500
Message-ID: <CAL_Jsq+87SOcwysfg2OuzihV=+Go5kxAaYCpAXa-M2KiMQdqPA@mail.gmail.com>
References: <1497451130-7741-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1497451130-7741-5-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1497451130-7741-5-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "open list:MEDIA DRIVERS FOR RENESAS - FCP" <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 14, 2017 at 9:38 AM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Adds serial port SCIF1 and the MAX9260 deserializers connected to it.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm/boot/dts/r8a7792-blanche.dts | 45 +++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7792-blanche.dts b/arch/arm/boot/dts/r8a7792-blanche.dts
> index 9b67dca..281484d 100644
> --- a/arch/arm/boot/dts/r8a7792-blanche.dts
> +++ b/arch/arm/boot/dts/r8a7792-blanche.dts
> @@ -21,6 +21,7 @@
>         aliases {
>                 serial0 = &scif0;
>                 serial1 = &scif3;
> +               serial2 = &scif1;
>         };
>
>         chosen {
> @@ -202,6 +203,11 @@
>                 function = "scif0";
>         };
>
> +       scif1_pins: scif1 {
> +               groups = "scif1_data";
> +               function = "scif1";
> +       };
> +
>         scif3_pins: scif3 {
>                 groups = "scif3_data";
>                 function = "scif3";
> @@ -246,6 +252,45 @@
>         status = "okay";
>  };
>
> +&scif1 {
> +       pinctrl-0 = <&scif1_pins>;
> +       pinctrl-names = "default";
> +
> +       status = "okay";
> +
> +       mux-select-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>,
> +                          <&gpio5 13 GPIO_ACTIVE_LOW>,
> +                          <&gpio5 14 GPIO_ACTIVE_LOW>,
> +                          <&gpio5 15 GPIO_ACTIVE_LOW>;
> +
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       gmsl-deserializer@0 {
> +               compatible = "maxim,max9260";
> +               reg = <0x8>;

You need to document how muxed serdev devices are represented in
general. As Peter mentioned, you should use the mux-ctrl binding.
Maybe this should have a mux node here too. That helps if we ever have
other child nodes on the UART.

The unit address and reg property values should match.

> +       };
> +       gmsl-deserializer@1 {
> +               compatible = "maxim,max9260";
> +               reg = <0x9>;
> +       };
> +       gmsl-deserializer@2 {
> +               compatible = "maxim,max9260";
> +               reg = <0xa>;
> +       };
> +       gmsl-deserializer@3 {
> +               compatible = "maxim,max9260";
> +               reg = <0xb>;
> +       };
> +       gmsl-deserializer@4 {
> +               compatible = "maxim,max9260";
> +               reg = <0x4>;
> +       };
> +       gmsl-deserializer@5 {
> +               compatible = "maxim,max9260";
> +               reg = <0x5>;
> +       };
> +};
> +
>  &scif3 {
>         pinctrl-0 = <&scif3_pins>;
>         pinctrl-names = "default";
> --
> 2.7.4
>
