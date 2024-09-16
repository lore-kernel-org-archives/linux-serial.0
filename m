Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99AC1581F2;
	Mon, 16 Sep 2024 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726500455; cv=none; b=NEDcojTtvxYjUnCMleakpIB67jyZyU+M3nL/Amob2co6CO1itgEBcpQWXm6+jTgifqf13q8v5fOh6ZCEpo6EkXWwYxWV/OpKuFRgzCmyCLPLSBrFsbhXN7Kw3mAGyYQy/na62YqGOMyvR35iuKzPmRp4D7hgHpJjghdx26lrjzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726500455; c=relaxed/simple;
	bh=ybn60viRg3GivcawU0AcW2NTeCsVAOOgH7XfXF/QLs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkDIzGM2ixwBX34ZVdB3UIWnFcvT2wJczt4LiSkMMEAF7+snmzO2mChpYtYJXVTsvmi1lL78VQms4iMXiQwp28Nb4leHBCCxEREMhSjxC3mJntAhTVQTpJhMhVcMZ7Uq0SBRgZpc0u4XvPTEh3utEK6gqLID2a9Zd+LBeRB06U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QcMBgl88; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcMBgl88"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726500454; x=1758036454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ybn60viRg3GivcawU0AcW2NTeCsVAOOgH7XfXF/QLs4=;
  b=QcMBgl88aJtWkYA8pFjoC1Xx9NVVk0UZrZiIVId6XHr95jzh/X4TePzR
   0HOYv+1l89nNNA4qWxG8s8tdkcqMvEVgdWFx3LI7cAtIg71JnB3p9AcfB
   H7K0nDT6/f/BtatCmmZk7zE37cKYfD2/Zg6euZgnADvpoUDPJQn13lmgR
   S6uDL/HniFPa0NXloCLVswKfbFIuke5sl/4YDykJn7chhCEIP+VoKkDAq
   dKSKF6FQ+MtzKM+KOq+YGTAaxd9EP3sXMa92GD9biYPI5eYD/6vAFwLgo
   HM7HIKwHRCuFHmsAeRrqGjcFTHZ99hQ0gr7sTBHqJv8ke+I+V7fr2yN8J
   w==;
X-CSE-ConnectionGUID: jpHBCUUeTcySpbBymtMQUA==
X-CSE-MsgGUID: f4V7hz3FTwOofqwX6014wQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="42848112"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="42848112"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 08:27:33 -0700
X-CSE-ConnectionGUID: 5sCWBK5QT+6icFZNaoTSpA==
X-CSE-MsgGUID: ckvy+jtoQbOE0TVStyhSJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="73258548"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 08:27:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sqDdQ-00000009VTc-3Cu1;
	Mon, 16 Sep 2024 18:27:28 +0300
Date: Mon, 16 Sep 2024 18:27:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 3/6] misc: eeprom: eeprom_93cx6: Replace
 printk(KERN_ERR ...) with pr_err()
Message-ID: <ZuhOYFx5ZvzkvG2o@smile.fi.intel.com>
References: <cover.1726237379.git.pnewman@connecttech.com>
 <127dcc7f60d15a1cc9007c9e5b06a1aa2b170e19.1726237379.git.pnewman@connecttech.com>
 <2024091438-charity-borough-54b3@gregkh>
 <ZugAeVWeMZGtjYme@smile.fi.intel.com>
 <2024091632-oboe-subfloor-afc8@gregkh>
 <ZugJT4nl1l04biJd@smile.fi.intel.com>
 <20240916080410.464c2b5f@SWDEV2.connecttech.local>
 <ZugiB0GoNF50OdYC@smile.fi.intel.com>
 <20240916112056.25193a17@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916112056.25193a17@SWDEV2.connecttech.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 16, 2024 at 11:20:56AM -0400, Parker Newman wrote:
> On Mon, 16 Sep 2024 15:18:15 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Sep 16, 2024 at 08:04:10AM -0400, Parker Newman wrote:
> > > On Mon, 16 Sep 2024 13:32:47 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Mon, Sep 16, 2024 at 12:25:52PM +0200, Greg Kroah-Hartman wrote:
> > > > > On Mon, Sep 16, 2024 at 12:55:05PM +0300, Andy Shevchenko wrote:
> > > > > > On Sat, Sep 14, 2024 at 08:58:50PM +0200, Greg Kroah-Hartman wrote:
> > > > > > > On Fri, Sep 13, 2024 at 10:55:40AM -0400, Parker Newman wrote:

...

> > > > > > > > -			printk(KERN_ERR "%s: timeout\n", __func__);
> > > > > > > > +			pr_err("%s: timeout\n", __func__);
> > > > > > >
> > > > > > > It's a device, please use dev_err().
> > > > > >
> > > > > > The problem is that this library doesn't know about this fact. I.e. it would
> > > > > > need a new member just for this message. Instead, maybe drop the message as we
> > > > > > anyway get a unique enough error code?
> > > > >
> > > > > Fair enough, although adding real device pointers would be good to do in
> > > > > the future...
> > > >
> > > > Let's then do it when it will be the real need? Because I don't think this
> > > > message is _so_ important. I believe one of the upper layers (whichever calls
> > > > this function) should propagate the error code up to the user space. If it's
> > > > not the case _that_ has to be fixed.
> > > >
> > > > TL;DR: Let's remove the message for now.
> > >
> > > I can remove the message or leave it as is and drop this patch from the series.
> > > One could make the argument that any error indication it is better than none
> > > in this case.
> >
> > I think you can drop the message and make the patch to be last in the series,
> > so it can be easily abandoned (in case that decision will be made) without
> > throttling the rest. At the same time in the commit message explain that with
> > move to read_poll_timeout() we drop the seems redundant message. I'm fine with
> > that approach. But at the end of the day it's not that critical to the main
> > purpose, i.e. cleaning up the Exar serial driver.
> 
> I don't think read_poll_timeout() will work directly because eeprom->register_read()
> does not return a value. I could add a "is write complete" wrapper function
> to work around that I guess. However, I think I will just drop this patch from
> the series as fixing it properly will be a big change and like you said its not
> critical to the main patch.

Sure, fine with me.

-- 
With Best Regards,
Andy Shevchenko


