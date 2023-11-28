Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHrsegpK"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFE2D56
	for <linux-serial@vger.kernel.org>; Tue, 28 Nov 2023 04:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701174171; x=1732710171;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GnkgnwXG9W6HaGzUvKw+GdXvCDSude1TEJi09Y/j6gc=;
  b=fHrsegpK/NRo1c7S8CGkXj+WB2Pb5Vag7WGxrMSclM5LOpOPBqY4bcHx
   Mp7JZ/qZIeydAGePGHvdZQiPSBoMsPdEN4KKuFAZQ20F9KN+YM7P127pf
   GzvEJ+dkjirhGyjKmsIJfdZ+M0Wk4kQ+9oQMO8k4G3orNkT5LhjR0Xo+I
   vKr9/S6EZUDhgqyhpmIjhiO6vu5STcs2axn2UQ3oI8HHJY6UJZ2sb2lnf
   vNhxpo7CUneAZZfHqTn04roLp8P6m9QXCIty8JhCSawiqclvL2n0B4tbr
   WIhYG0kdPJ45ZQH7vrhy90NLjio7qMLe7vubYJpXSxA0WZ072TDZH8SNm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="390066587"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="390066587"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 04:22:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="941904516"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="941904516"
Received: from haslam-mobl1.ger.corp.intel.com ([10.252.43.79])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 04:22:47 -0800
Date: Tue, 28 Nov 2023 14:22:45 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: mcpratt@pm.me
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Wander Lairson Costa <wander@redhat.com>, 
    Vamshi Gajjela <vamshigajjela@google.com>
Subject: Re: [PATCH] serial/8250: Set fifo timeout with uart_fifo_timeout()
In-Reply-To: <HPbnILrnlwSUYDSVm3nL_lHYYxueg4aCdoUL3rHZTk3qLuY05GzBCibJS7GBFolJi7Mr4egmTPxjWYt3TGbQ8N9ate8rRvdq31z9BL04sVY=@pm.me>
Message-ID: <26d2d26-7ead-b62-4636-bb34da636cf0@linux.intel.com>
References: <20231125063552.517-1-mcpratt@pm.me> <ZWS-pSDFMh0xx5Bv@smile.fi.intel.com> <HPbnILrnlwSUYDSVm3nL_lHYYxueg4aCdoUL3rHZTk3qLuY05GzBCibJS7GBFolJi7Mr4egmTPxjWYt3TGbQ8N9ate8rRvdq31z9BL04sVY=@pm.me>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

+ Cc Vamshi

On Tue, 28 Nov 2023, mcpratt@pm.me wrote:
> On Monday, November 27th, 2023 at 11:07, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Sat, Nov 25, 2023 at 06:36:32AM +0000, Michael Pratt wrote:
> > 
> > > Commit 8f3631f0f6eb ("serial/8250: Use fifo in 8250 console driver")
> > > reworked functions for basic 8250 and 16550 type serial devices
> > > in order to enable and use the internal FIFO device for buffering,
> > > however the default timeout of 10 ms remained, which is proving
> > > to be insufficient for low baud rates like 9600, causing data overrun.
> > > 
> > > Unforunately, that commit was written and accepted just before commit
> > > 31f6bd7fad3b ("serial: Store character timing information to uart_port")
> > > which introduced the frame_time member of the uart_port struct
> > > in order to store the amount of time it takes to send one UART frame
> > > relative to the baud rate and other serial port configuration,
> > > and commit f9008285bb69 ("serial: Drop timeout from uart_port")
> > > which established function uart_fifo_timeout() in order to
> > > calculate a reasonable timeout to wait for all frames
> > > in the FIFO device to flush before writing data again
> > > using the now stored frame_time value and size of the buffer.
> > > 
> > > Fix this by using the new function to calculate the timeout
> > > whenever the buffer is larger than 1 byte (unknown port default).
> > > 
> > > Tested on a MIPS device (ar934x) at baud rates 625, 9600, 115200.
> > 
> > 
> > Do we need a Fixed tag?
> > 
> > ...
> 
> 
> Hi Andy,
> 
> I'm not sure whether this qualifies as a "bug fix" or not,
> since the proper way to handle it was introduced after the "bad" commit,
> and the "bad" commit happens to still work fine for anyone running the
> standard 115200 baud or higher.

Sometimes the proper way is then backported too to stables, but it needs
to be checked how complicated that seems.

So basically you'd need 31f6bd7fad3b and at least a part of f9008285bb69?

> For that matter, I'm not even sure if this affects other hardware,
> I'm only able to test this on a MIPS SOC, and I wonder if anyone can
> reproduce it on something else.
> 
> If that level of accuracy doesn't matter for tags, then yes I suppose
> it should be tagged as "Fixes".
> 
> 
> 
> > 
> > > unsigned int status, tmout = 10000;
> > > 
> > > - /* Wait up to 10ms for the character(s) to be sent. /
> > > + / Wait for a time relative to buffer size and baud */
> > > + if (up->port.fifosize > 1)
> > > + tmout = jiffies_to_usecs(uart_fifo_timeout(&up->port));
> > 
> > 
> > Why can't we simply use this one?
> > 
> > unsigned int status, tmout;
> > 
> > tmout = jiffies_to_usecs(uart_fifo_timeout(&up->port));

I wonder if fifosize is always >= 1?

> > > for (;;) {
> > > status = serial_lsr_in(up);
> 
> 
> Again, I'm not sure which is better for performance, between adding
> a conditional check or doing the math for every case.
> The 10 ms timeout has been there since the beginning of the git history,
> so clearly it is enough for single-frame transfers at any baud.
> The new function uart_fifo_timeout() provides a variable timeout, but starting out
> with an arbitrary 20 ms as a minimum, which I think can be traced back
> to some hardware-specific workaround...

Would you happen to have a pointer for that 20 msecs is for HW 
workaround information bit

I'd kind of want to lower it and base the extra delay on frame time 
rather than, like you say, on arbitrary number.

> but definitely much more
> than what's needed for most cases (115200 baud needs at least ~1.5 ms).
> 
> I'd let you all decide, and I can adjust the patch if needed.
> 
> --
> Thanks for your time
> MCP
> 

-- 
 i.

