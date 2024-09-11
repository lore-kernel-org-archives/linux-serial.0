Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F357813C9D9;
	Wed, 11 Sep 2024 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087876; cv=none; b=P3G68M49AkDf986+5uMtvWKYlgPNbrgBkFtvnAJDc3FOukO0jDILq8ec3RE9XF/7T4bZUKCqw+YC8h4MSqjx40KZAZtEjIFr9yRzOCy3KStB3AZaorLH4/c2Tv1WoB/kdceNTgyYmC7xlPMDEhTjQF5cU7YjrdLqI5Rrj8Qzv4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087876; c=relaxed/simple;
	bh=IP8lI/rrAeh2EHOlKZ1+1zFyQWdnSzxjXXK+KAZU1O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoIfRVNOpG3ImOD1FOGoK4Psxiut5Ow020Z7IzPivju7jyVAN5sJ+ugVDnNKJidcBfjNzxKX1Aw0RbhA2d0sJFtsQijBLK7Iu6r6lJC+npvDMkLU1Pwj4Gd1U7EVNMBh9KFgA83HoHcCcxwvkkm5jrX8cjslQCoo0Ga+rKsxupc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XAO0s1ms; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XAO0s1ms"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726087875; x=1757623875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IP8lI/rrAeh2EHOlKZ1+1zFyQWdnSzxjXXK+KAZU1O4=;
  b=XAO0s1msAgyqoGF2OXUkhXUfJ40imSIwqieXnyqX7ngu3ZooKovRU5F6
   Ar5KInyBk7B0cSQ+eyvPrlKfhwSq70k3SjFBs/8vk5I7qmJ2EIjHF9b0G
   0EShGicTOTOpIFYaPTG7S4JrD8Gn5VvbTucRvGoHFf80++hnEwtK5NVlj
   IiQh+Ftjw5Lt+WHrup2oU62OlkQsiOqXZDeCc34PHEnb2OtAk86/VYCaE
   SMb1oH9+8befnki7mFK2htFmrFi8q8swqfuC3saHZMSmHMl0AV/Z6c3ho
   aqb98DqEitnePlRbcskHY/TBUV2As+OLPfqW3BXSLtTpKNhEaiAgF5kN4
   g==;
X-CSE-ConnectionGUID: kgHy/i7yQDmtS1ehdFxJVA==
X-CSE-MsgGUID: Y5C0fV0PSVCFIdl0Ebw4hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="42388243"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="42388243"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 13:51:14 -0700
X-CSE-ConnectionGUID: KtGL8BexT72upTZUnjIZ2Q==
X-CSE-MsgGUID: WYFxQdR7R06EEI/Grtd6FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="68264385"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 13:51:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1soUIw-00000007iXa-0ZGg;
	Wed, 11 Sep 2024 23:51:10 +0300
Date: Wed, 11 Sep 2024 23:51:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 00/13] serial: 8250_exar: Clean up the driver
Message-ID: <ZuICvRjM4TqozL_X@smile.fi.intel.com>
References: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
 <20240503143303.15bf82bc@SWDEV2.connecttech.local>
 <Ztr5u2wEt8VF1IdI@black.fi.intel.com>
 <20240906095141.021318c8@SWDEV2.connecttech.local>
 <ZtsQrFgH86AkKgPp@smile.fi.intel.com>
 <20240906103354.0bf5f3b7@SWDEV2.connecttech.local>
 <ZtsU0nfAFssevmmz@smile.fi.intel.com>
 <20240906143851.21c97ef9@SWDEV2.connecttech.local>
 <Zt7IonZIYgBqjvy7@smile.fi.intel.com>
 <20240911133848.2cbb1834@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911133848.2cbb1834@SWDEV2.connecttech.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Sep 11, 2024 at 01:38:48PM -0400, Parker Newman wrote:
> On Mon, 9 Sep 2024 13:06:26 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Sep 06, 2024 at 02:38:51PM -0400, Parker Newman wrote:
> > > On Fri, 6 Sep 2024 17:42:26 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, Sep 06, 2024 at 10:33:54AM -0400, Parker Newman wrote:
> > > > > On Fri, 6 Sep 2024 17:24:44 +0300
> > > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Fri, Sep 06, 2024 at 09:51:41AM -0400, Parker Newman wrote:
> > > > > > > On Fri, 6 Sep 2024 15:46:51 +0300
> > > > > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > On Fri, May 03, 2024 at 02:33:03PM -0400, Parker Newman wrote:

...

> > > > > > > > Sorry for blast from the past, but I have some instersting information
> > > > > > > > for you. We now have spi-gpio and 93c46 eeprom drivers available to be
> > > > > > > > used from others via software nodes, can you consider updating your code
> > > > > > > > to replace custom bitbanging along with r/w ops by the instantiating the
> > > > > > > > respective drivers?
> > > > > > >
> > > > > > > Hi Andy,
> > > > > > > The Exar UARTs don't actually use MPIO/GPIO for the EEPROM.
> > > > > > > They have a dedicated "EEPROM interface" which is accessed by the
> > > > > > > REGB (0x8E) register. It is a very simple bit-bang interface though,
> > > > > > > one bit per signal.
> > > > > > >
> > > > > > > I guess in theory I could either add  GPIO wrapper to toggle these bits
> > > > > > > and use the spi-gpio driver but I am not sure if that really improves things?
> > > > > > > Maybe using the spi-bitbang driver directly is more appropriate?
> > > > > > > What do you think?
> > > > > >
> > > > > > Yes, spi-bitbang seems better in this case.
> > > > >
> > > > > I will try to make some time to implement this... Or if someone else from the
> > > > > community wants to take this on in the mean time I am certainly happy to test
> > > > > and help out!
> > > >
> > > > Sure, I shared this thought due to having lack of time to look myself,
> > > > but I prepared the above mentioned drivers to make them work in this case.
> > > > (If you are curios, see the Git history for the last few releases with
> > > >  --author="Andy Shevchenko")
> > > >
> > >
> > > Looking into it a bit more I think we could just use the eeprom_93cx6
> > > driver without any SPI layer. Just need to add simple register_read()
> > > and register_write() functions to read/write the REB register.
> > >
> > > That should be a pretty easy change to make, I can try to make that
> > > change soon unless anyone has any objections to that method?
> >
> > Thank you, this is pretty wonderful news!
> >
> 
> I have this mostly working however there is one issue. The eeprom_93cx6
> driver doesn't seem to discard the "dummy bit" the 93C46 EEPROM outputs
> between the writing of the op-code/address to the EEPROM and the reading
> of the data from the EEPROM.
> 
> More info can be found on page 6 of the AT93C46 datasheet. I see similar
> notes in other 93C46/93C56/93C66 datasheets.
> Link: https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-5193-SEEPROM-AT93C46D-Datasheet.pdf
> 
> In summary the read operation for the AT93C46 EEPROM is:
> Write to EEPROM :	110[A5-A0]	(9 bits)
> Read from EEPROM: 	0[D15-D0]	(17 bits)
> 
> Where 110 is the READ OpCode, [A5-A0] is the address to read from,
> 0 is a "dummy bit" and then [D15-D0] is the actual data.
> 
> I am seeing the "correct" values being read from the EEPROM when using the
> eeprom_93cx6 driver but they are all shifted right by one because the
> dummy 0 bit is not being discarded.
> 
> The confusing part is the eeprom_93cx6 driver has behaved the same since
> at least 2009 and half a dozen or so other drivers use it. I am not sure
> if they just work around and/or live with this bug or if they have
> different HW that handles the extra dummy bit?

I briefly looked at a few users and it seems to me:
1) either the Atmel chip has different HW protocol;
2) or all of them handle that in HW transparently to SW.

> I am hesitant to "fix" the eeprom_93cx6 driver and potentially break the
> other users of it. I could add a flag to the eeprom_93cx6 struct to work
> around this issue... Unless anyone else has some ideas or input?

In my opinion the 93c46 needs an additional configuration setting (in the
respective data structure) and some code to implement what you need here.

But yes, let's wait a bit for other opinions...

-- 
With Best Regards,
Andy Shevchenko


