From: Miquel RAYNAL <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 01/16] dt-bindings: mvebu-uart: update documentation
 with extended UART
Date: Thu, 19 Oct 2017 09:36:42 +0200
Message-ID: <20171019093642.6fd6d4d8@xps13>
References: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
        <20171013090200.31034-2-miquel.raynal@free-electrons.com>
        <20171017220022.kr2qiodln3qfkbwe@rob-hp-laptop>
        <20171018082531.59a2e5d0@xps13>
        <CAL_JsqJ3VkXHnh1H2NcBhgiFE+++WvXGA9Phdgj77X-4VGX3+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqJ3VkXHnh1H2NcBhgiFE+++WvXGA9Phdgj77X-4VGX3+w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh@m>
List-Id: linux-serial@vger.kernel.org

Hi Rob,

On Wed, 18 Oct 2017 08:29:07 -0500
Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> On Wed, Oct 18, 2017 at 1:25 AM, Miquel RAYNAL
> <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > Hi Rob,
> >
> > On Tue, 17 Oct 2017 17:00:22 -0500
> > Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> >  
> >> On Fri, Oct 13, 2017 at 11:01:45AM +0200, Miquel Raynal wrote:  
> >> > Update the Device Tree binding documentation for the Marvell EBU
> >> > UART, in order to allow describing the extended UART IP block, in
> >> > addition to the already supported standard UART IP. This requires
> >> > adding a new compatible string, the introduction of a clocks
> >> > property, and extensions to the interrupts property.
> >> >
> >> > Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> >> > Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> >> > ---
> >> >  .../devicetree/bindings/serial/mvebu-uart.txt      | 49
> >> > +++++++++++++++++++--- 1 file changed, 44 insertions(+), 5
> >> > deletions(-)
> >> >
> >> > diff --git
> >> > a/Documentation/devicetree/bindings/serial/mvebu-uart.txt
> >> > b/Documentation/devicetree/bindings/serial/mvebu-uart.txt index
> >> > d37fabe17bd1..3df3a3fab4bb 100644 ---
> >> > a/Documentation/devicetree/bindings/serial/mvebu-uart.txt +++
> >> > b/Documentation/devicetree/bindings/serial/mvebu-uart.txt @@
> >> > -1,13 +1,52 @@ -* Marvell UART : Non standard UART used in some
> >> > of Marvell EBU SoCs (e.g., Armada-3700) +* Marvell UART : Non
> >> > standard UART used in some of Marvell EBU SoCs
> >> > +                 e.g., Armada-3700.
> >> >
> >> >  Required properties:
> >> > -- compatible: "marvell,armada-3700-uart"
> >> > +- compatible:
> >> > +    - "marvell,armada-3700-uart" for the standard variant of the
> >> > UART
> >> > +      (32 bytes FIFO, no DMA, level interrupts, 8-bit access to
> >> > the
> >> > +      FIFO, baudrate limited to 230400).
> >> > +    - "marvell,armada-3700-uart-ext" for the extended variant of
> >> > the
> >> > +      UART (128 bytes FIFO, DMA, front interrupts, 8-bit or
> >> > 32-bit
> >> > +      accesses to the FIFO, baudrate unlimited by the
> >> > dividers).  
> >>
> >> What do you call the next extended version?
> >> marvell,armada-3700-uart-ext-ext?  
> >
> > I don't know what you mean by "next extended version"?  
> 
> IP evolves on new chips with new features. Just trying to understand
> how you are

I think I misunderstood your initial question.

Indeed you are right, I did not think about the naming of a potential
next extended version of the extended IP, but I don't know how to
rename it otherwise than "-ext" to best fit what the "new" IP
does.

> 
> >> This is different versions of UART on the same chip?  
> >
> > Today in mainline there is support for the A3700 UART IP.
> > This series add support for another IP, based on the A3700, but with
> > extended features (explaining the -ext suffix).
> >
> > Can you precise what is bothering you?  
> 
> Is this different versions of UART IP on 1 chip or a new version of
> the UART IP on a new SoC? The latter should be a new compatible with
> the new SoC. The former case does happen some, but is not common. I'm
> just trying to understand which applies here.

Actually, both IP are available since the first version of the
Armada 3700 SoCs. There is no other implementation of these IPs yet. I
think we fall in the former case.

> 
> 
> >> >  - reg: offset and length of the register set for the device.
> >> > -- interrupts: device interrupt
> >> > +- clocks: UART reference clock used to derive the baudrate (only
> >> > +      mandatory with "marvell,armada-3700-uart-ext"
> >> > compatible).  
> >>
> >> How is this optional? The freq is fixed if not present? If so, what
> >> frequency?  
> >
> > The "clocks" property should not be optional at all but that is how
> > the bindings were handled before this series, so I can't tell now
> > that this property is mandatory as it would break compatibility
> > with older versions of the driver.  
> 
> Okay. I think it should be mandatory with a note how missing property
> is handled.

Sure.

> 
> > When no clock is provided, the frequency is fixed by the bootloader
> > and cannot be changed. There is no standard frequency for it but the
> > one chosen by the bootloader often is 115200 as the UART is usually
> > used as the serial console.
> >
> > Because the bootloader does only initialize the UART in use for the
> > serial console, the clock is mandatory when using another port or it
> > will not work at all.  

Thank you,
Miquèl


-- 
Miquel Raynal, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
