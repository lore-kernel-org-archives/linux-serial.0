Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B6645009;
	Sat, 28 Dec 2024 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735422691; cv=none; b=GA8TOAVOnJYlWMJsyBJz6eI1YQBUhFYZHh97zcUWvFNXOqgjeEP6ZGiPKuCbUGqunzVXeZ6mUqydVmFz9bDD+vWq+DKxDPfPiIMoyeG1jylF1rTAVDG/zIbbt8iVpNxbA8P24W/DtobceSOnobxCsooi5f4giP9GEQi04oIQvFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735422691; c=relaxed/simple;
	bh=Zn0yG6ajX7o5mx+4/Mh03+Sp4nkPUEYmOLASAfYQqv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaSQZpyGR42w/IQbN9wwSh04dYfTuVI1j8NpBTWRT9aftbb0ryOCAaHpUw7FSwJLMjRA0x5InoNDH0JnZ+Yuq9vw/es+ZdXtxGH4q9vaeKnXXU12bfvdmVOXaphihcJufZYVZU9n18X1qmKG52YC6M5EiFDkfkXuiPP4ncfxcSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WG9dx0va; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WG9dx0va"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735422690; x=1766958690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zn0yG6ajX7o5mx+4/Mh03+Sp4nkPUEYmOLASAfYQqv0=;
  b=WG9dx0vaz8meyTm1tTRXRgcem76CLvQ4ipN/4vEV0YMOOXgRSwtgxdDo
   +QOTxnV9SClXwWHOA8X+BEutZZqkxL3j55SKPVnnbREtXkLYFNgxPEmf3
   i+q5fsT7i5cZA//voX+GgWABmeVN+Z4Qkc4L0j3sPJDAOhHlRiRqETuEv
   bqHMhuRmwYEHZeN7/WPtjZq28a0j0RcZHOUyPpB7+YAGHh7zaTpWXXNYD
   aPGWSNhAGl9jnOeLaX+Cgj8TtRozHLWYYwh+qlYSrW83fQC5rNpCiAanO
   9wEN1pieafeD8IX9hw6VZ+kpszO6PdW6dHFLejiVYZrtIoNbdzTBVKmjz
   w==;
X-CSE-ConnectionGUID: JhPu3Ma6RqqJ8PWrJrDa5w==
X-CSE-MsgGUID: I8nRF20lT36KyWjOLwev+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="38607123"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="38607123"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 13:51:29 -0800
X-CSE-ConnectionGUID: dYseAHvYT7agOsAViW1E6g==
X-CSE-MsgGUID: PL9WuLUFSmeBHxUOJ5XnhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="100279041"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 13:51:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tReiQ-0000000DUYC-1WGZ;
	Sat, 28 Dec 2024 23:51:22 +0200
Date: Sat, 28 Dec 2024 23:51:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH tty-next v4 2/6] serial: 8250: Use frame rate to
 determine timeout
Message-ID: <Z3By2ji2aJBCuMjT@smile.fi.intel.com>
References: <20241227224523.28131-1-john.ogness@linutronix.de>
 <20241227224523.28131-3-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227224523.28131-3-john.ogness@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 27, 2024 at 11:51:18PM +0106, John Ogness wrote:
> Rather than using a hard-coded per-character Tx-timeout of 10ms,
> use the frame rate to determine a timeout value. The value is
> doubled to ensure that a timeout is only hit during unexpected
> circumstances.
> 
> Since the frame rate may not be available during early printing,
> the previous 10ms value is kept as a fallback.

...

>  	unsigned int status, tmout = 10000;
>  
> -	/* Wait up to 10ms for the character(s) to be sent. */
> +	/*
> +	 * Wait for a character to be sent. Fallback to a safe default
> +	 * timeout value if @frame_time is not available.
> +	 */

> +

Redundant blank line (esp. after addressing below).

> +	if (up->port.frame_time)
> +		tmout = up->port.frame_time * 2 / NSEC_PER_USEC;

This will be harder to maintain in case some new code will be squeezed in
between, so I propose to make it if-else.

-- 
With Best Regards,
Andy Shevchenko


