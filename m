From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 01/25] serial: sh-sci: Update DT binding documentation for
 external clock input
Date: Fri, 20 Nov 2015 09:00:13 +0100
Message-ID: <CAMuHMdUtvCLed4wReYUin3rT-H+psmgg=SiiwinNTa-430RD1w@mail.gmail.com>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
	<2241755.f72hngpPkv@avalon>
	<CAMuHMdUnT2zCnj9QBVgxJaHV2fk5iuc7cxq=fh+fVTv3toOVaQ@mail.gmail.com>
	<1492878.6yAAhNSnGb@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1492878.6yAAhNSnGb@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Laurent,

On Thu, Nov 19, 2015 at 10:17 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thursday 19 November 2015 21:39:50 Geert Uytterhoeven wrote:
>> On Thu, Nov 19, 2015 at 9:27 PM, Laurent Pinchart wrote:
>> > On Thursday 19 November 2015 22:19:14 Laurent Pinchart wrote:
>> >> On Thursday 19 November 2015 19:38:40 Geert Uytterhoeven wrote:
>> >> > Amend the DT bindings to include the optional external clock on
>> >> > (H)SCI(F) and some SCIFA, where this pin can serve as a clock input,
>> >> > depending on board wiring.
>> >> >
>> >> > --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>> >> > +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>> >> >
>> >> > @@ -43,6 +43,9 @@ Required properties:
>> >> >    - clocks: Must contain a phandle and clock-specifier pair for each
>> >> >      entry in clock-names.
>> >> >    - clock-names: Must contain "fck" for the SCIx UART functional
>> >> >    clock.
>> >> > +    On (H)SCI(F) and some SCIFA, an additional clock may be specified:
>> >>
>> >> Could you list the SCIFA variants that support external clocks ?
>> >>
>> >> > +      - "hsck" for the optional external clock input (on HSCIF),
>> >> > +      - "sck" for the optional external clock input (on other
>> >> > variants).
>> >
>> > Additionally, those clocks are used as inputs to the baud rate generator
>> > for external clocks, as the ones listed in patch 02/25 in this series.
>> > I'd merge the two patches and clarify the wording.
>>
>> "SCK" predates the BRG, it even exists on SCI in H8/300.
>>
>> That SCK is used as input to the BRG is just an artefact of how the BRG was
>> added to the SCIF. The BRG is just muxed with the existing SCK to form a
>> clock input, which is muxed with the BRR clock through the SCSCR.CKEx bits.
>> And the BRG itself can choose between SCIF_CLK and INT_CLK.
>>
>> Hence that's why I split it in two parts.
>
> It makes sense with the explanation.
>
> I think some of the patches should be clarified to mention BRG-EC (or whatever
> you want to call it) instead of just BRG, as otherwise it's very easy to
> confuse the two BRGs. The (H)SCK clock is an input to the internal BRG, while
> the SCIF_CLK and INT_CLK are inputs to the BRG-EC. Without clarification the
> DT bindings and the code can be hard to understand.

The (H)SCK clock is not an input to the internal BRG: it's used directly as the
sampling clock.

I'll add more clarification...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
