Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C5D9463
	for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 21:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764192824; cv=none; b=H9PxpdlFvHz/aeE70btEazL6DtHQDDwy6q8WIIxaGTruKazly9WdOoV8O/wAy4eUCm5KITI1bWjX5YnaLKKudpJ/WLK06VQib9xFtiydjFnp1ZFM2uADzMT8AhJt2LRfYUymvFfYeHW9sccvxpI94sVNT5nvQqBq/twjSB0ZZtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764192824; c=relaxed/simple;
	bh=iieyN2UU2nk1jjoImPSobtvcPXRx17cc6hr3aODk08Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+EKlXqm0OucemMrQMiLUrfb2jFBkplPNAo/EOepvmQYhchTfO0p/j2B9/zhZyzLPaCrFI002M5xwk2zjj8wDu/l928n1tbxIiBYqE91WwUUYDAhS3Htcp7ikSlpfh/lKqocjz0RWercnExLN9+VSuOB/sJPFkHNVNySfxGA/bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kdpaum4Z; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kdpaum4Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764192822; x=1795728822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iieyN2UU2nk1jjoImPSobtvcPXRx17cc6hr3aODk08Q=;
  b=Kdpaum4Z5UnSAfHmjJq1+RzLxbxN4YGDMkLaDBG/szmSobYNVw2w/3JB
   jgZoZqyQt2mP1hSG5lERQQFpo3L8GMlkmRrfe2Pz4gZwSkRsNQET+Vqx7
   awxa695Y+nCp2vJK41/2vQPDz/ssSKRSiJ4Jdkfpnx9DrpJTEIXQaam2Q
   PHPcN81n/4r9fCcMZkEgL/DP1iDrKRIsj589z9tQvceGHakKTHD/7y0CS
   TirR3hFgwbjbjtEZuyxkRW3pNQg2govWUAAOINsuWPHh+akcF4NbbQxv9
   X1NQKj/ATvASOnryO7jfwTA+6l75XZistOgU5nhYOGXKH01qnmNtnmwV3
   g==;
X-CSE-ConnectionGUID: mhbBxWOOTxGznahOKdrOPg==
X-CSE-MsgGUID: +Py6tINCTkuV3R/ExuyLxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66126498"
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="66126498"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 13:33:41 -0800
X-CSE-ConnectionGUID: e/JHrvFKSH2388kanuQnfg==
X-CSE-MsgGUID: WzxYAXbZRg6EaFcq/HuchA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="216405181"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 13:33:40 -0800
Date: Wed, 26 Nov 2025 23:33:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, lukas@wunner.de,
	Gerhard Engleder <eg@keba.com>, Daniel Gierlinger <gida@keba.com>
Subject: Re: [PATCH v4 2/2] serial: 8250: add driver for KEBA UART
Message-ID: <aSdyMXhtpDX_Eo82@smile.fi.intel.com>
References: <20251023151229.11774-1-gerhard@engleder-embedded.com>
 <20251023151229.11774-3-gerhard@engleder-embedded.com>
 <aSb99zuXhUh3VD4J@black.igk.intel.com>
 <1692bf5e-a0de-4f75-8ec0-b228e94b6b4b@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692bf5e-a0de-4f75-8ec0-b228e94b6b4b@engleder-embedded.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 10:06:17PM +0100, Gerhard Engleder wrote:
> On 26.11.25 14:17, Andy Shevchenko wrote:
> > On Thu, Oct 23, 2025 at 05:12:29PM +0200, Gerhard Engleder wrote:

...

> > > +#include <linux/auxiliary_bus.h>
> > 
> > + bits.h
> > + container_of.h
> > 
> > > +#include <linux/device.h>
> > 
> > I don't see how it's being used.
> > What I see are
> > 
> > + dev_printk.h
> > + device/devres.h
> > 
> > + err.h
> > 
> > > +#include <linux/io.h>
> > > +#include <linux/misc/keba.h>
> > 
> > + mod_devicetable.h
> > 
> > > +#include <linux/module.h>
> > 
> > + spinlock.h
> > + types.h
> 
> Is there any extra tool to check for missing headers? Or do I have to
> check the header for every used function?

There is iwyu, which is heavily tweaked by Jonathan Cameron for use in Linux
kernel and even though it gives some false positives.

I did this manually by reading the code of the driver and remembering which
header provides which API.

...

> > Can't you call uart_read_port_properties()?
> > 
> > If ever you gain some properties either via FW description or via software
> > nodes, they will be automatically used without need to update the driver!
> 
> Yes that would be some nice behavior. But __uart_read_properties()
> sets some defaults even if no firmware node exist (UPF_SHARE_IRQ,

Is it a problem? Even a single IRQ may be marked shared.

> 0 as irq number

It doesn't do that, it just skips setting it in that case.

> or it fails if not irq number is found).

Yeah, this is most "problematic" part in case of this driver. Why is it
auxiliary and not platform? With that the __uart_read_properties() needs
to be updated to also query IRQ from respective aux device, and aux dev
needs implementation of dev_is_auxiliary(). Not that big deal, though.

> So __uart_read_properties() would need to be changed. IMO it makes no sense
> to change __uart_read_properties() as this functionality is currently
> not required.

Yes, but as I said it will give you for free the possibility to use those
properties without future modifications of the driver. OTOH, driver is in
tree and modifications will be needed one way or another :-)

-- 
With Best Regards,
Andy Shevchenko


