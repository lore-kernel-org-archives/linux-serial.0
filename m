From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/5] serial: sa1100: delete .set_wake callback
Date: Thu, 17 Oct 2013 10:43:45 +0200
Message-ID: <CACRpkdY0vSse3s8-writAvW+h6Arz2NdSTixbhTw5VOyOHg9MQ@mail.gmail.com>
References: <1381821626-19441-1-git-send-email-linus.walleij@linaro.org>
	<20131015140733.GC25034@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:47447 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567Ab3JQInq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Oct 2013 04:43:46 -0400
Received: by mail-wg0-f52.google.com with SMTP id f12so1908544wgh.31
        for <linux-serial@vger.kernel.org>; Thu, 17 Oct 2013 01:43:45 -0700 (PDT)
In-Reply-To: <20131015140733.GC25034@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tue, Oct 15, 2013 at 4:07 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Oct 15, 2013 at 09:20:26AM +0200, Linus Walleij wrote:
>> This callback is unused by the serial core since pre-git days
>> and is not coming back. Delete it. Enabling wakeup on the
>> SA1100 platforms should be done in the suspend() callback
>> so the platform hook is left in the serial port struct for
>> later enablement.
>>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> This is only used by the old iPAQ stuff for serial 3.  If we push gpio
> layer support into the serial driver for CTS/DCD signalling, then we can
> kill this set_wake off entirely.

This seems like a good idea and I really like the patch.

> Through looking at this, there's a side effect of your removal of the
> gpio stuff in mach/gpio.h for SA11x0 - these platforms will now spit
> warnings about GPIOs being used without first being registered.  I
> think I need to drop your patch, and then we need to sort that out
> first.

Oh, I didn't see any of this when I tested it in the h3600 so I guess
it must be GPIOs that aren't used on that machine. Can you give
me a copy of these messages so I know where to go in and fix?

The occasional warning is harmless as the GPIO framework will
still allow usage without requesting first, but if it's kilobytes of
warnings it will be harmful due to sheer log spamming.

> How about something like this?  If we push the other platforms to put
> their mctrl stuff under gpiolib, then there is a candidate here for
> further cleanup.  Only tested on the Assabet.

I tested this on the H3600 console and atleast there are no
regressions. However I'm uncertain if these signals get properly
handled on this setup - I enable HW flow control and the console
still works fine, but it works fine also if I comment out the GPIO
lines so apparently the RTS/CTS isn't propagated. (And I know
way to little about HW flow control to do a proper test.)

But I can't see any problem with the code so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
