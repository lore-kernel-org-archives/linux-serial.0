From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 10/14] dt-bindings: pinctrl: milbeaut: Add Milbeaut M10V
 pinctrl description
Date: Tue, 4 Dec 2018 17:11:31 -0600
Message-ID: <20181204231131.GA7366@bogus>
References: <1542589336-13925-1-git-send-email-sugaya.taichi@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1542589336-13925-1-git-send-email-sugaya.taichi@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sugaya Taichi <sugaya.taichi@socionext.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 19, 2018 at 10:02:12AM +0900, Sugaya Taichi wrote:
> Add DT bindings document for Milbeaut M10V pinctrl.
> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../pinctrl/socionext,milbeaut-pinctrl.txt         | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
> new file mode 100644
> index 0000000..7469189
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
> @@ -0,0 +1,33 @@
> +Milbeaut SoCs pin controller
> +
> +Required properties:
> +- compatible: should be one of the following:
> +    "socionext,milbeaut-m10v-pinctrl"  - for m10v SoC
> +- reg: offset and length of the register set.
> +- reg-names: should be "pinctrl", "exiu".
> +- gpio-cells; should be 2.

#gpio-cells

gpio-controller?

> +- interrupt-cells: should be 2.

#interrupt-cells

interrupt-controller?

> +- clocks: phandle to the input clock.
> +- interrupts: three interrupts specifer.
> +- interrupt-names: corresponds "interrupts" factor.
> +
> +Example:
> +	pinctrl: pinctrl@1d022000 {
> +		compatible = "socionext,milbeaut-m10v-pinctrl";
> +		reg = <0x1d022000 0x1000>,
> +			<0x1c26f000 0x1000>;
> +		reg-names = "pinctrl", "exiu";
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		clocks = <&dummy_clk>;
> +		interrupts = <0 54 4>, <0 55 4>, <0 56 4>, <0 57 4>,
> +				<0 58 4>, <0 59 4>, <0 60 4>, <0 61 4>,
> +				<0 62 4>, <0 63 4>, <0 64 4>, <0 65 4>,
> +				<0 66 4>, <0 67 4>, <0 68 4>, <0 69 4>;
> +		interrupt-names = "pin-48", "pin-49", "pin-50", "pin-51",
> +				"pin-52", "pin-53", "pin-54", "pin-55",
> +				"pin-56", "pin-57", "pin-58", "pin-59",
> +				"pin-60", "pin-61", "pin-62", "pin-63";
> +	}
> -- 
> 1.9.1
> 
