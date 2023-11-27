Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtYMQAuf"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD2BCE
	for <linux-serial@vger.kernel.org>; Mon, 27 Nov 2023 08:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701101227; x=1732637227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZmTAIWMlDZZTla7IcryRM3imxMHiZ4p9enOzoZqgVyM=;
  b=JtYMQAufgcu4IxSv6+P/id63rFgXNQu/K4DaKi0ExOx8yMWPdr0uSnKT
   mdHiO7RMYQ0P9FvRbDQwfRO8nay07LLKq2eCZKcUu7hD6j2xxDLRQkul3
   FgUOU5qOgcMMR6jB0Ndyqp8+Tl1Bovu5E5RI3GJQ57RNE62DgNMmL2eAt
   QEzPBQndV0grtrbmxgpOqw/xjtYhSHR1BkleW2dfFM4HvOIj371bAreBo
   R/itDApr3pSkmKdjgzTZzMzsaWUjCDwZaPcPWu2x4Q/VxndQpNPQqt0v9
   i0loHDTt7OP+NnCpe2oaSG+gXibPfTstzL0K1PSfHXRfuWHFYbR7v1b4F
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="377766540"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="377766540"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 08:07:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="941606890"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="941606890"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 08:07:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1r7e8U-0000000HYCl-1BUH;
	Mon, 27 Nov 2023 18:07:02 +0200
Date: Mon, 27 Nov 2023 18:07:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michael Pratt <mcpratt@pm.me>
Cc: linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Wander Lairson Costa <wander@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH] serial/8250: Set fifo timeout with uart_fifo_timeout()
Message-ID: <ZWS-pSDFMh0xx5Bv@smile.fi.intel.com>
References: <20231125063552.517-1-mcpratt@pm.me>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125063552.517-1-mcpratt@pm.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Nov 25, 2023 at 06:36:32AM +0000, Michael Pratt wrote:
> Commit 8f3631f0f6eb ("serial/8250: Use fifo in 8250 console driver")
> reworked functions for basic 8250 and 16550 type serial devices
> in order to enable and use the internal FIFO device for buffering,
> however the default timeout of 10 ms remained, which is proving
> to be insufficient for low baud rates like 9600, causing data overrun.
> 
> Unforunately, that commit was written and accepted just before commit
> 31f6bd7fad3b ("serial: Store character timing information to uart_port")
> which introduced the frame_time member of the uart_port struct
> in order to store the amount of time it takes to send one UART frame
> relative to the baud rate and other serial port configuration,
> and commit f9008285bb69 ("serial: Drop timeout from uart_port")
> which established function uart_fifo_timeout() in order to
> calculate a reasonable timeout to wait for all frames
> in the FIFO device to flush before writing data again
> using the now stored frame_time value and size of the buffer.
> 
> Fix this by using the new function to calculate the timeout
> whenever the buffer is larger than 1 byte (unknown port default).
> 
> Tested on a MIPS device (ar934x) at baud rates 625, 9600, 115200.

Do we need a Fixed tag?

...

>  	unsigned int status, tmout = 10000;
>  
> -	/* Wait up to 10ms for the character(s) to be sent. */
> +	/* Wait for a time relative to buffer size and baud */
> +	if (up->port.fifosize > 1)
> +		tmout = jiffies_to_usecs(uart_fifo_timeout(&up->port));

Why can't we simply use this one?

	unsigned int status, tmout;

	tmout = jiffies_to_usecs(uart_fifo_timeout(&up->port));
	for (;;) {

>  	for (;;) {
>  		status = serial_lsr_in(up);

-- 
With Best Regards,
Andy Shevchenko


