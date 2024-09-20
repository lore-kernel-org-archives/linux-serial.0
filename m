Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255E2C147;
	Fri, 20 Sep 2024 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726843581; cv=none; b=J/IpsxrVHemCME4/c0GY7tgwjQwtkFEirMPFIPlwjLnb0VW3IWqn7ccJJft/1doreoUo4ki6RmGw/NB0Zsl0wlWpq9zHZiNLbUXYVcGzGceMMYJNhHhSwHduMamyfgoNHioxUg7oauJefFRm1dWvPHrULFQSmGNR7hIc0fBnKwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726843581; c=relaxed/simple;
	bh=FNzFB4lLCsY2LXEXm7NlGT/b33OasZw1zU275ENsZQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AK6zYkRHHzy/c8YWp7/Dri8nTFsTZunARLS1dwEi00vdmruDqA3lLO9wii+AsbyLH41uVK6lunZODaC1MZdbe91RlfqBtCG4fM29ENzUsQnKMCmH004O6QCUBkcactatgvpI4tNQFBVsz2tW2/TCcYHCfa7MmQGjbyclQK2mV/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ko1g2aLf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ko1g2aLf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726843580; x=1758379580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FNzFB4lLCsY2LXEXm7NlGT/b33OasZw1zU275ENsZQQ=;
  b=Ko1g2aLfYFIWHEhwl7IFEu2Sk13LDS37WVfXGvrWy+aUdITakXV5W5mt
   3coLLQH9EwcZVtIyzSxf5ZWQW74qr/xc/yxjh0yqN3I6TXFr3FcDf1ICJ
   zL2pxcz9klq0jEp3Ukiv4lDP7wp7UlzglZnWNqgFfUDi3aT8QD+w6eysj
   tjUxbH10XNPWs5g0Gj6xJxiobBAUwr5wpDk87tJmfINg4J10EOjIdpU6e
   Aiv4K67ExVbkXSm0bVGwUSmVvze01ECPnziyCV9Y0DDmc8qZa0CmsRlnW
   IG6x3dFh6MBBRTta7u4UFsWVw1Ic+I76o9uROT4vdMkJXJOKsrfuvKHfM
   g==;
X-CSE-ConnectionGUID: u6G5FSadQnOXSita901dTg==
X-CSE-MsgGUID: TmHCLz6RSvSPU+Qtz4TYmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="43372443"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="43372443"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 07:46:19 -0700
X-CSE-ConnectionGUID: qB8FHlXSQhKIsZiaAArGMA==
X-CSE-MsgGUID: nXIsThN6T1aUc5IJDjArBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="69920590"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 07:46:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sreth-0000000Awbb-46V4;
	Fri, 20 Sep 2024 17:46:13 +0300
Date: Fri, 20 Sep 2024 17:46:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 2/4] misc: eeprom: eeprom_93cx6: Switch to BIT() macro
Message-ID: <Zu2KtQToCqo06oJf@smile.fi.intel.com>
References: <cover.1726838531.git.pnewman@connecttech.com>
 <1c2406fc139015988b996b26b240963b9a35d754.1726838531.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c2406fc139015988b996b26b240963b9a35d754.1726838531.git.pnewman@connecttech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 20, 2024 at 10:03:22AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> Use the BIT() macro rather than (1 << (i - 1)).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


