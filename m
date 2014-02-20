From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 4/4] Documentation: devicetree: add bindings
 documentation for bcm63xx-uart
Date: Thu, 20 Feb 2014 09:45:53 +0000
Message-ID: <20140220094553.GA32707@e106331-lin.cambridge.arm.com>
References: <1392852167-26243-1-git-send-email-f.fainelli@gmail.com>
 <1392852167-26243-5-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:38475 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750838AbaBTJqH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Feb 2014 04:46:07 -0500
Content-Disposition: inline
In-Reply-To: <1392852167-26243-5-git-send-email-f.fainelli@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "mbizon@freebox.fr" <mbizon@freebox.fr>, "jogo@openwrt.org" <jogo@openwrt.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>

On Wed, Feb 19, 2014 at 11:22:47PM +0000, Florian Fainelli wrote:
> Add the Device Tree binding documentation for the non-standard BCM63xx
> UART hardware block found in the BCM63xx DSL SoCs.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/serial/bcm63xx-uart.txt    | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/bcm63xx-uart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/bcm63xx-uart.txt b/Documentation/devicetree/bindings/serial/bcm63xx-uart.txt
> new file mode 100644
> index 0000000..829441d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/bcm63xx-uart.txt
> @@ -0,0 +1,24 @@
> +Broadcom BCM63xx UART: Non standard UART used in the Broadcom BCM63xx DSL SoCs
> +
> +Required properties:
> +- compatible: must be "brcm,bcm63xx-uart"
> +- reg: offset and length of the register set for the device
> +- interrupts: device interrupt
> +- clocks: a phandle to the functional clock node
> +- clock-names: must be "periph"

Minor issues: clocks aren't just phandles, and as the clock is expected
to be named it would be nice to define clocks in terms of clock-names:

- clocks: a list of phandles + clock-specifiers, one for each entry in
  clock-names
- clock-names: should contain "periph" for the functional clock

Thanks,
Mark.

> +
> +Note: each UART port must have an alias correctly numbered in the "aliases"
> +node, e.g:
> +
> +serial0: uart@600 {
> +	compatible = "brcm,bcm63xx-uart";
> +	reg = <0x600 0x1b>;
> +	interrupts = <GIC_SPI 32 0>;
> +	clocks = <&periph_clk>;
> +	clock-names = "periph";
> +};
> +
> +aliases {
> +	uart0 = &serial0;
> +	uart1 = &serial1;
> +};
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
