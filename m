Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F126249F9
	for <linux-serial@vger.kernel.org>; Mon, 26 Feb 2024 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965478; cv=none; b=QYJm4hn9RpRW2dOZL+ui1YJnMwERMaPOKgAQ4j/dQu4MmHL7V2oCwRA+T0mnC6U2iLNBXlj0u1awaMM+9eFTH4RP9RtlwG2vJtPsmzR+b3/SSl+IwNdYb16afDQ0dzmSV9dZd8JDJ+JhPHHzmZxBW19krTpEQmkNKcYkuFdB5A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965478; c=relaxed/simple;
	bh=m7w5Gpo3wtQAimFYwtZl3AhKe8HHrKMXxttf1yYtPi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFt7jl3XCLhX6bBvfnV37Milv1VlFwvC9mkL4xx4iztl0dBRgDBQUAU4Wefy8SsyzGF1PU0wiRV6OeKsAHMvP/SR5VCMLeunSBwEn+np5xwEP2pNd2WUZmP3+wYRuzCsOy6hJMo7De/8wiqA9Rh5WGz9iQt0X/LGNAgjlb84tVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWrd++uo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWrd++uo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708965476; x=1740501476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=m7w5Gpo3wtQAimFYwtZl3AhKe8HHrKMXxttf1yYtPi8=;
  b=RWrd++uovJdJhErQgIlv2JAGhXcRgPHcl1zl992fvQD8UlJ31y5/RHkv
   4WKNMEMckfiD4ZVWYTXHHYvENsDVe2+6sPCStvUkQT3M+UiyX3Dg2zUyl
   H8EY7dTu5mncUdy5oQ3o6n4HdBdvprHUIEUfEpc0XStDj27xEArUt7lK1
   zbi7+UjYD3BG8zno9sHljvLcM+1gbWbeh0b2896NzEHzgK1J/mCnDKbuc
   6Sw18rxLr4+m+GV7d4GP2y7RQV5o9rMrULoY99mQP2ELbXUAq76xJ/Diq
   SEdcsZMFJRfZ6pc5RCoW/IPDIIKR6IGlXwrVY/+ab1K6OwJSoBxsOUO70
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="13902755"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="13902755"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:37:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="913881375"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="913881375"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:37:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1redzD-00000007ja8-3bo6;
	Mon, 26 Feb 2024 18:37:51 +0200
Date: Mon, 26 Feb 2024 18:37:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: VAMSHI GAJJELA <vamshigajjela@google.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_dw: Emit an error message if getting the
 baudclk failed
Message-ID: <Zdy-X37encfcr9g7@smile.fi.intel.com>
References: <20240222111922.2016122-2-u.kleine-koenig@pengutronix.de>
 <CAMTSyjrKVL12CrXuqJhWydObhYfgLF=zKTE0U0LdzimTT6Sdsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMTSyjrKVL12CrXuqJhWydObhYfgLF=zKTE0U0LdzimTT6Sdsw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 26, 2024 at 09:30:53PM +0530, VAMSHI GAJJELA wrote:
> On Thu, Feb 22, 2024 at 4:50 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:

...

> >         if (data->clk == NULL)
> >                 data->clk = devm_clk_get_optional_enabled(dev, NULL);
> >         if (IS_ERR(data->clk))
> > -               return PTR_ERR(data->clk);
> > +               return dev_err_probe(dev, PTR_ERR(data->clk),
> > +                                    "failed to get baudclk\n");
> 
> Not required IMO as the baudclk is optional,

It adds verbosity to the cases when it's defined, but for some reason
can't be retrieved.

> otherwise it might ask
> for a similar change at apb_pclk.

If you need so, yes. Send a patch.

> Could you please provide some insight into the circumstances that lead
> to encountering this error case?
> 
> Also the check is for IS_ERR(data->clk), data-clk could be NULL aswell.

Yes, and that's the case of everything is fine as the clock is optional.
Do you see any problem with that check?

> I see any error should be caught at the following line, provided no
> clock-frequency
> ```
> /* If no clock rate is defined, fail. */
> if (!p->uartclk)
>         return dev_err_probe(dev, -EINVAL, "clock rate not defined\n");
> ```

Not sure what you meant by this. Even if we ask for an optional clock,
the error condition still might happen with many other reasons besides
the absence of the clock.

-- 
With Best Regards,
Andy Shevchenko


