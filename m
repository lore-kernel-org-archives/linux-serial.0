From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 28/29] serial: sh-sci: Add device tree bindings documentation
Date: Sun, 10 Nov 2013 22:07:16 +0400
Message-ID: <527FCB54.404@cogentembedded.com>
References: <1384054421-13357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1384054421-13357-29-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:51242 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729Ab3KJSHT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 10 Nov 2013 13:07:19 -0500
Received: by mail-lb0-f181.google.com with SMTP id x18so2689233lbi.26
        for <linux-serial@vger.kernel.org>; Sun, 10 Nov 2013 10:07:18 -0800 (PST)
In-Reply-To: <1384054421-13357-29-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>, devicetree@vger.kernel.org

On 10-11-2013 7:33, Laurent Pinchart wrote:

> Document the device tree bindings for the sci serial port devices.

> Cc: devicetree@vger.kernel.org

    Hm, why are you not CCing a bunch of people responsible for the DT 
bindings maintenance that scripts/get_maintainer.pl should yield?

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   .../bindings/serial/renesas,sci-serial.txt         | 42 ++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt

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
> +
> +    - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
> +    - "renesas,scifa-r8a7790" for R8A7790 (R-Car H2) SCIFA compatible UART.
> +    - "renesas,scifb-r8a7790" for R8A7790 (R-Car H2) SCIFB compatible UART.
> +    - "renesas,hscif-r8a7790" for R8A7790 (R-Car H2) HSCIF compatible UART.
> +    - "renesas,scif-generic" for generic SCIF compatible UART.
> +    - "renesas,scifa-generic" for generic SCIFA compatible UART.
> +    - "renesas,scifb-generic" for generic SCIFB compatible UART.
> +    - "renesas,hscif-generic" for generic HSCIF compatible UART.
> +
> +    When compatible with the generic version, nodes must also list the
> +    SoC-specific version corresponding to the platform.

    Which are not all specified here?

> +
> +  - reg: Base address and length of the memory resource used by the UART.
> +
> +  - interrupt-parent: Reference to the parent interrupt controller.

    This is not a required property. It can be specified in the parent node.

> +  - interrupts: Interrupt number.

    s/number/specifier/

> +
> +  - clocks: Reference to the SCIx UART interface clock.
> +  - clock-names: Should be "sci_ick".
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

WBR, Sergei

