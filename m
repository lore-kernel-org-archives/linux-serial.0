Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01501156880;
	Fri,  6 Sep 2024 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633753; cv=none; b=KzM7vm6f9tV5bMP/3bri5v7bEgmC93MA1OoL2y2U/IKwnKHbnWPGg1eO4/e7clTRNNAUaxQo9nim3c5DnmDKjRC0vr7MWtjBJZVXH1LE40u/F9JytSinonmsbNzn6ssBrJcP5BCAMz9/Zm8Q7vZyPqepYkwqUhIOu2F4Uetj2EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633753; c=relaxed/simple;
	bh=E/O01DYIOb9W9GaxJ+Y+3+N4ZJwxnWvEDblOXl2trIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkMXT3pCZg/TIGHon+4Cfp4ea0/UeY9IKwLzv/tspmRPKIRxXYRo6MuGeIiFqvC+CfOQ0KOClELSlNPimcr8GAzD6Agze0YHK3EMPgAGp1koE4Du3wxF13lZAJoSOky6oQ2JP9i2ex78Im5G9NmM6vPNTTDuMx6Rn/A+QuH28To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DUesnVBa; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUesnVBa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725633752; x=1757169752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E/O01DYIOb9W9GaxJ+Y+3+N4ZJwxnWvEDblOXl2trIQ=;
  b=DUesnVBapj+HxkVE9yFmtSjkTDb7CK4rgNDPaa/sMN5o4qEV2lcsfgrd
   t2THZcJCf5I/q2Ls1CZH9rbW+3RBuA72UwwOvbZZFI2LaxIM+2sz3GL15
   BdnnaYRnDsmpyq3NYmbAjosyNuMvwH+bK01NaGwL/pfO0TjcMFTZ4UHX8
   VK5jWEbzqkfmSAOtG1KCqLERKAqBgyC7flUL24EJBo8emLkxjAmSewPxe
   qM6VafO79QGdMch0b8rX43e5zeqAe3lNVlWEow1QBwY/2suSJyVFAlLwl
   EReXW24HwvGy6ypG1BCDrACnarYnKXF/vg5kPzcgCA9i3qdjMigpeq2oU
   w==;
X-CSE-ConnectionGUID: 3ZlC6zpsQaSrSuQU2w85ig==
X-CSE-MsgGUID: gmTkuDYNSeCOjqRCJmHuHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="24195842"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="24195842"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 07:42:31 -0700
X-CSE-ConnectionGUID: +TavGMlyQtOrLMLAOCTpuQ==
X-CSE-MsgGUID: 5eJj58oKRe2mkcdKtxrYng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="65787484"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 07:42:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1smaAN-00000005pdW-0nay;
	Fri, 06 Sep 2024 17:42:27 +0300
Date: Fri, 6 Sep 2024 17:42:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 00/13] serial: 8250_exar: Clean up the driver
Message-ID: <ZtsU0nfAFssevmmz@smile.fi.intel.com>
References: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
 <20240503143303.15bf82bc@SWDEV2.connecttech.local>
 <Ztr5u2wEt8VF1IdI@black.fi.intel.com>
 <20240906095141.021318c8@SWDEV2.connecttech.local>
 <ZtsQrFgH86AkKgPp@smile.fi.intel.com>
 <20240906103354.0bf5f3b7@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906103354.0bf5f3b7@SWDEV2.connecttech.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 06, 2024 at 10:33:54AM -0400, Parker Newman wrote:
> On Fri, 6 Sep 2024 17:24:44 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Sep 06, 2024 at 09:51:41AM -0400, Parker Newman wrote:
> > > On Fri, 6 Sep 2024 15:46:51 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, May 03, 2024 at 02:33:03PM -0400, Parker Newman wrote:

...

> > > > Sorry for blast from the past, but I have some instersting information
> > > > for you. We now have spi-gpio and 93c46 eeprom drivers available to be
> > > > used from others via software nodes, can you consider updating your code
> > > > to replace custom bitbanging along with r/w ops by the instantiating the
> > > > respective drivers?
> > >
> > > Hi Andy,
> > > The Exar UARTs don't actually use MPIO/GPIO for the EEPROM.
> > > They have a dedicated "EEPROM interface" which is accessed by the
> > > REGB (0x8E) register. It is a very simple bit-bang interface though,
> > > one bit per signal.
> > >
> > > I guess in theory I could either add  GPIO wrapper to toggle these bits
> > > and use the spi-gpio driver but I am not sure if that really improves things?
> > > Maybe using the spi-bitbang driver directly is more appropriate?
> > > What do you think?
> >
> > Yes, spi-bitbang seems better in this case.
> 
> I will try to make some time to implement this... Or if someone else from the
> community wants to take this on in the mean time I am certainly happy to test
> and help out!

Sure, I shared this thought due to having lack of time to look myself,
but I prepared the above mentioned drivers to make them work in this case.
(If you are curios, see the Git history for the last few releases with
 --author="Andy Shevchenko")

-- 
With Best Regards,
Andy Shevchenko


