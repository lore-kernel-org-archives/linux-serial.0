Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E0933B6FC;
	Tue, 27 Jan 2026 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769522269; cv=none; b=DRJeqnybgnzprxIeOTiaZbs+jRl3m30GPAUT+KZfeXxSSd7ELCxBTRuaAaXOCWGDXmJlf2rIPOUE49az/VUnsMlotGg7wNwcy0H11Csp0F1rAB8PjrsX+OkjeknDe+tl+9ZiBhf9mDwFlUNS5+C1/jEBi0HCAlQUWU5776Km2Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769522269; c=relaxed/simple;
	bh=bxmaCfyCj5/qM4wFvjutrBJXmXjHJNfa+bGwOfgbbJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJuwt+g3eJvJVs2cqUvg4Mb+ztqyEwaerrMh2ir1aBBvtJyGn4+iWSCrKwuAeecgrTrKU4d8fmXo8Z3YxTyoiN+hEVS8Ul3C01+zPX5ic8fkr+51GPFa/rXSfrkw1M5HUolu1HGsT8AoHkMm+5sRb/6XpYeiqgWUZUoTLAzjl+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UII/9yI8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UII/9yI8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769522268; x=1801058268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bxmaCfyCj5/qM4wFvjutrBJXmXjHJNfa+bGwOfgbbJU=;
  b=UII/9yI8yKTiiGaOSRqMoFXupKIGtcuTo+I6xq0rFzfYseT2NlKyWzUO
   7itYYh5d8oC1AUw3zOt9Q7celtrKpPKR3dlZRnTAIUY8L8sx+mat6ResC
   pOpVl0laCyHzTdLcSg1gIFIYK71ggBNVsXVpP8qLeECE2gsD8oBtnGF2H
   7BhsoOMoJ5Kvb4kkB2uOaM6aSVYbI19DrWjPPRzIpKqK67V676WCGCrqj
   7CpH52/IeD90dsSP/9Azbr5lNsmfhCquSMwPSxO7U0D3amhFivvYwCpmB
   9naEHovwgTpCw0l7uHVy4okOS5ZkoQmTXOUS0iHmAfsA+GdhNNSezTFji
   Q==;
X-CSE-ConnectionGUID: x2CkAFYGRhGZb9t/MQ0ZfA==
X-CSE-MsgGUID: NFBfgC/mR9GuE9kLS3ggTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="82082833"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="82082833"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 05:57:47 -0800
X-CSE-ConnectionGUID: RDSDa0WAT5iH/oe4ZkcTzA==
X-CSE-MsgGUID: eU58YX6DSwykAFFvuegPhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="208225700"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 05:57:44 -0800
Date: Tue, 27 Jan 2026 15:57:42 +0200
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
Subject: Re: [PATCH 4/6] serial: 8250_dw: Rework IIR_NO_INT handling to stop
 interrupt storm
Message-ID: <aXjEVtI7Bo5BCOiX@smile.fi.intel.com>
References: <20260123172739.13410-1-ilpo.jarvinen@linux.intel.com>
 <20260123172739.13410-5-ilpo.jarvinen@linux.intel.com>
 <aXPyiOMxClprdOQM@smile.fi.intel.com>
 <be94eddc-0395-7215-df1e-ba5e718701f8@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be94eddc-0395-7215-df1e-ba5e718701f8@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 27, 2026 at 03:01:46PM +0200, Ilpo Järvinen wrote:
> On Sat, 24 Jan 2026, Andy Shevchenko wrote:
> > On Fri, Jan 23, 2026 at 07:27:37PM +0200, Ilpo Järvinen wrote:

...

> > > +		d->no_int_count++;
> > > +		if (d->no_int_count > 2 && quirks & DW_UART_QUIRK_IER_KICK)
> > > +			dw8250_quirk_ier_kick(p);
> > 
> > Usual way is to use modulo. And perhaps use 4 for the sake of avoiding
> > division:
> > 
> > 		if (d->no_int_count == 3 && quirks & DW_UART_QUIRK_IER_KICK)
> > 			dw8250_quirk_ier_kick(p);
> > 
> > 		d->no_int_count = (d->no_int_count + 1) % 4;
> 
> This doesn't look equivalent code as it only fires on 4th NO_INT,

Correct, I forgot to clarify this in my original reply. Yes, bumping to
power-of-two for simplicity, but as you noticed it bumps also the loop to
"every 4th". (I was under impression that I wrote it somewhere else in
the reply, but now I see it's not the case.)

> but I guess the difference doesn't matter that much so changing to your
> suggestion so that the kick will only occurs on fourth NO_INT interrupt.

> > where 4 may be defined with meaningful name. With that u8 is more than enough.


-- 
With Best Regards,
Andy Shevchenko


