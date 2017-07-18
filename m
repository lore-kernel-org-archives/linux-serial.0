From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC v2 6/6] ARM: dts: blanche: add SCIF1 and MAX9260 deserializer
Date: Tue, 18 Jul 2017 08:52:33 +0200
Message-ID: <CAMuHMdWBqRNKLmzfx_ynPbCyrce5aceH5E7nHgTu-36igOxZow@mail.gmail.com>
References: <1500305076-15570-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1500305076-15570-7-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1500305076-15570-7-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh@kernel.org>, Peter Rosin <peda@axentia.se>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Uli,

On Mon, Jul 17, 2017 at 5:24 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Adds serial port SCIF1 and the MAX9260 deserializers connected to it.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Thanks for your patch!

>  arch/arm/boot/dts/r8a7792-blanche.dts | 52 +++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7792-blanche.dts b/arch/arm/boot/dts/r8a7792-blanche.dts
> index 9b67dca..2ae9a87 100644
> --- a/arch/arm/boot/dts/r8a7792-blanche.dts
> +++ b/arch/arm/boot/dts/r8a7792-blanche.dts

>         status = "okay";
>  };
>
> +&scif1 {
> +       pinctrl-0 = <&scif1_pins>;
> +       pinctrl-names = "default";
> +
> +       status = "okay";
> +
> +       mux-controls = <&mux>;
> +
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       gmsl-deserializer@0 {
> +               compatible = "maxim,max9260";
> +               reg = <0x8>;

unit address and reg property don't match.

(try "make dtbs W=1")

Gr{oetje,eeting}s,

                        Geert
