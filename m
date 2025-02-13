Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1900E20B209;
	Thu, 13 Feb 2025 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739434168; cv=none; b=ARlbKRBPX7O0dt2Ym5jlaRYvCXhUTpsFc0NmGswNkGSh0RWNw4BhOg3v7bELHyKuYmS6aqsVqmB+09TaickUGDqW7vUAcE7FvUSV7dyhdXv+SWT+oQrKCpt3rPGx1Uj8yXd0n/mK3mtWjH3OmHXxVIUr3juyjL3uRIxEJBieCCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739434168; c=relaxed/simple;
	bh=W9slmLEgwfMI1MJeemIMaWcXhgHgot5xKS72Ii/ulmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uh7ehd16h1w5j/fwF5HmE2wr9rv0t2vP8gkZ4/wI2aCOqPlHXQRkOsVe9s795gq4Dv5xtaByPgixU8RADghgYwMFk8dyf3914/tIARtiuonDIGjl47dW4Ot8qYXdTG5WOMseCJtBtx7a/sJZtkO0Iw4DroWp6jnvPh8pSD9AVrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXcuYDKA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXcuYDKA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739434167; x=1770970167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W9slmLEgwfMI1MJeemIMaWcXhgHgot5xKS72Ii/ulmU=;
  b=MXcuYDKAg8Rwhds6gS+fsX/amMmSKQvJuLjgdeEDLUQyN7BkR1F1P81n
   2VkSxslmMxWBGebgpk/gTXnqniQWA51V5RI4Jf3A+9wxrFUoXIG5Fi369
   q+IxnCWzorQ+Inb2w9K+Y3di5Oxdo2f8tbiwuUOfBLy4841FfHwQuqjvk
   L/9+y2+4mp/PDT7XKUvTU80xYxtj+YrFDJJJr22BOmS/iqsj6GdIZUdu7
   ZRxesQoSZkvWfSljOzq9VGldDUi/UIGDx0fWaKr/3CLMr7eWzA60lD45c
   1zaDQpNl0CmWZotvKm6RKNj6Sxc5MThhlB0rE05RlhNSx2sdpk86NGs4f
   Q==;
X-CSE-ConnectionGUID: 5SW3goOhR7epPZHOnj9lBA==
X-CSE-MsgGUID: qAjLNwPRSoeq4eupKmhrmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="39310948"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="39310948"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 00:09:26 -0800
X-CSE-ConnectionGUID: P3lpblIAQcefB4B+R52lfA==
X-CSE-MsgGUID: sx1hI1lLQkqqOvfWD3cbBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113968316"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 00:09:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiUHe-0000000B6H9-0ZfZ;
	Thu, 13 Feb 2025 10:09:18 +0200
Date: Thu, 13 Feb 2025 10:09:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Kartik Rajput <kkartik@nvidia.com>, gregkh@linuxfoundation.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	thierry.reding@gmail.com, jonathanh@nvidia.com,
	hvilleneuve@dimonoff.com, arnd@kernel.org, geert+renesas@glider.be,
	robert.marko@sartura.hr, schnelle@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/2] serial: tegra-utc: Add driver for Tegra UART
 Trace Controller (UTC)
Message-ID: <Z62orWpDF5obQZLy@smile.fi.intel.com>
References: <20250212104132.61060-1-kkartik@nvidia.com>
 <20250212104132.61060-3-kkartik@nvidia.com>
 <Z6y5vRGyouZsQWyj@smile.fi.intel.com>
 <6f3e6958-25eb-4835-88e1-2d531c892dbe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f3e6958-25eb-4835-88e1-2d531c892dbe@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 13, 2025 at 08:38:15AM +0100, Jiri Slaby wrote:
> On 12. 02. 25, 16:09, Andy Shevchenko wrote:

...

> > > +	pending = uart_port_tx(port, c,
> > > +		     !(tegra_utc_tx_readl(tup, TEGRA_UTC_FIFO_STATUS) & TEGRA_UTC_FIFO_FULL),
> > > +		     tegra_utc_tx_writel(tup, c, TEGRA_UTC_DATA));
> > 
> > Make the last two to reside in temporary variables with self-explanatory names.
> 
> Not sure what you mean here? They are needed to be evaluated (read/written)
> in every loop.

Ah, uart_port_tx() is a macro!

-- 
With Best Regards,
Andy Shevchenko


