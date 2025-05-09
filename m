Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AFD27A925;
	Fri,  9 May 2025 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791008; cv=none; b=MfXQkz5mc4sntba2aKAtRHsY7u5YT0kYxCxm21uJrvuTjexb8MUW9J/t8RGm11tnyhHOGjKCP9083QEXy9cZ3FoKX4h4uAVKW2NFDNU4YxOCx8o31PQTEFyCVQGeBCfuIduRHY4KV7xG1UgbB3cHL/PvHZETm8MiV9kC7pQXgNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791008; c=relaxed/simple;
	bh=m+H1/8ViVgDOq8MR5pZ2MQkUSV/nUQAsOK5uSoyLjkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+zAQ9EkAqAy3qWT4HHgDgYX7BuAdLnvXfbA+z4alOU81fdRQ32liKWz4r6b9aSRijV5Uxh3Ics6dnlqV0D9QiHkf7cZRHe5uyx1S8oif0n6JSysG0X44uyTM+UaiR+4ur6dhUbO17ZVPxIie2eyC6DOnTySbYdHz6X9UpTi8yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVIGjyan; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVIGjyan"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746791007; x=1778327007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m+H1/8ViVgDOq8MR5pZ2MQkUSV/nUQAsOK5uSoyLjkk=;
  b=YVIGjyanvSkiVTgeggqlpU3PcV0P7FblcQlygWKnOW2Yx62D8o9CLJM5
   A43ZY9IUv1zq9+DsZ31P1aDDNCug4U3Mz+ZGZ76DRZ0rJOOk8DXzhm1CB
   TvHUztPh4xLng/QZ5YJ1VPTtYVvZh6e9xMdYg6WFlZNtr/zgcJwY+TwPM
   yRQSPDrVbsGXERoJIThOID5XlLwipeq0AMb113rNrRXUMNoocSId7FXoZ
   S092AistIrsa7K21acRd0DApHJBlTvAmpFk/kzHcDtlw3s8a23x+jNG2S
   9ICEOoj5fIJSf4b2BIxo3Gd4GrHEwxdsuXUgJbqVN7tR53afXPuflyhtT
   w==;
X-CSE-ConnectionGUID: 2JIQb31wSJiI/xrh4pLQxw==
X-CSE-MsgGUID: sm4zaRXdTtm+LQLS5lrw7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48773844"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="48773844"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 04:43:27 -0700
X-CSE-ConnectionGUID: 4coElZisQ+SyDOyBQNDiWQ==
X-CSE-MsgGUID: 7GDizL0uRvWXTINzlS+Hwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="141372472"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 04:43:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uDM8P-000000004xf-3Sp7;
	Fri, 09 May 2025 14:43:21 +0300
Date: Fri, 9 May 2025 14:43:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Judith Mendez <jm@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Hari Nagalla <hnagalla@ti.com>
Subject: Re: [PATCH RFC 2/2] serial: 8250: Add PRUSS UART driver
Message-ID: <aB3qWWgWfs6fDTgg@smile.fi.intel.com>
References: <20250501003113.1609342-1-jm@ti.com>
 <20250501003113.1609342-3-jm@ti.com>
 <aBSVeKoR0j4J0ruz@smile.fi.intel.com>
 <22de0384-974d-4170-8181-e43cc90aab9d@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22de0384-974d-4170-8181-e43cc90aab9d@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 08, 2025 at 05:09:03PM -0500, Judith Mendez wrote:
> On 5/2/25 4:50 AM, Andy Shevchenko wrote:
> > On Wed, Apr 30, 2025 at 07:31:13PM -0500, Judith Mendez wrote:

...

> > The list of the inclusions is semi-random. Please, follow the IWYU principle.

This and other comments left unanswered, why? What does this mean? Usual way is
to remove the context with all what you are agree on and discuss only stuff
that needs more elaboration.

Ah, I see now the P.S., but please also remove the context you agree with next
time.

> > > +#include <linux/clk.h>
> > > +#include <linux/module.h>
> > > +#include <linux/serial_reg.h>
> > > +#include <linux/serial_core.h>
> > 
> > > +#include <linux/of_irq.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/of_platform.h>
> > 
> > Please, no of*.h in a new code.
> 
> Will only keep linux/of_platform.h for of_device_id struct.

Hmm... Is it really the header where it's defined? (I know the answer,
but want you to perform some research.)

> > > +#include <linux/remoteproc.h>
> > 
> > Keep them ordered as well.
> > 
> > + blank line here.
> > 
> > > +#include "8250.h"

...

> > > +	/* Old custom speed handling */
> > > +	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST) {
> > > +		quot = port->custom_divisor & UART_DIV_MAX;
> > > +		if (port->custom_divisor & (1 << 16))
> > > +			*frac = PRUSS_UART_MDR_13X_MODE;
> > > +		else
> > > +			*frac = PRUSS_UART_MDR_16X_MODE;
> > > +
> > > +		return quot;
> > > +	}
> > 
> > Why?! Please, try to avoid adding more drivers with this ugly hack.
> 
> My understanding is that this is not a hack, for 38400 we need to pass
> as custom baud. What is the alternative here?

BOTHER. The 38400 is a hack, you lie to the stakeholders that you are at 38.4,
while in real life it means anything.

> I see other drivers are doing this as well, will look into this further
> but not sure if there is a better solution for this.

BOTHER is the solution. Not perfect, but the existing one.

-- 
With Best Regards,
Andy Shevchenko


