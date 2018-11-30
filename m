From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 06/14] dt-bindings: clock: milbeaut: add Milbeaut clock
 description
Date: Fri, 30 Nov 2018 00:19:29 -0800
Message-ID: <154356596981.88331.14415961625410424962@swboyd.mtv.corp.google.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-7-git-send-email-sugaya.taichi@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542589274-13878-7-git-send-email-sugaya.taichi@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>, Sugaya Taichi <sugaya.taichi@socionext.com>
List-Id: linux-serial@vger.kernel.org

Quoting Sugaya Taichi (2018-11-18 17:01:11)
> Add DT bindings document for Milbeaut clock.
> =

> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../devicetree/bindings/clock/milbeaut-clock.txt   | 93 ++++++++++++++++=
++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/milbeaut-cloc=
k.txt
> =

> diff --git a/Documentation/devicetree/bindings/clock/milbeaut-clock.txt b=
/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
> new file mode 100644
> index 0000000..5c093c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
> @@ -0,0 +1,93 @@
> +Milbeaut M10V Clock Controller Binding
> +----------------------------------------
> +Milbeaut clock controller is consists of few oscillators, PLL, multiplex=
er
> +and few divider modules
> +
> +This binding uses common clock bindings
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible: shall be "socionext,milbeaut-m10v-clk-regs"
> +- reg: shall contain base address and length of clock registers
> +- #clock-cells: shall be 0
> +
> +Example:
> +       m10v-clk-tree@ {
> +               compatible =3D "socionext,milbeaut-m10v-clk-regs";
> +               reg =3D <0x1d021000 0x4000>;
> +
> +               clocks {
> +                       #address-cells =3D <0>;
> +                       #size-cells =3D <0>;
> +
> +                       uclk40xi: uclk40xi {
> +                               compatible =3D "fixed-clock";
> +                               #clock-cells =3D <0>;
> +                               clock-frequency =3D <40000000>;
> +                       };
> +               };

This style of binding is highly discouraged. We don't describe each and
every clk in DT, we describe clk controllers and their outputs and
inputs in DT. The driver is the place where the clock controller
describes the internal clk topology of that controller. Also, fixed
frequency clks are typically oscillators and those would come from the
board dts file, but otherwise I wouldn't expect to see fixed frequency
clks in DT.

> +       }
> +
> +The clock consumer shall specify the desired clock-output of the clock
> +controller (as defined in [2]) by specifying output-id in its "clock"
> +phandle cell
> +[2] arch/arm/boot/dts/milbeaut-m10v-clk.h
> +
[...]
> +
> +Example
> +       piclk_mux_0: spiclk_mux_0 {
> +               compatible =3D "socionext,m10v-clk-div";
> +               #clock-cells =3D <0>;
> +               clocks =3D <&pll10_div_1_2>;
> +               offset =3D <bSPICLK>;
> +               mask =3D <0x3>;
> +               ratios =3D <4 0x5 2 0x4>;
> +       };
> +
> +       pll10: pll10 {
> +               compatible =3D "socionext,m10v-pll-fixed-factor";
> +               #clock-cells =3D <0>;
> +               clocks =3D <&uclk40xi>;
> +               offset =3D <10>;
> +               clock-div =3D <5>;
> +               clock-mult =3D <108>;
> +       };
> +
> +       emmcclk: emmcclk {
> +               compatible =3D "socionext,m10v-clk-div";
> +               #clock-cells =3D <0>;
> +               clocks =3D <&pll11>;
> +               offset =3D <bEMMCCLK>;
> +               mask =3D <0x3>;
> +               ratios =3D <15 0x7 10 0x6 9 0x5 8 0x4>;

Yeah, please no. This whole binding needs a rewrite to not have one node
per clk.
