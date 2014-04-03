From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v6 1/3] tty/serial: Add GPIOLIB helpers for controlling
 modem lines
Date: Thu, 3 Apr 2014 11:35:01 +0200
Message-ID: <CACQ1gAipPmbnHSZScFxdt=GisBaVV_hmGNcec-ZyyypmM3O4+Q@mail.gmail.com>
References: <1394469951-21192-1-git-send-email-richard.genoud@gmail.com>
 <1394469951-21192-2-git-send-email-richard.genoud@gmail.com>
 <20140317232359.GA8943@kroah.com> <533C280F.3060804@gmail.com> <20140402231315.GD24324@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:65503 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbaDCJfX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 Apr 2014 05:35:23 -0400
Received: by mail-la0-f54.google.com with SMTP id mc6so1101530lab.41
        for <linux-serial@vger.kernel.org>; Thu, 03 Apr 2014 02:35:21 -0700 (PDT)
In-Reply-To: <20140402231315.GD24324@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Richard Genoud <noreply.rgenoud@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

2014-04-03 1:13 GMT+02:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Wed, Apr 02, 2014 at 05:09:03PM +0200, Richard Genoud wrote:
>> On 18/03/2014 00:23, Greg Kroah-Hartman wrote:
>> > On Mon, Mar 10, 2014 at 05:45:49PM +0100, Richard Genoud wrote:
>> >> This patch add some helpers to control modem lines (CTS/RTS/DSR...) via
>> >> GPIO.
>> >> This will be useful for many boards which have a serial controller that
>> >> only handle CTS/RTS pins (or even just RX/TX).
>> >>
>> >> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>> >
>> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> >
>> > I can't take this series through my tty tree as the non-tty patches
>> > don't apply, so feel free to take them through whatever tree is needed.
>> >
>> > greg k-h
>> >
>>
>> I guess this series won't make it for 3.15, as it doesn't apply on any tree.
>> However, I'd like to know if I did something wrong, or if there's no
>> solution when a series depends on several patches that are in different
>> trees ?
>
> That's a hard problem, either wait a release cycle for everything to get
> merged properly (like should be done in time for 3.15-rc1 now) and then
> submit the code, or ask for different maintainers to either allow other
> trees to take the patches, put the patches in different trees at the
> same time, or have "topic branches" that different maintainers can pull
> from.
>
> Care to send me the patches after 3.15-rc1 is out, as there should not
> be any dependancy issues then, right?
>
> greg k-h

Ok, I'll do that.
Thanks for the explanation !

I will just send a little patch for 3.15rc1 or rc2 to prevent a DTS
ABI change in 3.16.
Something like this in Documentation/devicetree/bindings/serial/atmel-usart.txt
-rts-gpios = <&pioD 15 0>;
+rts-gpios = <&pioD 15 GPIO_ACTIVE_LOW>;
I guess it could go in AT91 tree
I'll send it soon.

Thanks !


Richard.
