Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A05199E94;
	Fri,  4 Apr 2025 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762099; cv=none; b=n0OHwJsPoaL8mKnVY6Vi1p9TSytsJSIwJiV8WZu8C04bB/rFmhGYMbJfyO+2NAflhe4HBM0Yu+sGAk/0nnvUItcvMp9XxOYxoUSmnBSZjJp/juDVAuBzP8HpgkOkfHrB8pyR5q+1DZZuLZbBhKwMaBTCYZqIMYdUMnHHl6OL8XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762099; c=relaxed/simple;
	bh=+R5alz/hiVkEdro8zZ5Zd00elGcA9uY7RSHDpwPPN2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVSWwG6gIR0fqOfIIpq25MedGz9oRDEaUVHTbfG5nVvzR0uCi3rC/vXVwEJ/rM7AbklI6Vc8PsF+LK4QUV1btDe3+3qQrDaTp/tc/LyaOSlp9W1WMDpsRweCQuxCg4dlrbx6xdrr1YcEwe6fMTFkVdyXWViMkVN5KzbfozsLy8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kC2y0deB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kC2y0deB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743762097; x=1775298097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+R5alz/hiVkEdro8zZ5Zd00elGcA9uY7RSHDpwPPN2A=;
  b=kC2y0deBNLZfrAP7AEiaC9q/q036OzfsdULkhsmpoqYxICheAqvORydY
   e1sn2Du8YTVNJJk7yxhqTqF+c0z7irMjuX+Ke/OXk4YH52UFJZ63C2vdn
   4hrUUFIxFURCbWfEMCPIQZuNbm4mIZqPPus3yoRTMcS0mDo83skRnWm4F
   jjSY79uPdzPKYs5u+lUOVSVlEvhCwXCrC6kmoYHodYq8ulLy3xiQ0cmrL
   N3Krn3eEjjjYpvnV5aWKbtYKiv6YWcotBFE3z/phhNDvYdwds9FNienRf
   VaAOkMn1gwqCq2wQ7WquJ0YLCwm2V2vdB8v3X6RhgYrrB2kDiT3oeDdjI
   Q==;
X-CSE-ConnectionGUID: /ujJkdsUQCidjNNW07S3ig==
X-CSE-MsgGUID: NM15iKroQKSrosPfTdigOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="44446549"
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="44446549"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 03:21:36 -0700
X-CSE-ConnectionGUID: pdWTszeuQECRgaqdOhRD0Q==
X-CSE-MsgGUID: XAJ+m7HyQBqR/TLj8Y+JXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="128186092"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 03:21:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u0eB0-0000000965l-1tSV;
	Fri, 04 Apr 2025 13:21:30 +0300
Date: Fri, 4 Apr 2025 13:21:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	john.ogness@linutronix.de, pmladek@suse.com, arnd@arndb.de,
	namcao@linutronix.de, benjamin.larsson@genexis.eu,
	schnelle@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [External] Re: [PATCH] serial: 8250: fix panic due to PSLVERR
Message-ID: <Z--yqlI0cRnixWpy@smile.fi.intel.com>
References: <20250403090336.16643-1-cuiyunhui@bytedance.com>
 <Z-5yr2mFaDt8kxC-@smile.fi.intel.com>
 <Z-51629pjyiZUIVy@smile.fi.intel.com>
 <CAEEQ3w=xVNuSN-4tHx6ir-i+huN8m1JXgJz672=WHAVBqcP+TA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3w=xVNuSN-4tHx6ir-i+huN8m1JXgJz672=WHAVBqcP+TA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 04, 2025 at 10:31:25AM +0800, yunhui cui wrote:
> On Thu, Apr 3, 2025 at 7:50 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Apr 03, 2025 at 02:36:16PM +0300, Andy Shevchenko wrote:
> > > On Thu, Apr 03, 2025 at 05:03:36PM +0800, Yunhui Cui wrote:
> >
> > A couple of more questions here:
> > 1) what is the DW IP version and where did you get the PSLVERR_RESP_EN
> > parameter from?
> > 2) what is the setting of the UART_16550_COMPATIBLE parameter?
> 
> 1): Refer to: https://www.synopsys.com/dw/ipdir.php?c=DW_apb_uart

I don't understand this. I asked about version of the IP, I have datasheets
already for many of them, I can't find PSLVERR_RESP_EN there, that's why the
question.

> 2): data->uart_16550_compatible == 0

Thanks!

-- 
With Best Regards,
Andy Shevchenko


