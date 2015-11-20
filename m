From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 17/25] serial: sh-sci: Correct SCIF type on R-Car for BRG
Date: Fri, 20 Nov 2015 16:30:22 +0100
Message-ID: <CAMuHMdWxEXnHGy6vkds8KKcPz4CFWHn8uK90aBQCw4B0ibQFJw@mail.gmail.com>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
	<1764695.P2DCFfYC1V@avalon>
	<CAMuHMdU+phbWh_8hgZs7HitHPakLE2Lc_Q9oUPOe-xCvj4uOzA@mail.gmail.com>
	<2770504.I7SM1dx10G@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <2770504.I7SM1dx10G@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Laurent,

On Fri, Nov 20, 2015 at 3:52 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Friday 20 November 2015 08:46:56 Geert Uytterhoeven wrote:
>> On Thu, Nov 19, 2015 at 9:55 PM, Laurent Pinchart wrote:
>> > On Thursday 19 November 2015 19:38:56 Geert Uytterhoeven wrote:
>> >> The "renesas,scif" compatible value is currently used for the SCIF
>> >> variant in all Renesas SoCs of the R-Car family.  However, the variant
>> >> used in the R-Car family is not the common "SH-4(A)" variant, but a
>> >> derivative with added "Baud Rate Generator for External Clock" (BRG),
>> >> which is also present in sh7734.
>> >
>> > Time to introduce a "renesas,scif-rcar" compatible string ? ;-)
>> >
>> > As the only DT-enabled platform to have a different SCIF type is r7s72100
>> > we could also consider just switching the regtype to
>> > SCIx_SH4_SCIF_BRG_REGTYPE for the generic "renesas,scif" entry as it's
>> > listed after the "renesas,scif- r7s72100" entry. That might cause an
>> > issue if we want to enable DT on arch/sh though, but even if that happens
>> > due to the J-Core processors I'd be surprised to see the old Renesas SH
>> > platforms being moved to DT.
>>
>> I thought about that, but you never know in which out-of-tree BSP it ended
>> up being used, too. So better safe than sorry.
>
> Out-of-tree should be banned :-)
>
> More seriously, I suppose you wouldn't be thrilled by the idea of a
> "renesas,scif-rcar-gen2" ?

Nope. Note that it's also used in R-Car Gen 1 and Gen 3, and sh7734.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
