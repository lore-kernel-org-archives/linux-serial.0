From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 01/25] serial: sh-sci: Update DT binding documentation for
 external clock input
Date: Mon, 21 Dec 2015 15:20:34 +0100
Message-ID: <CAMuHMdV30XBQDvbDFnF1f23zrKt8_=5cX9XNJ8WFcKQS9Kkp-w@mail.gmail.com>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
	<1447958344-836-2-git-send-email-geert+renesas@glider.be>
	<1756365.Ijac5ApxcA@avalon>
	<CAMuHMdX4ToefbBLR6o2AMuzCMoKcYo9XRZOzHJzgtQn552vmNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdX4ToefbBLR6o2AMuzCMoKcYo9XRZOzHJzgtQn552vmNg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 19, 2015 at 9:33 PM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> On Thu, Nov 19, 2015 at 9:19 PM, Laurent Pinchart
> <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
>> On Thursday 19 November 2015 19:38:40 Geert Uytterhoeven wrote:
>>> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>>> b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt index
>>> 2c9e6b8477e92792..8efc9b6f35637fbb 100644
>>> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>>> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>>> @@ -43,6 +43,9 @@ Required properties:
>>>    - clocks: Must contain a phandle and clock-specifier pair for each entry
>>>      in clock-names.
>>>    - clock-names: Must contain "fck" for the SCIx UART functional clock.
>>> +    On (H)SCI(F) and some SCIFA, an additional clock may be specified:
>>
>> Could you list the SCIFA variants that support external clocks ?
>
> The list is in the commit description of "[PATCH 19/25] serial: sh-sci: Add
> support for optional external (H)SCK input": sh7723, sh7724, and r8a7740.
>
> Note that the list is probably incomplete, so I don't know if it's that useful
> to have it in the binding docs. Especially as I haven't verified yet that it
> actually works ;-)

For the record: on r8a7740, this feature is not available on SCIFA instances
2-7. The sole pins providing access to SCIFA_SCK[01] are muxed for Ethernet use
on r8a7740/armadillo. So it's unlikely I'll be able to support and test this.

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
