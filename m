From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] tty/serial: at91: BUG: disable interrupts when !UART_ENABLE_MS()
Date: Fri, 5 Sep 2014 14:48:00 +0200
Message-ID: <5409B100.5080709@atmel.com>
References: <1409760567-13186-1-git-send-email-richard.genoud@gmail.com> <54097F2E.6090809@atmel.com> <54099926.6000302@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:11979 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932094AbaIEMsG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Sep 2014 08:48:06 -0400
In-Reply-To: <54099926.6000302@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yegor Yefremov <yegor_sub1@visionsystems.de>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 05/09/2014 13:06, Peter Hurley :
> Hi Nicolas,
> 
> On 09/05/2014 05:15 AM, Nicolas Ferre wrote:
>> On 03/09/2014 18:09, Richard Genoud :
>> Richard,
>>
>> Indeed it seems needed:
>>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>>
>>
>> But BTW, I see just below a call to the atmel_enable_ms() function in
>> atmel_set_ldisc(). My question is, shouldn't we also add this
>> atmel_disable_ms() in the alternative that disables the PPS in this
>> ldisc function?
> 
> I have that change in another series but it has to wait for:

Given the attractive enhancements that you describe below... I'll wait
with pleasure ;-)

> 1. another series that fixes races setting and clearing the controlling tty
>    (and reduces the footprint of tty_mutex)
> 2. a series built on that which moves tty_lock() out from under tty_mutex
>    when reopening ttys
>    This allows the tty_lock to be held while closing the tty.
> 3. a series which removes the ldisc flush from the serial core, among some
>    other locking fixes in the serial core.
>    This fixes a lock inversion between the termios_rwsem and the port mutex.
> 
> All of which enables the set_ldisc() notification to be safely passed
> termios so it can use UART_ENABLE_MS() and also claim the port mutex
> to change the UPF_HARDPPS_CD flag, which is currently non-atomic and
> may corrupt the uart port flags field.
> 
> The series also claims the port lock around the *_enable_ms() in the
> various set_ldisc() handlers to protect the hardware re-programming :)
> 
> Right now, all of this is temporarily stuck on the most recent patch
> series, which hinges on whether the kernel should continue to support
> non-atomic byte stores.

Thanks for sharing your plans. Bye,
-- 
Nicolas Ferre
