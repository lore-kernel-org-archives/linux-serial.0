Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF80155A3C;
	Mon, 16 Sep 2024 10:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726482774; cv=none; b=uz7SOaXZR6KO6EBWwExLAQZL6BgoCId6GcV+pvdCJdLmfXNfYRu4Eghgbdm0jPtW2fTsRoUwzzf0Un32F+qqB4p9/HiWZ+kouwzMkl5gDv32BzPl/ZB4QxbgyI2K6QgDWH9/NS7QIz32VstupDzBjZh30C8sxLG4oxErlxsYu7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726482774; c=relaxed/simple;
	bh=/OqrmRhJnc+bPv7HEDZGjIkvsQTtCUcSiuZC5hrqqAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAlMM9LnYKR8vSK78Lx80Hlea/3iAWPn7LImlR9jY1HXNWO3QizL5kazBHhDMtAuLzwIGBCoE4jIS5hl5snH3rWqPsY4MDkSghD2fJqhWAduYcVjnTxtIFzeNB08ebPITJxFGNpurayiwiFtRMX/d7qgCePF3vmgdBS9sI2hGuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oGFMZkij; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oGFMZkij"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726482772; x=1758018772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/OqrmRhJnc+bPv7HEDZGjIkvsQTtCUcSiuZC5hrqqAw=;
  b=oGFMZkijRdJ8BMMkw8gsU7+dToD/lEQUjTKkoiCWOCo79mmzHmsYb26a
   bAD+XqynOA3A/UOH6ZYmyW+AaKwnmfa1deC6eROCe32EwWh2bzN49oh7l
   1p1Q2oX5kdf5s6FX2vCHUrM7/MzO2WKShMqI9i9wp1OSxBckC8l2LHEqn
   2FJl+MAkFw9Pi5IjRYPDcsArZQDdVGCttWYj454f6fwTgPnVbDo5oipqx
   NV44E/4hULEoTXvpTmFeugTFMSwlqydkSCH1sz7jKEtuSY0vK1jbf/zhQ
   S/UP3zNbtY6dSMZKUwdm6G5e0eJ5vHjzalPi+n0UOFxnIzTdjX6UHEPs1
   w==;
X-CSE-ConnectionGUID: Pe+Z3NXgQfWoTaZXgS0Png==
X-CSE-MsgGUID: N9tkBMSmQZy5vZBwkbSEIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="25429020"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="25429020"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 03:32:52 -0700
X-CSE-ConnectionGUID: NIYG7K5AQCSQ0bFORY9oeg==
X-CSE-MsgGUID: n98MMR8oTXKxWdXm8hXrtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="72922504"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 03:32:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sq92F-00000009QKi-2R4Q;
	Mon, 16 Sep 2024 13:32:47 +0300
Date: Mon, 16 Sep 2024 13:32:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Parker Newman <parker@finest.io>, Jiri Slaby <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 3/6] misc: eeprom: eeprom_93cx6: Replace
 printk(KERN_ERR ...) with pr_err()
Message-ID: <ZugJT4nl1l04biJd@smile.fi.intel.com>
References: <cover.1726237379.git.pnewman@connecttech.com>
 <127dcc7f60d15a1cc9007c9e5b06a1aa2b170e19.1726237379.git.pnewman@connecttech.com>
 <2024091438-charity-borough-54b3@gregkh>
 <ZugAeVWeMZGtjYme@smile.fi.intel.com>
 <2024091632-oboe-subfloor-afc8@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024091632-oboe-subfloor-afc8@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 16, 2024 at 12:25:52PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 16, 2024 at 12:55:05PM +0300, Andy Shevchenko wrote:
> > On Sat, Sep 14, 2024 at 08:58:50PM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Sep 13, 2024 at 10:55:40AM -0400, Parker Newman wrote:

...

> > > > -			printk(KERN_ERR "%s: timeout\n", __func__);
> > > > +			pr_err("%s: timeout\n", __func__);
> > > 
> > > It's a device, please use dev_err().
> > 
> > The problem is that this library doesn't know about this fact. I.e. it would
> > need a new member just for this message. Instead, maybe drop the message as we
> > anyway get a unique enough error code?
> 
> Fair enough, although adding real device pointers would be good to do in
> the future...

Let's then do it when it will be the real need? Because I don't think this
message is _so_ important. I believe one of the upper layers (whichever calls
this function) should propagate the error code up to the user space. If it's
not the case _that_ has to be fixed.

TL;DR: Let's remove the message for now.

-- 
With Best Regards,
Andy Shevchenko


