From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: serial: Convert riscv,sifive-serial to
 json-schema
Date: Mon, 02 Sep 2019 14:39:12 +0100
Message-ID: <5d6d1b81.1c69fb81.7eabb.cabd@mx.google.com>
References: <1567321765-3738-1-git-send-email-pragnesh.patel@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1567321765-3738-1-git-send-email-pragnesh.patel@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pragnesh Patel <pragnesh.patel@sifive.com>
Cc: palmer@sifive.com, paul.walmsley@sifive.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Albert Ou <aou@eecs.berkeley.edu>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, Sep 01, 2019 at 12:39:21PM +0530, Pragnesh Patel wrote:
> Convert the riscv,sifive-serial binding to DT schema using json-schema.
> 
> Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
> ---
>  .../devicetree/bindings/serial/sifive-serial.txt   | 33 ------------
>  .../devicetree/bindings/serial/sifive-serial.yaml  | 62 ++++++++++++++++++++++
>  2 files changed, 62 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.txt b/Documentation/devicetree/bindings/serial/sifive-serial.txt
> deleted file mode 100644
> index c86b1e5..0000000
> --- a/Documentation/devicetree/bindings/serial/sifive-serial.txt
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -SiFive asynchronous serial interface (UART)
> -
> -Required properties:
> -
> -- compatible: should be something similar to
> -	      "sifive,<chip>-uart" for the UART as integrated
> -	      on a particular chip, and "sifive,uart<version>" for the
> -	      general UART IP block programming model.	Supported
> -	      compatible strings as of the date of this writing are:
> -	      "sifive,fu540-c000-uart" for the SiFive UART v0 as
> -	      integrated onto the SiFive FU540 chip, or "sifive,uart0"
> -	      for the SiFive UART v0 IP block with no chip integration
> -	      tweaks (if any)
> -- reg: address and length of the register space
> -- interrupts: Should contain the UART interrupt identifier
> -- clocks: Should contain a clock identifier for the UART's parent clock
> -
> -
> -UART HDL that corresponds to the IP block version numbers can be found
> -here:
> -
> -https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/uart
> -
> -
> -Example:
> -
> -uart0: serial@10010000 {
> -	compatible = "sifive,fu540-c000-uart", "sifive,uart0";
> -	interrupt-parent = <&plic0>;
> -	interrupts = <80>;
> -	reg = <0x0 0x10010000 0x0 0x1000>;
> -	clocks = <&prci PRCI_CLK_TLCLK>;
> -};
> diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.yaml b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
> new file mode 100644
> index 0000000..56fa935
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/sifive-serial.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiFive asynchronous serial interface (UART)
> +
> +maintainers:
> +  - Pragnesh Patel <pragnesh.patel@sifive.com>
> +  - Paul Walmsley  <paul.walmsley@sifive.com>
> +  - Palmer Dabbelt <palmer@sifive.com>
> +
> +allOf:
> +  - $ref: /schemas/serial.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sifive,fu540-c000-uart
> +      - sifive,uart0

This is wrong and should have warned if you tested this on 5.3.

items:
  - const: sifive,fu540-c000-uart
  - const: sifive,uart0


> +
> +    description:
> +      Should be something similar to "sifive,<chip>-uart"
> +      for the UART as integrated on a particular chip,
> +      and "sifive,uart<version>" for the general UART IP
> +      block programming model.
> +
> +      UART HDL that corresponds to the IP block version
> +      numbers can be found here -
> +
> +      https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/uart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +      #include <dt-bindings/clock/sifive-fu540-prci.h>
> +      serial@10010000 {
> +        compatible = "sifive,fu540-c000-uart", "sifive,uart0";
> +        interrupt-parent = <&plic0>;
> +        interrupts = <80>;
> +        reg = <0x0 0x10010000 0x0 0x1000>;
> +        clocks = <&prci PRCI_CLK_TLCLK>;
> +      };
> +
> +...
> -- 
> 2.7.4
> 
