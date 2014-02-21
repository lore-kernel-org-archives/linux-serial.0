From: Jonas Gorski <jogo@openwrt.org>
Subject: Re: [PATCH tty-next v2 4/4] Documentation: devicetree: add bindings
 documentation for bcm63xx-uart
Date: Fri, 21 Feb 2014 15:48:04 +0100
Message-ID: <CAOiHx==LEMeLVxLv2r+btWQNcPitndpVTsjbu0Ji4_tzmap51A@mail.gmail.com>
References: <1392920154-3642-1-git-send-email-f.fainelli@gmail.com>
 <1392920154-3642-5-git-send-email-f.fainelli@gmail.com> <3250738.VGSO94B75K@wuerfel>
 <20140221134946.GA20449@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 0.mx.nanl.de ([217.115.11.12]:42044 "EHLO mail.nanl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755839AbaBUOse (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Feb 2014 09:48:34 -0500
In-Reply-To: <20140221134946.GA20449@e106331-lin.cambridge.arm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Florian Fainelli <f.fainelli@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "mbizon@freebox.fr" <mbizon@freebox.fr>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "gregory.0xf0@gmail.com" <gregory.0xf0@gmail.com>

On Fri, Feb 21, 2014 at 2:49 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Feb 21, 2014 at 12:49:05PM +0000, Arnd Bergmann wrote:
>> Two more comments:
>>
>> On Thursday 20 February 2014 10:15:54 Florian Fainelli wrote:
>> > +- clock-names: should contain "periph" for the functional clock
>>
>> I think we should really start standardizing on the clock names more.
>> We don't have any uart that calls its functional clock "periph" so
>> far.
>>
>> How about naming it "fclk" or "uart"?
>>
>> I'd actually prefer making it an anonymous clock, but I know that
>> will just trigger comments about what might happen if it turns
>> out we need more than one clock for a future version of this device.
>
> Yup ;)
>
> I'm happy as long as we have a well-defined name for each clock input,
> regardless of what those particular names might be.

There already is a (non-OF) user for this driver that exports a
"periph" clock, which is where the name comes from. It currently does
all clock lookups purely based on the clock name, not the device name
itself. Of course we can just make it get a different named clock when
of_node is present; that should satisfy both.

Technically on BCM6345 there are actually two clocks (more or less),
the "periph" for the reference clock rate, and a clock bit in the
clock controller register for the uart block. All later chips do not
expose a uart clock bit anymore, and the bootloader is expected to
enable it on systems with the clock, so we can probably pretend that
it does not exist. Also it's quite unlikely that BCM6345 will ever
receive proper OF support, and if it does, we can add the second
optional clock then if we find devices that need it.



Regards
Jonas
