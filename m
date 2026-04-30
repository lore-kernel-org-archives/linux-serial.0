Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8F1175A75;
	Thu, 30 Apr 2026 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561419; cv=none; b=RgaPsSlNRMp7lOgB9ErUUMBLxGPGcTAPyNRDt+jJQRQjV81/VMyN1Api901ub9MJDoGvTUDhSXGHrK5e6WusBwzX3FXzHQou6VpjzfYiTb5uGdOpTLQtfNmCT64MfdTwsDt1J0Q6QIhObDm433pveAPTqbJzqRShtWtxOfu1Km8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561419; c=relaxed/simple;
	bh=hCtRkPIwadQN5Y1cNqb24+x6A58qAOh/ypHNMk0vwJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hI7w5aDCsfuVqwFrB32LWzRxbW2oUGUc+Z3irn3tj1VHiMvDlNJD9PuAOAzpkWZbtpjL336UL28arynCqRH0wnkbjvuxLAhv0twB7H28N+IEdZdpyZ0s8PV8q/bfPHZBqMYG2T5RnBsKRO7dP3Hctf3fDZhdsR1Ij0q9HzfQ2EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VBmsHD2a; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VBmsHD2a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777561418; x=1809097418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hCtRkPIwadQN5Y1cNqb24+x6A58qAOh/ypHNMk0vwJQ=;
  b=VBmsHD2aYfdivgMzebYERSKfrY12uO6QzSmW1fot01gaJMzOZE1jFrER
   sYBA97NJAIxlH/5NdRisHHq6qxsYIYoHx+tnaaQ5x9QBWN/y0kz9x8u7t
   0pGzBTLJjqYIoeP3E3fz/2YBKGHcDl1qTMoDOC43dKVRSk1dPNRg7/fxW
   CeTKtANCnPm6k+bobBnLgcpIu4Tf3XMJGevJlp16gnHNhgXDv90uKyaIT
   AhaMPnM2RH0JxdfyZ58f4k3LkMCkZBPKZKSfvr3R4EqkPWMZiT/05QFGw
   /UW5l/w1/0nX0C3BNsbEjtOkB7tVjiBNhEfdFVMTzarJYsPgGFpksG/nD
   w==;
X-CSE-ConnectionGUID: sPhT+WbKRLGHdb5qKotVfg==
X-CSE-MsgGUID: utsfB6kCS4qrDfx1SRxQJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="78409668"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="78409668"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 08:03:38 -0700
X-CSE-ConnectionGUID: yqZWO9qYRW68P3uPQp74zg==
X-CSE-MsgGUID: PbcZEMPmSmmLpGhBd+EDPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="233758698"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 30 Apr 2026 08:03:36 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 3323995; Thu, 30 Apr 2026 17:03:35 +0200 (CEST)
Date: Thu, 30 Apr 2026 17:03:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v2 08/15] serial: earlycon: use uart_iotype_*() to
 simplify code
Message-ID: <afNvR59jmKu3-CoF@black.igk.intel.com>
References: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
 <20260428-tty-upio-v2-8-01c1857cf761@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-tty-upio-v2-8-01c1857cf761@dimonoff.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 28, 2026 at 01:53:54PM -0400, Hugo Villeneuve wrote:

> Make use of new functions uart_iotype_mmio() and uart_iotype_legacy_io()
> to simplify and improve code readability.

...

> +	char address[64] = "";

TBH, I prefer two pr_info() calls as that approach
- doesn't require temporary buffer
- doesn't use heavy s*printf() on top of the existing printing
- doesn't limit the flexibility of each of the strings (64 might
  become not enough in some cases, however unlikely to happen)

-- 
With Best Regards,
Andy Shevchenko


