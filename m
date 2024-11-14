Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA4F1E9080;
	Thu, 14 Nov 2024 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731570645; cv=none; b=YCzQL9aKrpWASLeWp5QWSuFxj5OzCmVLFDpWq3Pb462huXSSb3KOntM/frffpGcqpntKxv/D4pwImjqrVt0CqZx1WYf91ia5gtCnWoesh5dV7wGkHmiGYZl4N10VxHOX+dNLcJnbKepOykoOoxyytmJDX3RWiywqKWt21cDx2T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731570645; c=relaxed/simple;
	bh=VEEdV2j4NTseykCPPGLuk4dbGlTHdNyaisNPkK2RWmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6JM+cvjpwbp2qLVd5TMorRF/VJmgtpj4F9vjmGeBFj6XTf0Oo7shlnAUP+rSRuX7HOXR9SbTpdi3W6RgZB5otdxAV6RjiuYzK3BzbDNf5lHyX5u4I7m1L5DumNZybFhZUuYZlHq7RLa1LpaaQBpAQHTDBmVXN61KHsz+1dh9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JIcvsFDz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIcvsFDz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731570643; x=1763106643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VEEdV2j4NTseykCPPGLuk4dbGlTHdNyaisNPkK2RWmc=;
  b=JIcvsFDzMg6zEuS5BN5tOD1REKxUOzZT/+PJjID616EGUgL4O5GPOFAm
   vAa7g0z9VVTpLEqoj0/TjL06/J/lfUq7coSSL10ENv56HPMwAPyxIFhqy
   ub8yKBgzwLFQVdnyRXQsq3U/njNfzR/6OHOntVB+/k5flX6Z72WHUKCX9
   pZtZ3TDVMjg41o1/wzU0P3dp/EoIKZgPX6L7/rJodqXcBpLv2jibHms5u
   kWpztNAA0DJQl/2mc8/iP1N9az7uED6UChsEeDgLJ2orsYOXFb3RawFuT
   tWL6v79Rx2JLf3hNb/B7AZYKeYTRFtvRlucEeMZGTLs3Z0zQMWGr8nHUM
   A==;
X-CSE-ConnectionGUID: 0TRftLKCQyaCmISb9h6G7w==
X-CSE-MsgGUID: cYmvHQvBRLKCRmZO1n/XVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31469695"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31469695"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 23:50:42 -0800
X-CSE-ConnectionGUID: gmLL/F8nR6OHb4eKqSuS0w==
X-CSE-MsgGUID: 6OtMX8/LQWCyFoj1fP5Tbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="93171172"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 23:50:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tBUce-0000000EdWX-1pu3;
	Thu, 14 Nov 2024 09:50:36 +0200
Date: Thu, 14 Nov 2024 09:50:36 +0200
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
Message-ID: <ZzWrzC1QhhlNqLpl@smile.fi.intel.com>
References: <20240216075948.131372-2-leobras@redhat.com>
 <20240216075948.131372-5-leobras@redhat.com>
 <87zfvwai62.ffs@tglx>
 <87v86kaf84.ffs@tglx>
 <ZdWMja3BfCZsbF_q@LeoBras>
 <87edd5hljz.ffs@tglx>
 <ZdghE6TNHgZ_bi19@LeoBras>
 <ZzVxIfb5KpL97P4Q@LeoBras>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzVxIfb5KpL97P4Q@LeoBras>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Nov 14, 2024 at 12:40:17AM -0300, Leonardo Bras wrote:
> On Fri, Feb 23, 2024 at 01:37:39AM -0300, Leonardo Bras wrote:
> > On Wed, Feb 21, 2024 at 04:41:20PM +0100, Thomas Gleixner wrote:
> > > On Wed, Feb 21 2024 at 02:39, Leonardo Bras wrote:
> > > > On Mon, Feb 19, 2024 at 12:03:07PM +0100, Thomas Gleixner wrote:
> > > >> >> Is scenarios where there is no need to keep track of IRQ handled, convert
> > > >> >> it back to IRQ_HANDLED.
> > > >> >
> > > >> > That's not really workable as you'd have to update tons of drivers just
> > > >> > to deal with that corner case. That's error prone and just extra
> > > >> > complexity all over the place.
> > > >
> > > > I agree, that's a downside of this implementation. 
> > > 
> > > A serious one which is not really workable. See below.
> > > 
> > > > I agree the above may be able to solve the issue, but it would make 2 extra 
> > > > atomic ops necessary in the thread handling the IRQ, as well as one extra 
> > > > atomic operation in note_interrupt(), which could increase latency on this 
> > > > IRQ deferring the handler to a thread.
> > > >
> > > > I mean, yes, the cpu running note_interrupt() would probably already have 
> > > > exclusiveness for this cacheline, but it further increases cacheline 
> > > > bouncing and also adds the mem barriers that incur on atomic operations, 
> > > > even if we use an extra bit from threads_handled instead of allocate a new 
> > > > field for threads_running.
> > > 
> > > I think that's a strawman. Atomic operations can of course be more
> > > expensive than non-atomic ones, but they only start to make a difference
> > > when the cache line is contended. That's not the case here for the
> > > normal operations.
> > > 
> > > Interrupts and their threads are strictly targeted to a single CPU and
> > > the cache line is already hot and had to be made exclusive because of
> > > other write operations to it.
> > > 
> > > There is usually no concurrency at all, except for administrative
> > > operations like enable/disable or affinity changes. Those administrative
> > > operations are not high frequency and the resulting cache line bouncing
> > > is unavoidable even without that change. But does it matter in the
> > > larger picture? I don't think so.
> > 
> > That's a fair point, but there are some use cases that use CPU Isolation on 
> > top of PREEMPT_RT in order to reduce interference on a CPU running an RT 
> > workload.
> > 
> > For those cases, IIRC the handler will run on a different (housekeeping) 
> > CPU when those IRQs originate on an Isolated CPU, meaning the above 
> > described cacheline bouncing is expected.
> > 
> > 
> > > 
> > > > On top of that, let's think on a scenario where the threaded handler will 
> > > > solve a lot of requests, but not necessarily spend a lot of time doing so.
> > > > This allows the thread to run for little time while solving a lot of 
> > > > requests.
> > > >
> > > > In this scenario, note_interrupt() could return without incrementing 
> > > > irqs_unhandled for those IRQ that happen while the brief thread is running, 
> > > > but every other IRQ would cause note_interrupt() to increase 
> > > > irqs_unhandled, which would cause the bug to still reproduce.
> > > 
> > > In theory yes. Does it happen in practice?
> > > 
> > > But that exposes a flaw in the actual detection code. The code is
> > > unconditionally accumulating if there is an unhandled interrupt within
> > > 100ms after the last unhandled one. IOW, if there is a periodic
> > > unhandled one every 50ms, the interrupt will be shut down after 100000 *
> > > 50ms = 5000s ~= 83.3m ~= 1.4h. And it neither cares about the number of
> > > actually handled interrupts.
> > > 
> > > The spurious detector is really about runaway interrupts which hog a CPU
> > > completely, but the above is not what we want to protect against.
> > 
> > Now it makes a lot more sense to me.
> > Thanks!
> 
> Hi Thomas,
> 
> I would like to go back to this discussion :)
> From what I could understand, and read back the thread:
> 
> - The spurious detector is used to avoid cpu hog when a lots of IRQs are 
>   hitting a cpu, but few ( < 100 / 100k) are being handled. It works by
>   disabling that interruption.
> 
> - The bug I am dealing with (on serial8250), happens to fit exactly at
>   above case: lots of requests, but few are handled.
>   The reason: threaded handler, many requests, and they are dealt with in 
>   batch: multiple requests are handled at once, but a single IRQ_HANDLED 
>   returned.
> 
> - My proposed solution: Find a way of accounting the requests handled.
> 
>   - Implementation: add an option for drivers voluntarily report how 
>     many requests they handled. Current drivers need no change.

>   - Limitation: If this issue is found on another driver, we need to 
>     implement accounting there as well. This may only happen on drivers
>     which handle over 1k requests at once.

> What was left for me TODO:
> Think on a generic solution for this issue, to avoid dealing with that 
> in a per-driver basis. 
> 
> That's what I was able to think about:

> - Only the driver code knows how many requests it handled, so without  
>   touching them we can't know how many requests were properly handled.

Hmm... But do I understand correctly the following:

- the IRQ core knows the amount of generated IRQs for the device (so it's kinda
obvious that IRQ number maps to the driver);

- the IRQ core disables IRQ while handling an IRQ number in question;

- the driver is supposed to handle all IRQs that were reported at the beginning
o.f its handler;

- taking the above the amount of handled IRQs is what came till the disabling
IRQ. IRQs that came after should be replayed when IRQ gets enabled.

?

> - I could try thinking a different solution, which involves changing only
>   the spurious detector.
> 
>   - For that I would need to find a particular characteristic we would want 
>     to avoid spurious detection against, and make sure it won't miss an
>     actual case we want to be protected about.
> 
> Generic solutions(?) proposed:
> - Zero irqs_unhandled if threaded & handles a single request in 100k
>   - Problem: A regular issue with the interruption would not be detected 
>     in the driver. 
> 
> - Skip detection if threaded & the handling thread is running
>   - Problem 1: the thread may run shortly and batch handle a lot of stuff, 
>   not being detected by the spurious detector. 
>   - Problem 2: the thread may get stuck, not handle the IRQs and also not
>   being detected by the spurious handler. (IIUC)
> 
> 
> In the end, I could not find a proper way of telling apart
> a - "this is a real spurious IRQ behavior, which needs to be disabled", and 
> b - "this is just a handler that batch-handles it's requests",
> without touching the drivers' code.
> 
> Do you have any suggestion on how to do that?

-- 
With Best Regards,
Andy Shevchenko


