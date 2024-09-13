Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA234126BE1;
	Fri, 13 Sep 2024 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726251008; cv=none; b=GY/fKYIMY+sD+p1NxCbokgWlPyKCh2KYEl5KOIOVz2fMn2IoLVDjjyj+9gle+nJ0qiDopYkbxR2QNrLGZumbJsqp5ETx+WmwsBPnFvOOjeJUryHMsAAodrs8miiCQH4ByphKPwSCzyE4HY0YFWGjB172JiSJFbM0N0Ng6iZ9CGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726251008; c=relaxed/simple;
	bh=1GXqbADojQ15lXlutK50SvWzT4F2kKmG3RHiIwu79sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lj06mu0+4P4J0gx5gTR1cjmpXwFiG9d0tcUXy0TrLz9pbOrltPUKaEa5+u+HT3SUo4X3ijMTt3Z2jmvFWDM+QZpJ4EXiBIyjwLS/g9P7yzJuTwVHs/f+kTf4n164IihbYbaqfifwGdRRcsV4uYdBbPxww4+RXu0wD+lnBRT2NdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7BrkxFt; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7BrkxFt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726251007; x=1757787007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1GXqbADojQ15lXlutK50SvWzT4F2kKmG3RHiIwu79sc=;
  b=T7BrkxFtllJx6eOFAZLHOqmDVuy4WKIM+BlOnjBY1GYOIP/4g8Uk+2xM
   BsyJSvAJCpnRyTqGPs28PmSSFPMxxY5P0PJ//YwekVIl+YrIaZdkubd9K
   wE/iVBO7ERcqSztQx1ikKtkf5V9raYPpEtEdmiBaMQhunoUzgne8sujiA
   6LGVFwVm/9dfDU0tNwOgdcQ18Ht0ULyYcGl9jnYi6L0yx/coGEYChD4Ps
   RfxeuUieqPiTgMagHelqA3zPJd4iObupp5HxmTlySpXg8ddVwe54S56CB
   xkPWOhiLV7PojMku5zeWiEGsdM/sCPxHr0c2bQY94onVHUQQtpcIpoHAN
   g==;
X-CSE-ConnectionGUID: Wi1SBwSYR/O4bMXtOC9gRQ==
X-CSE-MsgGUID: msU6RZzMSNC9J0wHuE0ZoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="24987236"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="24987236"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 11:10:07 -0700
X-CSE-ConnectionGUID: JuvKgL5LQ0+LTnsnqYepQQ==
X-CSE-MsgGUID: W2vIvt6bQQqkqfiQL7Phmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="68082419"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 11:10:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1spAk5-00000008Nmg-40ry;
	Fri, 13 Sep 2024 21:10:01 +0300
Date: Fri, 13 Sep 2024 21:10:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 0/6] serial: 8250_exar: Replace custom EEPROM code
 with eeprom_93cx6
Message-ID: <ZuR_-cV5zy1mwel3@smile.fi.intel.com>
References: <cover.1726237379.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726237379.git.pnewman@connecttech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 13, 2024 at 10:55:37AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> This series of patches replaces the custom 93cx6 EEPROM read functions in
> the 8250_exar driver with the eeprom_93cx6 driver. This removes duplicate code
> and improves code readability.
> 
> In order to use the eeprom_93cx6 driver a quirk needed to be added to add an
> extra clock cycle before reading from the EEPROM. This is similar to the
> quirk in the eeprom_93xx46 driver.
> 
> More details in associated patch and mailing list discussion with
> Andy Shevchenko about these changes:
> Link: https://lore.kernel.org/linux-serial/Ztr5u2wEt8VF1IdI@black.fi.intel.com/

Thanks for the prompt update!

However we are close to the merge window, I think Greg won't accept this until
v6.12-rc1 is out. So, we have a two or three weeks of time.

Meanwhile I have some (small) comments, I just sent in individual replies.
Overall, LGTM.

-- 
With Best Regards,
Andy Shevchenko


