Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4191F5825;
	Thu,  3 Apr 2025 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743682250; cv=none; b=HEhYdkUYQvNT9ItNOCzhDLPm3gcEt9AWJYu7li0wt975oeFcdyt1O27jkZQOfgJLafckG6MBWXmf6qyYihkjfTd52ahZLRF/FQRemjDvFIIHPBF/6SF0wJTqRaDU7pOyVVSVhhp25re3jmiSAqPZ5+fPw7N2TOSMWbiPTFuN9XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743682250; c=relaxed/simple;
	bh=eZLA8gurWW5QhHfAshLNQAxe+9JyzGLbwEv+PdeHV20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmxBp6xwS+z884VP0PKl6T3JOOgaK0TSHGEPQ+ONoBKGRksNyCfs7Dxq++NTtdZ5s7eMB2ql4OPLY7XgJEgd2RuD/UbIlWzfRomBZUVCcM6lCMObiqxlOQc9ZAikYahQWLe08fOuvfCXCZpTJ1BgithVTLPXxAEUBQf9XkXF9Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0w2JJom; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0w2JJom"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743682250; x=1775218250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eZLA8gurWW5QhHfAshLNQAxe+9JyzGLbwEv+PdeHV20=;
  b=O0w2JJomZ7d5togwmILAGoK4GDPBZQRrafkyLnPR3JM0UEUN2mOPXvrJ
   32dF5KIQDmVbpiSlqd3JWSJNlhS1Hoag9+Sx8WDdWq/3mLPXFNyy+cKqF
   UAUWCJNQIwknJJx/lNB6C9nt1j0pdQX825LPx4iJRf2Y+zEzMpHmH72lL
   g418hKy5Hf4EB6n3daA6qbGuJyrZeX4begqmjoR/IT7P9rhmRExaJgr2T
   5OuwKY0u73Bh/qiJMk/IsQEjgjHO1FAyQXsFXcrxELWgNNWHAFneMiwsO
   l+U6fOrA/KSnZa2vygc7SSf0xj6vLUJ/qSfpJ63Ex2ZxD7n//AEsB+KO/
   g==;
X-CSE-ConnectionGUID: 3CEdJYWwQOW/c6MePtdwyA==
X-CSE-MsgGUID: SUpytyk1Qnitqv2gVBtYdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="48745742"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="48745742"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 05:10:49 -0700
X-CSE-ConnectionGUID: isvUFOscRjKsW5BrpWUmsg==
X-CSE-MsgGUID: FQRvObTFTDGe62O8Kp0rvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="150189112"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 05:10:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u0JP8-00000008neC-2y2Z;
	Thu, 03 Apr 2025 15:10:42 +0300
Date: Thu, 3 Apr 2025 15:10:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Yunhui Cui <cuiyunhui@bytedance.com>, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, pmladek@suse.com, arnd@arndb.de,
	namcao@linutronix.de, benjamin.larsson@genexis.eu,
	schnelle@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: fix panic due to PSLVERR
Message-ID: <Z-56wshiZz_1wU__@smile.fi.intel.com>
References: <20250403090336.16643-1-cuiyunhui@bytedance.com>
 <84iknl5uex.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84iknl5uex.fsf@jogness.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 03, 2025 at 02:03:58PM +0206, John Ogness wrote:
> On 2025-04-03, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> > When the PSLVERR_RESP_EN parameter is set to 1, the device generates
> > an error response if an attempt is made to read an empty RBR (Receive
> > Buffer Register) while the FIFO is enabled.
> >
> > In serial8250_do_startup, calling serial_port_out(port, UART_LCR,
> > UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
> > dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
> > function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
> > Execution proceeds to the dont_test_tx_en label:
> > ...
> > serial_port_in(port, UART_RX);
> > This satisfies the PSLVERR trigger condition.
> >
> > Because another CPU(e.g., using printk) is accessing the UART (UART
> > is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) ==
> > (lcr & ~UART_LCR_SPAR), causing it to enter dw8250_force_idle().
> 
> Didn't this[0] patch resolve this exact issue?

I see it applied (in v6.0), but version in the traceback seems from v6.12.
I think this is about race condition so only locking parts should suffice.

> [0] https://lore.kernel.org/lkml/20220713131722.2316829-1-vamshigajjela@google.com

-- 
With Best Regards,
Andy Shevchenko


