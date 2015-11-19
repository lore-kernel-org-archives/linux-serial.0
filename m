From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 01/25] serial: sh-sci: Update DT binding documentation for
 external clock input
Date: Thu, 19 Nov 2015 21:39:50 +0100
Message-ID: <CAMuHMdUnT2zCnj9QBVgxJaHV2fk5iuc7cxq=fh+fVTv3toOVaQ@mail.gmail.com>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
	<1447958344-836-2-git-send-email-geert+renesas@glider.be>
	<1756365.Ijac5ApxcA@avalon>
	<2241755.f72hngpPkv@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2241755.f72hngpPkv@avalon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 19, 2015 at 9:27 PM, Laurent Pinchart
<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
> On Thursday 19 November 2015 22:19:14 Laurent Pinchart wrote:
>> On Thursday 19 November 2015 19:38:40 Geert Uytterhoeven wrote:
>> > Amend the DT bindings to include the optional external clock on
>> > (H)SCI(F) and some SCIFA, where this pin can serve as a clock input,
>> > depending on board wiring.

>> > --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>> > +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>> >
>> > @@ -43,6 +43,9 @@ Required properties:
>> >    - clocks: Must contain a phandle and clock-specifier pair for each
>> >    entry
>> >
>> >      in clock-names.
>> >
>> >    - clock-names: Must contain "fck" for the SCIx UART functional clock.
>> >
>> > +    On (H)SCI(F) and some SCIFA, an additional clock may be specified:
>> Could you list the SCIFA variants that support external clocks ?
>>
>> > +      - "hsck" for the optional external clock input (on HSCIF),
>> > +      - "sck" for the optional external clock input (on other variants).
>
> Additionally, those clocks are used as inputs to the baud rate generator for
> external clocks, as the ones listed in patch 02/25 in this series. I'd merge
> the two patches and clarify the wording.

"SCK" predates the BRG, it even exists on SCI in H8/300.

That SCK is used as input to the BRG is just an artefact of how the BRG was
added to the SCIF. The BRG is just muxed with the existing SCK to form a clock
input, which is muxed with the BRR clock through the SCSCR.CKEx bits.
And the BRG itself can choose between SCIF_CLK and INT_CLK.

Hence that's why I split it in two parts.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
