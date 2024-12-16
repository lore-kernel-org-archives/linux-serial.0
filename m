Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8091F12E6;
	Mon, 16 Dec 2024 20:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381817; cv=none; b=ir3lgmMO83B8ZWtLOB9JgGdXfZfRpiQIeCe92ozytQIWvo1uuQaB59fHt1TMNyWQMotnvd7uHinvheXlxDbgbYOeaub8RvGZ1cYTjR0wsepVVgdwnkGIbqC59aB2OM31/US8kPFMaeqxVHOK8Jea/tzIWCPStitIxyuBqhOP1ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381817; c=relaxed/simple;
	bh=0BaMYlNAFb9HgkBB2xtOwGy6i64VF7BXefzM3e8O04k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcKZ74CmdBPLMfAKYcm/df0mbYjMSLkAshEXLlnwtzgqhv3Z1m3mWikXx0w6VKJqdYgpxvSGVH75dL+yk15/5E/030WdHW+F5f/NVcPieLnadmQNmc8XBE8vaWBqHgxwWloizB2pYFkLp6tumDJG4/cImbf+xagdc0Ae5ZUIKF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nzd+ovsV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzd+ovsV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734381816; x=1765917816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0BaMYlNAFb9HgkBB2xtOwGy6i64VF7BXefzM3e8O04k=;
  b=nzd+ovsVhXJKNZDkOeKBmyzJ6zl34lXDdCtWEt0f69gmWZnc6ft5cTqG
   UA4tZAKuJKbss4DsbuBD6cipmsxt9fA4/56jWZbWtJj2XxTplVHynve7f
   5XLt0CVzxlapNVY0WRZedB1tisX9xn2uZGBM6lPgpe2cJMzSZ3Iz6J7q2
   PbqGsvFPbS5X8liUEu13zIebuJ6fIadevomLwbv29dS3346vNEHDBiJ8I
   TjJ1ZDmtjc1UV1EPPKCoHOUhHdIsMj6MoPP2dnRTnKzXyzi4wPshEm9bs
   MyvyJeqd8+hkN7LQYmW0NPPKM6fR2WO1UE44da78bKfX7dvEX76fQ0e2M
   w==;
X-CSE-ConnectionGUID: kGe7aa+KTlmTx8jcRajLUg==
X-CSE-MsgGUID: J5risfCfRvCC0uGXK2N1qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45789175"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45789175"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 12:43:35 -0800
X-CSE-ConnectionGUID: gIugq1Y3SxO9rtM/B3lhDg==
X-CSE-MsgGUID: lIupBWCtQdGweZjkXjkIdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="97551785"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 12:43:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tNHw8-00000008jD7-10GU;
	Mon, 16 Dec 2024 22:43:28 +0200
Date: Mon, 16 Dec 2024 22:43:28 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH tty-next v1 1/4] serial: 8250: Use @ier bits to determine
 if Rx is stopped
Message-ID: <Z2CQ8NvNhIOpPcBn@smile.fi.intel.com>
References: <20241216171244.12783-1-john.ogness@linutronix.de>
 <20241216171244.12783-2-john.ogness@linutronix.de>
 <Z2COCeWqyauMYYyk@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2COCeWqyauMYYyk@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 16, 2024 at 10:31:06PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 16, 2024 at 06:18:41PM +0106, John Ogness wrote:
> > Commit f19c3f6c8109 ("serial: 8250_port: Don't service RX FIFO if
> > throttled") uses @read_status_mask (bit UART_LSR_DR) to determine
> > if Rx has been stopped. However, the bit UART_LSR_DR is not
> > managed properly in @read_status_mask for all Rx stop/start
> > situations and is therefore not suitable for this purpose.
> > 
> > Use the UART_IER_RLSI and UART_IER_RDI bits in @ier instead, as
> > this is already common in 8250-variants and drivers.
> 
> Hmm... IER is Interrupt Enable Register, so it has been programmed to the value
> we control, on the opposite the LSR is Line Status Register and defines status
> on the line at the moment of reading. Can you elaborate how your change is correct
> substitute?

Additionally the common IRQ handler may be called at last in the custom ones
and hence potentially the value of saved IER might be different to what the
actual register is programmed to.

Besides that I don't remember all of the mysterious ways of DMA. May it affect
the value of IER and when we swtich from DMA to PIO and vice versa we get an
incorrect value in the saved variable?

-- 
With Best Regards,
Andy Shevchenko


