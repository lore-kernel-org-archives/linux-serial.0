Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B136DA93D;
	Wed, 18 Jun 2025 05:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750225740; cv=none; b=eZ9oQod7fzHYEuDE0Pl6ONgo6ztweM3zyTt4cAYR14D4Wo5D6WzD17Uf6C08yxl/VS2PycoFaa/6+y1M2P21VtdL7Km3XsKTPMxMd54ZbuovAbjpow+ag1N/eEuYt+F8yxOH5lK6UzomKNK4HyxoWLRkZxNg1f5XEbrD5YxQ2GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750225740; c=relaxed/simple;
	bh=0t4p8OABWaqZSIgV2AO/AGAOkVnzT1MLBwZEUajBQGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ynw/J2hMN9vOmh7fkAM09bw3N7PKQnBaYfzJWoeAuVq2gIg8OGO5LyEJhtgoxpy9p1IjN401FFek0MoUYks+pH9hjUdWQ3PL49F/ZbHBWMMCKjwEhgbJ18fR3ghGfOW/+3j0kfPf+jGFUex4r0+vJYINIDK87MdFuczdzFNFiyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVLQy5xu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVLQy5xu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750225738; x=1781761738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0t4p8OABWaqZSIgV2AO/AGAOkVnzT1MLBwZEUajBQGI=;
  b=cVLQy5xuVMngWzTajRJ8OExOJy/2hiOM49u26hnI6U4AGvLX5tIDBmD7
   HXYjzarFc4kqfOxktYrc7V/+L5p51ojwRFpXsK8KsHzaeYjDX5ZwwtbBa
   431d5SKWRUAw6Fn93km4ng6CTfl2c4kQnIXKk2FsL9hc/kdGq+SWIfaLP
   vs2vKZQ2WX2SzRkk0oDnWQkV4Sq3/53LfddmVFDOTWvRssGCQHWXyvLzN
   eORUIdKF7cc9OuRbnR+6S9HD3KAUxZJd+NvqgarR4MhC9Jex04m1Sf8mE
   7u3Gr0ynjalw4gE9+lEwbgoHxM49xGii1WIwDAh/+xatiR8z9fjgntcaL
   w==;
X-CSE-ConnectionGUID: mxexm3Q+RJ2TkYxq4coybw==
X-CSE-MsgGUID: cK1zExnaQPmJQCgTn9GRTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52568543"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="52568543"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 22:48:53 -0700
X-CSE-ConnectionGUID: +k55VszYQI6t5YIPvw9vIg==
X-CSE-MsgGUID: 7a/nQIixQVya1mTu7WWcqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="180185537"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 17 Jun 2025 22:48:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 64E9012D; Wed, 18 Jun 2025 08:48:50 +0300 (EEST)
Date: Wed, 18 Jun 2025 08:48:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 30/33] serial: 8250: invert
 serial8250_register_8250_port() CIR condition
Message-ID: <aFJTQqVvmLBvrVRA@black.fi.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org>
 <20250611100319.186924-31-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611100319.186924-31-jirislaby@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 11, 2025 at 12:03:16PM +0200, Jiri Slaby (SUSE) wrote:
> There is no point in a long 'if' in serial8250_register_8250_port() to
> just return ENOSPC for PORT_8250_CIR ports. Invert the condition and
> return immediately.
> 
> 'gpios' variable was moved to its set location.
> 
> And return ENODEV instead of ENOSPC. The latter is a leftover from the
> previous find-uart 'if'. The former makes a lot more sense in this case.

...

> +	if (uart->port.type == PORT_8250_CIR) {
> +		ret = -ENODEV;
> +		goto unlock;
> +	}

> +	if (up->port.flags & UPF_FIXED_TYPE)
> +		uart->port.type = up->port.type;

> +	if (uart->port.type != PORT_8250_CIR) {

I admit that there tons of mysterious ways of UART initialisation, but can you
elaborate how this is not a always-true conditional?

> +		if (uart_console_registered(&uart->port))
> +			pm_runtime_get_sync(uart->port.dev);
> +
> +		if (serial8250_isa_config != NULL)
> +			serial8250_isa_config(0, &uart->port,
> +					&uart->capabilities);
> +
> +		serial8250_apply_quirks(uart);
> +		ret = uart_add_one_port(&serial8250_reg,
> +					&uart->port);
> +		if (ret)
> +			goto err;
> +
> +		ret = uart->port.line;
> +	} else {
> +		dev_info(uart->port.dev,
> +			"skipping CIR port at 0x%lx / 0x%llx, IRQ %d\n",
> +			uart->port.iobase,
> +			(unsigned long long)uart->port.mapbase,
> +			uart->port.irq);
> +
> +		ret = 0;
> +	}

-- 
With Best Regards,
Andy Shevchenko


