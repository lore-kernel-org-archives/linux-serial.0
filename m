From: john stultz <johnstul@us.ibm.com>
Subject: Re: /proc/stat btime accuracy problem
Date: Wed, 01 Jun 2011 17:49:05 -0700
Message-ID: <1306975745.11492.30.camel@work-vm>
References: <BANLkTiniq6GVMJPO_-efKrWHQg9V9Dod9g@mail.gmail.com>
	 <1306967733.11492.11.camel@work-vm>
	 <BANLkTi=yEMDLEo99WZm2Bt4pi_pog5igww@mail.gmail.com>
	 <1306972711.11492.23.camel@work-vm>
	 <BANLkTimuPrqN1euyOqAGm2m4Ea1PdbrzDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:46060 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755135Ab1FBAtN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Jun 2011 20:49:13 -0400
In-Reply-To: <BANLkTimuPrqN1euyOqAGm2m4Ea1PdbrzDQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

On Wed, 2011-06-01 at 18:31 -0600, Bjorn Helgaas wrote:
> On Wed, Jun 1, 2011 at 5:58 PM, john stultz <johnstul@us.ibm.com> wrote:
> > My first instinct is "don't do that!" to whatever driver is disabling
> > irqs for so long. Do you know what's actually causing these long irq off
> > periods?
> >
> > I assume you're noticing this offset by seeing that CLOCK_REALTIME is
> > off from the RTC right after boot? How severe is this? The RTC read is
> > only second granular, so there's a fair amount of error (~1 second)
> > possible right at boot, so this then must be many seconds worth of lost
> > ticks to be noticeable, right?
> 
> I'm using 2.6.34, so not really new.  I think the major offender is
> kernel serial printk, which is done in polled mode.  A *lot* of it,
> e.g., 30+ seconds' worth.

CC'ing the linux-serial list and Alan for their thoughts: Does the
serial port is disabling irqs for 30+ seconds during boot seem at all
sane?

I would think it would periodically enable irqs in the polling loop to
let things be processed, but maybe not?

>   I wonder if there's some reasonably clean
> way to resync with the RTC, say at the time we register a clocksource
> better than jiffies, or in clocksource_done_booting(), or something.

I definitely think we need to address the long irq disable periods
instead of trying to hack around the issue in the timekeeping code.

thanks
-john



