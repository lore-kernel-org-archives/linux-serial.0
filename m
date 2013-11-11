From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 28/29] serial: sh-sci: Add device tree bindings
 documentation
Date: Mon, 11 Nov 2013 09:40:39 +0000
Message-ID: <20131111094039.GA21201@e106331-lin.cambridge.arm.com>
References: <1384054421-13357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1384054421-13357-29-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1384054421-13357-29-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Content-Language: en-US
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Laurent,

I have a few comments.

On Sun, Nov 10, 2013 at 03:33:40AM +0000, Laurent Pinchart wrote:
> Document the device tree bindings for the sci serial port devices.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  .../bindings/serial/renesas,sci-serial.txt         | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> new file mode 100644
> index 0000000..66d3bca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> @@ -0,0 +1,42 @@
> +* Renesas SH-Mobile Serial Communication Interface
> +
> +Required properties:
> +
> +  - compatible: one of the following types (scif, scifa, scifb, hscif).

Minor nit, but would be nice to have "Should contain one of the
following:". We might have future variants whereby the compatible string
will actually be a string list.

> +
> +    - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
> +    - "renesas,scifa-r8a7790" for R8A7790 (R-Car H2) SCIFA compatible UART.
> +    - "renesas,scifb-r8a7790" for R8A7790 (R-Car H2) SCIFB compatible UART.
> +    - "renesas,hscif-r8a7790" for R8A7790 (R-Car H2) HSCIF compatible UART.
> +    - "renesas,scif-generic" for generic SCIF compatible UART.
> +    - "renesas,scifa-generic" for generic SCIFA compatible UART.
> +    - "renesas,scifb-generic" for generic SCIFB compatible UART.
> +    - "renesas,hscif-generic" for generic HSCIF compatible UART.

Is the "-generic" suffix necessary? Why not just "renesas,scif" etc?

> +
> +    When compatible with the generic version, nodes must also list the
> +    SoC-specific version corresponding to the platform.

Presumably the SoC-specific version should come first; it would be nice
to note that.

> +
> +  - reg: Base address and length of the memory resource used by the UART.

I assume by memory resource you mean the memory-mapped registers?
Resource sounds like Linux-internal nomenclature leaking.

> +
> +  - interrupt-parent: Reference to the parent interrupt controller.

I don't think this is strictly necessary. It's implicit by default and
can be added optionally when a system is wired in a complex way. As it's
a completely standard optional property I'm not even sure it needs to be
documented.

> +  - interrupts: Interrupt number.

Minor nit: "Should contain an interrupt-specifier for ..."

I saw the cover mentioned multiple interrupts. Which logical interrupt
output of the device are you expecting here?

> +
> +  - clocks: Reference to the SCIx UART interface clock.

Minor nit: s/Reference to/A phandle + clock-specifier pair for/

> +  - clock-names: Should be "sci_ick".

As we're using clock-names, it would be nicer still to define clocks in
terms of clock-names so as to make it easier to update the document in
future and make the expected use of clock-names clearer:

- clocks: Should contain a phandle + clock-specifier pair for each entry
  in clock-names.

- clock-names: Should contain "sci_ick".

> +
> +Note: Each enabled SCIx UART should have an alias correctly numbered in the
> +"aliases" node.
> +
> +Example:
> +	aliases {
> +		serial0 = &scifa0;
> +	};
> +
> +	scifa0: serial@e6c40000 {
> +		compatible = "renesas,scifa-r8a7790", "renesas,scifa-generic";
> +		reg = <0 0xe6c40000 0 64>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 144 4>;
> +		clocks = <&mstp2_clks 4>;
> +		clock-names = "sci_ick";
> +	};

Otherwise this looks good to me.

Thanks,
Mark.
