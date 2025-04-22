Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A578F10A1F;
	Tue, 22 Apr 2025 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307866; cv=none; b=aV24Yo1ugQSq3rx0WbkW02P44xZRBJr0iIi2Hf6/Ma127V8zjks8HmLktKz0cCX0Qeyim622Vs/H3PYeCP3LxwApuCQYqZlVQTQDKwuDa1H1IcShHR9GBa5Z1ZEI7ccFn7njVNJ19fPffh2bNyT7MX+A4dJmYAUnODDbnOT/vKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307866; c=relaxed/simple;
	bh=9vnSOSCDjiR7R75CeBz4NTj+CZMsCQdvv0AiGtRRiW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/2IuGNb5HzDIuYp5jQZCu9R3cHVZ961hhs6RIpiUNj0l822wxOTEiDUDti8yucKAVSUHFUH8hWysWyM4gNxrB1bQPxan2WpLUfzfycKq4hTCMrfzK3Ca6Y4JJ0c9mbSTAaa5qIoFYcS7FjYuKjjHvUoyrNyly44Q5MYlT8mvcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ml0e1kVp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ml0e1kVp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745307865; x=1776843865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9vnSOSCDjiR7R75CeBz4NTj+CZMsCQdvv0AiGtRRiW0=;
  b=ml0e1kVpqK5eY3hw119+dNUO8DiYGBD8TDa2BLB8gjhgeuC3J4xBkCVU
   YzhfxgskLhURZWr3mYsq0rN1RH58V4yA3BaHlA59KGYGdxu3A5HX/jej8
   acRLmVD+Q9OBpRC+KIIw5zTR2ziqdHFZvUr0foNyBwnlK6K2c6LKucw5E
   28cIYsxL66/PxvG2CWM7Y0TaeQZp+8C1xQYb9v71XabpF1pBINGyN8wNi
   NE3cSeVQm78M21jwH6u22v05McmB85N5pYnfJR17PkHxXW5WYWvMPV/0Q
   OpGb6+F4GlVqKJIMPLZsH6b721vFB4cLs6XU3vT6Gnbn2tKkq7YvrHbeg
   w==;
X-CSE-ConnectionGUID: 4cLu8V2lSEaTvvHmnGMW7Q==
X-CSE-MsgGUID: Iab9LOGtQwmWk+DmdC3wPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="58218028"
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="58218028"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 00:44:24 -0700
X-CSE-ConnectionGUID: YloV0KSCQc2d6vZ0nKdBfA==
X-CSE-MsgGUID: YUBnzR1EQV6p3XGtBmjdlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="162991230"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 00:44:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u78Ij-0000000EfBX-2dMa;
	Tue, 22 Apr 2025 10:44:17 +0300
Date: Tue, 22 Apr 2025 10:44:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, john.ogness@linutronix.de, pmladek@suse.com,
	arnd@arndb.de, namcao@linutronix.de, benjamin.larsson@genexis.eu,
	schnelle@linux.ibm.com, heikki.krogerus@linux.intel.com,
	markus.mayer@linaro.org, tim.kryger@linaro.org,
	matt.porter@linaro.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [External] Re: [PATCH v3] serial: 8250: fix panic due to PSLVERR
Message-ID: <aAdI0SH-mz1Uf4d-@smile.fi.intel.com>
References: <20250414031450.42237-1-cuiyunhui@bytedance.com>
 <Z_zLqH1Moavhi52x@smile.fi.intel.com>
 <CAEEQ3wnEu2o+h2RY4rTGYR0yMX2EcX+7SdciqfzV3VLGWFyG3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wnEu2o+h2RY4rTGYR0yMX2EcX+7SdciqfzV3VLGWFyG3A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 21, 2025 at 10:55:05AM +0800, yunhui cui wrote:
> On Mon, Apr 14, 2025 at 4:47 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Apr 14, 2025 at 11:14:50AM +0800, Yunhui Cui wrote:

...

> > This patch seems need split to three. See below.

...

> > > --- a/drivers/tty/serial/8250/8250_dw.c
> > > +++ b/drivers/tty/serial/8250/8250_dw.c
> >
> > Changes here deserve the separate patch (patch 1).
> 
> Splitting into a patchset is fine. What does "patch 1" refer to here?

A new series out of three patches, the above change looks good to be placed in
patch 1/3 in that _new_ series. Same for patch 2/3 and 3/3 below.

...

> > > +     /*
> > > +      * Serial_in(p, UART_RX) should be under port->lock, but we can't add
> >
> > serial_in()
> 
> Okay.
> 
> > > +      * it to avoid AA deadlock as we're unsure if serial_out*(...UART_LCR)
> > > +      * is under port->lock.
> > > +      */
> > > +     lockdep_assert_held_once(&p->lock);

...

> > > +     uart_port_lock_irqsave(port, &flags);
> >
> > And one patch (patch 3) about locking.
> 
> Okay.

-- 
With Best Regards,
Andy Shevchenko


