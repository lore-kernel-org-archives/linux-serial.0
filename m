Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165929443;
	Fri,  1 May 2026 11:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777636141; cv=none; b=rwUQYihNPoCfRh4lpqMYEKgakdGwXAHZ9ip9Bxk3IqGZ3mX6b/bv/nsiDao2XJlgiNN+NSF68rQmSQV+al+0Twf+MxFPg6/Osrs3RRrX7WOeDFZlf8/uRZOobi5wjbfOD3T9pikfhcL34ZJZOhc5VGcEKWNRjLTizGdcZB3G9x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777636141; c=relaxed/simple;
	bh=Kp3utsp0AE9bpKsBCkmHY0mVIH/BO2MnrapVCI9cJO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIVle2CiZFwYczzqxfeJzLlBdZxDUZawBJw9xtzW/+cI1yMw7ZJMJMmyXsEadpSlZeZvzjlTEOrTY7rCYZHDGZCkQJ2W5ff+EkSlrp8faC3VUVfXuarssOjlr6iYecdEK4HMUZ3htUVmaeyblFdDsIh2sQnPDkB86D3ZM3UORgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EgZEwb3v; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EgZEwb3v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777636141; x=1809172141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kp3utsp0AE9bpKsBCkmHY0mVIH/BO2MnrapVCI9cJO0=;
  b=EgZEwb3vN371O1KoBpnxjPJxxjAyUHm0xpo1IoX89IR2aUmMlyCSPVTT
   MMWI5IPwFppXYmtDvXzjLl8327nCAhU3Kp35SMWOW2N3NkMgIQxKF5ll9
   2fpO6wOcBLaJIR2eVuxrOX1OeCTPJCBBB0fol8f9sKuR+9yeHTNRAy0zl
   Ft2z2g1luZfj7Zv9Oo68WJvZE0Xz2j7VPzR9fAKyUOIFuT11Ns1ZWdtSV
   8/kdjFnnikNSPSrSwzSEluyeELFl920SXkP81ICSzVzsWpD6I+seWdVMI
   +vtaoFALEoBVL3oiMK40g7/zmiYRvSRCz/Or3qcydMITebkLuljC1T5Ms
   Q==;
X-CSE-ConnectionGUID: 01zquH2FRJ2ziN5oNflNjQ==
X-CSE-MsgGUID: n+qGTYRARaqjBMOvyD74Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="78301657"
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="78301657"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 04:49:00 -0700
X-CSE-ConnectionGUID: 9qDJuYyJTEmr7Dr9Kj1lcg==
X-CSE-MsgGUID: aFdBecedTiul6/Kl2mxpaA==
X-ExtLoop1: 1
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.241])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 04:48:57 -0700
Date: Fri, 1 May 2026 14:48:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v2 02/15] serial: core: add uart_iotype_mmio/legacy_io
 helper functions
Message-ID: <afSTJyQjpVy2rmTx@ashevche-desk.local>
References: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
 <20260428-tty-upio-v2-2-01c1857cf761@dimonoff.com>
 <afNwaUf8esqaqxUe@black.igk.intel.com>
 <20260430113011.fea8a6edca8d864429a63fd5@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430113011.fea8a6edca8d864429a63fd5@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 30, 2026 at 11:30:11AM -0400, Hugo Villeneuve wrote:
> On Thu, 30 Apr 2026 17:08:25 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, Apr 28, 2026 at 01:53:48PM -0400, Hugo Villeneuve wrote:

...

> > > +bool uart_iotype_legacy_io(enum uart_iotype iotype)
> > 
> > Why do we use 'legacy'? Still in use in modern CPUs...
> 
> TBH I do not remember exactly where i got this, but what would you
> suggest?
> 
> Maybe:
>   uart_iotype_io()

Yep!

-- 
With Best Regards,
Andy Shevchenko


