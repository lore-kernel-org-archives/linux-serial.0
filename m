From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 04/14] dt-bindings: timer: Add Milbeaut M10V timer
 description
Date: Tue, 4 Dec 2018 17:03:54 -0600
Message-ID: <20181204230354.GA26204@bogus>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-5-git-send-email-sugaya.taichi@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1542589274-13878-5-git-send-email-sugaya.taichi@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sugaya Taichi <sugaya.taichi@socionext.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 19, 2018 at 10:01:09AM +0900, Sugaya Taichi wrote:
> Add DT bindings document for Milbeaut M10V timer.
> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../bindings/timer/socionext,milbeaut-timer.txt         | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
> new file mode 100644
> index 0000000..ddb1b31
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
> @@ -0,0 +1,17 @@
> +Milbeaut SoCs Timer Controller
> +
> +Required properties:
> +
> +- compatible : should be "socionext,milbeaut-m10v-timer"
> +- reg : Specifies base physical address and size of the registers.

How many register ranges? Looks like 2.

> +- interrupts : The interrupt of the first timer
> +- clocks: should be "rclk"
> +
> +Example:
> +
> +timer {

timer@1e000050

> +	compatible = "socionext,milbeaut-m10v-timer";
> +	reg = <0x1e000050 0x10>, <0x1e000060 0x10>;
> +	interrupts = <0 91 4>;
> +	clocks = <&rclk>;
> +};
> -- 
> 1.9.1
> 
