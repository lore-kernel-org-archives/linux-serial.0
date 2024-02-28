Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7780D71ED2
	for <linux-serial@vger.kernel.org>; Wed, 28 Feb 2024 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143178; cv=none; b=WUuDAzFJOChEseBu7B1Y8nKU7a94wuJaspM9nKvk0gjHzQETkHkVIK8/Y9zATSd0z3e+9fZmFodO2SKOvKbHgaozWAZHjWRqvIGKfJVgMmris+UDp62e2IoQeRNbNXfU+bZ9hHUvnTZaY/lGhnGPdhwMA2jnDMMVdXSdIXe3a4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143178; c=relaxed/simple;
	bh=Cryg0oMlMm65LIgyevh5OmxK1msBCbiQJnZ5+mS95BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dra6SgK2vJ5NsaQE1P//6Y9S4O+OvKyRgw/9cFftYEUsGT74F4QzGI504DpKp/W+cJPYbsRvgEcM6hcH2HfjDTmTriwPMUloIOQpvcnyts+otUpMYnubiPlTfhOQ1CQF7b5WcsU85Me3E+llYG4DcCQ4faD+vnwn4MlKnKYlk24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DjOEn/ha; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DjOEn/ha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709143177; x=1740679177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Cryg0oMlMm65LIgyevh5OmxK1msBCbiQJnZ5+mS95BE=;
  b=DjOEn/haYNDdrin9dHpLH+YImgdYq01Gcph2SIueZJRQMBeQKfFNwTeX
   Bww9rMwwj5jwhJrPXh02QyUD2Ji4XrpeGqjziNDnPL/5XWtyqaJh40PCt
   tSqoQrHnzFaXTOgoySBQnf+AGp43XZllyr9e7F+BGI5ybJnvduIGh9ooO
   bzhIrc0FXh6G5a+r4H+ewPvX+MThFIk7+ZfmXnK+zNJ5jdWHzqYkHvprd
   7w0UanRakv/nmUE2zhqhxe54M42+juEyVe/foiI9vPshQe6yL9Da392CR
   cGjKrOUzk+bszHLGf0HgX+BA5TTp/HrQoFw53epxN86m1UBKNRgyAabvS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="15000847"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="15000847"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 09:59:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913957046"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="913957046"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 09:59:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfODL-00000008I7i-0y1N;
	Wed, 28 Feb 2024 19:59:31 +0200
Date: Wed, 28 Feb 2024 19:59:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: VAMSHI GAJJELA <vamshigajjela@google.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_dw: Emit an error message if getting the
 baudclk failed
Message-ID: <Zd90ghtOxQSGNZxD@smile.fi.intel.com>
References: <20240222111922.2016122-2-u.kleine-koenig@pengutronix.de>
 <CAMTSyjrKVL12CrXuqJhWydObhYfgLF=zKTE0U0LdzimTT6Sdsw@mail.gmail.com>
 <Zdy-X37encfcr9g7@smile.fi.intel.com>
 <CAMTSyjodFe0K_0h3R1d1JRYCHMnHhVCjhCSWRLGuzB46Gx+SVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMTSyjodFe0K_0h3R1d1JRYCHMnHhVCjhCSWRLGuzB46Gx+SVQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 11:15:23PM +0530, VAMSHI GAJJELA wrote:
> On Mon, Feb 26, 2024 at 10:07 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Feb 26, 2024 at 09:30:53PM +0530, VAMSHI GAJJELA wrote:
> > > On Thu, Feb 22, 2024 at 4:50 PM Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:

...

> > > I see any error should be caught at the following line, provided no
> > > clock-frequency
> > > ```
> > > /* If no clock rate is defined, fail. */
> > > if (!p->uartclk)
> > >         return dev_err_probe(dev, -EINVAL, "clock rate not defined\n");
> > > ```
> >
> > Not sure what you meant by this. Even if we ask for an optional clock,
> > the error condition still might happen with many other reasons besides
> > the absence of the clock.
> I was looking for a reason that the author has encountered. Error condition
> on an optional clock might also fail `p->uartclk = clk_get_rate` and result
>  "clock rate not defined\n" error.

Are you sure that CCF allows this to happen on real clocks?
I mean, the rate of (existing) clock can be 0 iff the clock provider is
powered off or unclocked itself (by parent clock).
But I'm not sure this is the case CCF handles.

-- 
With Best Regards,
Andy Shevchenko


