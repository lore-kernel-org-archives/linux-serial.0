Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B806EC2FA;
	Mon, 23 Jun 2025 07:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750663037; cv=none; b=pgSqQ1zKwmuo9o367xwuKNmZkYFsk/cjE5dVyvsVHn9CiyGRgwiTrVWd7Hl5SqHGBNL5hMvoW33mel0dZm+1He34ivokO8rP4Ixlvd+I8L+WLbjAtEiGUyMUt0Rko5EIe/O38Zp6vJg1xaP8ZfVbKxzvc6WTaY+1z9UHox3SsLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750663037; c=relaxed/simple;
	bh=Jw8wpXNfGQO8GLwLn1ZOFZeP1vBXCVLhyyP9zZ92GDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQxNz3rAoKqRpGmlwZTJ71or09jwwZwTSIcxHaQel5yLno94P1yZDmFhOtEd65hLRwo4HEoBltA9Mgjol5b3BG4XaBnzDKPYCRwwInvBtI719IGRiUUbwQq3UIyCPkL00J/OkCbZKtzVnzl9nBFNc6Ursf5ElhZHrK8myP251Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wizj2PU2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wizj2PU2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750663036; x=1782199036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jw8wpXNfGQO8GLwLn1ZOFZeP1vBXCVLhyyP9zZ92GDg=;
  b=Wizj2PU2x7Iu6F3fYQL4pRt55u1e/AO4xAJTtslSTtWcWAA/jQ1XV97P
   yqwSjwLkEXx+LEv76IHlLWX3O6s0QFEIFOwy2RozQWCwo06zbymtd7znd
   Qp9aXRWmh1lVpBfokthCoqvxumQFGsAHV90nJoXTnFWUMluoPqWn4dBWu
   OZOGFOwX2Qb7XEosb+4zRy3BtS8S4jecc7Xvkzp2dGnDrhpMcs7Zpj8vn
   rAxEaJVE2e6QKbcuHoTmShleltTzCbz7e2gpwkqMThZzboAAHsj65W0+u
   Q2mo0scVwrKX2gm8d/Dx3L23tfKa2ZXyUmmqOCHcggILZkmuHe1rS5fQX
   A==;
X-CSE-ConnectionGUID: DZVAw/9bRqeWn3oBaZBvRA==
X-CSE-MsgGUID: UOc6iR4SQJWpu+q8o1MERA==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52787527"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="52787527"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 00:17:15 -0700
X-CSE-ConnectionGUID: o1MCT5QVS+Wv4S6yRCuloA==
X-CSE-MsgGUID: UEiemObAS0S1apvQ/tmVDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="182560803"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 00:17:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uTbQT-000000095oN-2ZW8;
	Mon, 23 Jun 2025 10:17:09 +0300
Date: Mon, 23 Jun 2025 10:17:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	"Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 30/33] serial: 8250: invert
 serial8250_register_8250_port() CIR condition
Message-ID: <aFj_dax6Gb9HrGyV@smile.fi.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org>
 <20250611100319.186924-31-jirislaby@kernel.org>
 <aFJTQqVvmLBvrVRA@black.fi.intel.com>
 <dfb7552f-9163-4334-b137-1bf69fbdef5b@maciej.szmigiero.name>
 <aFcDOx1bdB34I5hS@surfacebook.localdomain>
 <9c3d387c-0ee1-4f53-b4fe-2c2783e5650c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c3d387c-0ee1-4f53-b4fe-2c2783e5650c@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 23, 2025 at 09:05:46AM +0200, Jiri Slaby wrote:
> On 21. 06. 25, 21:08, Andy Shevchenko wrote:
> > Fri, Jun 20, 2025 at 11:48:09PM +0200, Maciej S. Szmigiero kirjoitti:
> > > On 18.06.2025 07:48, Andy Shevchenko wrote:
> > > > On Wed, Jun 11, 2025 at 12:03:16PM +0200, Jiri Slaby (SUSE) wrote:

...

> > > > > +	if (uart->port.type == PORT_8250_CIR) {
> > > > > +		ret = -ENODEV;
> > > > > +		goto unlock;
> > > > > +	}
> > > > 
> > > > > +	if (up->port.flags & UPF_FIXED_TYPE)
> > > > > +		uart->port.type = up->port.type;
> > > > 
> > > > > +	if (uart->port.type != PORT_8250_CIR) {
> > > > 
> > > > I admit that there tons of mysterious ways of UART initialisation, but can you
> > > > elaborate how this is not a always-true conditional?
> > > 
> > > Careful here, someone had an idea in the past that this is indeed
> > > a dead code/branch and ended causing a regression [1].
> 
> Right, I was confused too, but then I noticed there is:
>   uart->port.type = up->port.type;
> in between the tests.
> 
> > > It would definitely make sense to add a comment describing the code
> > > flow there though as it proven to bewilder people.
> > 
> > Yes, this is my point between the lines. I left the code that may affect the
> > type change and the second check needs a comment explaining these cases, if any.
> > "If any" defines "always-true" or not conditional. W//o a comment this code
> > tends to be updated again and lead to a regression.
> 
> ACK, I will.

Thanks!

Looking at the code again, I think it deserves actually two comments, on top of
each of the checks against PORT_8250_CIR.

-- 
With Best Regards,
Andy Shevchenko


