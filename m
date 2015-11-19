From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 02/25] serial: sh-sci: Update DT binding documentation for BRG support
Date: Thu, 19 Nov 2015 23:13:37 +0200
Message-ID: <3455553.NW0SflpMPP@avalon>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be> <1577961.dn1fd8r35p@avalon> <CAMuHMdWHbc1kK7MipyZ_M_C6gPyPqvC4H35eZLXQezjbQNK2Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdWHbc1kK7MipyZ_M_C6gPyPqvC4H35eZLXQezjbQNK2Jw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Geert,

On Thursday 19 November 2015 21:44:27 Geert Uytterhoeven wrote:
> On Thu, Nov 19, 2015 at 9:26 PM, Laurent Pinchart wrote:
> > On Thursday 19 November 2015 19:38:41 Geert Uytterhoeven wrote:
> >> Amend the DT bindings to include the optional clock sources for the Baud
> >> Rate Generator for External Clock (BRG), as found on some SCIF variants
> >> and on HSCIF.
> >> 
> >> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> >> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> >> 
> >> @@ -46,6 +46,12 @@ Required properties:
> >>      On (H)SCI(F) and some SCIFA, an additional clock may be specified:
> >>        - "hsck" for the optional external clock input (on HSCIF),
> >>        - "sck" for the optional external clock input (on other variants).
> >> 
> >> +    On UARTs equipped with a Baud Rate Generator for External Clock
> >> (BRG)
> >> +    (some SCIF and HSCIF), additional clocks may be specified:
> >> +      - "int_clk" for the optional internal clock source for the
> >> frequency
> >> +     divider (typically the (AXI or SHwy) bus clock),
> > 
> > Isn't this always the same clock as the SCIF functional clock ?
> 
> (On R-Car Gen2/3)
> 
> No, SCIF uses different parents for fck (p) and int_clk (zs).

Right, my bad.

Should we rename "int_clk" to something that makes it explicit that the clock 
is used as the BRG-EC input ? Maybe brg_clk, int_brg, int_brg_clk ? We 
probably don't need to keep the _clk suffix as it's quite evident that a clock 
name refers to a clock.

> HSCIF uses the same parents though (zs).

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
