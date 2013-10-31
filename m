From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 5/5] serial: sh-sci: Add device tree bindings documentation
Date: Thu, 31 Oct 2013 15:55:34 +0100
Message-ID: <1975664.tS0XZnqC8i@avalon>
References: <1383042599-25151-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1383042599-25151-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <9B7DF883-D119-47F5-BD71-11E30BE3DB88@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <9B7DF883-D119-47F5-BD71-11E30BE3DB88@codeaurora.org>
Sender: linux-sh-owner@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Kumar,

Thank you for the review.

On Thursday 31 October 2013 09:42:48 Kumar Gala wrote:
> On Oct 29, 2013, at 5:29 AM, Laurent Pinchart wrote:
> > Document the device tree bindings for the sci serial port devices.
> > 
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > .../bindings/serial/renesas,sci-serial.txt         | 51 ++++++++++++++++++
> > 1 file changed, 51 insertions(+)
> > create mode 100644
> > Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> > b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt new
> > file mode 100644
> > index 0000000..5658b4f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> > @@ -0,0 +1,51 @@
> > +* Renesas SH-Mobile Serial Communication Interface
> > +
> > +Required properties:
> > +
> > +  - compatible: should be one of the following.
> 
> Being pedantic, but how about saying 'one of the following types (scif,
> scifa, scifb, or hscif)

Sounds good to me.

> > +
> > +    - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
> > +    - "renesas,scifa-r8a7790" for R8A7790 (R-Car H2) SCIFA compatible
> > UART.
> > +    - "renesas,scifb-r8a7790" for R8A7790 (R-Car H2) SCIFB compatible
> > UART.
> > +    - "renesas,hscif-r8a7790" for R8A7790 (R-Car H2) HSCIF compatible
> > UART.
> > +    - "renesas,scif-generic" for generic SCIF compatible UART.
> > +    - "renesas,scifa-generic" for generic SCIFA compatible UART.
> > +    - "renesas,scifb-generic" for generic SCIFB compatible UART.
> > +    - "renesas,hscif-generic" for generic HSCIF compatible UART.
> > +
> > +    When compatible with the generic version, nodes must also list the
> > +    SoC-specific version corresponding to the platform.
> > +
> > +  - reg: Base address and length of the memory resource used by the UART.
> > +
> > +  - interrupt-parent: Reference to the parent interrupt controller.
> > +  - interrupts: Interrupt number(s). Depending on the SoC SCIx UARTs are
> > tied
> > +    to one or multiple interrupt lines. When using multiple interrupt
> > lines,
> > +    specify the interrupt names as described below.
> > +
> > +  - clocks: Reference to the SCIx UART interface clock.
> > +  - clock-names: Should be "sci_ick".
> > +
> > +Optional properties:
> > +
> > +  - interrupt-names: When using multiple interrupts, report the interrupt
> > +    names as "eri" (receive error), "rxi" (receive), "txi" (transmit) and
> > +    "bri" (break). When using a single interrupt this property should not
> > be +    present.
> 
> Hmm, is there a reason not to just have the 4 interrupts always present and
> in the case they are all wired to the same interrupt, just have the
> interrupts all be the same?
> 
> example:
> 
> interrupts = <0 144 4>, <0 144 4>, <0 144 4>, <0 144 4>;

The multiple interrupts case is the exception, I thought it would be easier to 
specify a single interrupt in the general case and have a more complex binding 
for the exceptions.

> > +
> > +Note: Each enabled SCIx UART should have an alias correctly numbered in
> > the +"aliases" node.
> > +
> > +Example:
> > +	aliases {
> > +		serial0 = &scifa0;
> > +	};
> > +
> > +	scifa0: serial@e6c40000 {
> > +		compatible = "renesas,scifa-r8a7790", "renesas,scifa-generic";
> > +		reg = <0 0xe6c40000 0 64>;
> > +		interrupt-parent = <&gic>;
> > +		interrupts = <0 144 4>;
> > +		clocks = <&mstp2_clks 4>;
> > +		clock-names = "sci_ick";
> > +	};
> 
> might be nice to have an example with the 4 interrupts.

The example would be pretty theoretical, as the r8a7790 uses a single 
interrupt in all cases. What about adding such an example when adding an SoC 
that uses multiple interrupts to the DT bindings documentation ?

-- 
Regards,

Laurent Pinchart

