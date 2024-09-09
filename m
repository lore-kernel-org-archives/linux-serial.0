Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C03BDF58;
	Mon,  9 Sep 2024 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876407; cv=none; b=E2yJeVc8q9PPzR564O5+XL9ocqoMo+3iR+MVgUkcDrDvOBYZW65UmiVNjGTFpZBmQ4vXt1cLOupK8ejxHE98r4rTuHr9JIaA2VZry+OSGzRCd7MG1tz+rV3BBN4FCsZTnS/TvV1Xj7krLGdQONa0wFgAvw+BudkSG3hHue1d4AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876407; c=relaxed/simple;
	bh=71flhjDVi15j6UOFXaKc8Ug8/1DkA1yhZA8lN1pRABk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7QDmqILHHdpdD/mpSnaFVg5mLGcDjxOalH15LXquLDJ6yf8n6rd6CGsCJJW9oIvpVOjYF6XfO+vrgDknXfu/CfL77DNftaF2esUFPrXFxiryXv3dch2Tv2cwAV8ul37+Rb1iw6kjHndthTbBVnthuEQHsm87RQiWP3F2hepjHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=elzn9Bnp; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="elzn9Bnp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725876407; x=1757412407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=71flhjDVi15j6UOFXaKc8Ug8/1DkA1yhZA8lN1pRABk=;
  b=elzn9Bnp4oKODy3bOdSRuBAvTQ5Oim4T08RrKef8PtnceFSkr8tT+AQz
   umEytx3QLp4qYNLcP8FTtXwzt6YaskvgHZjypUiFbwKeoXLv2yCL6UEIG
   8houEhYJAB5pBTJX49BAt2BtLoWN5mFd7q/X3cKtlExEDBD1E48rh6RoD
   odR6PEQ1iut2A+dYa+nf88ArYAno8aKY+46uKI58DcDLUcTnn6rtGxo6w
   rIBVyxx69KBJblQ/H4wdbH18v+MkTIa3tOuqwYqMv3ZQ03KcUbC1thU2U
   OFYdkeCbPVFMI6rq8Jj3zCaBzOsA7Ul7WnshFGw5wAzQu9SqOr/kp/FsY
   A==;
X-CSE-ConnectionGUID: AV0NlsOxTi2/wHLCK7EWEg==
X-CSE-MsgGUID: m15bmGwHSFuyXHTS8Q4nsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24435282"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="24435282"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 03:06:46 -0700
X-CSE-ConnectionGUID: UF9e/8//TkSKuEGzC6bqNA==
X-CSE-MsgGUID: pqAg6/QyRTqrE4iOz+VBaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="67361508"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 03:06:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1snbI8-00000006kHj-43mW;
	Mon, 09 Sep 2024 13:06:40 +0300
Date: Mon, 9 Sep 2024 13:06:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 00/13] serial: 8250_exar: Clean up the driver
Message-ID: <Zt7IonZIYgBqjvy7@smile.fi.intel.com>
References: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
 <20240503143303.15bf82bc@SWDEV2.connecttech.local>
 <Ztr5u2wEt8VF1IdI@black.fi.intel.com>
 <20240906095141.021318c8@SWDEV2.connecttech.local>
 <ZtsQrFgH86AkKgPp@smile.fi.intel.com>
 <20240906103354.0bf5f3b7@SWDEV2.connecttech.local>
 <ZtsU0nfAFssevmmz@smile.fi.intel.com>
 <20240906143851.21c97ef9@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906143851.21c97ef9@SWDEV2.connecttech.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 06, 2024 at 02:38:51PM -0400, Parker Newman wrote:
> On Fri, 6 Sep 2024 17:42:26 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Sep 06, 2024 at 10:33:54AM -0400, Parker Newman wrote:
> > > On Fri, 6 Sep 2024 17:24:44 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, Sep 06, 2024 at 09:51:41AM -0400, Parker Newman wrote:
> > > > > On Fri, 6 Sep 2024 15:46:51 +0300
> > > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Fri, May 03, 2024 at 02:33:03PM -0400, Parker Newman wrote:

...

> > > > > > Sorry for blast from the past, but I have some instersting information
> > > > > > for you. We now have spi-gpio and 93c46 eeprom drivers available to be
> > > > > > used from others via software nodes, can you consider updating your code
> > > > > > to replace custom bitbanging along with r/w ops by the instantiating the
> > > > > > respective drivers?
> > > > >
> > > > > Hi Andy,
> > > > > The Exar UARTs don't actually use MPIO/GPIO for the EEPROM.
> > > > > They have a dedicated "EEPROM interface" which is accessed by the
> > > > > REGB (0x8E) register. It is a very simple bit-bang interface though,
> > > > > one bit per signal.
> > > > >
> > > > > I guess in theory I could either add  GPIO wrapper to toggle these bits
> > > > > and use the spi-gpio driver but I am not sure if that really improves things?
> > > > > Maybe using the spi-bitbang driver directly is more appropriate?
> > > > > What do you think?
> > > >
> > > > Yes, spi-bitbang seems better in this case.
> > >
> > > I will try to make some time to implement this... Or if someone else from the
> > > community wants to take this on in the mean time I am certainly happy to test
> > > and help out!
> >
> > Sure, I shared this thought due to having lack of time to look myself,
> > but I prepared the above mentioned drivers to make them work in this case.
> > (If you are curios, see the Git history for the last few releases with
> >  --author="Andy Shevchenko")
> >
> 
> Looking into it a bit more I think we could just use the eeprom_93cx6
> driver without any SPI layer. Just need to add simple register_read()
> and register_write() functions to read/write the REB register.
> 
> That should be a pretty easy change to make, I can try to make that
> change soon unless anyone has any objections to that method?

Thank you, this is pretty wonderful news!

-- 
With Best Regards,
Andy Shevchenko


