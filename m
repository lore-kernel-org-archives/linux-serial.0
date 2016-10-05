From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] sh-sci: add R8A7743/5 support
Date: Wed, 05 Oct 2016 12:55:07 +0300
Message-ID: <2254757.qf3e5qBuAz@avalon>
References: <2017044.9fZNuWa2OZ@wasted.cogentembedded.com> <CAMuHMdWEg8V81w=MT4akCaV=VUGopyWLJtSQC+KeWSpTR5dR_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWEg8V81w=MT4akCaV=VUGopyWLJtSQC+KeWSpTR5dR_w@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Friday 30 Sep 2016 10:38:48 Geert Uytterhoeven wrote:
> On Thu, Sep 29, 2016 at 11:37 PM, Sergei Shtylyov wrote:
> > Renesas  RZ/G SoC also have the SCIF, SCIFA, SCIFB, and HSCIF ports.
> > Document RZ/G1[ME] (also known as R8A774[35]) SoC bindings along with
> > the RZ/G family bindings.  The driver itself also needs to recognize
> > the latter binding for the SCIF ports, so teach it...
> > 
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > 
> > ---
> > This patch is against the 'tty-next' branch of GregKH's 'tty.git' repo.
> > 
> >  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt |   12
> >  ++++++++++
> >  drivers/tty/serial/sh-sci.c                                     |    3 ++
> >  2 files changed, 15 insertions(+)
> > 
> > Index: tty/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> > ===================================================================
> > ---
> > tty.orig/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> > +++ tty/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt> 
> > @@ -9,6 +9,14 @@ Required properties:
> >      - "renesas,scifb-r8a73a4" for R8A73A4 (R-Mobile APE6) SCIFB
> >      compatible UART. - "renesas,scifa-r8a7740" for R8A7740 (R-Mobile A1)
> >      SCIFA compatible UART. - "renesas,scifb-r8a7740" for R8A7740
> >      (R-Mobile A1) SCIFB compatible UART.> 
> > +    - "renesas,scif-r8a7743" for R8A7743 (RZ/G1M) SCIF compatible UART.
> > +    - "renesas,scifa-r8a7743" for R8A7743 (RZ/G1M) SCIFA compatible UART.
> > +    - "renesas,scifb-r8a7743" for R8A7743 (RZ/G1M) SCIFB compatible UART.
> > +    - "renesas,hscif-r8a7743" for R8A7743 (RZ/G1M) HSCIF compatible UART.
> > +    - "renesas,scif-r8a7745" for R8A7745 (RZ/G1E) SCIF compatible UART.
> > +    - "renesas,scifa-r8a7745" for R8A7745 (RZ/G1E) SCIFA compatible UART.
> > +    - "renesas,scifb-r8a7745" for R8A7745 (RZ/G1E) SCIFB compatible UART.
> > +    - "renesas,hscif-r8a7745" for R8A7745 (RZ/G1E) HSCIF compatible UART.

Are we *really* going to add four compat string for each RZ/G* SoC ? We're 
reaching the limit of sanity...

> >      - "renesas,scif-r8a7778" for R8A7778 (R-Car M1) SCIF compatible UART.
> >      - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART.
> >      - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
> 
> For the part above:
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > @@ -38,11 +46,15 @@ Required properties:
> >      - "renesas,rcar-gen1-scif" for R-Car Gen1 SCIF compatible UART,
> >      - "renesas,rcar-gen2-scif" for R-Car Gen2 SCIF compatible UART,
> >      - "renesas,rcar-gen3-scif" for R-Car Gen3 SCIF compatible UART,
> > +    - "renesas,rzg-scif" for RZ/G SCIF compatible UART.
> >      - "renesas,rcar-gen2-scifa" for R-Car Gen2 SCIFA compatible UART,
> > +    - "renesas,rzg-scifa" for RZ/G SCIFA compatible UART.
> >      - "renesas,rcar-gen2-scifb" for R-Car Gen2 SCIFB compatible UART,
> > +    - "renesas,rzg-scifb" for RZ/G SCIFB compatible UART.
> >      - "renesas,rcar-gen1-hscif" for R-Car Gen1 HSCIF compatible UART,
> >      - "renesas,rcar-gen2-hscif" for R-Car Gen2 HSCIF compatible UART,
> >      - "renesas,rcar-gen3-hscif" for R-Car Gen3 HSCIF compatible UART,
> > +    - "renesas,rzg-hscif" for RZ/G HSCIF compatible UART.
> >      - "renesas,scif" for generic SCIF compatible UART.
> >      - "renesas,scifa" for generic SCIFA compatible UART.
> >      - "renesas,scifb" for generic SCIFB compatible UART.
> > 
> > Index: tty/drivers/tty/serial/sh-sci.c
> > ===================================================================
> > --- tty.orig/drivers/tty/serial/sh-sci.c
> > +++ tty/drivers/tty/serial/sh-sci.c
> > @@ -2950,6 +2950,9 @@ static const struct of_device_id of_sci_
> >         }, {
> >                 .compatible = "renesas,rcar-gen3-scif",
> >                 .data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
> > 
> > +       }, {
> > +               .compatible = "renesas,rzg-scif",
> > +               .data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
> >         },
> >         /* Generic types */
> >         {
> 
> However, I wouldn't bother adding RZ/G family-specific DT bindings, as
> RZ/G is a derivative of R-Car Gen2.

I agree, we need to stop the compat string proliferation madness.

-- 
Regards,

Laurent Pinchart
