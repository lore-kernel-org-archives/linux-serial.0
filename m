Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725744;
	b=WLpJbI3w+RehI2+LH4mc0tISfP2w5jCtpBWnOIzNhFJKY1nMxhh3fXbKJxF5cg497gvJ
	 vUVTtKdElOJqMsD7BkPqdKnMAG/9x3uFHjNCVy0URq39OiatcwJXWJJZocZaCqssfzdI5
	 nKNkuZMLOVLPLyED+9a1jH9F8SX2x0ax1SyxYXgJF4emHQmw+ybHvGShzL108W5DP13ly
	 CIBYeTp5bylnLVN1juJ4yuePhHfUGvWNmQ+zoLncagESrPGzv609TNDqgS22O19mcHbtg
	 RnKjtbtRR+ZFEmLxsmBkbLEV6Xanm6el2x9lxbjKQ7lzFrJmpP8pnB2VT5r32XnB3Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725744;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=7OtorZTCub4hIrC0NxSIXMmmJ1EiV6CLt9CpRNRER7w=;
	b=hl1dUUxwF901wwmUWYqyCXLD0yENcrTITVl+mhXnDYIyw3To3pSCjdRPkjPtad9ptX5S
	 ZGhq8vKbZnjyKctJmbJxYLMRxNCv7num5SKgVioh+fhBVtVgAYk7DF2KeM+lrlT5C6j5s
	 cqdUT9kOPTVCUSjJt17uhuk+AOUxLufJ0uBmpy9lmHAa3c2y1+kqZmpKHnzrcHutXzvpb
	 gQtcBSM5SdWigges1IkSF36Y3OU5StMwuTugUJEP6zmws4OQiKQ2mYl8UJNFAi83zyWdp
	 dPtWD1tEX2Ou/hd3tA7TtOePPFI82MER3M2hurpp2uJvn8gYvlQQGqc2ve36ZB8zFPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="YgEMMH/p";
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22A6606A324;
	Tue,  3 Nov 2026 17:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D22A6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YgEMMH/p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793725739; x=1825261739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kzOMXBdWLJQFKe7hbRAZJzr2q8dSOIdKIXVdm/WjI1A=;
  b=YgEMMH/p6LovTgmA23R4KcmYZt8OJjVm0+G6PCe7QI/P2OBtnMRHrHEn
   BoxhDVES4/8olMRSYHqsGfKBao7p668dznsdVGj/rSrWSX3aUgGisMjZ8
   2t6/eeOxLdxq7p2eB1ESS6Ipyl71NmuIJ3o0R77I/iFzt6d+L+OjgqwsH
   1OY3htUENjMvojS36/UbM7xQYJcOfD+v9oyG7cncaBj2pwqCBcY+uc0XA
   lvkTOUiUjTI4FpCqVwKIHoZPR0FPjnVGuPY+5uanZhKBhdHKqAJV0tmoR
   7zMQp9zFCpjjkhfCymZVc7on72bngX3GKOhS2CLKzEx2WxrTGhPxw/0ZM
   w==;
X-CSE-ConnectionGUID: cOlapIepS3CfYtes1euwVA==
X-CSE-MsgGUID: v20VG5MHS8uk9/PHGkh2DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2343740"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2343740"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:08:58 -0800
X-CSE-ConnectionGUID: l3z2TcvyTaalmoEHrpiZCQ==
X-CSE-MsgGUID: /HBnWMLARr6XaNehCmxvyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6560590"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:08:52 -0800
Date: Tue, 3 Nov 2026 19:08:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raul E Rangel <rrangel@chromium.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Timur Tabi <timur@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 5/8] serial: core: allow drivers to reserve flushed
 transmit storage
Message-ID: <auoVIR05PNyU8EEt@ashevche-desk.local>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
 <20261102-submit-serial-8250-dma-cancel-v1-v9-5-9159caade148@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-5-9159caade148@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 04:14:32PM -0700, James Hilliard wrote:
> uart_flush_buffer() resets the transmit FIFO before calling the driver's
> flush callback. An asynchronous DMA transfer can still access that storage
> after the callback returns, while a new write can immediately reuse it.
> 
> Add uart_xmit_block() and uart_xmit_unblock() so a driver can reserve the
> flushed storage until its transfer and completion callbacks have retired.
> Serialize the reservation with FIFO producers using the port lock.
> 
> While the storage is reserved, write_room() reports no space and write()
> and put_char() accept no data. Defer write-ready notifications until the
> reservation is released, preserving one-shot TTY wakeups. Keep the flush's
> write-ready notification under the port lock so it cannot race another
> reservation.
> 
> Wake tty->write_wait after flushing even when writes remain blocked.
> tty_wait_until_sent() waits for the logical FIFO to empty, independently
> of whether its storage can be reused. Notify these drain waiters without
> invoking the line discipline's write_wakeup() callback, so a reservation
> does not prevent a completed logical flush from waking a drain waiter or
> consume a one-shot write-ready notification prematurely.
> 
> Suppress ordinary TX starts while the FIFO storage is blocked. Preserve
> high-priority flow-control characters, which use separate storage.
> Releasing the reservation wakes writers through the existing TTY wakeup
> path. This preserves immediate logical flushing while applying write
> backpressure until the storage is reusable.
> 
> Track port readiness separately from DMA ownership. Retirement releases the
> reservation even during startup or shutdown, while writes and wakeups stay
> gated until successful startup or resume. Reopening or restarting a port
> wakes deferred writers with either a new or retained FIFO. Restart queued
> output when reusing a FIFO after suspension. Keep its write-ready
> notification pending until the retained output drains below the normal
> wakeup threshold.
> 
> Publish resume readiness under the same port lock as the TX restart,
> without clearing any reservation. A concurrent flush can then reserve a
> new transfer without resume releasing its storage prematurely.
> 
> Assert the port-lock requirement at uart_write_wakeup(), alongside the
> reservation helpers, so callers cannot inspect readiness or release a
> one-shot notification concurrently with a reservation change.

...

> +	/* Retained output must drain before consuming a write-ready notification. */
> +	if (kfifo_len(&state->port.xmit_fifo) < WAKEUP_CHARS)
> +		uart_write_wakeup(port);

I believe I have seen this already a few times. Perhaps a helper with
documented idea behind it?

-- 
With Best Regards,
Andy Shevchenko


