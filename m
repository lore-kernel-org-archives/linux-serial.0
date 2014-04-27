From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 0/5] tty/serial: Add helpers to use GPIOs to control modem
 lines and implement atmel_serial.c
Date: Sun, 27 Apr 2014 06:59:15 -0700
Message-ID: <535D0D33.4050401@atmel.com>
References: <1398437561-4289-1-git-send-email-richard.genoud@gmail.com> <20140425155847.GC22879@kroah.com> <CACQ1gAiyonHpg5YP4nSd3B=iiVQoTKQvYoC_JxbzA6Dmzr8+tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:36487 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbaD0N7X (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 27 Apr 2014 09:59:23 -0400
In-Reply-To: <CACQ1gAiyonHpg5YP4nSd3B=iiVQoTKQvYoC_JxbzA6Dmzr8+tw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 27/04/2014 02:58, Richard Genoud :
> 2014-04-25 17:58 GMT+02:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
>> On Fri, Apr 25, 2014 at 04:52:36PM +0200, Richard Genoud wrote:
>>> This patch series is a leftover of http://www.spinics.net/lists/arm-kernel/msg314242.html
>>> that missed 3.15 because it caused merge conflicts.
>>>
>>> The 1st patch may be applied as a fix for 3.15-rc, since it correct a
>>> device tree binding documentation example.
>>>
>>> Greg, for you to decide if it's worth it or not !
>>
>> Why am I the one tho decides if it is worth it?  If it's up to me, I'll
>> just say "no", as I sure don't need this for any of my machines...

Ok, so I need to speak up and say that the patch series is useful for me :-)

> Ok, let me reformulate :) :
> 
> This patch series is a leftover of
> http://www.spinics.net/lists/arm-kernel/msg314242.html
> that missed 3.15 because it caused merge conflicts (you acked the
> series and ask me to resend it during 3.15-rc cycle).
> 
> I think that "[PATCH 1/5] tty/serial: atmel_serial: Fix device tree
> documentation" should be applied on 3.15-rc,
> since it corrects a device tree binding documentation example.
> 
> The patches 2-5/5 are for 3.16.

BTW, patches 4 and 5 were "Acked" by me in v6 revision of this series.

Thanks, bye,
-- 
Nicolas Ferre
