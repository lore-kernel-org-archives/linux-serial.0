Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB1E156F57;
	Thu, 16 Jan 2025 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028861; cv=none; b=grm42qx2k4qNPFAZw4gVnQtfB1PdnM7JSMwxdTIKuFxbFu+nquHJX0nCGSrYTZq8uTStX5I72DxWsE2V9pDyeA8y6QKrhBrKuP6BSIPn3Mgb0hBguayB14JcRGPrq4r9nEZVHYKHcR+Z5I5ixCiBd8iZviANj1jhdZzwHzJdgKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028861; c=relaxed/simple;
	bh=zzTLoVzSX9Yy14g2FiQb71Oz83Wd90fvnjfV7cb90gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2AAHga/zqvWT4NUbLDs3tiUnNuV0HPZYiWmYCyGDgG0NY8d5Wqq/NPD+RiW1QhPmgby4kf0Dpfj9znJqn6HQ9KB4goir20mdZH+tRt3YIeDKRsjJsRtNKUXughGeyV6cojlwt6VHqQf4qPCJC4tTEQP16S/h0fF8AOq2b5UEmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: rBZTx0fNRJyMxzRRnbd41Q==
X-CSE-MsgGUID: iDSmC5F5SVyUBctppa+HVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37296291"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="37296291"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 04:00:59 -0800
X-CSE-ConnectionGUID: MTsEOGT3RuqVpMlRuYJYOQ==
X-CSE-MsgGUID: oZQx0DBGRsq0E9xX5ITAPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110105501"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 04:00:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tYOYP-00000001enb-3ENr;
	Thu, 16 Jan 2025 14:00:53 +0200
Date: Thu, 16 Jan 2025 14:00:53 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Andre Werner <andre.werner@systec-electronic.com>,
	gregkh@linuxfoundation.org, hvilleneuve@dimonoff.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	lech.perczak@camlingroup.com
Subject: Re: [External Email] Re: [PATCH v1] serial: sc16is7xx: Extend IRQ
 check for negative valus
Message-ID: <Z4j09SbPVysrZtQt@smile.fi.intel.com>
References: <Z4jLU75SU53VGsRU@smile.fi.intel.com>
 <20250116093203.460215-1-andre.werner@systec-electronic.com>
 <be1bc254-da95-47c2-b81c-e630c0f924b2@kernel.org>
 <5556e4f7-79b1-af02-7456-fac9800a173f@systec-electronic.com>
 <516509cc-23d9-41b3-a3a2-f0c66d8c2af2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <516509cc-23d9-41b3-a3a2-f0c66d8c2af2@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 16, 2025 at 11:01:30AM +0100, Jiri Slaby wrote:
> On 16. 01. 25, 10:52, Andre Werner wrote:
> > On Thu, 16 Jan 2025, Jiri Slaby wrote:
> > > On 16. 01. 25, 10:32, Andre Werner wrote:
> > > > Fix the IRQ check to treat the negative values as No IRQ.
> > > 
> > > Care to describe on what HW that can happen?
> > 
> > I have no example on that. In the previous thread it was mentioned that
> > it is not absolutely sure that the API is not called with negative values. Thus,
> > negative values shall also be treated as no IRQ.
> 
> SPI:
>         if (spi->irq < 0)
>                 spi->irq = 0;

In all cases of how SPI target device is instantiated? I haven't checked myself
all those (three or four? or even five?) ways.

> I2C:
>                 if (irq < 0)
>                         irq = 0;

> So unlikely :).

Yes, but none of them _guarantees_ that (looking at the documentation and
the field type in the respective data structures).

Until there no guarantees, I would consider this patch as robustness increase.

-- 
With Best Regards,
Andy Shevchenko


