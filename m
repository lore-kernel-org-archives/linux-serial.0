Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3715198A35;
	Tue, 19 Nov 2024 10:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732010785; cv=none; b=opbGu9g2VQ0FTa2Ab5SMpXBZ0FQUBSpeWiQhi453zS35LRPpztcjxLbY+1J9QolJ3YPdEtjgEGNvX3kd4xVcyLWs3+C4RwsQeXaPgJqSe8sQN7uV0ZmXafTjKr8yxgBhMtNbDdk+IZ/AGFhBBZKtZq2y++TlZfp4XjCYonSGs8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732010785; c=relaxed/simple;
	bh=s+9IZ73WdtGiD89wfdkaPi2mIRbD7b7eW8GDnWa7idg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzKkCHnzMfNT5APBKOGsk/tvjn55zVk9iV3cayhayn13C9M6qS9RoPg6cYXQyMkFvKUzIxSlexdORoCnMZMS5VY6e8yfUXV2bGiCn94hEvhcFQMrGPhuShfhfWVvTBKPH2B5YyEMuDIazqL8vXKDupY0q4JK8XrCTJr+oZYL9RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GkYTSP27; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GkYTSP27"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732010784; x=1763546784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s+9IZ73WdtGiD89wfdkaPi2mIRbD7b7eW8GDnWa7idg=;
  b=GkYTSP27KAZvXTFLx8M8YVB18uZ3vVQ8Ut42Omz5CrhScJwc2LEJPcL1
   WRLgxgxs3sfG32C8+6T1jgtne384kVtmcwos6bsuUshG6mj6Pmj77KYjX
   d9WItC4YuHDGiykg+qGolkiNkIRUYOQS+P8C0qt2qoo3FAlQjkABSR2H8
   B7UalNY7ecNGXp821LMCDwXiBBw5OAL5kHuxy2kMJVCghP/4TpiGyu6d6
   ONkTeBMJgmEwR9RZ8Oi4T/9HAZitFavpLeOwZHUNpXG9nUJOvbK4JsDFL
   Z5/X3abhIHnxu5Yp3+czlaSj4NnTsduXarVkekv+blI2Rhl4U3oSOew1K
   A==;
X-CSE-ConnectionGUID: /NjS2ONCRGu0a3frUd/8ew==
X-CSE-MsgGUID: 2o9q6uWhS3asLAsC79XbNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="49537605"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="49537605"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 02:06:23 -0800
X-CSE-ConnectionGUID: 3uGJLfY9QDmdnwqc1f/PcA==
X-CSE-MsgGUID: quOKzzZBTZqKJSx94uAJIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="90312445"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 02:06:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tDL7g-0000000GJTH-2BFU;
	Tue, 19 Nov 2024 12:06:16 +0200
Date: Tue, 19 Nov 2024 12:06:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Tony Lindgren <tony@atomide.com>,
	John Ogness <john.ogness@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] irq: Introduce IRQ_HANDLED_MANY
Message-ID: <ZzxjGEBXNMICJU3w@smile.fi.intel.com>
References: <20240216075948.131372-2-leobras@redhat.com>
 <20240216075948.131372-5-leobras@redhat.com>
 <87zfvwai62.ffs@tglx>
 <87v86kaf84.ffs@tglx>
 <ZdWMja3BfCZsbF_q@LeoBras>
 <87edd5hljz.ffs@tglx>
 <ZdghE6TNHgZ_bi19@LeoBras>
 <ZzVxIfb5KpL97P4Q@LeoBras>
 <ZzWrzC1QhhlNqLpl@smile.fi.intel.com>
 <ZzvmvBdqJpAyUicm@LeoBras>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzvmvBdqJpAyUicm@LeoBras>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 18, 2024 at 10:15:40PM -0300, Leonardo Bras wrote:
> On Thu, Nov 14, 2024 at 09:50:36AM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 14, 2024 at 12:40:17AM -0300, Leonardo Bras wrote:
> > > On Fri, Feb 23, 2024 at 01:37:39AM -0300, Leonardo Bras wrote:
> > > > On Wed, Feb 21, 2024 at 04:41:20PM +0100, Thomas Gleixner wrote:
> > > > > On Wed, Feb 21 2024 at 02:39, Leonardo Bras wrote:
> > > > > > On Mon, Feb 19, 2024 at 12:03:07PM +0100, Thomas Gleixner wrote:
> > > > > >> >> Is scenarios where there is no need to keep track of IRQ handled, convert
> > > > > >> >> it back to IRQ_HANDLED.
> > > > > >> >
> > > > > >> > That's not really workable as you'd have to update tons of drivers just
> > > > > >> > to deal with that corner case. That's error prone and just extra
> > > > > >> > complexity all over the place.
> > > > > >
> > > > > > I agree, that's a downside of this implementation. 
> > > > > 
> > > > > A serious one which is not really workable. See below.
> > > > > 
> > > > > > I agree the above may be able to solve the issue, but it would make 2 extra 
> > > > > > atomic ops necessary in the thread handling the IRQ, as well as one extra 
> > > > > > atomic operation in note_interrupt(), which could increase latency on this 
> > > > > > IRQ deferring the handler to a thread.
> > > > > >
> > > > > > I mean, yes, the cpu running note_interrupt() would probably already have 
> > > > > > exclusiveness for this cacheline, but it further increases cacheline 
> > > > > > bouncing and also adds the mem barriers that incur on atomic operations, 
> > > > > > even if we use an extra bit from threads_handled instead of allocate a new 
> > > > > > field for threads_running.
> > > > > 
> > > > > I think that's a strawman. Atomic operations can of course be more
> > > > > expensive than non-atomic ones, but they only start to make a difference
> > > > > when the cache line is contended. That's not the case here for the
> > > > > normal operations.
> > > > > 
> > > > > Interrupts and their threads are strictly targeted to a single CPU and
> > > > > the cache line is already hot and had to be made exclusive because of
> > > > > other write operations to it.
> > > > > 
> > > > > There is usually no concurrency at all, except for administrative
> > > > > operations like enable/disable or affinity changes. Those administrative
> > > > > operations are not high frequency and the resulting cache line bouncing
> > > > > is unavoidable even without that change. But does it matter in the
> > > > > larger picture? I don't think so.
> > > > 
> > > > That's a fair point, but there are some use cases that use CPU Isolation on 
> > > > top of PREEMPT_RT in order to reduce interference on a CPU running an RT 
> > > > workload.
> > > > 
> > > > For those cases, IIRC the handler will run on a different (housekeeping) 
> > > > CPU when those IRQs originate on an Isolated CPU, meaning the above 
> > > > described cacheline bouncing is expected.
> > > > 
> > > > 
> > > > > 
> > > > > > On top of that, let's think on a scenario where the threaded handler will 
> > > > > > solve a lot of requests, but not necessarily spend a lot of time doing so.
> > > > > > This allows the thread to run for little time while solving a lot of 
> > > > > > requests.
> > > > > >
> > > > > > In this scenario, note_interrupt() could return without incrementing 
> > > > > > irqs_unhandled for those IRQ that happen while the brief thread is running, 
> > > > > > but every other IRQ would cause note_interrupt() to increase 
> > > > > > irqs_unhandled, which would cause the bug to still reproduce.
> > > > > 
> > > > > In theory yes. Does it happen in practice?
> > > > > 
> > > > > But that exposes a flaw in the actual detection code. The code is
> > > > > unconditionally accumulating if there is an unhandled interrupt within
> > > > > 100ms after the last unhandled one. IOW, if there is a periodic
> > > > > unhandled one every 50ms, the interrupt will be shut down after 100000 *
> > > > > 50ms = 5000s ~= 83.3m ~= 1.4h. And it neither cares about the number of
> > > > > actually handled interrupts.
> > > > > 
> > > > > The spurious detector is really about runaway interrupts which hog a CPU
> > > > > completely, but the above is not what we want to protect against.
> > > > 
> > > > Now it makes a lot more sense to me.
> > > > Thanks!
> > > 
> > > I would like to go back to this discussion :)
> > > From what I could understand, and read back the thread:
> > > 
> > > - The spurious detector is used to avoid cpu hog when a lots of IRQs are 
> > >   hitting a cpu, but few ( < 100 / 100k) are being handled. It works by
> > >   disabling that interruption.
> > > 
> > > - The bug I am dealing with (on serial8250), happens to fit exactly at
> > >   above case: lots of requests, but few are handled.
> > >   The reason: threaded handler, many requests, and they are dealt with in 
> > >   batch: multiple requests are handled at once, but a single IRQ_HANDLED 
> > >   returned.
> > > 
> > > - My proposed solution: Find a way of accounting the requests handled.
> > > 
> > >   - Implementation: add an option for drivers voluntarily report how 
> > >     many requests they handled. Current drivers need no change.
> > 
> > >   - Limitation: If this issue is found on another driver, we need to 
> > >     implement accounting there as well. This may only happen on drivers
> > >     which handle over 1k requests at once.
> > 
> > > What was left for me TODO:
> > > Think on a generic solution for this issue, to avoid dealing with that 
> > > in a per-driver basis. 
> > > 
> > > That's what I was able to think about:
> > 
> > > - Only the driver code knows how many requests it handled, so without  
> > >   touching them we can't know how many requests were properly handled.
> 
> Hello Andy, thanks for reviewing!
> 
> > Hmm... But do I understand correctly the following:
> > 
> > - the IRQ core knows the amount of generated IRQs for the device (so it's kinda
> > obvious that IRQ number maps to the driver);
> 
> Yes, I could understand that as well.
> 
> > - the IRQ core disables IRQ while handling an IRQ number in question;
> 
> Not necessarily:
> When on irqs are force-threaded, only a quick handler is called, returning 
> IRQ_WAKE_THREAD, which is supposed to wake up the handler thread.
> 
>   * @IRQ_WAKE_THREAD:   handler requests to wake the handler thread
> 
> In this case (which is what I am dealing with), the actual handler will run 
> in thread context (which I suppose don't disable IRQ for sched-out 
> purposes).

Each IRQ can be disabled on both sides: device side, host side. I think we are
talking about host side here as IRQ code doesn't know about each and every devices.
Am I right? Then host side of device IRQ is disabled by core and it doesn't prevent
scheduling from happening (of course if it's UP system with nohz fully on, it might
be that this IRQ is the only one to schedule the system, but I don't see any other
way out here).

At least this is how I interpret the 81e2073c175b ("genirq: Disable interrupts
for force threaded handlers"). Maybe that I'm missing something obvious here...

> > - the driver is supposed to handle all IRQs that were reported at the beginning
> > o.f its handler;
> 
> That I am not aware about. I suppose it depends on driver implementation.

This is just an expectation and some drivers proven to loose performance if
they don't follow it:

0b60557230ad ("usb: ehci: Prevent missed ehci interrupts with edge-triggered MSI")

> But if this one is correct, and must be true for every handler, then my 
> first approach should be the right fix. See [1] below.

I believe it depends if IRQ is level or edge triggered. For level triggered
we may stuck for a while in the handler if there is a stream of IRQs, hence
driver may deliberately give up to give other tasks a chance to progress.

> Below I am assuming handled IRQs = 'handlers which returned IRQ_HANDLED':

Right.

> > - taking the above the amount of handled IRQs is what came till the disabling
> > IRQ.
> 
> Sure
> 
> > IRQs that came after should be replayed when IRQ gets enabled.
> > 
> > ?
> 
> Not sure about this one as well.
> You mean the ones that got queued for thread-handling, but somehow got 
> paused since the interrupt got disabled?

If it's edge triggered, we may loose it if it's not get replayed.

> If not, I guess once you disable an IRQ no interruption on that line happens,
> so I don't think any interruption gets saved for later (at least not in 
> kernel level).

There is a mechanism for IRQ replay in the kernel, see IRQS_REPLAY and code
around it.

> But I may be wrong here, it's a guess.
> 
> > > - I could try thinking a different solution, which involves changing only
> > >   the spurious detector.
> > > 
> > >   - For that I would need to find a particular characteristic we would want 
> > >     to avoid spurious detection against, and make sure it won't miss an
> > >     actual case we want to be protected about.
> > > 
> > > Generic solutions(?) proposed:
> 
> [1] here:
> 
> > > - Zero irqs_unhandled if threaded & handles a single request in 100k
> > >   - Problem: A regular issue with the interruption would not be detected 
> > >     in the driver. 
> > > 
> > > - Skip detection if threaded & the handling thread is running
> > >   - Problem 1: the thread may run shortly and batch handle a lot of stuff, 
> > >   not being detected by the spurious detector. 
> > >   - Problem 2: the thread may get stuck, not handle the IRQs and also not
> > >   being detected by the spurious handler. (IIUC)
> > > 
> > > In the end, I could not find a proper way of telling apart
> > > a - "this is a real spurious IRQ behavior, which needs to be disabled", and 
> > > b - "this is just a handler that batch-handles it's requests",
> > > without touching the drivers' code.
> > > 
> > > Do you have any suggestion on how to do that?

-- 
With Best Regards,
Andy Shevchenko


