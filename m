Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9AE1FDA8B;
	Mon, 13 Jan 2025 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736773872; cv=none; b=XhDtTaDDw+JkGtpRmzQeaFk4ZOpd4p+M8UZAMBGBFW6+pBguKsIAGz6h5V9Uk1dH/Wfvk4WVu0xo+DSf+rYPfqRZHWa0ZZjlLnvooF0Nj/bWOu7A8mYZhaVpuxvK8xkdLH98TZKSbVjH2rJ34dSdrKco5DXXmUsws94tzNftQgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736773872; c=relaxed/simple;
	bh=b7mRbVZSj31a1uvMGjop45KSBdwunxeQqSpb+HZutLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQb/VnV25W76+tkH9I5IYM3xD8IE9WRIQ12AGzQ7QDYjto/Gg85H0aBo5/LzoDPd0c53j2EltQBGSijqoASdGsFuW2uC3WHkPhtSwEsaIsXj8+giUlmAOJchXN/WEP0TFcYVyhNcKn8VK7E0PsdH+ZgfhtUn+MxNQJFCM/K3/u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 3W1PIW8bQRKOT1kHJe5cgw==
X-CSE-MsgGUID: DpVJ9jM6RgiGqItS9CbEaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="36248380"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="36248380"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 05:11:10 -0800
X-CSE-ConnectionGUID: f3+YdzYNQguEKr1U3RdSXQ==
X-CSE-MsgGUID: fmKDRB1uTUumX0S+smad7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104264335"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 05:11:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tXKDf-00000000TF9-3c4D;
	Mon, 13 Jan 2025 15:11:03 +0200
Date: Mon, 13 Jan 2025 15:11:03 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	hvilleneuve@dimonoff.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	lech.perczak@camlingroup.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, robh@kernel.org
Subject: Re: [External Email] Re: [PATCH v6 2/2] serial: sc16is7xx: Add
 polling mode if no IRQ pin is available
Message-ID: <Z4UQ56-DDr8zim-e@smile.fi.intel.com>
References: <20250113073030.15970-1-andre.werner@systec-electronic.com>
 <20250113073030.15970-2-andre.werner@systec-electronic.com>
 <Z4UMP1-0x25g1fX2@smile.fi.intel.com>
 <6ccaf061-c3d7-c78a-17e3-f0b9642c412f@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ccaf061-c3d7-c78a-17e3-f0b9642c412f@systec-electronic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jan 13, 2025 at 02:02:25PM +0100, Andre Werner wrote:
> On Mon, 13 Jan 2025, Andy Shevchenko wrote:
> > On Mon, Jan 13, 2025 at 08:30:30AM +0100, Andre Werner wrote:

...

> > > +static void sc16is7xx_poll_proc(struct kthread_work *ws)
> > > +{
> > > +	struct sc16is7xx_port *s = container_of(ws, struct sc16is7xx_port, poll_work.work);
> > > +
> > > +	/* Reuse standard IRQ handler. Interrupt ID is unused in this context. */
> >
> > Period.
> 
> What do you expect here? Shall I add the period time from the define as
> the dedicated value? I do not understand what I should add here in
> detail.
> 
> >
> > > +	/* Setup delay based on SC16IS7XX_POLL_PERIOD_MS */
> >
> > No period.
> 
> Or do you mean that I add the define only once and not add all used
> places?

...

> > Please, go through the comments you added in the patch and use the style that
> > is mostly used in the driver for the similar (one-line comment) situations.

^^^ Read this. You have added three comments in two different styles.
It's not a big or anyhow critical issue in this case, it's matter of
the consistency with the existing style.

I expect that all three will in the same style, preferable the one
that is currently in use in the driver for other comments.

...

> > > +		/* Initialize kernel thread for polling */
> >
> > Again, no period.
> 
> Same here. Do you expect the value here or the name of the used define?


-- 
With Best Regards,
Andy Shevchenko


