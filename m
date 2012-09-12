From: Alan Cox <alan@linux.intel.com>
Subject: Re: [RFC] tty/serial/kgdboc: Add and wire up clear_irqs callback
Date: Wed, 12 Sep 2012 10:44:20 +0100
Message-ID: <20120912104420.06a88957@bob.linux.org.uk>
References: <20120911093042.GA12471@lizard>
	<1347356106-25368-6-git-send-email-anton.vorontsov@linaro.org>
	<20120911151540.362001c6@pyramind.ukuu.org.uk>
	<20120912033209.GA32156@lizard>
	<CAMbhsRTmZyxFE-vAa-UvNE8KJ2f0cfXP7mncXKcpUiNF6C9PUQ@mail.gmail.com>
	<20120912040657.GA3880@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45212 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752014Ab2ILJ03 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Sep 2012 05:26:29 -0400
In-Reply-To: <20120912040657.GA3880@lizard>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Cc: Colin Cross <ccross@android.com>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Jason Wessel <jason.wessel@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arve =?ISO-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Brian Swetland <swetland@google.com>, John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, kernel-team@android.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org

> Of course, if Alan is OK with this, I'm more than OK too. :-)

It may well be better.

> (But the polling routines would need to clear all interrupts, not
> just rx/tx. For example, if the controller indicated some error, and
> nobody clears it, then we'll start reentering infinitely.)

For a lot of devices and platforms you'd probably mask them instead ?

> 
> > If you use a clear_irqs callback, you can drop characters if
> > one arrives between the last character buffer read and calling
> > clear_irqs.
> 
> Only if we call clear_irqs() after reading the characters, but we do
> it before. So if new characters are available, we will reenter NMI,
> which is OK.

Recursively or not... again you get platform specific magic in places
we don't want.

In the driver poll method for most uarts is going to be at least buried
in what is usually arch specific uarts.

