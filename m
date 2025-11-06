Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1D9224AF7;
	Thu,  6 Nov 2025 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446967; cv=none; b=DXvt5WFsbiFraNSg3EpTUeiT/8Cg/xd5r9pTZfAvnR1tPeW1ZrLdqwj+ekMTJhrm6y8ly3sekMPVdcBF8NCnkNdzcj8fupzo1l6mRhzyCwjZl9jQBVXsOve/ENGZZ1gNJEAeZvvYL5+j4GFjBlC4vSnGCBSHtDjpW4kon85P+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446967; c=relaxed/simple;
	bh=xIwmgloQv8Eair/QuGUeusQcp6EUVu7HFBseK1JIIAM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=By94CXseL3JTrMnmYnfpUYmZ/uPwWQOUDMfg1SciB+oeG4S4fj4mNDKlTifSgWa+4pO7EZe2rslneApT9B3+I/0ZYv6i3wDjBC/CZi/FM5TlT0wH9c3uVJnTbhPQUEtL7fr3QqNdN1rRGrlrt4jX1rMZv3nlVEWQvUZU3Uj0bsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+P1yvZ3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+P1yvZ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762446966; x=1793982966;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xIwmgloQv8Eair/QuGUeusQcp6EUVu7HFBseK1JIIAM=;
  b=Z+P1yvZ3YiphCH/hmzrAMsep8swhdfmPxTVRTdS/sQ0H4wzhmWPvgHhO
   Wy8Tm9N5tT1sGFK95vdwz/3JxnpPHYvD3CyG7Y0pqvZ4lNFNEU1EFNWga
   sBrtFjv/zLK2uw2ZfNK20kUBK1kZd3msHTWHGjEwa2S46TJ3z89XprOcb
   vm8Sm4qVANcHoKUEM/2vtgyOdDF6FOFLI9XEFEpQZdWcBPlc3H9gmKdN4
   23jEYzTJjeMfWqt4jXRC6ktUeXFtDfQQwwXTj6poQLGlng99JXrqBWKWk
   90XVFt44YCQfrdBfAd1xT4nXl9hslSX3G+XPmcAuJw52bpg8Uf5t/BEva
   Q==;
X-CSE-ConnectionGUID: 0+Zzm2zeRB2eA5wha6p4yg==
X-CSE-MsgGUID: 68jkYg+SQi+oLMPd0kbO1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64473189"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64473189"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:36:05 -0800
X-CSE-ConnectionGUID: YAq6LNmBQ82BB/zn0rKcPw==
X-CSE-MsgGUID: 73SvT47dQ+6Ij/ejI+Elhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187746279"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.187])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:36:01 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 6 Nov 2025 18:35:58 +0200 (EET)
To: Borislav Petkov <bp@alien8.de>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Alex Davis <alex47794@gmail.com>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    John Ogness <john.ogness@linutronix.de>, linux-serial@vger.kernel.org
Subject: Re: [Regression] depmod fails on kernel 6.17.1 rc1
In-Reply-To: <20251106162436.GFaQzLxBW-_50ndwtr@fat_crate.local>
Message-ID: <3fe70726-80d6-a84a-4101-446fd8b49209@linux.intel.com>
References: <CADiockCvM6v+d+UoFZpJSMoLAdpy99_h-hJdzUsdfaWGn3W7-g@mail.gmail.com> <20251106160235.GBaQzGm8W2Gt_VMy-s@fat_crate.local> <aQzJveMYT6O3EHeK@smile.fi.intel.com> <20251106162436.GFaQzLxBW-_50ndwtr@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 6 Nov 2025, Borislav Petkov wrote:

> On Thu, Nov 06, 2025 at 06:15:57PM +0200, Andy Shevchenko wrote:
> > > So I'm seeing this with an allmodconfig build too:
> 			       ^^^^^^^^^^^^
> 
> > > depmod: ERROR: Cycle detected: 8250 -> 8250_base -> 8250
> > > depmod: ERROR: Found 2 modules in dependency cycles!
> > 
> > I'm surprised it took so long to people to start complaining.
> > 
> > So, some of those are modules? Can you share the
> > 
> > 	grep 8250 .config
> > 
> > part?
> 
> See above.

https://lore.kernel.org/all/87frc3sd8d.fsf@posteo.net/

I wonder if 8250_rsa.o can be put into 8250_base.o where most of its 
callers are anyway?

-- 
 i.

