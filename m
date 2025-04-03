Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BE43597B;
	Thu,  3 Apr 2025 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743681011; cv=none; b=MVhRs9bJYJUeYuw1MSks/W2G02jGM316q5y63qlEXuJO6VsAWJ9DtOBtZ6s1oM3WxdWitCPSTh61zc0chiMKmd3dI4GAqmqZ6fvLTRxaPcWCVtRZyzfDFhuO3h9MarmsD/wLRYTgRHxhkVRqo34f2h+cfuQ3SfltlZ3rfmnH4C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743681011; c=relaxed/simple;
	bh=+LzFNjsmL3SNfJqe9YQUZ3eFxQ82oCA4DlG+FYehnoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FArvfbMxoOPHXMy6I4TJf+zNCe/yxfaYazgzJ2FF0MJ9nInnW5mqZkwKt7NCnThcNcmZP9yW3//J7FQQ8tzD8+YooH0VO6uYUoQExd2lXedeUXyxSoKaNNlaGo85+r5CjKhIppKnCBeP0JaJMBZKfjjU/Q2TXebT76uxbiKzV34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtHUJ8xk; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtHUJ8xk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743681010; x=1775217010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+LzFNjsmL3SNfJqe9YQUZ3eFxQ82oCA4DlG+FYehnoY=;
  b=OtHUJ8xkoE35f3IiWOODeZENJQK8I1QLJVI/wlPHbPThow0wjlw90QpA
   MQeOY0ZeeDkZWBRgihPVu8J0iHC+ZK3AA4COS1OSS5GhH08FzRmD+auIt
   lds/ieJfH9qJG8QnqOUQZKBuOK7QF+gG3XART6WG7pDwXugqxJJgBfb1W
   ZFb+1AuIzMXou+pW9zX2IghiLxASH5YKBcOfArk04Rns0B7UB6zqIH6oh
   sAXlmEBSv9RJOLnVe3zA7yXbJrYibYbM2Ai49yqbv2MSa12CUJai1HZWi
   ZhedwykYvWNBqxLokJ4iq9+DOyszxu2cv0yzDv4v8P+1gJo+c9A6FOYWJ
   A==;
X-CSE-ConnectionGUID: IlCM+875Sf2bINgpgi8C4w==
X-CSE-MsgGUID: KrVWz+hwQJqTFVLq/u4L6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="48948884"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="48948884"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 04:50:09 -0700
X-CSE-ConnectionGUID: RO5pSAYPQyynUlSBkqdI9Q==
X-CSE-MsgGUID: c7UTmJr3Rm+sVlAgTflMhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="127836746"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 04:50:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u0J59-00000008nHc-2pLF;
	Thu, 03 Apr 2025 14:50:03 +0300
Date: Thu, 3 Apr 2025 14:50:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	john.ogness@linutronix.de, pmladek@suse.com, arnd@arndb.de,
	namcao@linutronix.de, benjamin.larsson@genexis.eu,
	schnelle@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: fix panic due to PSLVERR
Message-ID: <Z-51629pjyiZUIVy@smile.fi.intel.com>
References: <20250403090336.16643-1-cuiyunhui@bytedance.com>
 <Z-5yr2mFaDt8kxC-@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-5yr2mFaDt8kxC-@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 03, 2025 at 02:36:16PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 03, 2025 at 05:03:36PM +0800, Yunhui Cui wrote:

A couple of more questions here:
1) what is the DW IP version and where did you get the PSLVERR_RESP_EN
parameter from?
2) what is the setting of the UART_16550_COMPATIBLE parameter?

> > When the PSLVERR_RESP_EN parameter is set to 1, the device generates
> > an error response if an attempt is made to read an empty RBR (Receive
> > Buffer Register) while the FIFO is enabled.
> > 
> > In serial8250_do_startup, calling serial_port_out(port, UART_LCR,
> 
> serial8250_do_startup()
> 
> > UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
> > dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
> > function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
> > Execution proceeds to the dont_test_tx_en label:
> > ...
> > serial_port_in(port, UART_RX);
> > This satisfies the PSLVERR trigger condition.
> > 
> > Because another CPU(e.g., using printk) is accessing the UART (UART
> 
> printk()
> 
> > is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) ==
> > (lcr & ~UART_LCR_SPAR), causing it to enter dw8250_force_idle().
> > 
> > To resolve this issue, relevant serial_port_out operations should be
> 
> serial_port_out()
> 
> > placed in a critical section, and UART_RX data should only be read
> > when the UART_LSR DR bit is set.
> 
> The last one is made in the common code, are you sure that all supported UARTs
> will be okay with such a change?
> 
> > Panic message:
> 
> Please, read this
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages
> and act accordingly.
> 
> > [    0.442336] Oops - unknown exception [#1]
> > [    0.442337] Modules linked in:
> > [    0.442339] CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.12.13-00102-gf1f43e345877 #1
> 
> Is it still reproducible on v6.14 (and soon v6.15-rc1)?
> 
> > [    0.442342] Tainted: [W]=WARN
> > [    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
> > [    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
> > [    0.442354] epc : ffffffff8064efca ra : ffffffff8064af28 sp : ffff8f8000103990
> > [    0.442355]  gp : ffffffff815bad28 tp : ffffaf807e36d400 t0 : ffffaf80804cf080
> > [    0.442356]  t1 : 0000000000000001 t2 : 0000000000000000 s0 : ffff8f80001039a0
> > [    0.442358]  s1 : ffffffff81626fc0 a0 : ffffffff81626fc0 a1 : 0000000000000000
> > [    0.442359]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : ffffffff81626fc0
> > [    0.442360]  a5 : ffff8f800012d900 a6 : 000000000000000f a7 : 000000000fc648c1
> > [    0.442361]  s2 : 0000000000000000 s3 : 0000000200000022 s4 : 0000000000000000
> > [    0.442362]  s5 : ffffffff81626fc0 s6 : ffffaf8085227000 s7 : ffffffff81073c58
> > [    0.442363]  s8 : 0000000000500000 s9 : ffffaf80851a5a60 s10: ffffaf80851a5a60
> > [    0.442365]  s11: ffffffff80e85980 t3 : ffffaf807e324600 t4 : 0000000000000002
> > [    0.442365]  t5 : 0000000000000003 t6 : ffffaf80804cf072
> > [    0.442366] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000013
> > [    0.442368] [<ffffffff8064efca>] dw8250_serial_in32+0x1e/0x4a
> > [    0.442371] [<ffffffff8064af28>] serial8250_do_startup+0x2c8/0x88e
> > [    0.442373] [<ffffffff8064b514>] serial8250_startup+0x26/0x2e
> > [    0.442375] [<ffffffff806428a2>] uart_startup+0x13a/0x308
> > [    0.442377] [<ffffffff80642aa4>] uart_port_activate+0x34/0x50
> > [    0.442378] [<ffffffff8062ab6a>] tty_port_open+0xb4/0x110
> > [    0.442383] [<ffffffff8063f548>] uart_open+0x22/0x36
> > [    0.442389] [<ffffffff806234b4>] tty_open+0x1be/0x5e6
> > [    0.442396] [<ffffffff802f2d52>] chrdev_open+0x10a/0x2a8
> > [    0.442400] [<ffffffff802e7ab6>] do_dentry_open+0xf6/0x34e
> > [    0.442405] [<ffffffff802e9456>] vfs_open+0x2a/0xb4
> > [    0.442408] [<ffffffff80300124>] path_openat+0x676/0xf36
> > [    0.442410] [<ffffffff80300a58>] do_filp_open+0x74/0xfa
> > [    0.442412] [<ffffffff802e9900>] file_open_name+0x84/0x144
> > [    0.442414] [<ffffffff802e99f6>] filp_open+0x36/0x54
> > [    0.442416] [<ffffffff80a01232>] console_on_rootfs+0x26/0x70
> > [    0.442420] [<ffffffff80a0154e>] kernel_init_freeable+0x2d2/0x30e
> > [    0.442422] [<ffffffff8099c730>] kernel_init+0x2a/0x15e
> > [    0.442427] [<ffffffff809a7666>] ret_from_fork+0xe/0x1c
> > [    0.442430] Code: e022 e406 0800 4683 0c15 691c 872a 96bb 00d5 97b6 (439c) 851b
> > [    0.442432] ---[ end trace 0000000000000000 ]---
> > [    0.442434] Kernel panic - not syncing: Fatal exception in interrupt
> > [    0.442435] SMP: stopping secondary CPUs
> > [    0.451111] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> 
> Fixes tag?
> Cc to stable@?
> 
> ...
> 
> >  	/*
> >  	 * Now, initialize the UART
> >  	 */
> 
> + Blank line.
> 
> > +	uart_port_lock_irqsave(port, &flags);
> >  	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> >  
> > -	uart_port_lock_irqsave(port, &flags);
> >  	if (up->port.flags & UPF_FOURPORT) {
> >  		if (!up->port.irq)
> >  			up->port.mctrl |= TIOCM_OUT1;

-- 
With Best Regards,
Andy Shevchenko


