Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76011176AC5;
	Fri, 20 Sep 2024 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726847195; cv=none; b=Spr6DRVo3kF7BB4CBM6G2b4dyTTbtqGMkZWRH0TJ/VDqo14lICrkCvc2SmUkJSsy0HgC2yWTMCwgrTfkr07SBKCvXFA6rdZkSLGbXpyhOgJEHnma2je0Y+GtJByUR2M9lTSu515ieBOgmFpRezE+731AYVYhWPk/Arm5l0xhrKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726847195; c=relaxed/simple;
	bh=Engf6z76qpKlNEPMOZLUg9FwBGasCOqP5Xndi5tcOEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIVQV1nwFBtrUFUERjAeTGzaXtUiLgdZB0bzxm3FfuveHv8ixI83nZdeqLT0+Ts9RLuPAw8TqxTzLGPyg3O6zph5t/Fj/DDO9wm59HQpkRJ+BhxTKFV27Ytzdfp3E8ra4dMbFvNIZpv7etVi9cCm/cdMypyf4yTL5Rff1bH60NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VrRHAjAW; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VrRHAjAW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726847194; x=1758383194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Engf6z76qpKlNEPMOZLUg9FwBGasCOqP5Xndi5tcOEQ=;
  b=VrRHAjAW8zWrvXjOgl6EX27UXSxOiOGoami2xqQoHP/Jrnf1nmFezq2o
   5Dt0/c/0V2ZGOelhKkX2eadH5ehJ3nWd9jUwX9jXwMfadiOP0mISpv6dD
   VAk1Ti0lMmMrkWrwHV15R7TFEYpYy5ql+xc6JgapGOkF8F6S0tkJe4m0U
   U5x8JGC74hvjgAqCgPNSFn2l3fEQdNk+bK81pfEkQKto0Ho/X2MzfznJG
   74zaRg3nyclPejeam4oivMsb3Q4kXOrdd6E+nXTeO68LiOxTa8/1U2/VD
   fR7zHMdGt1gkIIKeYaHPqO+gvn7/tJTn3V7q6UHkj37m0kvDCyCVCoJap
   w==;
X-CSE-ConnectionGUID: W6L/cyJSRtaD7G1bRoc0gw==
X-CSE-MsgGUID: hOnh+V0uTnCK5iPQIF4Pow==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="26006032"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="26006032"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 08:46:33 -0700
X-CSE-ConnectionGUID: VwO/chKUTpu5flE5yDl3JQ==
X-CSE-MsgGUID: 8R1P82BVQV6VIc9RNhayAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="70345991"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 08:46:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1srfq0-0000000Axm7-3G6Z;
	Fri, 20 Sep 2024 18:46:28 +0300
Date: Fri, 20 Sep 2024 18:46:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 3/4] serial: 8250_exar: Replace custom EEPROM read
 with eeprom_93cx6
Message-ID: <Zu2Y1HlX8JqvJg-z@smile.fi.intel.com>
References: <cover.1726838531.git.pnewman@connecttech.com>
 <87719d2113970b6ff4979329fb96346a0aca9775.1726838531.git.pnewman@connecttech.com>
 <Zu2UEAY1jweup6tS@smile.fi.intel.com>
 <20240920114221.57da8890@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920114221.57da8890@SWDEV2.connecttech.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 20, 2024 at 11:42:21AM -0400, Parker Newman wrote:
> On Fri, 20 Sep 2024 18:26:08 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> I will fix in v3. In this case should I drop your Reviewed-by tag?
> Or is this change small enough to keep it?

I'm glad you asked. As you rightfully noted, this one is small, no need
to drop tag.

-- 
With Best Regards,
Andy Shevchenko


