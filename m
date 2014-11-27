From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V2 01/10] tty: Fallback to use dynamic major number
Date: Thu, 27 Nov 2014 12:10:46 +0100
Message-ID: <CAMuHMdV7Uo7JBAXDa6z8R+9v7HaDYQ=QpKf8FMBqvmt372oSsA@mail.gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
	<1415825647-6024-2-git-send-email-cernekee@gmail.com>
	<20141125203431.GA9385@kroah.com>
	<CAJiQ=7DOxK2NzmC9gGsnARxGMN8wRQyGX+5u5YC_vt00ADVsDg@mail.gmail.com>
	<20141126133306.659E9C4099B@trevor.secretlab.ca>
	<5475E4EC.7090309@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:46311 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251AbaK0LKs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 27 Nov 2014 06:10:48 -0500
In-Reply-To: <5475E4EC.7090309@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Grant Likely <grant.likely@linaro.org>, Kevin Cernekee <cernekee@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, daniel@zonque.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, tushar.b@samsung.com

On Wed, Nov 26, 2014 at 3:34 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 11/26/2014 08:33 AM, Grant Likely wrote:
>> On Tue, 25 Nov 2014 15:37:16 -0800
>> , Kevin Cernekee <cernekee@gmail.com>
>>  wrote:
>>> On Tue, Nov 25, 2014 at 12:34 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>> On Wed, Nov 12, 2014 at 12:53:58PM -0800, Kevin Cernekee wrote:
>>>>> From: Tushar Behera <tushar.behera@linaro.org>
>>>>
>>>> This email bounces, so I'm going to have to reject this patch.  I can't
>>>> accept a patch from a "fake" person, let alone something that touches
>>>> core code like this.
>>>>
>>>> Sorry, I can't accept anything in this series then.
>>>
>>> Oops, guess I probably should have updated his address after the V1
>>> emails bounced...
>>>
>>> Before I send a new version, what do you think about the overall
>>> approach?  Should we try to make serial8250 coexist with the other
>>> "ttyS / major 4 / minor 64" drivers (possibly at the expense of
>>> compatibility) or is it better to start with a simpler, cleaner driver
>>> like serial/pxa?
>>
>> Co-existing really needs to be fixed.
>
> What are the requirements for co-existence?
> Is it sufficient to provide 1st come-1st served minor allocation?
>
> Anything done should be designed to solve this name problem forever,
> not some expeditious band-aid.

+1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
