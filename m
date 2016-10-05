From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] sh-sci: add R8A7743/5 support
Date: Wed, 05 Oct 2016 16:37:09 +0300
Message-ID: <7496008.sErWcihIz4@avalon>
References: <2017044.9fZNuWa2OZ@wasted.cogentembedded.com> <2254757.qf3e5qBuAz@avalon> <CAL_Jsq+p35REB_Lwm2vhGEKiTQHCawAXqYeJ1Yq5o3WEad9K8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+p35REB_Lwm2vhGEKiTQHCawAXqYeJ1Yq5o3WEad9K8Q@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wednesday 05 Oct 2016 08:28:05 Rob Herring wrote:
> On Wed, Oct 5, 2016 at 4:55 AM, Laurent Pinchart
> 
> <laurent.pinchart@ideasonboard.com> wrote:
> > On Friday 30 Sep 2016 10:38:48 Geert Uytterhoeven wrote:
> >> On Thu, Sep 29, 2016 at 11:37 PM, Sergei Shtylyov wrote:
> >> > Renesas  RZ/G SoC also have the SCIF, SCIFA, SCIFB, and HSCIF ports.
> >> > Document RZ/G1[ME] (also known as R8A774[35]) SoC bindings along with
> >> > the RZ/G family bindings.  The driver itself also needs to recognize
> >> > the latter binding for the SCIF ports, so teach it...
> >> > 
> >> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >> > 
> >> > ---
> >> > This patch is against the 'tty-next' branch of GregKH's 'tty.git' repo.
> >> > 
> >> >  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt |   12
> >> >  ++++++++++
> >> >  drivers/tty/serial/sh-sci.c                                     |    3
> >> >  ++
> >> >  2 files changed, 15 insertions(+)
> >> > 
> >> > Index:
> >> > tty/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> >> > ===================================================================
> >> > ---
> >> > tty.orig/Documentation/devicetree/bindings/serial/renesas,sci-serial.tx
> >> > t
> >> > +++
> >> > tty/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt>
> >> > 
> >> > @@ -9,6 +9,14 @@ Required properties:
> >> >      - "renesas,scifb-r8a73a4" for R8A73A4 (R-Mobile APE6) SCIFB
> >> >      compatible UART. - "renesas,scifa-r8a7740" for R8A7740 (R-Mobile
> >> >      A1)
> >> >      SCIFA compatible UART. - "renesas,scifb-r8a7740" for R8A7740
> >> >      (R-Mobile A1) SCIFB compatible UART.>
> >> > 
> >> > +    - "renesas,scif-r8a7743" for R8A7743 (RZ/G1M) SCIF compatible
> >> > UART.
> >> > +    - "renesas,scifa-r8a7743" for R8A7743 (RZ/G1M) SCIFA compatible
> >> > UART.
> >> > +    - "renesas,scifb-r8a7743" for R8A7743 (RZ/G1M) SCIFB compatible
> >> > UART.
> >> > +    - "renesas,hscif-r8a7743" for R8A7743 (RZ/G1M) HSCIF compatible
> >> > UART.
> >> > +    - "renesas,scif-r8a7745" for R8A7745 (RZ/G1E) SCIF compatible
> >> > UART.
> >> > +    - "renesas,scifa-r8a7745" for R8A7745 (RZ/G1E) SCIFA compatible
> >> > UART.
> >> > +    - "renesas,scifb-r8a7745" for R8A7745 (RZ/G1E) SCIFB compatible
> >> > UART.
> >> > +    - "renesas,hscif-r8a7745" for R8A7745 (RZ/G1E) HSCIF compatible
> >> > UART.
> > 
> > Are we *really* going to add four compat string for each RZ/G* SoC ? We're
> > reaching the limit of sanity...
> 
> Is it really 4 distinct UARTs on a chip? DT can't fix that insanity.

It's really 4 different UART types on a chip, yes. We have actually 5 
different UART types, named SCI, SCIF, SCIFA, SCIFB and HSCIF. Only the last 4 
are used on R-Car SoCs.

There are 34 compatible strings defined, one per UART + SoC combination, plus 
a set of more generic ones. So far, the driver handles the r7s72100 compatible 
string separately as the UART on that chip is quite peculiar, but for all 
other SoCs we only need to match against

- the five generic renesas,(h)sci(f|fa|fb)? types
- the per-family renesas,rcar-gen[123]-scif types for the SCIF only

This means that there's a high level of compatibility between UARTs instances 
in different SoCs (we might need a few more per-family compatible strings to 
tell models apart that could present have family-dependent features currently 
not supported in the driver, but I believe my argument still remains largely 
true). However, due to the combination of the "DT is an ABI" and "IPs that 
appear identical in the datasheet could actually have differences that we 
haven't found yet" dogmas, the proliferation of per-SoC compatible strings is 
getting out of hands.

-- 
Regards,

Laurent Pinchart
