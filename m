Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49ED1E2847;
	Thu, 13 Feb 2025 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440541; cv=none; b=jnyAztLFPjXcF2Q96GzygookXqkiWePO8E+7YkgEPqR5ElENuOProVAF/4bi0j2NX5u8S48CapnwVkAjQeyMDYJb1og2+4LEGKQYAl0qSvrrOUUn/VZrzqrxGUe9t8HeagQmgf7EQsGQO57NL57ZRTinNw18E08JcV3NReiOM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440541; c=relaxed/simple;
	bh=cdaR+psnQL9u32qL0IqQ300rKEIrT0JQrJXVM8wTiLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJcggtQnncwei43zfMHsEvBnRNkxvMnPgRV71QKJuiDf7f3vuJ23m16AdxRNTTfff1/SJyFtIRRVIMcilfDtAMj4VG6+0zLiyEv4o6mKwFp+tBIxBp3oFjdsXwSJzaGv+AyDqHggTiEAbgrpNFHM5YjyQ1nbwSJn1nrRXgzk8T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YEx6rK/I; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YEx6rK/I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739440540; x=1770976540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cdaR+psnQL9u32qL0IqQ300rKEIrT0JQrJXVM8wTiLo=;
  b=YEx6rK/IHsNZB3+wvx/kM+yCujGgCjEnh0SI88QkM4zBhFuuT8iVv9M2
   R0MLYWutIn1AUJ0D8J5q+/tMEb7UQPaywvukWA+x+Uy946AM5PaoYy/Gf
   BBCvC2lyXiyEuEVQ/dBisk56pG/DQtK2QZIBLBS3ebnjKXmEcnrnvoS0V
   wKY8YB1hgGR/Cc0VykIeW3Vw/C0SfAl0ofdhMt4M4ZX2IKwAffjfbgf4z
   C6kIZx6ItWt1UXaTNq8qKx70ikqKykkDDOVQOh6ZY8nt7+JPiAH3xCMuf
   B/Rl4C+OzhytkzPTDbBf2xGyBw2GDGpM1J0VVv6rpm9Tc32M6ev0lKAyi
   g==;
X-CSE-ConnectionGUID: fWcLeHYfSYOLPmZ3I30eTA==
X-CSE-MsgGUID: ehvTNWJFRtK/NGjdU+8iLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="43784804"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="43784804"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 01:55:39 -0800
X-CSE-ConnectionGUID: FNDkr+ItTz24buEAvkOqnQ==
X-CSE-MsgGUID: BT7LH2bsTkajc3ymp9YCEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113996071"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 01:55:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiVwR-0000000B7uz-297a;
	Thu, 13 Feb 2025 11:55:31 +0200
Date: Thu, 13 Feb 2025 11:55:31 +0200
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, "robh@kernel.org" <robh@kernel.org>,
	"robert.marko@sartura.hr" <robert.marko@sartura.hr>,
	"arnd@kernel.org" <arnd@kernel.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] serial: tegra-utc: Add driver for Tegra UART
 Trace Controller (UTC)
Message-ID: <Z63Bk6sgQryG1pFK@smile.fi.intel.com>
References: <20250212104132.61060-1-kkartik@nvidia.com>
 <20250212104132.61060-3-kkartik@nvidia.com>
 <Z6y5vRGyouZsQWyj@smile.fi.intel.com>
 <ec06322386adbf4404e2fbc5d7656e3465eb4320.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec06322386adbf4404e2fbc5d7656e3465eb4320.camel@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 13, 2025 at 09:05:36AM +0000, Kartik Rajput wrote:
> On Wed, 2025-02-12 at 17:09 +0200, Andy Shevchenko wrote:
> > On Wed, Feb 12, 2025 at 04:11:32PM +0530, Kartik Rajput wrote:

...

> > > +     for (i = 0; i < len; i++) {
> > > +             if (!nbcon_enter_unsafe(wctxt))
> > > +                     break;
> > > +
> > > +             read_poll_timeout_atomic(tegra_utc_tx_readl, val,
> > > !(val & TEGRA_UTC_FIFO_FULL),
> > > +                                      0, USEC_PER_SEC, false, tup,
> > > TEGRA_UTC_FIFO_STATUS);
> > 
> > No error check?
> 
> I'm not sure about this. The case where the TX FIFO doesn't clear up,
> even after polling for 1 second, is highly unlikely, especially since
> there's no flow control involved here. Even if that did happen, writing
> to the TX FIFO should just result in an overflow, which is probably
> acceptable in this scenario.

Perhaps a warning (debug?) message in such a case?

> > > +             uart_console_write(&tup->port, wctxt->outbuf + i, 1,
> > > tegra_utc_console_putchar);
> > > +
> > > +             if (!nbcon_exit_unsafe(wctxt))
> > > +                     break;
> > > +     }

-- 
With Best Regards,
Andy Shevchenko


