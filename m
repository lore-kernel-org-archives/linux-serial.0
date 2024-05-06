Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78781419A0;
	Mon,  6 May 2024 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714984656; cv=none; b=W1RC5Y0FCAh6WNcHOYyxndDurAgw6m1LZNcD0Msb1QCtaK/lTZNdnziXXjrNYdfbBrgQxnr7e9q+Uy+Y6zkjFoBC8QUw/VX9/uW4SYpYY7hneKKNqfMxErJA6Rb7tHgCfb7lg2hZFG1P8mudDdq513YlUk2DQbxyPzwJt8Vvm2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714984656; c=relaxed/simple;
	bh=wR7EtXhi0Bboa1M9frBGq1z8wCZ0rEmjQBLC5qtConE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJwppu00RSfKLbB/bgrl3iiuAcLYswa/7odB5syPKjdfF42C9Jxaqq7xJKeMI1+CBcR3o2fi75f5lLTkAtgMZNH5VF7e9+LYg18mTBzg8rJapc/m9hin+DqDAYZYweCAotlEE7zMUJd87w1x/6znyla3Uq2d6epZCOiSPQBdaFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kI3S8JnZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kI3S8JnZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714984655; x=1746520655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wR7EtXhi0Bboa1M9frBGq1z8wCZ0rEmjQBLC5qtConE=;
  b=kI3S8JnZqL0wPUOLYu8Yy2e+mMtl3MIBAsl/kFrL0KwKkdLQxnXlCgKr
   V2pGY/iL1CLWN7wPNvbJuQ9y5uuS2Dg7b6n0zdn1ul0VkE2eaegHPDVHW
   I1Wj88gVhHLWUJ8czwuy0G5BYBJK7my59XVg2fuw1KgSWfa0J4BLjxamX
   TrMwHWz24kILCxfIctr9x5HEx1SVO4GPTgVIceF2bP7KTAlwCWP0mJVOh
   TpvwlEf1b2aiPe/qKhc1pbkc6XKGbCFDy4Ub6lrRjPMKgRTbGh6rTm6Fl
   ZKCQMvK+IXIvTk5pC3dSrx7LiU1ygHlFYMbKVZOGvyJ9lZsft325qyNBD
   w==;
X-CSE-ConnectionGUID: ndYnzye3TsurRZ+Wl+3TQg==
X-CSE-MsgGUID: QH/LEyJkTv6nmlwQFa2TDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="13665164"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="13665164"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 01:37:34 -0700
X-CSE-ConnectionGUID: caXQkTNsR+ilWcZ6yPxNtg==
X-CSE-MsgGUID: stXDMFGwQWKBRYRo23VYrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="28049190"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 01:37:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s3tqj-00000004bxR-2veA;
	Mon, 06 May 2024 11:37:29 +0300
Date: Mon, 6 May 2024 11:37:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Parker Newman <pnewman@connecttech.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 11/13] serial: 8250_exar: Use BIT() in exar_ee_read()
Message-ID: <ZjiWyYlfd7NdevFq@smile.fi.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
 <20240502144626.2716994-12-andriy.shevchenko@linux.intel.com>
 <702a9145-5bc1-c765-a1fa-278702741637@linux.intel.com>
 <ZjPLQeTEKvt7B3mj@smile.fi.intel.com>
 <20240503102632.112a34bd@SWDEV2.connecttech.local>
 <ZjUEURneUmZ4nmbC@smile.fi.intel.com>
 <20240503145633.1ad55378@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240503145633.1ad55378@SWDEV2.connecttech.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 03, 2024 at 02:56:33PM -0400, Parker Newman wrote:
> On Fri, 3 May 2024 18:35:45 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, May 03, 2024 at 10:26:32AM -0400, Parker Newman wrote:
> > > On Thu, 2 May 2024 20:20:01 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> > > > On Thu, May 02, 2024 at 07:08:21PM +0300, Ilpo Järvinen wrote:  
> > > > > On Thu, 2 May 2024, Andy Shevchenko wrote:    

...

> > > > > >  	// Send address to read from
> > > > > > -	for (i = 1 << (UART_EXAR_REGB_EE_ADDR_SIZE - 1); i; i >>= 1)
> > > > > > -		exar_ee_write_bit(priv, (ee_addr & i));
> > > > > > +	for (i = UART_EXAR_REGB_EE_ADDR_SIZE - 1; i >= 0; i--)
> > > > > > +		exar_ee_write_bit(priv, ee_addr & BIT(i));
> > > > > >  
> > > > > >  	// Read data 1 bit at a time
> > > > > >  	for (i = 0; i <= UART_EXAR_REGB_EE_DATA_SIZE; i++) {
> > > > > > -		data <<= 1;
> > > > > > -		data |= exar_ee_read_bit(priv);
> > > > > > +		if (exar_ee_read_bit(priv))
> > > > > > +			data |= BIT(i);    
> > > > > 
> > > > > Does this end up reversing the order of bits? In the original, data was left
> > > > > shifted which moved the existing bits and added the lsb but the replacement
> > > > > adds highest bit on each iteration?    
> > > > 
> > > > Oh, seems a good catch!
> > > > 
> > > > I was also wondering, but missed this somehow. Seems the EEPROM is in BE mode,
> > > > so two loops has to be aligned.
> > > >   
> > > 
> > > I just tested this and Ilpo is correct, the read loop portion is backwards as 
> > > expected. This is the corrected loop:
> > > 
> > >     // Read data 1 bit at a time
> > >     for (i = UART_EXAR_REGB_EE_DATA_SIZE; i >= 0; i--) {
> > >         if (exar_ee_read_bit(priv))
> > >             data |= BIT(i);
> > >     }
> > > 
> > > I know this looks wrong because its looping from 16->0 rather than the 
> > > more intuitive 15->0 for a 16bit value. This is actually correct however 
> > > because according to the AT93C46D datasheet there is always dummy 0 bit
> > > before the actual 16 bits of data.
> > > 
> > > I hope that helps,  
> > 
> > Yes, it helps and means that we need that comment to be added to the code. Is
> > it the same applicable to the write part above (for address)? Because AFAIU
> > mine is one bit longer than yours. Maybe in the original code is a bug? Have
> > you tried to read high addresses?
> 
> The address portion is 6 bits, nothing extra, so what you have is correct.
> 
> The original code was legacy, I cleaned it up but didn't change those loops. 
> 
> Your method works out the the same number of bits as the legacy method
> which sets bit 5 and has to shift right 6 times to get i = 0 which ends the loop.

Okay, thank your for confirming the correctness of a new code!

-- 
With Best Regards,
Andy Shevchenko


