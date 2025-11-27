Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4D52EF655
	for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764273493; cv=none; b=tFmWzELjvt4HbzJSsgBdR1tDuIcm0sxmovvVlGaKkGaXUOupRVbNinysdl2L93o83ov5dQ/YopgKpyUfEYjuWWDdppvOV2nltJZ+t0fkfJ6nbo+DhzpiDz7ROU4Dt0dVHoqqMA+VUewKbKnRCJkfQAGM7zurIndCk8LLtlDJmp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764273493; c=relaxed/simple;
	bh=Xjg3++cr6YKjD2m2FHvx19e5MjLpykOJhyLczK8X1Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eICyd1MepJtEExpxLy0gz2cDRPUbaWWn5vPECPNhiFYu5fStkW5cJglgKSwmDfpQEAM3KypxJEYh4YoDHrEJthbp5xoT4BAh1iyR7GN9+mjV3Rv9XLsjOR0fbLPQL6qeZvGmClyH2lYZkYvnShtBLO1did0uy3a11WO5WiehXJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ilEsjVTQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ilEsjVTQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764273492; x=1795809492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xjg3++cr6YKjD2m2FHvx19e5MjLpykOJhyLczK8X1Lw=;
  b=ilEsjVTQHDDRZZa9EVkF+rGZKh3uYnOEbR4DMtWBWi5BN+olJTQ2QMUl
   yylJubVlpMxykVJPFOf6Kr74WBW7ufMJUo+oXElQthnLaA+V4IeUFfzG6
   YUnXG5v8gxbd1kjOlxXnGfnYIBYbL2rI/P3XiUK/w562nw9yLm1B5KGMm
   kqx/rVetq3/xy0nYrBqHcKWEu2mymxbeN8flODqDdnXGxdvzDOe1ur64Y
   4tb6tUhdEH8CO/zz/7lCbfHqHitsROJ9lQfj+wFW2uHaVlhhDtCbsoh4X
   YIZyCNlpCUt/RhreF0EGmS0pgnOiWJfA2A8nkz5XBlrLGPulFk1e9LBme
   Q==;
X-CSE-ConnectionGUID: utbHapygSIu7OyzQZw2aYQ==
X-CSE-MsgGUID: RQYSjlvhTti0cKsZpZ6Erg==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="91798129"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="91798129"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 11:58:12 -0800
X-CSE-ConnectionGUID: 4wAvVdzBSbuPKwqvlHORxA==
X-CSE-MsgGUID: 04uyngHxTDqSkN5IYonSeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="192961956"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 11:58:09 -0800
Date: Thu, 27 Nov 2025 21:58:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, lukas@wunner.de,
	Gerhard Engleder <eg@keba.com>, Daniel Gierlinger <gida@keba.com>
Subject: Re: [PATCH v4 2/2] serial: 8250: add driver for KEBA UART
Message-ID: <aSitT0qmfb19K69H@smile.fi.intel.com>
References: <20251023151229.11774-1-gerhard@engleder-embedded.com>
 <20251023151229.11774-3-gerhard@engleder-embedded.com>
 <aSb99zuXhUh3VD4J@black.igk.intel.com>
 <1692bf5e-a0de-4f75-8ec0-b228e94b6b4b@engleder-embedded.com>
 <aSdyMXhtpDX_Eo82@smile.fi.intel.com>
 <3f3092a0-8e9c-4d5c-9f98-3b574f970361@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f3092a0-8e9c-4d5c-9f98-3b574f970361@engleder-embedded.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 27, 2025 at 08:40:41PM +0100, Gerhard Engleder wrote:
> On 26.11.25 22:33, Andy Shevchenko wrote:
> > On Wed, Nov 26, 2025 at 10:06:17PM +0100, Gerhard Engleder wrote:
> > > On 26.11.25 14:17, Andy Shevchenko wrote:
> > > > On Thu, Oct 23, 2025 at 05:12:29PM +0200, Gerhard Engleder wrote:

...

> > > > Can't you call uart_read_port_properties()?
> > > > 
> > > > If ever you gain some properties either via FW description or via software
> > > > nodes, they will be automatically used without need to update the driver!
> > > 
> > > Yes that would be some nice behavior. But __uart_read_properties()
> > > sets some defaults even if no firmware node exist (UPF_SHARE_IRQ,
> > 
> > Is it a problem? Even a single IRQ may be marked shared.
> > 
> > > 0 as irq number
> > 
> > It doesn't do that, it just skips setting it in that case.
> > 
> > > or it fails if not irq number is found).
> > 
> > Yeah, this is most "problematic" part in case of this driver. Why is it
> > auxiliary and not platform? With that the __uart_read_properties() needs
> > to be updated to also query IRQ from respective aux device, and aux dev
> > needs implementation of dev_is_auxiliary(). Not that big deal, though.
> 
> It is auxiliary and not platform, because gregkh suggested to switch
> from platform to auxiliary. IMO he is right and that is a better fit,
> because auxiliary devices were introduced to split big devices into
> sub devices, which results in smaller drivers with one job for the
> sub device. That's actually what I tried to do with platform devices
> first.
> 
> > > So __uart_read_properties() would need to be changed. IMO it makes no sense
> > > to change __uart_read_properties() as this functionality is currently
> > > not required.
> > 
> > Yes, but as I said it will give you for free the possibility to use those
> > properties without future modifications of the driver. OTOH, driver is in
> > tree and modifications will be needed one way or another :-)
> 
> Yes, if the KEBA UART changes, then modifications would be needed. We
> kept this UART stable now for over 10 years. As it is FPGA based, we
> can keep it stable as long as FPGAs are on the market. In industrial
> automation the products are in the field for 10 years, 20 years or even
> more. We can only support the devices for that long time by keeping
> them compatible. So I don't expect changes now and therefore I would
> not prepare for them.

Fair enough.

-- 
With Best Regards,
Andy Shevchenko


