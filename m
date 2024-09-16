Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B75114A4E2;
	Mon, 16 Sep 2024 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726480513; cv=none; b=AXsxVP2qUyKCpiMea8BCu2M6BTz8bxwUub+B0YShsl3jvz4XnhoBIXpXO3gVYeqphMV7J27k9wzpvuC5TVZkD49FS3dYFg8E70iTP8qz1pi1lTb2huVBzUn/y5P5ywkXTgLp/y92lkZipPCcqLLQLgXfuJY/YrDarOYt+ZueTy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726480513; c=relaxed/simple;
	bh=/WFKC3SoO7nnl0ody5g+rBvMFJbQKowrTvuCU4rEXK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyhLY3QUZm8zQBWH/E7c6sSECd8ndcPRv3LvSRIA6+upm48fQW9gPgue3NKxM3gDvRiT3p15kfhE9u5cOmV84eet3TFMfgNpuvneKp0FbojL3HV1u/mnZ64/cmVeD7N2gKoMGgvSdH8YGZODIPrB/mLpg/1o0uh+G1aU9Ht06WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ipiij/ay; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ipiij/ay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726480512; x=1758016512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/WFKC3SoO7nnl0ody5g+rBvMFJbQKowrTvuCU4rEXK4=;
  b=Ipiij/ayEK8afb6kIU4aaojVr+9CZpYnnTD4CFrrxKJPWY0oGesxBTTk
   jEfBgg6B1yaDWC+yUujmJCW4moj3TUwvDiLcipGMXVQPXuVT85cRjbNEz
   GLOvxXhuTDQpQ8dn8/Yva5jr4V10VXemXZhOdEsENogluv8GC4r+y7LaE
   QvZ3KwFtdQ01EgMgP5fkXvccUQMt/tckbQEUT+eB7MbgGLfpdBT50JVzm
   rg4vL7M8S0lRno7rjDamKcYQV+blErAJFAh4M6Yxk95XQJI6gNUuu/qd2
   f36/AvE+Bin8BmT4J2xm9hyDKNmdo0OwVvSifwhCD/MmUpb8BwKJbJtVI
   Q==;
X-CSE-ConnectionGUID: 0y8ZCWAJT1im7eltVOv5Xg==
X-CSE-MsgGUID: Bb2sifChQmOrPPOclar5JQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="42774824"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="42774824"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 02:55:11 -0700
X-CSE-ConnectionGUID: HBZnngcETzKM3OIs32/ToA==
X-CSE-MsgGUID: b1OfRFM3QdmSW2Eh4EZ6WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="68699289"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 02:55:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sq8Rm-00000009PeS-1LiL;
	Mon, 16 Sep 2024 12:55:06 +0300
Date: Mon, 16 Sep 2024 12:55:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Parker Newman <parker@finest.io>, Jiri Slaby <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 3/6] misc: eeprom: eeprom_93cx6: Replace
 printk(KERN_ERR ...) with pr_err()
Message-ID: <ZugAeVWeMZGtjYme@smile.fi.intel.com>
References: <cover.1726237379.git.pnewman@connecttech.com>
 <127dcc7f60d15a1cc9007c9e5b06a1aa2b170e19.1726237379.git.pnewman@connecttech.com>
 <2024091438-charity-borough-54b3@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024091438-charity-borough-54b3@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Sep 14, 2024 at 08:58:50PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 13, 2024 at 10:55:40AM -0400, Parker Newman wrote:

...

> > -			printk(KERN_ERR "%s: timeout\n", __func__);
> > +			pr_err("%s: timeout\n", __func__);
> 
> It's a device, please use dev_err().

The problem is that this library doesn't know about this fact. I.e. it would
need a new member just for this message. Instead, maybe drop the message as we
anyway get a unique enough error code?

-- 
With Best Regards,
Andy Shevchenko


