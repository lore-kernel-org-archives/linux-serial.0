From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 7/7] arm64: dts: r8a7796: salvator-x: add SCIF1 (DEBUG1)
Date: Wed, 14 Dec 2016 15:10:07 +0100
Message-ID: <CAMuHMdUKzcPndJcQYEKDucpTSNemjZE=Q3R=DgD5T45OoPXjNQ@mail.gmail.com>
References: <1481286971-16667-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1481286971-16667-8-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1481286971-16667-8-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Uli,

On Fri, Dec 9, 2016 at 1:36 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Enables the SCIF hooked up to the DEBUG1 connector.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> index da46ac7..9204691 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> @@ -18,6 +18,7 @@
>
>         aliases {
>                 serial0 = &scif2;
> +               serial1 = &scif1;

Is there any specific reason you chose scif1 over hscif1?

>                 ethernet0 = &avb;
>         };
>
> @@ -140,6 +141,11 @@
>         pinctrl-0 = <&scif_clk_pins>;
>         pinctrl-names = "default";
>
> +       scif1_pins: scif1 {
> +               groups = "scif1_data_a";

Please add "scif1_ctrl_a".

> +               function = "scif1";
> +       };
> +
>         scif2_pins: scif2 {
>                 groups = "scif2_data_a";
>                 function = "scif2";
> @@ -280,6 +286,12 @@
>         status = "okay";
>  };
>
> +&scif1 {
> +       pinctrl-0 = <&scif1_pins>;
> +       pinctrl-names = "default";

Please add "uart-has-rtscts".

> +       status = "okay";
> +};

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
