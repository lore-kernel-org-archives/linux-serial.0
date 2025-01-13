Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326E81BEF7E;
	Mon, 13 Jan 2025 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736762084; cv=none; b=draR+49aiKcTQp5+BpmbqY+P/di4aZ5bAKMgWYPYdi3ZiGsz3m0Q1haFQXxHifEGCPmsqRjekRpHVPsO2X/9Uii9yRns8ApSHOb6SWM7UKJUo1ewJp4svsEffXu+tMQ3dsQcQXla6yzZtriLoOsaTY+Am/4/vjDzJbqLQRS/eRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736762084; c=relaxed/simple;
	bh=qigp+U4WstapoVqkIFX/CR6qidy2Lhh81loiEa2sM1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXfh/BZKagh1gnnSaxqP8HIIWl6Oym1XN357Y1mfI6xZ4zMZsIzvGjKske6ay7YOogrv4zzUW7yy1ZK6Jaqw46j6LLS02rfLpwFfN/aUDXfRgpQL/xalZgl5BEMrprtvuyfETQMnx8DY3nAK+w4SnVInFb88HHYf9PAHDbGPOpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QmlQHexr; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QmlQHexr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736762084; x=1768298084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qigp+U4WstapoVqkIFX/CR6qidy2Lhh81loiEa2sM1E=;
  b=QmlQHexrtt+8a4mgZbvXaecwzqxXVYVfdcoc7NFrBAydoVExIFnkqc/M
   qDDZG/eIZ2W3/bdzdYm+u1wydBaVcxV6sa7eBD+nxM/jQ2CgPT0VeusuA
   6lqHVE/jz1mcprQnVOwVm9/4rBKBYtkWVaDqklg40jVXBcF0PPuNHz80t
   lyT1Tw6GFShCxV9CtCLrFzqw5rVyfoSKOeKm5rMV4+L9eevmaENBUZywo
   wWlDY7ejZjK1jyugozlzdwT5y8DUeZwHPuaZBew52PkZySv3B/v7P4Nsj
   TUtByomf7ksLz87QnDNh67oyzPb0bu1ftXP6wqPJMwFkNJRGd6iLa5DFs
   A==;
X-CSE-ConnectionGUID: SEsY72gRRQ+LHW+Rc+ndMg==
X-CSE-MsgGUID: aX3sTt8aTkCvmpe2i1jZ6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="37033880"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37033880"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 01:54:42 -0800
X-CSE-ConnectionGUID: 2lJeD4zqRYegMDEzgeqI3A==
X-CSE-MsgGUID: Tcc7hzsmTXKnS0XMmd0dJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104986144"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 01:54:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tXH9X-00000000Pcv-2Bjg;
	Mon, 13 Jan 2025 11:54:35 +0200
Date: Mon, 13 Jan 2025 11:54:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH tty-next v5 2/6] serial: 8250: Use frame time to
 determine timeout
Message-ID: <Z4Ti24Sw4zo5-wqe@smile.fi.intel.com>
References: <20250107212702.169493-1-john.ogness@linutronix.de>
 <20250107212702.169493-3-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107212702.169493-3-john.ogness@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jan 07, 2025 at 10:32:58PM +0106, John Ogness wrote:
> Rather than using a hard-coded per-character Tx-timeout of 10ms,
> use the frame time to determine a timeout value. The value is
> doubled to ensure that a timeout is only hit during unexpected
> circumstances.
> 
> Since the frame time may not be available during early printing,
> the previous 10ms value is kept as a fallback.

...

> +	/*
> +	 * Wait for a character to be sent. Fallback to a safe default
> +	 * timeout value if @frame_time is not available.
> +	 */
> +	if (up->port.frame_time)
> +		tmout = up->port.frame_time * 2 / NSEC_PER_USEC;
> +	else
> +		tmout = 10000;

I would use it in a form of

		tmout = 10 * USEC_PER_MSEC;

This will give a hint of the real unit (10 ms in us).

-- 
With Best Regards,
Andy Shevchenko


