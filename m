From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 02/25] serial: sh-sci: Update DT binding documentation for
 BRG support
Date: Thu, 19 Nov 2015 21:44:27 +0100
Message-ID: <CAMuHMdWHbc1kK7MipyZ_M_C6gPyPqvC4H35eZLXQezjbQNK2Jw@mail.gmail.com>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
	<1447958344-836-3-git-send-email-geert+renesas@glider.be>
	<1577961.dn1fd8r35p@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1577961.dn1fd8r35p@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Laurent,

On Thu, Nov 19, 2015 at 9:26 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thursday 19 November 2015 19:38:41 Geert Uytterhoeven wrote:
>> Amend the DT bindings to include the optional clock sources for the Baud
>> Rate Generator for External Clock (BRG), as found on some SCIF variants
>> and on HSCIF.

>> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>> @@ -46,6 +46,12 @@ Required properties:
>>      On (H)SCI(F) and some SCIFA, an additional clock may be specified:
>>        - "hsck" for the optional external clock input (on HSCIF),
>>        - "sck" for the optional external clock input (on other variants).
>> +    On UARTs equipped with a Baud Rate Generator for External Clock (BRG)
>> +    (some SCIF and HSCIF), additional clocks may be specified:
>> +      - "int_clk" for the optional internal clock source for the frequency
>> +     divider (typically the (AXI or SHwy) bus clock),
>
> Isn't this always the same clock as the SCIF functional clock ?

(On R-Car Gen2/3)

No, SCIF uses different parents for fck (p) and int_clk (zs).
HSCIF uses the same parents though (zs).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
