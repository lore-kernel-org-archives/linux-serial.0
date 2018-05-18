From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 4/6] dt-bindings: add binding for at91-usart in spi
 mode
Date: Fri, 18 May 2018 16:40:51 -0500
Message-ID: <20180518214051.GA29868@rob-hp-laptop>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-5-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180511103822.31698-5-radu.pirea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Radu Pirea <radu.pirea@microchip.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, mark.rutland@arm.com, lee.jones@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com, richard.genoud@gmail.com, alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com, broonie@kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, May 11, 2018 at 01:38:20PM +0300, Radu Pirea wrote:
> These are bindings for at91-usart IP in spi spi mode. There is no support for

s/spi spi/SPI/

> internal chip select. Only kind of chip selects available are gpio chip

GPIO

> selects.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  .../bindings/spi/microchip,at91-usart-spi.txt | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt b/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
> new file mode 100644
> index 000000000000..b68a3bec4121
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt

So now we have 2 copies of the same thing that varies by 2 properties?
Please make this one doc.

> @@ -0,0 +1,28 @@
> +* Universal Synchronous Asynchronous Receiver/Transmitter (USART) in SPI mode
> +
> +Required properties:
> +- #size-cells      : Must be <0>
> +- #address-cells   : Must be <1>
> +- compatible: Should be "atmel,at91rm9200-usart" or "atmel,at91sam9260-usart"
> +- reg: Should contain registers location and length
> +- interrupts: Should contain interrupt
> +- clocks: phandles to input clocks.
> +- clock-names: tuple listing input clock names.
> +	Required elements: "usart"
> +- cs-gpios: chipselects (internal cs not supported)
> +- at91,usart-mode: AT91_USART_MODE_SPI (found in dt-bindings/mfd/at91-usart.h)

at91 is not a vendor.


> +
> +Example:
> +	#include <dt-bindings/mfd/at91-usart.h>
> +
> +	spi0: spi@f001c000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "atmel,at91rm9200-usart", "atmel,at91sam9260-usart";
> +		at91,usart-mode = <AT91_USART_MODE_SPI>;
> +		reg = <0xf001c000 0x100>;
> +		interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&usart0_clk>;
> +		clock-names = "usart";
> +		cs-gpios = <&pioB 3 0>;
> +	};
> -- 
> 2.17.0
> 
