Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9C43BE643
	for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790355631; cv=none; b=IEUYjbOxvqBmu6icvMW9RcTV9DD4TP3OEOkqHIeUu3ZtWMgXWrLLSotsT2WDlCodUME0KnwMt1iCyllT6A569wz1Wqsl0srXyyLsi8e0lNRDZ+RhAN6U3inHLXJwwNq3mIvLv5262L9vrGvt5RIQuYMHecjGqtxUSdXKHRM4i2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790355631; c=relaxed/simple;
	bh=trGfb5h3aihrsj132AhSyMKG2jvzs9a9TvuhCmuHUE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9+Rwm2gPVT6WH8dkKc4pMOYfzIkTjkobDyDwXVl+sUlbjJBkfs1qY1eUuxO42aeaH+Nc3hlrsmSqm9/nl+0TbRWPAb0lkPRqIvUHTgMi+XjfNm6NAmuvumul1nHkmzZCQGLzJbQkJsyvaXnI8uvEHivm6lMtPHOiSe+6MLDwls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NqRAiY7E; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NqRAiY7E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790355611; x=1821891611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=trGfb5h3aihrsj132AhSyMKG2jvzs9a9TvuhCmuHUE0=;
  b=NqRAiY7E5uDF02hg9Va87PUDYZmI0CkJc7OASDzbB9e9JDl0CVzFpl4J
   Oy/SoHJkekOwYmOG6pdnrohJZUkcKBUzpmAn5gH69KUhZo3unow1kxfmO
   jVPwluheeOGE6cfO7p21cLDUMs64k3xur2zNCNLzsV9WU3xohHdMv1yMo
   AH1v1fpadrfKJp5N4icgu+/eRksk7eV+fA8ExYm/0OAqlL7cCzO3myEDx
   1DQ5PqlVprFGfWbg5xabg3HFcK+8rhRmoH537eOYXsS8Swx8PidIM0Ffu
   nYRYwlV8HZvcW8iJb8cIUCJqh2mkjVDKYePp7JrQ24U9Zpm6oSzpMAELn
   w==;
X-CSE-ConnectionGUID: RskuDU2rSlS3B7tsFAL4MA==
X-CSE-MsgGUID: mLe3GdpIR7GM3IcOvGC7jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="112931455"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="112931455"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 10:00:08 -0700
X-CSE-ConnectionGUID: trxOHcR0T9mkE3PUghq/gA==
X-CSE-MsgGUID: qazJTVfLSqaQ5iNF8wCLoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="272970527"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.27])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 10:00:06 -0700
Date: Fri, 25 Sep 2026 20:00:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: 8250_port: properly handle runtime PM in
 IRQ
Message-ID: <araolO22LVK_Nq1-@ashevche-desk.local>
References: <20260924122549.668680-1-andriy.shevchenko@linux.intel.com>
 <20260924122549.668680-3-andriy.shevchenko@linux.intel.com>
 <20260924124042.1C4AF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924124042.1C4AF1F000FF@smtp.kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 24, 2026 at 12:40:41PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] serial: 8250: missing port->dev NULL check in serial8250_default_handle_irq()
> --

Isn't this a preexisting issue since serial8250_rpm_get() is implemented this way
https://elixir.bootlin.com/linux/v7.3-rc3/source/drivers/tty/serial/8250/8250_port.c#L517
?

Yes, only for platforms with UART_CAP_RPM, but it doesn't matter, they have no
special handling for the port in this case. (And pm_runtime_get_if_active() actually
works properly on those which do not set that flag as we only check pm_status for 0
and don't care for the other cases.)

> commit 128116d52224b04215dd65b2f4f799e8c14bdec7
> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> serial: 8250_port: properly handle runtime PM in IRQ
> 
> This commit updates the 8250 driver IRQ handler to explicitly check the
> runtime PM status before processing the interrupt. It returns immediately
> if the device is powered off, assuming it is a shared interrupt.
> 
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > index c0bcc0742a60c..1e62460b19ab9 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -1878,13 +1878,22 @@ EXPORT_SYMBOL_GPL(serial8250_handle_irq);
> >  
> >  static int serial8250_default_handle_irq(struct uart_port *port)
> >  {
> [ ... ]
> > +	/* if driver suspended, return, probably shared interrupt */
> > +	pm_status = pm_runtime_get_if_active(port->dev);
> 
> [Severity: High]
> Will this trigger a kernel panic if the port has no associated device? 
> Some ports, such as legacy ISA serial ports, might have a NULL port->dev. 
> Calling pm_runtime_get_if_active() with a NULL pointer would unconditionally 
> dereference it.
> 
> > +	if (!pm_status)
> > +		return 0;
> >  
> >  	iir = serial_port_in(port, UART_IIR);
> > -	return serial8250_handle_irq(port, iir);
> > +	ret = serial8250_handle_irq(port, iir);
> > +
> > +	if (pm_status > 0)
> > +		pm_runtime_put_autosuspend(port->dev);
> 
> [Severity: High]
> Similarly, does this put operation need a check to ensure port->dev is valid
> before passing it to pm_runtime_put_autosuspend()?

Same as above. We check pm_status. It can't be positive if above case failed
already.

> > +	return ret;
> >  }

-- 
With Best Regards,
Andy Shevchenko


