Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2757E1D1F4C;
	Fri,  6 Sep 2024 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632691; cv=none; b=MjJ3fS+LnlJRpDWcbr/wN4Pq6dWeu+bmTV/yLbUi1fztovLZCKw+D4JYyNb4JUnudqkifPxEMjydzIGjUQ0sK+bGagq4gN2wXM94T0bEZr2FN5BLYb5FDI/oijCQuxqqkOUV7dKe6kReQMN0qjZP2/NX2j3LiEC9k0ZmZDf5rTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632691; c=relaxed/simple;
	bh=qHBHB2kdrNFDSiFJgTc2SnouAy6yPXOIwzYtL6xR0lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npUvs3OUHdrN3Zv8eY2bcmVqLc86o4+MhJG2k2HTB2Z9PctUmCnlt1tw27eNvEnQozGT1z1oqqY+8J8fZA0G7PlKbwyi64L6gCAzRZAA2UyJF+mUvQ2KvU6z1zQVk99U6zkmaFYEt3V5C2FYwn2wNh+N452EpWHDDISoU/zfgYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqJCXL2A; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqJCXL2A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725632690; x=1757168690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qHBHB2kdrNFDSiFJgTc2SnouAy6yPXOIwzYtL6xR0lw=;
  b=hqJCXL2AL2hsyMjqLIAFhuZCxHWFbfjbOUpeJh6Uu28ck2lGtnFUac0m
   XlcI7FNdzxsRecwOgZx7Iz6BMrVi046KlMzPoxVKSxtHHUzBiASiehTvr
   tHPCFAkJPHdmM+h7b5qUB1VQkVo69HL2Am6V75kf2P9JMf0Nk08RDskwJ
   cCs2d35egeWZG8Junx8jGIPXXDBuOABZeQV2RNFKEvzkbtAGJq7P24ybs
   XHInSj7ZQmjqv0TNWkeGv0CIpX50FTn8rBCVKpn28fCChguZG1DvEBIM4
   DOn21EbFbvR7oW8pfr9yltFOfWsEPOCgqgFMcWbqP8GAJGDHdjN7INBh/
   A==;
X-CSE-ConnectionGUID: tKOtkQqeR/OC2OXfIBeVMQ==
X-CSE-MsgGUID: KGNzHPUrTECS9xGGuEIqGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="35778570"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="35778570"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 07:24:49 -0700
X-CSE-ConnectionGUID: f8pegL7PQz6Jb13k4USfxg==
X-CSE-MsgGUID: ObgZyOa6SPurGhtR4M+cAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="70771114"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 07:24:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1smZtF-00000005pGm-0Clu;
	Fri, 06 Sep 2024 17:24:45 +0300
Date: Fri, 6 Sep 2024 17:24:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 00/13] serial: 8250_exar: Clean up the driver
Message-ID: <ZtsQrFgH86AkKgPp@smile.fi.intel.com>
References: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
 <20240503143303.15bf82bc@SWDEV2.connecttech.local>
 <Ztr5u2wEt8VF1IdI@black.fi.intel.com>
 <20240906095141.021318c8@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906095141.021318c8@SWDEV2.connecttech.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 06, 2024 at 09:51:41AM -0400, Parker Newman wrote:
> On Fri, 6 Sep 2024 15:46:51 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, May 03, 2024 at 02:33:03PM -0400, Parker Newman wrote:
> > > On Fri,  3 May 2024 20:15:52 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > > After a rework for CONNTECH was done, the driver may need a bit of
> > > > love in order to become less verbose (in terms of indentation and
> > > > code duplication) and hence easier to read.
> > > >
> > > > This clean up series fixes a couple of (not so critical) issues and
> > > > cleans up the recently added code. No functional change indented by
> > > > the cleaning up part.
> > > >
> > > > Parker, please test this and give your formal Tested-by tag
> > > > (you may do it by replying to this message if all patches are
> > > >  successfully tested; more details about tags are available in
> > > >  the Submitting Patches documentation).
> > >
> > > I was able to test the Connect Tech related code and everything is
> > > work as expected. I can't test the non-CTI related changes but they
> > > are pretty minor.
> > >
> > > Tested-by: Parker Newman <pnewman@connecttech.com>
> >
> > Sorry for blast from the past, but I have some instersting information
> > for you. We now have spi-gpio and 93c46 eeprom drivers available to be
> > used from others via software nodes, can you consider updating your code
> > to replace custom bitbanging along with r/w ops by the instantiating the
> > respective drivers?
> 
> Hi Andy,
> The Exar UARTs don't actually use MPIO/GPIO for the EEPROM.
> They have a dedicated "EEPROM interface" which is accessed by the
> REGB (0x8E) register. It is a very simple bit-bang interface though,
> one bit per signal.
> 
> I guess in theory I could either add  GPIO wrapper to toggle these bits
> and use the spi-gpio driver but I am not sure if that really improves things?
> Maybe using the spi-bitbang driver directly is more appropriate?
> What do you think?

Yes, spi-bitbang seems better in this case.

-- 
With Best Regards,
Andy Shevchenko


