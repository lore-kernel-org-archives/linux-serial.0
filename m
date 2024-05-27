Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FE113BC11;
	Mon, 27 May 2024 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716808416; cv=none; b=LlSU5tSP7ekmWicTZUX624gfJKR+AgZ9rYen6XWZr/59WWCZk3WgC38QHXG1+RxhASHDHZ6yNgfdrlrSWcghQoqemobXnto4RxqU+rc+bpXr3O8JE39fD3eV5d3GqJiEg+IbwMb4y3CcRJ1PbrQ5IbzRA/Wgl6Xxv8FAkiPEtYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716808416; c=relaxed/simple;
	bh=afdDbhmD9ThP1FKZTIsEe/wj5S44yknEdyXRvW/hwco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohkPDpJC2Rn4Vr+eIdxsc5V2LK4R5+30A0Vggi6uh+xR7K2UltsJ3IzkKIPij6PA91yRp8wqP7MZ2D6lFafgnSUXdC2edkUAKe9smVVSd8liBja2i6ECB7pezGAkKsrj/csvgWtiDRsZMM1GI3WrfW5Xj4D8QNMuUPTUuwEynV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UhffPI/f; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UhffPI/f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716808415; x=1748344415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=afdDbhmD9ThP1FKZTIsEe/wj5S44yknEdyXRvW/hwco=;
  b=UhffPI/fa0ytd3xp/4Yg+JTrzCXLBdnFtaii2cMaqq+B0uy/NTOo5tjh
   2RKlV+1cpb0XCedJ7mRzGUYp9IrPnkgQWcXcR1NwuNl/5QxapngANtTl8
   PFXxqHzLiyHAPEOmmH7ITVQd+35TW3/uCKTHuh81VadGh8DqdcIFGwonX
   5/0kb+Q5xDzJtLJi2CYLm25KtRSbqEJnu9Qf7LUKQvoivPoIGSJgEOoQA
   Vim1RBC3NXY6LXGPaNigAqwTG5Dg6k4Wu8ji9hKq1V3EXZJUQGqGZ3bdh
   q38jNxS/MAX6anNhVCy2DBuZ26+rFc2/w2XGs1qIz4ZoE31Cs40Vt5P1P
   A==;
X-CSE-ConnectionGUID: sKOhbvxISu+GW5VuNg+XLQ==
X-CSE-MsgGUID: D3S0EL7zSaS25dlmLDxCWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="16069203"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="16069203"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 04:13:34 -0700
X-CSE-ConnectionGUID: fwN1LcrQSqe8uHf9/d/h2w==
X-CSE-MsgGUID: zxrOB3amRoymbBaomYW/Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="35219496"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO tlindgre-MOBL1) ([10.245.244.124])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 04:13:27 -0700
Date: Mon, 27 May 2024 14:13:19 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 1/7] printk: Save console options for
 add_preferred_console_match()
Message-ID: <ZlRqz2b0ZrtkxScL@tlindgre-MOBL1>
References: <20240327110021.59793-1-tony@atomide.com>
 <20240327110021.59793-2-tony@atomide.com>
 <ZlC6_Um4P4b-_WQE@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlC6_Um4P4b-_WQE@pathway.suse.cz>

Hi,

On Fri, May 24, 2024 at 06:06:21PM +0200, Petr Mladek wrote:
> I have finally found time to looks at this again.

Great good to hear.

> First, about breaking the preferred console:
> 
> The patchset still causes the regression with /dev/console association
> as already reported for v3, see
> https://lore.kernel.org/r/ZWnvc6-LnXdjOQLY@alley

Thanks and sorry for missing this issue. I thought I had this issue
already handled, but looking at what I tested with earlier, looks like
I had the console options the wrong way around.
 
> I used the following kernel command line:
> 
>    earlycon=uart8250,io,0x3f8,115200 console=ttyS0,115200 console=tty0 ignore_loglevel log_buf_len=1M
> 
> The patchset caused that /dev/console became associated with
> ttyS0 instead of tty0, see the "C" flag:
> 
> 	original # cat /proc/consoles
> 	tty0                 -WU (EC    )    4:1
> 	ttyS0                -W- (E  p a)    4:64
> 
>    vs.
> 
> 	patched # cat /proc/consoles
> 	ttyS0                -W- (EC p a)    4:64
> 	tty0                 -WU (E     )    4:1

OK

> I have added some debugging messages which nicely show the reason.
> In the original code, __add_preferred_console() is called twice
> when processing the command line:
> 
> [    0.099312] __add_preferred_console[0]: ttyS, 0 (preferrred_console == 0)
> [    0.099982] __add_preferred_console[1]: tty, 0 (preferrred_console == 1)

OK thanks for tracking down where things go wrong.

> The code thinks that "ttyS0" has been mentioned on the command line
> once again. And preferred_console is _wrongly_ set back to '0'.
> 
> My view:
> 
> The delayed __add_preferred_console() is a way to hell.
> 
> The preferences are defined by the ordering on the command line.
> All entries have to be added when the command line options are
> being proceed to keep the order.

To me it seems we can fix this by keeping track of the console position
in the kernel command line. I'll send a fix for this to discuss.

> A solution might be to store "devname" separately in
> struct console_cmdline and allow empty "name". We could
> implement then a function similar to
> add_preferred_console_match() which would try to match
> "devname" and set/update "name", "index" value when matched.
> 
> Note that we might also need to add some synchronization
> if it might be possible to modify struct console_cmdline
> in parallel.

OK certainly no objection from me if we can make this happen without
making things more complex :)
 
> Second, about the possible duplication:
> 
> I might get it wrong. IMHO, in principle, this patchset tries
> to achieve similar thing as the "match()" callback, see
> the commit c7cef0a84912cab3c9 ("console: Add extensible
> console matching").
> 
> The .match() callback in struct console is to match, for example,
> console=uart8250,io,0x3f8,115200 when the uart8250 driver
> calls register_console() when it is being properly initialized
> as "ttyS".
> 
> BTW: The .match() needs saved options because it internally calls
>      .setup() callback. IMHO, this is a very ugly detail
>      which complicates design of the register_console() code.
> 
> 
> Both approaches try to match a "driver/device-specific name" with
> the generic "ttySX".
> 
>     console=uart8250,io,0x3f8,115200	=> ttyS0
> vs.
>     console=00:00:0.0,115200		=> ttyS0
> 
> 
> Where console=uart8250,io,0x3f8,115200 is handled by:
> 
>     - "uart" is added to console_cmdline[]
>     - matched directly via newcon->match() callback
> 
> vs. console=00:00:0.0,115200
> 
>     - 00:00:0.0 is added to conopt[]
>     - "ttyS0" added to console_cmdline[] when "00:00:0.0" initialized
>     - "ttyS0" is then matched directly
> 
> 
> Question: Would it it be able to use the existing .match() callback
> 	  also to match the DEVNAME?
> 
> 	  Or somehow reuse the approach?

Thanks, I'll take a look if .match(), or some parts related to it, can
be used.

> 	  Could register_console() know how to generate possible
> 	  DEVNAME for the given struct console?

I don't think we can make much assumptions about the devices early on,
and we also have the console index -1 issue.

Regards,

Tony
