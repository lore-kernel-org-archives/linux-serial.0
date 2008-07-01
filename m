From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: 8250: fix shared interrupts issues with SMP and
 RT kernels
Date: Tue, 1 Jul 2008 14:43:53 +0100
Message-ID: <20080701144353.7285805d@lxorguk.ukuu.org.uk>
References: <20080623232957.GA5111@polina.dev.rtsoft.ru>
	<20080624001221.GA20685@elte.hu>
	<20080701134343.GA1865@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37913 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758744AbYGAOHm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 1 Jul 2008 10:07:42 -0400
In-Reply-To: <20080701134343.GA1865@polina.dev.rtsoft.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Daniel Walker <dwalker@mvista.com>

> > again, please let the -rt maintainers sort out which patches need to be 
> > propagated to upstream maintainers.
> 
> This appears to be not only RT issue though. In theory, this can be

Agreed - RT is showing up a real bug here.

> triggered on SMP also. Thanks to Daniel Walker for pointing this out.

It looks correct to me except that you cannot use spin_lock/disable_irq
in that way safely. You must always disable_irq before taking the lock,
or prove it is safe and use disable_irq_nosync

The reason:
		CPU#0 spin_lock_... [taken]
		CPU#1 IRQ
		CPU#1 spin_lock [waits]
		CPU#0 disable_irq (deadlock)

Note that is also not generally safe to do

		disable IRQ on device
		spin_lock
		disable_irq

because IRQ propogation occurs asynchronously to PCI bus traffic even on
PC class systems (especially Pentium-PII era boxes with SMP). You can
disable the device IRQ and still have an IRQ 'in flight' that arrives
afterwards.

So the fix needs some reworking in its ordering I think

Alan
