From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/5] ARM: at91: fix irq_pm_install_action WARNING
Date: Tue, 16 Dec 2014 21:37:22 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1412162125000.17382@nanos>
References: <1418660152-17185-1-git-send-email-boris.brezillon@free-electrons.com> <2662748.NJbkr6jW7r@vostro.rjw.lan> <3542278.8lcJeXLMFm@vostro.rjw.lan> <20141216100715.57baeb65@bbrezillon> <alpine.DEB.2.11.1412161013570.17382@nanos>
 <20141216192609.778f5f8d@bbrezillon>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141216192609.778f5f8d@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Mike Turquette <mturquette@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 16 Dec 2014, Boris Brezillon wrote:
> On Tue, 16 Dec 2014 11:03:55 +0100 (CET)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> > That avoids the whole flag, action, whatever business for the price of
> > a really trivial demux mechanism. Everything just works. Even the irq
> > storm detector will just disable the parent interrupt once all
> > handlers return NONE often enough.
> 
> Still have one question regarding the spurious interrupt detection code.
> AFAIU, it disables a specific IRQ handler if it triggers to often with
> an IRQ_NONE return, right ?
> 
> In this dumb demuxer I can't tell which child interrupt should be
> handled (there is no interrupt cause register), thus I call
> generic_handle_irq on all unmasked IRQs.
> Isn't there a risk to get some of my child interrupts disabled because
> they always return IRQ_NONE (which is a normal use case for
> IRQF_SHARED: we're only expecting at least one handler to return
> IRQ_HANDLED or IRQ_WAKE_THREAD, not all of them) ?

Good point. I missed that aspect.

Another good reason to make that core infrastructure.

So what you need is the following:

void dumb_demux_handler(....)
{
	irq_return ret = IRQ_NONE:
	int i;

	for_each_demux_irq(i)
		ret |= handle_dumb_demux_irq(base + i);

	note_interrupt(demuxirq, ret);
}   

So that disables the demux irq if all sub handlers return NONE 100k
times in a row. Otherwise if one of them handles it, you're fine.

That more or less resembles the shared action magic.

So yes, that wants to be core functionality which can be instantiated
from an affected irq chip for this particular case of HW insanity.

Thanks,

	tglx
