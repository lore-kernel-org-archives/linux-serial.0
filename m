From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] sh-sci: add R8A7743/5 support
Date: Wed, 5 Oct 2016 12:03:24 +0200
Message-ID: <CAMuHMdWG3R9FzFakx8eccYXXFMP_8_JH0Q0f8W8n1uZrOdygtg@mail.gmail.com>
References: <2017044.9fZNuWa2OZ@wasted.cogentembedded.com> <CAMuHMdWEg8V81w=MT4akCaV=VUGopyWLJtSQC+KeWSpTR5dR_w@mail.gmail.com>
 <2254757.qf3e5qBuAz@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <2254757.qf3e5qBuAz@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Laurent,

On Wed, Oct 5, 2016 at 11:55 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Friday 30 Sep 2016 10:38:48 Geert Uytterhoeven wrote:
>> On Thu, Sep 29, 2016 at 11:37 PM, Sergei Shtylyov wrote:
>> > Renesas  RZ/G SoC also have the SCIF, SCIFA, SCIFB, and HSCIF ports.
>> > Document RZ/G1[ME] (also known as R8A774[35]) SoC bindings along with
>> > the RZ/G family bindings.  The driver itself also needs to recognize
>> > the latter binding for the SCIF ports, so teach it...
>> >
>> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> >
>> > ---
>> > This patch is against the 'tty-next' branch of GregKH's 'tty.git' repo.
>> >
>> >  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt |   12
>> >  ++++++++++
>> >  drivers/tty/serial/sh-sci.c                                     |    3 ++
>> >  2 files changed, 15 insertions(+)
>> >
>> > Index: tty/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>> > ===================================================================
>> > ---
>> > tty.orig/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>> > +++ tty/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt>
>> > @@ -9,6 +9,14 @@ Required properties:
>> >      - "renesas,scifb-r8a73a4" for R8A73A4 (R-Mobile APE6) SCIFB
>> >      compatible UART. - "renesas,scifa-r8a7740" for R8A7740 (R-Mobile A1)
>> >      SCIFA compatible UART. - "renesas,scifb-r8a7740" for R8A7740
>> >      (R-Mobile A1) SCIFB compatible UART.>
>> > +    - "renesas,scif-r8a7743" for R8A7743 (RZ/G1M) SCIF compatible UART.
>> > +    - "renesas,scifa-r8a7743" for R8A7743 (RZ/G1M) SCIFA compatible UART.
>> > +    - "renesas,scifb-r8a7743" for R8A7743 (RZ/G1M) SCIFB compatible UART.
>> > +    - "renesas,hscif-r8a7743" for R8A7743 (RZ/G1M) HSCIF compatible UART.
>> > +    - "renesas,scif-r8a7745" for R8A7745 (RZ/G1E) SCIF compatible UART.
>> > +    - "renesas,scifa-r8a7745" for R8A7745 (RZ/G1E) SCIFA compatible UART.
>> > +    - "renesas,scifb-r8a7745" for R8A7745 (RZ/G1E) SCIFB compatible UART.
>> > +    - "renesas,hscif-r8a7745" for R8A7745 (RZ/G1E) HSCIF compatible UART.
>
> Are we *really* going to add four compat string for each RZ/G* SoC ? We're
> reaching the limit of sanity...

Soon we can use soc_device_match(), if we ever need to handle r8a7743 or
r8a7745 quirks?

Declaring it is compatible with renesas,rcar-gen2-scif is still good/needed for
the BRG (Baud Rate Generator for External Clock), which is not present on e.g.
RZ/A1H.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
