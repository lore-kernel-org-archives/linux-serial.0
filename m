From: Colin Cross <ccross@android.com>
Subject: Re: [RFC] tty/serial/kgdboc: Add and wire up clear_irqs callback
Date: Tue, 11 Sep 2012 21:40:35 -0700
Message-ID: <CAMbhsRT+JR9-qzADiPXo9e59oHFCY4g6HNObKNMeciC5Xj6m6g@mail.gmail.com>
References: <20120911093042.GA12471@lizard>
	<1347356106-25368-6-git-send-email-anton.vorontsov@linaro.org>
	<20120911151540.362001c6@pyramind.ukuu.org.uk>
	<20120912033209.GA32156@lizard>
	<CAMbhsRTmZyxFE-vAa-UvNE8KJ2f0cfXP7mncXKcpUiNF6C9PUQ@mail.gmail.com>
	<20120912040657.GA3880@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43630 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab2ILEkg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Sep 2012 00:40:36 -0400
Received: by ieje11 with SMTP id e11so2222091iej.19
        for <linux-serial@vger.kernel.org>; Tue, 11 Sep 2012 21:40:35 -0700 (PDT)
In-Reply-To: <20120912040657.GA3880@lizard>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Jason Wessel <jason.wessel@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Brian Swetland <swetland@google.com>, John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, kernel-team@android.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org

On Tue, Sep 11, 2012 at 9:06 PM, Anton Vorontsov
<anton.vorontsov@linaro.org> wrote:
> On Tue, Sep 11, 2012 at 08:42:46PM -0700, Colin Cross wrote:
> [...]
>> > The "problem" is in the last step. If we exit NMI without making UART
>> > know that we're done with the interrupt, we will reenter the NMI
>> > immediately, even without any new characters from the UART.
>>
>> The UART irq line should go low when you read the character out of the
>
> Probably some controllers may lower the line by themselves, but not
> all, and probably most of them need an explicit clear.

Anything 8250-based will clear the interrupt automatically, assuming
you read the status registers as well as the character register.

>> receive buffer, or the polling rx function should clear the interrupt
>> for you.
>
> Yes, that's an option. But that way we add a new semantic for the
> polling routines, and effecitvely we just merge the two callbacks.
>
> Of course, if Alan is OK with this, I'm more than OK too. :-)
>
> (But the polling routines would need to clear all interrupts, not
> just rx/tx. For example, if the controller indicated some error, and
> nobody clears it, then we'll start reentering infinitely.)

For exynos5, the only non-8250 based serial port I've come across, we
clear all interrupts in the rx poll function (see
https://android.googlesource.com/kernel/exynos/+/ef427aafffb7153dde59745e440fd7ec41ea969d/arch/arm/mach-exynos/exynos_fiq_debugger.c).

>> If you use a clear_irqs callback, you can drop characters if
>> one arrives between the last character buffer read and calling
>> clear_irqs.
>
> Only if we call clear_irqs() after reading the characters, but we do
> it before. So if new characters are available, we will reenter NMI,
> which is OK.
>
> But if used incorrectly, it truly can cause dropping (or staling) of
> characters, so I'd better add some comments about this.

What does clear_irqs() mean for a status or tx interrupt?  The tx
interrupt will generally re-assert as long as the tx fifo is empty,
which would require disabling it.  On 8250 ports, status interrupts
will re-assert until the corresponding status register is read.
