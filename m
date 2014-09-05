From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] tty/serial: at91: BUG: disable interrupts when !UART_ENABLE_MS()
Date: Fri, 05 Sep 2014 07:06:14 -0400
Message-ID: <54099926.6000302@hurleysoftware.com>
References: <1409760567-13186-1-git-send-email-richard.genoud@gmail.com> <54097F2E.6090809@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:41680 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756464AbaIELGW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Sep 2014 07:06:22 -0400
In-Reply-To: <54097F2E.6090809@atmel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yegor Yefremov <yegor_sub1@visionsystems.de>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Nicolas,

On 09/05/2014 05:15 AM, Nicolas Ferre wrote:
> On 03/09/2014 18:09, Richard Genoud :
> Richard,
> 
> Indeed it seems needed:
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> 
> But BTW, I see just below a call to the atmel_enable_ms() function in
> atmel_set_ldisc(). My question is, shouldn't we also add this
> atmel_disable_ms() in the alternative that disables the PPS in this
> ldisc function?

I have that change in another series but it has to wait for:

1. another series that fixes races setting and clearing the controlling tty
   (and reduces the footprint of tty_mutex)
2. a series built on that which moves tty_lock() out from under tty_mutex
   when reopening ttys
   This allows the tty_lock to be held while closing the tty.
3. a series which removes the ldisc flush from the serial core, among some
   other locking fixes in the serial core.
   This fixes a lock inversion between the termios_rwsem and the port mutex.

All of which enables the set_ldisc() notification to be safely passed
termios so it can use UART_ENABLE_MS() and also claim the port mutex
to change the UPF_HARDPPS_CD flag, which is currently non-atomic and
may corrupt the uart port flags field.

The series also claims the port lock around the *_enable_ms() in the
various set_ldisc() handlers to protect the hardware re-programming :)

Right now, all of this is temporarily stuck on the most recent patch
series, which hinges on whether the kernel should continue to support
non-atomic byte stores.

Regards,
Peter Hurley

