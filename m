Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AA92AD33;
	Fri, 13 Sep 2024 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726252376; cv=none; b=DlwVgka8a1EFip4753eFtDFgjnU6T6fg4fkebGEeJUqQ3FCwjWisW5xt1YcD+VMLe4TBUaMq4ypySLX6isUJirsaR/crjbQ621c1fKKwuuh/HX6W78ymMFexh1hX1rf7aWCkuBX8oZWChlKmJmX4G1de/lmV+jApexS2ZofZHO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726252376; c=relaxed/simple;
	bh=znnVx+uRElVywTjUapcfKJ0/15Z+HLxKd6BG/S5a4M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzEp/JfJsBpCYQR/kq1eDoR86QipLKtaLNEKkgUwuZk9E0JeSAv1lG+/Tb2VleuuAqwMc0IFYbNME7fwBygOOffFx+OKxCprSFpwwhWepxFKS5et0EwxSUGVnOG+AH6jE2xm7U1zSavfNhi86j0OFA76rCAIzs0KyeFi3/zA8gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PAizeBNH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PAizeBNH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726252375; x=1757788375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=znnVx+uRElVywTjUapcfKJ0/15Z+HLxKd6BG/S5a4M0=;
  b=PAizeBNHTm7DjDdK+Xu7928v+WVrhQ/qhoKIXAiQAagiWt7xsdOkHhjw
   9GlTChwdQUo1w/lSxTNjC+QS6PeJZiniHi3HYIvY8bgV7UScjxqDmWac5
   uQhkNPmQAlsSKX7iDSXEGP1nnZJF7XP2sCPgp7fpP4pj3hRAkieT0mzXd
   h599+Bjypqd9poqub8YPhQ4rIiXvLZAkjeTRXplB/dO8pVHMoNlLJk00E
   a+j/lsLlXMRPx2eBNk6Q1Ya8lU5vOYKIHap3YK/Ns8yIYhbF+XFIyBGX9
   8DaGOgyd16zZ56Lrg1eeyZU6KqIxNPyuMH6RMcjHCkJf4y40lFWEsSKcc
   Q==;
X-CSE-ConnectionGUID: iwAKvfuzSxSWYpdVExIhFw==
X-CSE-MsgGUID: J+uDHX3bTtGm9shtwk/4nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25261411"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="25261411"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 11:32:54 -0700
X-CSE-ConnectionGUID: j+lir26ERx2OTTkmcaTa/A==
X-CSE-MsgGUID: z8VyUXDqS6y4Ie9aPyw45A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="72524838"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 11:32:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1spB69-00000008OIL-1yG8;
	Fri, 13 Sep 2024 21:32:49 +0300
Date: Fri, 13 Sep 2024 21:32:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 1/6] misc: eeprom: eeprom_93cx6: Add quirk for extra
 read clock cycle
Message-ID: <ZuSFUQPp0BdcFpx9@smile.fi.intel.com>
References: <cover.1726237379.git.pnewman@connecttech.com>
 <d0818651c4a58d0162a898c3ba3dd8abf9f95272.1726237379.git.pnewman@connecttech.com>
 <ZuR600QgWi6oQcau@smile.fi.intel.com>
 <20240913142420.675faf80@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913142420.675faf80@SWDEV2.connecttech.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 13, 2024 at 02:24:20PM -0400, Parker Newman wrote:
> On Fri, 13 Sep 2024 20:48:03 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Sep 13, 2024 at 10:55:38AM -0400, Parker Newman wrote:

...

> > > Link: https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-5193-SEEPROM-AT93C46D-Datasheet.pdf
> >
> > Make it a tag (i.e. locate just above your SoB tag)
> 
> Sorry, not 100% sure what you mean by tag? Do I just need to move the Link: entry
> to be above my Sign-off? Or is there something else? Thanks!

Make it like

  ...Summary...
  <blank line>
  ...commit message text...
  <blank line>
  Link: ...
  Signed-off-by: ...

...

> > > +	if (has_quirk_extra_read_cycle(eeprom)) {
> > > +		eeprom_93cx6_pulse_high(eeprom);
> >
> > No additional delay is needed?
> 
> Should not need any extra delay as both pulse high/low functions have the worst case
> 450ns delay after the register write. It was working well on my test cards.

OK!

> > > +		eeprom_93cx6_pulse_low(eeprom);
> > > +	}

-- 
With Best Regards,
Andy Shevchenko


