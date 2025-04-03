Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FAE24BBF5;
	Thu,  3 Apr 2025 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743680184; cv=none; b=Np+O8Ym1wDG2zzyhS+0ytauIFEsZpXvJ54I/ab8wrsJVuP+PQBBQRNKYrof/3Oxix/iaccVgVIDE6t8dfcmV8WDwGGKITatlVS+d+a/hqESW9e6EuX2B/C/axJJcR0zL43s20Js8lG65ZGoEXG12jadqduEU+NsXkaV4SD2hRZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743680184; c=relaxed/simple;
	bh=+/iLoM0QmXyYyf6XoRz9tlNCq1yISogUWZb6/Gw0wQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvS00qCPuTnHrpcwIjNpGd0mrB8OppvP66DNJrHJ64hwKM3pS0Gp0WQOcgYxtfK0EQMQyCIzfDk0R9r1L57/CXrQwr9O3rUNB7ia7yaI/Aly+tDDjtzbIukeWv/JHhPvdKXigl0OJLbjLvvSmP+2kbsrwQJmG5ITT/G92Jh224o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZFJl0D1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZFJl0D1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743680183; x=1775216183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+/iLoM0QmXyYyf6XoRz9tlNCq1yISogUWZb6/Gw0wQQ=;
  b=OZFJl0D1+1W3saweduUCEI6KRlYW09ZygKBo1Y4kXNaKNv+wyq0nvM2V
   ZttXFYVj40quGBOD8KeNAH/Z6mr+OOtS+dyhCr/ui2gwtHPGsX+sa1RHJ
   nOR72dYQOCAddvLVOmrXnAF/Phfbn14weum4HM6FwnEWPCm169tDuvafM
   e8VBZVHHAKJG1EQS5H2+mNuLYyMMRzagXCPJw2UWzX3RZdaXN9UWi2/9y
   VoMwykZhR8F4VYKyYcOCwjeW8z16szdSeBNnjgCmc5cQpd85utXYMRN3Z
   J/uRBAMl9sB60/IHUmZYYHzc85M3i9zj4llKw+++7qoqUWRaswVjQes9m
   A==;
X-CSE-ConnectionGUID: Bgu2SZHDT6+MgODCBWs3+g==
X-CSE-MsgGUID: R8d1XDTjQn6Upe6R0tP4Mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="70451625"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="70451625"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 04:36:22 -0700
X-CSE-ConnectionGUID: 6ticzHCWRBG1SipfImG8og==
X-CSE-MsgGUID: PXGYxZVbTC+jQyMaGHCsbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="126756000"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 04:36:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u0Iro-00000008n2E-14GI;
	Thu, 03 Apr 2025 14:36:16 +0300
Date: Thu, 3 Apr 2025 14:36:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	john.ogness@linutronix.de, pmladek@suse.com, arnd@arndb.de,
	namcao@linutronix.de, benjamin.larsson@genexis.eu,
	schnelle@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: fix panic due to PSLVERR
Message-ID: <Z-5yr2mFaDt8kxC-@smile.fi.intel.com>
References: <20250403090336.16643-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403090336.16643-1-cuiyunhui@bytedance.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 03, 2025 at 05:03:36PM +0800, Yunhui Cui wrote:
> When the PSLVERR_RESP_EN parameter is set to 1, the device generates
> an error response if an attempt is made to read an empty RBR (Receive
> Buffer Register) while the FIFO is enabled.
> 
> In serial8250_do_startup, calling serial_port_out(port, UART_LCR,

serial8250_do_startup()

> UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
> dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
> function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
> Execution proceeds to the dont_test_tx_en label:
> ...
> serial_port_in(port, UART_RX);
> This satisfies the PSLVERR trigger condition.
> 
> Because another CPU(e.g., using printk) is accessing the UART (UART

printk()

> is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) ==
> (lcr & ~UART_LCR_SPAR), causing it to enter dw8250_force_idle().
> 
> To resolve this issue, relevant serial_port_out operations should be

serial_port_out()

> placed in a critical section, and UART_RX data should only be read
> when the UART_LSR DR bit is set.

The last one is made in the common code, are you sure that all supported UARTs
will be okay with such a change?

> Panic message:

Please, read this
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages
and act accordingly.

> [    0.442336] Oops - unknown exception [#1]
> [    0.442337] Modules linked in:
> [    0.442339] CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.12.13-00102-gf1f43e345877 #1

Is it still reproducible on v6.14 (and soon v6.15-rc1)?

> [    0.442342] Tainted: [W]=WARN
> [    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
> [    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
> [    0.442354] epc : ffffffff8064efca ra : ffffffff8064af28 sp : ffff8f8000103990
> [    0.442355]  gp : ffffffff815bad28 tp : ffffaf807e36d400 t0 : ffffaf80804cf080
> [    0.442356]  t1 : 0000000000000001 t2 : 0000000000000000 s0 : ffff8f80001039a0
> [    0.442358]  s1 : ffffffff81626fc0 a0 : ffffffff81626fc0 a1 : 0000000000000000
> [    0.442359]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : ffffffff81626fc0
> [    0.442360]  a5 : ffff8f800012d900 a6 : 000000000000000f a7 : 000000000fc648c1
> [    0.442361]  s2 : 0000000000000000 s3 : 0000000200000022 s4 : 0000000000000000
> [    0.442362]  s5 : ffffffff81626fc0 s6 : ffffaf8085227000 s7 : ffffffff81073c58
> [    0.442363]  s8 : 0000000000500000 s9 : ffffaf80851a5a60 s10: ffffaf80851a5a60
> [    0.442365]  s11: ffffffff80e85980 t3 : ffffaf807e324600 t4 : 0000000000000002
> [    0.442365]  t5 : 0000000000000003 t6 : ffffaf80804cf072
> [    0.442366] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000013
> [    0.442368] [<ffffffff8064efca>] dw8250_serial_in32+0x1e/0x4a
> [    0.442371] [<ffffffff8064af28>] serial8250_do_startup+0x2c8/0x88e
> [    0.442373] [<ffffffff8064b514>] serial8250_startup+0x26/0x2e
> [    0.442375] [<ffffffff806428a2>] uart_startup+0x13a/0x308
> [    0.442377] [<ffffffff80642aa4>] uart_port_activate+0x34/0x50
> [    0.442378] [<ffffffff8062ab6a>] tty_port_open+0xb4/0x110
> [    0.442383] [<ffffffff8063f548>] uart_open+0x22/0x36
> [    0.442389] [<ffffffff806234b4>] tty_open+0x1be/0x5e6
> [    0.442396] [<ffffffff802f2d52>] chrdev_open+0x10a/0x2a8
> [    0.442400] [<ffffffff802e7ab6>] do_dentry_open+0xf6/0x34e
> [    0.442405] [<ffffffff802e9456>] vfs_open+0x2a/0xb4
> [    0.442408] [<ffffffff80300124>] path_openat+0x676/0xf36
> [    0.442410] [<ffffffff80300a58>] do_filp_open+0x74/0xfa
> [    0.442412] [<ffffffff802e9900>] file_open_name+0x84/0x144
> [    0.442414] [<ffffffff802e99f6>] filp_open+0x36/0x54
> [    0.442416] [<ffffffff80a01232>] console_on_rootfs+0x26/0x70
> [    0.442420] [<ffffffff80a0154e>] kernel_init_freeable+0x2d2/0x30e
> [    0.442422] [<ffffffff8099c730>] kernel_init+0x2a/0x15e
> [    0.442427] [<ffffffff809a7666>] ret_from_fork+0xe/0x1c
> [    0.442430] Code: e022 e406 0800 4683 0c15 691c 872a 96bb 00d5 97b6 (439c) 851b
> [    0.442432] ---[ end trace 0000000000000000 ]---
> [    0.442434] Kernel panic - not syncing: Fatal exception in interrupt
> [    0.442435] SMP: stopping secondary CPUs
> [    0.451111] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Fixes tag?
Cc to stable@?

...

>  	/*
>  	 * Now, initialize the UART
>  	 */

+ Blank line.

> +	uart_port_lock_irqsave(port, &flags);
>  	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
>  
> -	uart_port_lock_irqsave(port, &flags);
>  	if (up->port.flags & UPF_FOURPORT) {
>  		if (!up->port.irq)
>  			up->port.mctrl |= TIOCM_OUT1;

-- 
With Best Regards,
Andy Shevchenko


