Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4C3C147;
	Fri, 20 Sep 2024 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726843701; cv=none; b=QXv7x1hbrI3oosWthu1449VaVJkks6hBJ1NvQYW8Hrj4Ovg3E9rPCRD1MjEnNtcCfnQ6gziQQrv0h/UrK9zjxppqR68uTgebzOneCGpR7YrZRvqM5kBL5b5m5vRevHsB94ODNQ6vtKYplCkFMO1Z+aGpN/oyeNc9rk+FY+BhLWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726843701; c=relaxed/simple;
	bh=FprzbyCVQigJ1Q7wttirGGnGSSSnrN3d7/0Hu0DuZSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSiAn5GQYL/QIlrFzskcvPKLJ6PMEBkCeOVyQGJ/dQweSBTUJcXGbX6EU3Z5BUml3n66cvqPjx2b+ryGXjWzI8PGbrgjzxY74ZXaI0IrV2nZgZt6g35/3RZkvhHsKX1vBkmHWZRM9jmXs4duU/0hF4nYY6dVHBPDiDFs0S1DARQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ERlKYV9u; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ERlKYV9u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726843700; x=1758379700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FprzbyCVQigJ1Q7wttirGGnGSSSnrN3d7/0Hu0DuZSo=;
  b=ERlKYV9uTviCQtyenMaM1JCIAhL9q1iBJZnO6FcMTdaXqhHh5txEnLOQ
   BykUUHoM4elop4XLcBqHP1cql41uMORmyPa2xJjqZoU9rHdXFpO+mlY91
   WlRBbhWG7kREEahkLT8PtVla02NvvXx2w1fKRNuZv78H8R7ibg1KB3lal
   MwMjuyX6DRMm3PDjnx1q4hpH4vOl5hZHFhXHm0diT3bW6PqZWgkkOWieP
   uwpcZELoiMJ9qsNqUF0HFCTgq+d+4t3j7XgPbWWDZkG19598dG8746yvS
   sdddowaeo0Bd4W3my8D0vege1fgz9+pNjLA4ufxByXh/3c9Dy9k0lT0lf
   w==;
X-CSE-ConnectionGUID: 9gkmHrBpTPe8aIWvXs9jdQ==
X-CSE-MsgGUID: Xcv3kpUnQNS9Z925aQO9iQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="29640462"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="29640462"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 07:48:20 -0700
X-CSE-ConnectionGUID: 0lEjLOY8QoihunAArUEKWA==
X-CSE-MsgGUID: mkYb3lrMQ/STX7QwpU2tHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="74440722"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 07:48:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1srevd-0000000Awe7-407v;
	Fri, 20 Sep 2024 17:48:13 +0300
Date: Fri, 20 Sep 2024 17:48:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 1/4] misc: eeprom: eeprom_93cx6: Add quirk for extra
 read clock cycle
Message-ID: <Zu2LLRNrFH6Lpjak@smile.fi.intel.com>
References: <cover.1726838531.git.pnewman@connecttech.com>
 <b92bd58e016a14ae95e259ffbdcfc5e5da6a7aca.1726838531.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b92bd58e016a14ae95e259ffbdcfc5e5da6a7aca.1726838531.git.pnewman@connecttech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 20, 2024 at 10:03:21AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> This patch adds a quirk similar to eeprom_93xx46 to add an extra clock
> cycle before reading data from the EEPROM.

Ah, sorry, forgot to mention the Submitting Patches documentation.
It suggests to use imperative mood in the commit messages, hence
the above should be like

  Add a quirk similar to eeprom_93xx46 to add an extra clock cycle
  before reading data from the EEPROM.

Also check other messages in this series.

-- 
With Best Regards,
Andy Shevchenko


