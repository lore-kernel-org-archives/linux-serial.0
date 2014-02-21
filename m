From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH tty-next v2 4/4] Documentation: devicetree: add bindings documentation for bcm63xx-uart
Date: Fri, 21 Feb 2014 16:23:46 +0100
Message-ID: <30959154.CHzZGsTM1h@wuerfel>
References: <1392920154-3642-1-git-send-email-f.fainelli@gmail.com> <3851734.OkR5IG0DHF@wuerfel> <CAOiHx==mQ5Dg4P1AYSLg1G1vHiXAcThSb+n+8L9OAoU-fPgt6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:50132 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932150AbaBUPYF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Feb 2014 10:24:05 -0500
In-Reply-To: <CAOiHx==mQ5Dg4P1AYSLg1G1vHiXAcThSb+n+8L9OAoU-fPgt6w@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jonas Gorski <jogo@openwrt.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "mbizon@freebox.fr" <mbizon@freebox.fr>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "gregory.0xf0@gmail.com" <gregory.0xf0@gmail.com>

On Friday 21 February 2014 16:18:54 Jonas Gorski wrote:
> On Fri, Feb 21, 2014 at 3:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 21 February 2014 15:48:04 Jonas Gorski wrote:
> >>
> >> There already is a (non-OF) user for this driver that exports a
> >> "periph" clock, which is where the name comes from. It currently does
> >> all clock lookups purely based on the clock name, not the device name
> >> itself. Of course we can just make it get a different named clock when
> >> of_node is present; that should satisfy both.
> >
> > I think you are referring to arch/mips/bcm63xx/clk.c, but that doesn't
> > actually use clkdev at all and instead expects device drivers to know
> > the name of *output* of the clock controllers. You can't use that
> > name in the binding for a device, which needs to know the name of
> > the *input* from the clock consumer point of view.
> 
> That's why I was suggesting making the driver do a lookup on the input
> name in case of probing through OF (having an of_node), and using
> the "legacy" output name else. That way the binding is not limited to
> the output name of bcm63xx/mips anymore.

Ok, fair enough.

> > An easy solution would be to register a clkdev lookup table in
> > the above clock driver.
> 
> Requiring bcm63xx/mips to implement clkdev would be IMHO an
> unnecessary burden just so bcm63xx/arm using OF can reuse this driver.
> Letting bcm63xx use a clkdev lookup table (or rather tables, as each
> chip is different) is good mid or long term goal, but it should not
> block other users.

Ah, that's probably right. I was assuming you'd only need to
add a single function call to register a table, but I see now
that using clkdev would impact the entire clk implementation
on bcm63xx.

	Arnd
