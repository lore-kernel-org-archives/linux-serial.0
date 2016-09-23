From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 02/11] DOCUMENTATION: dt-bindings: Document the STM32
 USART bindings
Date: Fri, 23 Sep 2016 10:29:07 -0500
Message-ID: <20160923152907.GA19206@rob-hp-laptop>
References: <1473957763-30629-1-git-send-email-alexandre.torgue@st.com>
 <1473957763-30629-3-git-send-email-alexandre.torgue@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1473957763-30629-3-git-send-email-alexandre.torgue-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>
Cc: Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, gerald.baeza-qxv4g6HH51o@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 15, 2016 at 06:42:34PM +0200, Alexandre TORGUE wrote:
> This adds documentation of device tree bindings for the
> STM32 USART

Please make your subject prefixes consistent and drop "DOCUMENTATION".

> 
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>
> 
> diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
> new file mode 100644
> index 0000000..75b1400
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
> @@ -0,0 +1,34 @@
> +* STMicroelectronics STM32 USART
> +
> +Required properties:
> +- compatible: Can be either "st,stm32-usart", "st,stm32-uart",
> +"st,stm32f7-usart" or "st,stm32f7-uart" depending on whether
> +the device supports synchronous mode and is compatible with
> +stm32(f4) or stm32f7.

Why not put f4 in the compatible string. stm32 is too generic.

What determines sync mode or not? If it is IP configuration fixed in the 
design, then this is fine. If it is user choice or board dependent, then 
use a separate property.

> +- reg: The address and length of the peripheral registers space
> +- interrupts: The interrupt line of the USART instance
> +- clocks: The input clock of the USART instance
> +
> +Optional properties:
> +- pinctrl: The reference on the pins configuration
> +- st,hw-flow-ctrl: bool flag to enable hardware flow control.
> +
> +Examples:
> +usart4: serial@40004c00 {
> +	compatible = "st,stm32-uart";
> +	reg = <0x40004c00 0x400>;
> +	interrupts = <52>;
> +	clocks = <&clk_pclk1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usart4>;
> +};
> +
> +usart2: serial@40004400 {
> +	compatible = "st,stm32-usart", "st,stm32-uart";

What are valid combinations? usart is sync only, not sync and async?

> +	reg = <0x40004400 0x400>;
> +	interrupts = <38>;
> +	clocks = <&clk_pclk1>;
> +	st,hw-flow-ctrl;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usart2 &pinctrl_usart2_rtscts>;
> +};
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
