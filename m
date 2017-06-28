From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 14/20] dt-bindings: serial: document option wake-up
 interrupt for STM32 USART
Date: Wed, 28 Jun 2017 13:10:13 -0500
Message-ID: <20170628181013.pv2f7acbckgnsnhg@rob-hp-laptop>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
 <1498481318-1894-15-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1498481318-1894-15-git-send-email-bich.hemon-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bich HEMON <bich.hemon-qxv4g6HH51o@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 26, 2017 at 12:49:15PM +0000, Bich HEMON wrote:
> From: Bich Hemon <bich.hemon-qxv4g6HH51o@public.gmane.org>
> 
> Introduce new compatibles for "st,stm32h7-usart" and "st,stm32h7-uart".
> This new compatible allow to use optional wake-up interrupt.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
> ---
>  .../devicetree/bindings/serial/st,stm32-usart.txt    | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
> index a229b14..3b42138 100644
> --- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
> +++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
> @@ -2,11 +2,14 @@
>  
>  Required properties:
>  - compatible: Can be either "st,stm32-usart", "st,stm32-uart",
> -"st,stm32f7-usart" or "st,stm32f7-uart" depending on whether
> -the device supports synchronous mode and is compatible with
> -stm32(f4) or stm32f7.
> +"st,stm32f7-usart", "st,stm32f7-uart", "st,stm32h7-usart" or
> +st,stm32h7-uart depending on whether the device supports synchronous
> +mode and is compatible with stm32(f4), stm32f7 or stm32h7.

Please reformat as 1 valid set of compatibles per line.

>  - reg: The address and length of the peripheral registers space
> -- interrupts: The interrupt line of the USART instance
> +- interrupts or interrupts-extended: Must contain first, the interrupt
> +  line specifier for the USART instance. An optional wake-up interrupt
> +  specifier can be added. Then, -extended variant may be needed to specify
> +  interrupts parent controllers.

Just describe the interrupts property and what the interrupts are. 
interrupts-extended is implied if it is necessary.

>  - clocks: The input clock of the USART instance
>  
>  Optional properties:
> @@ -53,3 +56,12 @@ usart1: serial@40011000 {
>  	       <&dma2 7 4 0x414 0x0>;
>  	dma-names = "rx", "tx";
>  };
> +
> +uart4: serial@40010000 {
> +	compatible = "st,stm32h7-uart";
> +	reg = <0x40010000 0x400>;
> +	interrupts-extended = <&intc GIC_SPI 52 IRQ_TYPE_NONE>,
> +			      <&aiec 30 1>;
> +	clocks = <&rcc UART4_K>;
> +	status = "disabled";
> +};
> -- 
> 1.9.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
