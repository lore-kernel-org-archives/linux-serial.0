From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: serial: Convert Samsung UART bindings
 to json-schema
Date: Tue, 15 Oct 2019 14:40:06 -0500
Message-ID: <20191015194006.GA3540@bogus>
References: <20191004151414.8458-1-krzk@kernel.org>
 <20191004151414.8458-3-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191004151414.8458-3-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Mark Rutland <mark.rutland@arm.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maciej Falkowski <m.falkowski@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 04, 2019 at 05:14:14PM +0200, Krzysztof Kozlowski wrote:
> Convert Samsung S3C/S5P/Exynos Serial/UART bindings to DT schema format
> using json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/mfd/samsung,exynos5433-lpass.txt |   2 +-
>  .../bindings/serial/samsung_uart.txt          |  58 -------
>  .../bindings/serial/samsung_uart.yaml         | 148 ++++++++++++++++++
>  3 files changed, 149 insertions(+), 59 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/samsung_uart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/samsung_uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
> index d759da606f75..30ea27c3936d 100644
> --- a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
> +++ b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
> @@ -18,7 +18,7 @@ an optional sub-node. For "samsung,exynos5433-lpass" compatible this includes:
>  UART, SLIMBUS, PCM, I2S, DMAC, Timers 0...4, VIC, WDT 0...1 devices.
>  
>  Bindings of the sub-nodes are described in:
> -  ../serial/samsung_uart.txt
> +  ../serial/samsung_uart.yaml
>    ../sound/samsung-i2s.txt
>    ../dma/arm-pl330.txt
>  
> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.txt b/Documentation/devicetree/bindings/serial/samsung_uart.txt
> deleted file mode 100644
> index e85f37ec33f0..000000000000
> --- a/Documentation/devicetree/bindings/serial/samsung_uart.txt
> +++ /dev/null
> @@ -1,58 +0,0 @@
> -* Samsung's UART Controller
> -
> -The Samsung's UART controller is used for interfacing SoC with serial
> -communicaion devices.
> -
> -Required properties:
> -- compatible: should be one of following:
> -  - "samsung,exynos4210-uart" -  Exynos4210 SoC,
> -  - "samsung,s3c2410-uart" - compatible with ports present on S3C2410 SoC,
> -  - "samsung,s3c2412-uart" - compatible with ports present on S3C2412 SoC,
> -  - "samsung,s3c2440-uart" - compatible with ports present on S3C2440 SoC,
> -  - "samsung,s3c6400-uart" - compatible with ports present on S3C6400 SoC,
> -  - "samsung,s5pv210-uart" - compatible with ports present on S5PV210 SoC.
> -
> -- reg: base physical address of the controller and length of memory mapped
> -  region.
> -
> -- interrupts: a single interrupt signal to SoC interrupt controller,
> -  according to interrupt bindings documentation [1].
> -
> -- clock-names: input names of clocks used by the controller:
> -  - "uart" - controller bus clock,
> -  - "clk_uart_baudN" - Nth baud base clock input (N = 0, 1, ...),
> -    according to SoC User's Manual (only N = 0 is allowedfor SoCs without
> -    internal baud clock mux).
> -- clocks: phandles and specifiers for all clocks specified in "clock-names"
> -  property, in the same order, according to clock bindings documentation [2].
> -
> -[1] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> -[2] Documentation/devicetree/bindings/clock/clock-bindings.txt
> -
> -Optional properties:
> -- samsung,uart-fifosize: The fifo size supported by the UART channel
> -
> -Note: Each Samsung UART should have an alias correctly numbered in the
> -"aliases" node, according to serialN format, where N is the port number
> -(non-negative decimal integer) as specified by User's Manual of respective
> -SoC.
> -
> -Example:
> -	aliases {
> -		serial0 = &uart0;
> -		serial1 = &uart1;
> -		serial2 = &uart2;
> -	};
> -
> -Example:
> -	uart1: serial@7f005400 {
> -		compatible = "samsung,s3c6400-uart";
> -		reg = <0x7f005400 0x100>;
> -		interrupt-parent = <&vic1>;
> -		interrupts = <6>;
> -		clock-names = "uart", "clk_uart_baud2",
> -				"clk_uart_baud3";
> -		clocks = <&clocks PCLK_UART1>, <&clocks PCLK_UART1>,
> -				<&clocks SCLK_UART>;
> -		samsung,uart-fifosize = <16>;
> -	};
> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> new file mode 100644
> index 000000000000..276bea1c231a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> @@ -0,0 +1,148 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/samsung_uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung S3C, S5P and Exynos SoC UART Controller
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> +
> +description: |+
> +  Each Samsung UART should have an alias correctly numbered in the "aliases"
> +  node, according to serialN format, where N is the port number (non-negative
> +  decimal integer) as specified by User's Manual of respective SoC.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - samsung,s3c2410-uart
> +          - samsung,s3c2412-uart
> +          - samsung,s3c2440-uart
> +          - samsung,s3c6400-uart
> +          - samsung,s5pv210-uart
> +          - samsung,exynos4210-uart
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 5
> +
> +  clock-names:
> +    description: |
> +      List of clock names:
> +        - "uart" - controller bus clock,
> +        - "clk_uart_baudN" - Nth baud base clock input (N = 0, 1, ...).

Kind of redundant to list this here.

> +      N = 0 is allowed for SoCs without internal baud clock mux.

You can add a description with the item:

items:
  - pattern: '^clk_uart_baud[0-3]$'
    description: N = 0 is allowed for SoCs without internal baud clock mux.

Or leave it here is fine too.

> +    minItems: 2
> +    maxItems: 5
> +    allOf:
> +      - uniqueItems: true

You can drop this.

> +      - oneOf:
> +          - items:
> +              - const: uart
> +              - pattern: '^clk_uart_baud[0-3]$'
> +          - items:
> +              - const: uart
> +              - pattern: '^clk_uart_baud[0-3]$'
> +              - pattern: '^clk_uart_baud[0-3]$'
> +          - items:
> +              - const: uart
> +              - pattern: '^clk_uart_baud[0-3]$'
> +              - pattern: '^clk_uart_baud[0-3]$'
> +              - pattern: '^clk_uart_baud[0-3]$'
> +          - items:
> +              - const: uart
> +              - pattern: '^clk_uart_baud[0-3]$'
> +              - pattern: '^clk_uart_baud[0-3]$'
> +              - pattern: '^clk_uart_baud[0-3]$'
> +              - pattern: '^clk_uart_baud[0-3]$'

You only need the last case. With 'minItems: 2', the additional items 
here will just be ignored.

> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2

What is each item?

> +
> +  samsung,uart-fifosize:
> +    description: The fifo size supported by the UART channel
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [16, 64, 256]
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - reg
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,s3c2410-uart
> +              - samsung,s5pv210-uart
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 3
> +        clock-names:
> +          minItems: 2
> +          maxItems: 3
> +          allOf:
> +            - uniqueItems: true
> +            - oneOf:
> +                - items:
> +                    - const: uart
> +                    - pattern: '^clk_uart_baud[0-1]$'
> +                - items:
> +                    - const: uart
> +                    - pattern: '^clk_uart_baud[0-1]$'
> +                    - pattern: '^clk_uart_baud[0-1]$'

Similar simplification can be done here.

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,exynos4210-uart
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +        clock-names:
> +          minItems: 2
> +          maxItems: 2
> +          allOf:
> +            - uniqueItems: true
> +            - items:
> +                - const: uart
> +                - const: clk_uart_baud0
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/samsung,s3c64xx-clock.h>
> +
> +    aliases {
> +        serial0 = &uart0;
> +    };

Drop this. It will cause a warning if we enforce 'aliases' to be at the 
root node.

> +
> +    uart0: serial@7f005000 {
> +        compatible = "samsung,s3c6400-uart";
> +        reg = <0x7f005000 0x100>;
> +        interrupt-parent = <&vic1>;
> +        interrupts = <5>;
> +        clock-names = "uart", "clk_uart_baud2",
> +                      "clk_uart_baud3";
> +        clocks = <&clocks PCLK_UART0>, <&clocks PCLK_UART0>,
> +                 <&clocks SCLK_UART>;
> +        samsung,uart-fifosize = <16>;
> +    };
> -- 
> 2.17.1
> 
