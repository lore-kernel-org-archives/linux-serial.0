Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5F02C0F75;
	Tue, 27 Jan 2026 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521732; cv=none; b=X+rhGyxBofqtETcaXYHRm6NISNlxtaS2mpQ/tSE0O3zLciJ1MR6j4HOqvIuq0XQa+VgsAxBYnFN3ZtMIL/JYCEh7qjquBd6y6EvE3senAxrEj0oHZ4aO/i177zloSOqFzlAcnffqctTh8d7ZqTZwrVFp5xjSXh0ykSjs4QwUUTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521732; c=relaxed/simple;
	bh=OjfFhhGeF5WxKhQCkhU0Q3O1ePR/MW/99rVMgHP9Ldg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0Y5PRDPDHsMFzWRqojVYJqsJpx6CR02o+TWUexOKVqj1SR5j1BmtDbhNNSBHN2QaGMO55Sroe/B/tPrXoQBxj6gT8RdLrZZZRYewW1gmk2aBtQAzQexL5NKhv5yUmTdYvNjfJ14C1I5yuJ4PBjLeWdyVArAn3wtbSK2VJ1G+PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHsVosKV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHsVosKV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769521731; x=1801057731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OjfFhhGeF5WxKhQCkhU0Q3O1ePR/MW/99rVMgHP9Ldg=;
  b=XHsVosKVUoWG25iPBtRW+IOw41p5yFaacuoGo9dGo7qIJtYUpThcM8od
   aPbj28DgXzhixhT8JOPa0jfcq/1m0p5Jg1wVd60azD//sn5hSCEIUC+hn
   QCYfILUGosuT/s7sprkC7pP71JqoZ4/VLoL0dZoZnUcZWF5uvQjGucJnx
   GcOdL06Al6bON2cY8t4/SDfNHhtdkpLzpV0CtJt9lgxsA6Yy8WNvr0paK
   zrqazBry8CkRfakFYLZtGI6cMG+D/2k0yu9t4joaouyvnS9aCmVdqvcWb
   /Nv8cMjljRIOFmp4Xw6q9wMPttU2p6BT0kZbSyOpcOS3wfzuGraAlux7T
   g==;
X-CSE-ConnectionGUID: PsYm54QiQRiVtyNCwba/Xg==
X-CSE-MsgGUID: uePfe4yfSWembB2CgPoFyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="82082091"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="82082091"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 05:48:50 -0800
X-CSE-ConnectionGUID: A8P0PF53QguPbSitm+K8IQ==
X-CSE-MsgGUID: wTwVxif1SreVJFKnNIGpLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="208414132"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 05:48:47 -0800
Date: Tue, 27 Jan 2026 15:48:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>
Subject: Re: [PATCH 3/6] serial: 8250_dw: Rework dw8250_handle_irq() locking
 and IIR handling
Message-ID: <aXjCPu9BglNWec_F@smile.fi.intel.com>
References: <20260123172739.13410-1-ilpo.jarvinen@linux.intel.com>
 <20260123172739.13410-4-ilpo.jarvinen@linux.intel.com>
 <aXPwmfqPlUkI2zuw@smile.fi.intel.com>
 <2aa4aaa4-07b5-2003-eba7-6e1e6fa89611@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2aa4aaa4-07b5-2003-eba7-6e1e6fa89611@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 27, 2026 at 02:48:30PM +0200, Ilpo Järvinen wrote:
> On Sat, 24 Jan 2026, Andy Shevchenko wrote:
> > On Fri, Jan 23, 2026 at 07:27:36PM +0200, Ilpo Järvinen wrote:

...

> > > dw8250_handle_irq() takes port's lock multiple times with no good
> > > reason to release it in between and calls serial8250_handle_irq()
> > > that also takes port's lock.
> > > 
> > > As serial8250_handle_irq() takes port's lock itself, create
> > > serial8250_handle_irq_locked() that allows caller to hold port's lock
> > > across the call. Take port's lock only once in dw8250_handle_irq() and
> > > call serial8250_handle_irq_locked() directly.
> > 
> > Sounds to me that the latter can be split to a prerequisite patch.
> 
> It's not easy to split this DW-side IIR rework and locking changes. What I 
> can do is to make 8250_port change separately. I guess I'll do just that 
> and only the 8250_dw change in this patch.

Yes, that's what I had in mind.

...

> > > +++ b/drivers/tty/serial/8250/8250_port.c
> > 
> > >  #include <linux/ioport.h>
> > >  #include <linux/init.h>
> > >  #include <linux/irq.h>
> > 
> > > +#include <linux/lockdep.h>
> > 
> > I would still keep more order.
> > 
> > >  #include <linux/console.h>
> > >  #include <linux/gpio/consumer.h>
> > 
> > Giving the context we have, the better place for a new inclusion is somewhere
> > here.
> 
> Feels to me something that is in the eye of the beholder, but whatever, I 
> can move it from one's "correct" place to somebody elses "correct"
> place. :-)

The idea is to have the longest ordered chain even if it's broken by some
unordered pieces. In long-term it helps to cleanup without an additional
churn.

> > >  #include <linux/sysrq.h>
> > 
> > (Also perhaps sorting headers in a separate patch helps with finding better
> >  places for the future inclusions?)
> 
> Yes, later (not in this series).

Sure!

...

> > > +EXPORT_SYMBOL_GPL(serial8250_handle_irq_locked);
> > 
> > Wondering if we can start exporting with a namespace...
> 
> I'll do that. I picked "SERIAL_8250", is that fine or should I use e.g.
> "8250" instead?

Since it's a string now, I have no preferences, but SERIAL_8250 sounds like
slightly better choice as it has not only digits (its own namespace in the
naming) and less chances to collide in the future.

-- 
With Best Regards,
Andy Shevchenko


