Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA26175D45;
	Fri, 13 Sep 2024 09:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726220268; cv=none; b=MOXdELJRLe+CH4YW2opgIj+q3TkRRhLie1aXxHyxp1GvQIojjrOmy5aO2Hhv3qPTmL9rEWHbmjOd5WaiS972+XRkgZTfOGOLW7hwXOTt4v2lf0q9PzSmgIQYkaoQmTdoJlGsmvVozlNu3gTVDQ3GTGRwmG+fmhPGTjYLSwVK5Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726220268; c=relaxed/simple;
	bh=zsaRI26ytatIl70DSoQ1SIaz3geJQP4pX3Z6fCVcIlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2BhnjLYaQ6/uqMSgKTYAw/mMbiS0OnEwGWry0p1QI4JW41PljOqOS72yryH2vAT1FkgzhXkPCbaJpSJa2cPnibG0bMjZsFMoXK39hdhwmUbJWHxLJoTiCLkCaraP0HLpxTdimJ/aj52uHgUhpFR8FfF7tEyshbF1b/F+iJVe0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQyaq9yA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQyaq9yA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726220267; x=1757756267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zsaRI26ytatIl70DSoQ1SIaz3geJQP4pX3Z6fCVcIlo=;
  b=mQyaq9yAH9sTyzuMYqMZ6lMS+TTJkWJ53kDlg4V5Rc9CPNat/o8sVGnO
   0TcAGaJGy1b8E+2arl2waGaXSWRzYVHbLPlIo50s3HdOFs+3Xb6GtMXLe
   lhLqkQBggEv/OIxjTSRKenxBgyh3GB2FnJOPeKZTufscjVX+y0VbBVMF9
   uAcPeKogzbheiPCeHsLDlfjKRYtrl6bQQmrJdD8grdIUsVjual9+zRumu
   GnZTknqhN8dlgcy5/V88Mc3RcARmdoEuiAq+6+J1TYSzSmkwIjsyiJ1E7
   OM0e4RuOLQ/KTXKGvbfJoWBR3yAAg2IbwOgq0B6c2sODRzJ2qJ4PW8chh
   A==;
X-CSE-ConnectionGUID: G4m1kXgKStanwRglD4aM0g==
X-CSE-MsgGUID: zZt8FIE+QauFEikiAZUbHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24603626"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="24603626"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:37:46 -0700
X-CSE-ConnectionGUID: Ll7xJsJrRGSI2gxiDKPhcA==
X-CSE-MsgGUID: ERESeP6sQe+GV/zsyKycKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="98814015"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:37:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sp2k7-00000008FHq-1GBi;
	Fri, 13 Sep 2024 12:37:31 +0300
Date: Fri, 13 Sep 2024 12:37:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 00/13] serial: 8250_exar: Clean up the driver
Message-ID: <ZuQH27ViT84wXKK3@smile.fi.intel.com>
References: <Ztr5u2wEt8VF1IdI@black.fi.intel.com>
 <20240906095141.021318c8@SWDEV2.connecttech.local>
 <ZtsQrFgH86AkKgPp@smile.fi.intel.com>
 <20240906103354.0bf5f3b7@SWDEV2.connecttech.local>
 <ZtsU0nfAFssevmmz@smile.fi.intel.com>
 <20240906143851.21c97ef9@SWDEV2.connecttech.local>
 <Zt7IonZIYgBqjvy7@smile.fi.intel.com>
 <20240911133848.2cbb1834@SWDEV2.connecttech.local>
 <ZuICvRjM4TqozL_X@smile.fi.intel.com>
 <20240912084147.6af5ac12@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912084147.6af5ac12@SWDEV2.connecttech.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 12, 2024 at 08:41:47AM -0400, Parker Newman wrote:
> On Wed, 11 Sep 2024 23:51:09 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Sep 11, 2024 at 01:38:48PM -0400, Parker Newman wrote:
> > > On Mon, 9 Sep 2024 13:06:26 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, Sep 06, 2024 at 02:38:51PM -0400, Parker Newman wrote:
> > > > > On Fri, 6 Sep 2024 17:42:26 +0300
> > > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Fri, Sep 06, 2024 at 10:33:54AM -0400, Parker Newman wrote:
> > > > > > > On Fri, 6 Sep 2024 17:24:44 +0300
> > > > > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > On Fri, Sep 06, 2024 at 09:51:41AM -0400, Parker Newman wrote:
> > > > > > > > > On Fri, 6 Sep 2024 15:46:51 +0300
> > > > > > > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > > > On Fri, May 03, 2024 at 02:33:03PM -0400, Parker Newman wrote:

...

> > > > > > > > > > Sorry for blast from the past, but I have some instersting information
> > > > > > > > > > for you. We now have spi-gpio and 93c46 eeprom drivers available to be
> > > > > > > > > > used from others via software nodes, can you consider updating your code
> > > > > > > > > > to replace custom bitbanging along with r/w ops by the instantiating the
> > > > > > > > > > respective drivers?
> > > > > > > > >
> > > > > > > > > Hi Andy,
> > > > > > > > > The Exar UARTs don't actually use MPIO/GPIO for the EEPROM.
> > > > > > > > > They have a dedicated "EEPROM interface" which is accessed by the
> > > > > > > > > REGB (0x8E) register. It is a very simple bit-bang interface though,
> > > > > > > > > one bit per signal.
> > > > > > > > >
> > > > > > > > > I guess in theory I could either add  GPIO wrapper to toggle these bits
> > > > > > > > > and use the spi-gpio driver but I am not sure if that really improves things?
> > > > > > > > > Maybe using the spi-bitbang driver directly is more appropriate?
> > > > > > > > > What do you think?
> > > > > > > >
> > > > > > > > Yes, spi-bitbang seems better in this case.
> > > > > > >
> > > > > > > I will try to make some time to implement this... Or if someone else from the
> > > > > > > community wants to take this on in the mean time I am certainly happy to test
> > > > > > > and help out!
> > > > > >
> > > > > > Sure, I shared this thought due to having lack of time to look myself,
> > > > > > but I prepared the above mentioned drivers to make them work in this case.
> > > > > > (If you are curios, see the Git history for the last few releases with
> > > > > >  --author="Andy Shevchenko")
> > > > > >
> > > > >
> > > > > Looking into it a bit more I think we could just use the eeprom_93cx6
> > > > > driver without any SPI layer. Just need to add simple register_read()
> > > > > and register_write() functions to read/write the REB register.
> > > > >
> > > > > That should be a pretty easy change to make, I can try to make that
> > > > > change soon unless anyone has any objections to that method?
> > > >
> > > > Thank you, this is pretty wonderful news!
> > > >
> > >
> > > I have this mostly working however there is one issue. The eeprom_93cx6
> > > driver doesn't seem to discard the "dummy bit" the 93C46 EEPROM outputs
> > > between the writing of the op-code/address to the EEPROM and the reading
> > > of the data from the EEPROM.
> > >
> > > More info can be found on page 6 of the AT93C46 datasheet. I see similar
> > > notes in other 93C46/93C56/93C66 datasheets.
> > > Link: https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-5193-SEEPROM-AT93C46D-Datasheet.pdf
> > >
> > > In summary the read operation for the AT93C46 EEPROM is:
> > > Write to EEPROM :	110[A5-A0]	(9 bits)
> > > Read from EEPROM: 	0[D15-D0]	(17 bits)
> > >
> > > Where 110 is the READ OpCode, [A5-A0] is the address to read from,
> > > 0 is a "dummy bit" and then [D15-D0] is the actual data.
> > >
> > > I am seeing the "correct" values being read from the EEPROM when using the
> > > eeprom_93cx6 driver but they are all shifted right by one because the
> > > dummy 0 bit is not being discarded.
> > >
> > > The confusing part is the eeprom_93cx6 driver has behaved the same since
> > > at least 2009 and half a dozen or so other drivers use it. I am not sure
> > > if they just work around and/or live with this bug or if they have
> > > different HW that handles the extra dummy bit?
> >
> > I briefly looked at a few users and it seems to me:
> > 1) either the Atmel chip has different HW protocol;
> > 2) or all of them handle that in HW transparently to SW.
> 
> The 3 Exar cards I have handy actually use the ST M93C46 version but looking
> through our BOMs I see AT/CAT/ST used on various cards over the years.
> 
> Looking at the READ timing diagrams in the Atmel and ST datasheets it looks
> like the dummy bit should actually be clocked out on the last address bit
> clock cycle. If this were so it would be ignored naturally.
> 
> This may just be a quirk of the Exar HW. All Exar code I have looked at
> manually discards the dummy bit.
> 
> > > I am hesitant to "fix" the eeprom_93cx6 driver and potentially break the
> > > other users of it. I could add a flag to the eeprom_93cx6 struct to work
> > > around this issue... Unless anyone else has some ideas or input?
> >
> > In my opinion the 93c46 needs an additional configuration setting (in the
> > respective data structure) and some code to implement what you need here.
> 
> I see the eeprom_93xx46 driver has the QUIRK_EXTRA_READ_CYCLE quirk to solve
> this issue. I could add something similar.

Seems like a good plan to me, and thanks again for looking into this!

> > But yes, let's wait a bit for other opinions...

-- 
With Best Regards,
Andy Shevchenko


