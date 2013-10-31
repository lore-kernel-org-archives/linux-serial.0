From: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 5/5] serial: sh-sci: Add device tree bindings documentation
Date: Thu, 31 Oct 2013 10:00:36 -0500
Message-ID: <B021E9B4-2795-4A84-9AD1-690EA119EF18@codeaurora.org>
References: <1383042599-25151-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1383042599-25151-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <9B7DF883-D119-47F5-BD71-11E30BE3DB88@codeaurora.org> <1975664.tS0XZnqC8i@avalon>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1975664.tS0XZnqC8i@avalon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bastian Hecht <hechtb+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


On Oct 31, 2013, at 9:55 AM, Laurent Pinchart wrote:

> Hi Kumar,
> 
> Thank you for the review.
> 
> On Thursday 31 October 2013 09:42:48 Kumar Gala wrote:
>> On Oct 29, 2013, at 5:29 AM, Laurent Pinchart wrote:
>>> Document the device tree bindings for the sci serial port devices.
>>> 
>>> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> Signed-off-by: Laurent Pinchart
>>> <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
>>> ---
>>> .../bindings/serial/renesas,sci-serial.txt         | 51 ++++++++++++++++++
>>> 1 file changed, 51 insertions(+)
>>> create mode 100644
>>> Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>>> 
>>> diff --git
>>> a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>>> b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt new
>>> file mode 100644
>>> index 0000000..5658b4f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>>> @@ -0,0 +1,51 @@
>>> +* Renesas SH-Mobile Serial Communication Interface
>>> +
>>> +Required properties:
>>> +
>>> +  - compatible: should be one of the following.
>> 
>> Being pedantic, but how about saying 'one of the following types (scif,
>> scifa, scifb, or hscif)
> 
> Sounds good to me.
> 
>>> +
>>> +    - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
>>> +    - "renesas,scifa-r8a7790" for R8A7790 (R-Car H2) SCIFA compatible
>>> UART.
>>> +    - "renesas,scifb-r8a7790" for R8A7790 (R-Car H2) SCIFB compatible
>>> UART.
>>> +    - "renesas,hscif-r8a7790" for R8A7790 (R-Car H2) HSCIF compatible
>>> UART.
>>> +    - "renesas,scif-generic" for generic SCIF compatible UART.
>>> +    - "renesas,scifa-generic" for generic SCIFA compatible UART.
>>> +    - "renesas,scifb-generic" for generic SCIFB compatible UART.
>>> +    - "renesas,hscif-generic" for generic HSCIF compatible UART.
>>> +
>>> +    When compatible with the generic version, nodes must also list the
>>> +    SoC-specific version corresponding to the platform.
>>> +
>>> +  - reg: Base address and length of the memory resource used by the UART.
>>> +
>>> +  - interrupt-parent: Reference to the parent interrupt controller.
>>> +  - interrupts: Interrupt number(s). Depending on the SoC SCIx UARTs are
>>> tied
>>> +    to one or multiple interrupt lines. When using multiple interrupt
>>> lines,
>>> +    specify the interrupt names as described below.
>>> +
>>> +  - clocks: Reference to the SCIx UART interface clock.
>>> +  - clock-names: Should be "sci_ick".
>>> +
>>> +Optional properties:
>>> +
>>> +  - interrupt-names: When using multiple interrupts, report the interrupt
>>> +    names as "eri" (receive error), "rxi" (receive), "txi" (transmit) and
>>> +    "bri" (break). When using a single interrupt this property should not
>>> be +    present.
>> 
>> Hmm, is there a reason not to just have the 4 interrupts always present and
>> in the case they are all wired to the same interrupt, just have the
>> interrupts all be the same?
>> 
>> example:
>> 
>> interrupts = <0 144 4>, <0 144 4>, <0 144 4>, <0 144 4>;
> 
> The multiple interrupts case is the exception, I thought it would be easier to 
> specify a single interrupt in the general case and have a more complex binding 
> for the exceptions.
> 
>>> +
>>> +Note: Each enabled SCIx UART should have an alias correctly numbered in
>>> the +"aliases" node.
>>> +
>>> +Example:
>>> +	aliases {
>>> +		serial0 = &scifa0;
>>> +	};
>>> +
>>> +	scifa0: serial@e6c40000 {
>>> +		compatible = "renesas,scifa-r8a7790", "renesas,scifa-generic";
>>> +		reg = <0 0xe6c40000 0 64>;
>>> +		interrupt-parent = <&gic>;
>>> +		interrupts = <0 144 4>;
>>> +		clocks = <&mstp2_clks 4>;
>>> +		clock-names = "sci_ick";
>>> +	};
>> 
>> might be nice to have an example with the 4 interrupts.
> 
> The example would be pretty theoretical, as the r8a7790 uses a single 
> interrupt in all cases. What about adding such an example when adding an SoC 
> that uses multiple interrupts to the DT bindings documentation ?

I'm fine with that if we strip the multiple interrupt bits out of the binding until a device/compatible exists that needs it.

- k
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
