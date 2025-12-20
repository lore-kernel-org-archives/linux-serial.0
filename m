Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2502D5932;
	Sat, 20 Dec 2025 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766242818; cv=none; b=YAgweidLA8YvdQXcISlQCtM+ZVIcLZd9nHM4Po5lFUmCKz7tiuTA4olN0lEV6b9puIUSJOY5pDfKoj8BhRE5pbHWDbawj4Bf4mJhS5l9RDszgX4AHNhRdnyhujE69fLWLRgzuLGr1eDlzgyzqQrsr9yCbp73rjSmgHmySmcAl+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766242818; c=relaxed/simple;
	bh=Zl/x/l+ntMqzLiAIf7xRigZ7suKHCDq5CNGwD/g6d2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReKCCOJSxv4yVY64wuSM83hEKKDx8LPWqXQfhp+fnIyOvBck2P000Jc5NGo5oWqJh4aTBuy1MxNhtXV3Jifg109AgOtTdXdDMHn47FNIU3lbvJeehVzyzk448xB7Q4ql8pSDLgy0JM2xrrQE1kwxfb/jf/45raHZ8FHnUeBA8Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RRl1PaEK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RRl1PaEK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766242817; x=1797778817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zl/x/l+ntMqzLiAIf7xRigZ7suKHCDq5CNGwD/g6d2Y=;
  b=RRl1PaEKlDwkLb7P9WDGyjZGDiHxNKOa4SGilUgDbPkoaots1/WA0Brx
   HR+XdP+Jd6YJfhIffTs7efh2peBGvhgOAbztqykVoA2LsGX2eCAqJZreE
   MpEsO01U8behYW70yOp9TfJ4F10g3CRVPT4z9Ym7kNgYJn4id90py/s5A
   PXg3EzSU4Jpi1cWOubCXWvWtR86B4qpvvDD2Qf35gJ5e//bPSo7T7dKKL
   ReMPJK8IjST/O8RpN1QUiVNLQM01YnGBP6pvxlsyW1tJzZOH+WSQ88TM7
   ex3miV5zXKiLt00WdI9PZ8Yf3WsbssACic/SvoYUqZV/+aTqJG+2KgASJ
   A==;
X-CSE-ConnectionGUID: wBxC3T4PT7y7SjzdF1xrKw==
X-CSE-MsgGUID: k3BG5SObT+6EX9dhSxx0Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="72034856"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="72034856"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 07:00:15 -0800
X-CSE-ConnectionGUID: GJ2Jc8Q1SHWOGtQOeDRYRw==
X-CSE-MsgGUID: fQF6PTBvQeGgrzEVyM4pNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="198360001"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 20 Dec 2025 07:00:12 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWyRF-000000004hd-0hcs;
	Sat, 20 Dec 2025 15:00:09 +0000
Date: Sat, 20 Dec 2025 22:59:30 +0800
From: kernel test robot <lkp@intel.com>
To: "j.turek" <jakub.turek@elsta.tech>, gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, michal.simek@amd.com,
	namcao@linutronix.de, tglx@linutronix.de, zack.rusin@broadcom.com,
	sean.anderson@linux.dev, hshah@axiado.com,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, "j.turek" <jakub.turek@elsta.tech>
Subject: Re: [PATCH] serial: xilinx_uartps: fix rs485 delay_rts_after_send
Message-ID: <202512202222.7nCGPOv4-lkp@intel.com>
References: <20251219114826.135017-1-jakub.turek@elsta.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219114826.135017-1-jakub.turek@elsta.tech>

Hi j.turek,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.19-rc1 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/j-turek/serial-xilinx_uartps-fix-rs485-delay_rts_after_send/20251219-203016
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20251219114826.135017-1-jakub.turek%40elsta.tech
patch subject: [PATCH] serial: xilinx_uartps: fix rs485 delay_rts_after_send
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20251220/202512202222.7nCGPOv4-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512202222.7nCGPOv4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512202222.7nCGPOv4-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/tty/serial/xilinx_uartps.c: In function 'cdns_uart_handle_tx':
>> drivers/tty/serial/xilinx_uartps.c:438:25: error: 'rts_delay' undeclared (first use in this function)
     438 |                         rts_delay = ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart));
         |                         ^~~~~~~~~
   drivers/tty/serial/xilinx_uartps.c:438:25: note: each undeclared identifier is reported only once for each function it appears in


vim +/rts_delay +438 drivers/tty/serial/xilinx_uartps.c

   418	
   419	/**
   420	 * cdns_uart_handle_tx - Handle the bytes to be transmitted.
   421	 * @dev_id: Id of the UART port
   422	 * Return: None
   423	 */
   424	static void cdns_uart_handle_tx(void *dev_id)
   425	{
   426		struct uart_port *port = (struct uart_port *)dev_id;
   427		struct cdns_uart *cdns_uart = port->private_data;
   428		struct tty_port *tport = &port->state->port;
   429		unsigned int numbytes;
   430		unsigned char ch;
   431	
   432		if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
   433			/* Disable the TX Empty interrupt */
   434			writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IDR);
   435			/* Set RTS line after delay */
   436			if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
   437				cdns_uart->tx_timer.function = &cdns_rs485_rx_callback;
 > 438				rts_delay = ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart));
   439				hrtimer_start(&cdns_uart->tx_timer, rts_delay, HRTIMER_MODE_REL);
   440			}
   441			return;
   442		}
   443	
   444		numbytes = port->fifosize;
   445		while (numbytes &&
   446		       !(readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXFULL) &&
   447		       uart_fifo_get(port, &ch)) {
   448			writel(ch, port->membase + CDNS_UART_FIFO);
   449			numbytes--;
   450		}
   451	
   452		if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
   453			uart_write_wakeup(port);
   454	
   455		/* Enable the TX Empty interrupt */
   456		writel(CDNS_UART_IXR_TXEMPTY, cdns_uart->port->membase + CDNS_UART_IER);
   457	}
   458	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
