From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 01/25] serial: sh-sci: Update DT binding documentation for
 external clock input
Date: Thu, 19 Nov 2015 21:33:01 +0100
Message-ID: <CAMuHMdX4ToefbBLR6o2AMuzCMoKcYo9XRZOzHJzgtQn552vmNg@mail.gmail.com>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
	<1447958344-836-2-git-send-email-geert+renesas@glider.be>
	<1756365.Ijac5ApxcA@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1756365.Ijac5ApxcA@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Laurent,

On Thu, Nov 19, 2015 at 9:19 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thursday 19 November 2015 19:38:40 Geert Uytterhoeven wrote:
>> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>> b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt index
>> 2c9e6b8477e92792..8efc9b6f35637fbb 100644
>> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>> @@ -43,6 +43,9 @@ Required properties:
>>    - clocks: Must contain a phandle and clock-specifier pair for each entry
>>      in clock-names.
>>    - clock-names: Must contain "fck" for the SCIx UART functional clock.
>> +    On (H)SCI(F) and some SCIFA, an additional clock may be specified:
>
> Could you list the SCIFA variants that support external clocks ?

The list is in the commit description of "[PATCH 19/25] serial: sh-sci: Add
support for optional external (H)SCK input": sh7723, sh7724, and r8a7740.

Note that the list is probably incomplete, so I don't know if it's that useful
to have it in the binding docs. Especially as I haven't verified yet that it
actually works ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
