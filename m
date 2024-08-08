Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA29C18CBE0;
	Thu,  8 Aug 2024 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126375; cv=none; b=JuhZ2RQ4+ZhcuN/ZKY5Alzi0cY2XZwlLSf+mapCv6+4WHUsTVxI2spDR/lPMEhYqJ+AKbANuw2CAuQIG6OFsK5H179qqElmzlWUppNjHr14hgqUKAgltczc+57kMGolLqGf0tEpIZoL+uA12c1T14Vp3j+JiHXs4aPRHlEp1d+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126375; c=relaxed/simple;
	bh=oqp0izSDKA/wf7VS2KDDDsHBa3GCXrHUWek3CkXPTjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4TwxG5NCsVj8XfTYgr62JkPsYel2tubjzvLghLi5UsRrqFbt+MDxRwHADXbu5pwnZBjVpmp/Cq5kMWY3kJHYlix50jICjVoDnvYwmFyAQcugrWk6Zw1TW0pugwKs4zY6JtfGI9PS6ogCqcokqdVob3qFxsrN3kAsab4SnotPYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDrQzE3d; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDrQzE3d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723126374; x=1754662374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oqp0izSDKA/wf7VS2KDDDsHBa3GCXrHUWek3CkXPTjM=;
  b=gDrQzE3daWKIGNseHSjAMjvY0nrrffgB3cOM4yok3vU8CvXAEnimVOzZ
   Ofh3TSnPbTTcPsDxusRFG1brr4SIEI0FXJD8UcptRQowA9ztU2I1pUPxI
   NWGIN9jbZ0tIyArtPqYP/mo2OP/M3nVluEgDqUlJvk++dEy0Bxf32i4z3
   r3tMCEJKolGckWAwSEz/+BYxEDq8BSoyHXn9h3Yvjh9dFMLHuphouzHzx
   UBmYQR/ZD0loPklQJKaWrDInG59GdrDT/kpi4lGR5lLqclkubpWTF4ier
   QK/R36i82bOirOe2peXjFNEO3nCMEMpmp5dJAUMWCsGTaT5ig57L38Rg/
   g==;
X-CSE-ConnectionGUID: q9Pi4zj+QM6mYZx2y9oP0A==
X-CSE-MsgGUID: uR0btK6DQKiYvmzkoDl64w==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="32401262"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="32401262"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 07:12:53 -0700
X-CSE-ConnectionGUID: wgYnLiBGRQSjLUh5KLqdwA==
X-CSE-MsgGUID: gFKZhXm6SMeA2v50eaUWHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="57473612"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 07:12:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sc3sm-0000000D8bm-1XfH;
	Thu, 08 Aug 2024 17:12:48 +0300
Date: Thu, 8 Aug 2024 17:12:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250_platform: fix uart_8250_port initializer
Message-ID: <ZrTSYOOZuR9WfSCU@smile.fi.intel.com>
References: <20240807075751.2206508-1-arnd@kernel.org>
 <20240807075751.2206508-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807075751.2206508-2-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Aug 07, 2024 at 09:57:44AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The first element in uart_8250_port is a structure, so initializing
> it to 0 causes a warning on newer compilers:
> 
> drivers/tty/serial/8250/8250_platform.c: In function 'serial8250_platform_probe':
> drivers/tty/serial/8250/8250_platform.c:111:40: error: excess elements in struct initializer [-Werror]
>   111 |         struct uart_8250_port uart = { 0 };
> 
> Use the modern empty {} initializer instead that works on all
> supported compilers.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


