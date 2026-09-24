Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4425436361;
	Thu, 24 Sep 2026 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252459; cv=none; b=bimexC6XA0L26R+XyF3hH799FxRI050lb0hhJZtOuOST2Rxg5Gg6QiA7vLDHjeW5l+rhNFBj2S/savz/+shWk3Cm9b6aY+F8rCZDD8VgG/0U2kyPUNbJmYhAkQAiYCv3A8FwIUBsiOF/7b9VTLjtNh165FOiv4YIpmbVtqx7zyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252459; c=relaxed/simple;
	bh=nagfg7pGGlFHP8tvimI6OAruL42VYjcqbtwqN2eCbXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyqBeAVocAmbLfC/wAYjfu3bHxTngN3ejcVvkD4tRseTtbL+WbgQLCWTZOtQtqBjKB05XviNFTCD437UHqrsCKwRKoOIfgKzhrQVJxC2C/ZOKfwMfhGGArYnlfRmvod/+cVqo4Kk2w+vuRFZvZSXQzVSNiV6vvWGnDejiA40MrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a8izCPcO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8izCPcO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790252458; x=1821788458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nagfg7pGGlFHP8tvimI6OAruL42VYjcqbtwqN2eCbXE=;
  b=a8izCPcOz4wh30pbORQEOTJSjyCRmerwk7F/p8q2+R9FX5PR6vOS3zTR
   4lHriDTueycYlK4Q8mpnQ92Lj982Te8QFyIpKDA5CeecyUFxGA91gBMkg
   OAxnYafdiYjxGCm0bwHwZjxQhxHvtnfF2PhONQ+JepNKaOoJusC+JulW3
   EUJ7T24IB0AjhWuxd90sBw4kKZb6G57w8ovdhK/vjGK8KCQpB1KriC1fp
   +mRpybnGF0fHGNUsM3sgulzEMaNk/VRp5LJ5hgSTQbdP8cjNUlXIwudOZ
   hOajaUbHMLreNS8fKWbA4W3ARqsbDh34P4j52NDehBQ7Rzb4XR5Iscp7D
   A==;
X-CSE-ConnectionGUID: t/FT18c6TGajhof1h0EPNw==
X-CSE-MsgGUID: Yw68RsvpQdy8P4grJ1HSww==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="91039853"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="91039853"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 05:20:57 -0700
X-CSE-ConnectionGUID: boDYprDWQ3m6fuIEiQtNSA==
X-CSE-MsgGUID: pqjWMMjLSLytHuXBih/MhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="273511382"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.199])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 05:20:55 -0700
Date: Thu, 24 Sep 2026 15:20:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 0/2] serial: 8250_port: Update runtime PM flow
Message-ID: <arUVpSEzX2YCHzaj@ashevche-desk.local>
References: <20260814112435.3290545-1-andriy.shevchenko@linux.intel.com>
 <2026092315-eatable-canned-26a5@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026092315-eatable-canned-26a5@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 23, 2026 at 02:41:23PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Aug 14, 2026 at 01:16:28PM +0200, Andy Shevchenko wrote:
> > There are two changes, one is a straightforward drop of the duplicate
> > runtime PM call (which is idempotent and hence it's harmless to call,
> > but practically no need to do so) and the other addresses long standing
> > problem with potentially sleeping PM calls on some system in IRQ context.
> > Also the latter might lead to unneeded resume-suspend cycle when IRQ is
> > shared and interrupt is not ours. This mini-series to update runtime
> > PM flow to make sure this won't happen.

...

>   CC      drivers/tty/serial/8250/8250_port.o
> drivers/tty/serial/8250/8250_port.c: In function ‘serial8250_default_handle_irq’:
> drivers/tty/serial/8250/8250_port.c:1897:32: error: unused variable ‘up’ [-Werror=unused-variable]
>  1897 |         struct uart_8250_port *up = up_to_u8250p(port);
>       |                                ^~
> cc1: all warnings being treated as errors
> 
> :(

Ouch, rebase issue I believe. Thanks for catching this, I will fix in v2!

-- 
With Best Regards,
Andy Shevchenko


