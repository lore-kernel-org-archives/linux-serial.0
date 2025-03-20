Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1331F7076
	for <linux-serial@vger.kernel.org>; Thu, 20 Mar 2025 23:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742512168; cv=none; b=MYA4N2uSVWRHlw65clPbZPVBFK3/dlFkfO6v/6ninoYplJ/QQQsH1Ma8/K7HecxBe+rthWQ2jYXuVMvy3arrngz/BDVDCkjGr/NtrxtSUlXBmBrBt58nqLi+FJ60CuY59htaiDBj8c45eELDSUYTJCOh9JLcsF1cCX+5SCJMUzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742512168; c=relaxed/simple;
	bh=rKZ/0GBEY72soB28V0yhs5liOwKSqYq4oTYpMCnZtGU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FksmGZ3vL/S/19Oj7Agj/sEVo4/9LxIm7wrNXK/K5enuZ8MWpfrVZvEtgSQ4Z+fJTtQhRQmQT8uzByfLF7NVIqOzliKikjPRoq9ggqoAfaEW8CT9A4iuefYj94PXiqkakaasU0Nehjx5h194NukYGconSHF+F7a15F39G1D2+Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GUaLR5R6; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GUaLR5R6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742512167; x=1774048167;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rKZ/0GBEY72soB28V0yhs5liOwKSqYq4oTYpMCnZtGU=;
  b=GUaLR5R6EgfpQj6wgrwpdwbfi1sIwT8wQtZi4nx70Rk5Jldl1LGos5d3
   q68jEvS7M+vh2ydNzmh49MSgKsfviqzBOby2cXXiDD3338OF64GdGRfrl
   UCUm5dgz6Jk/RXIPghlUZ6wqj9ghmSrZ7VVig480+RDgen79oYItia2JK
   mat9JQzH8UBlCqVomF7gvyP5XNCBIEQlI+ttWAGVGAB+9APrDYfDXetA1
   I7iR/1XdFifdt/sXfTBDmN8wp8C0N+tSNuHb1R5EULmjfl035RxnABMQe
   ND5eESHWR206Rac/ilFEEQxrrDnhG+3gCeQh//iFB2PZYodE41mPt4LY+
   w==;
X-CSE-ConnectionGUID: +Qltcm3gRMaHwPNBKdcFOA==
X-CSE-MsgGUID: uX7lk48fQRmvkBbAHbZJbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43779644"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="43779644"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:09:26 -0700
X-CSE-ConnectionGUID: 2dBgRgqySuC0z/FpndqpSg==
X-CSE-MsgGUID: KV3FdsFfTXyJgtNjkrnXVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="123224106"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 20 Mar 2025 16:09:25 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvP0s-0000rX-32;
	Thu, 20 Mar 2025 23:09:22 +0000
Date: Fri, 21 Mar 2025 07:09:07 +0800
From: kernel test robot <lkp@intel.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 47/58] drivers/tty/serial/fsl_lpuart.c:642:29:
 warning: unused variable 'sport'
Message-ID: <202503210614.2qGlnbIq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   2790ce23951f0c497810c44ad60a126a59c8d84c
commit: 3cc16ae096f164ae0c6b98416c25a01db5f3a529 [47/58] tty: serial: fsl_lpuart: use port struct directly to simply code
config: x86_64-buildonly-randconfig-003-20250321 (https://download.01.org/0day-ci/archive/20250321/202503210614.2qGlnbIq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250321/202503210614.2qGlnbIq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503210614.2qGlnbIq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/tty/serial/fsl_lpuart.c: In function 'lpuart_poll_init':
>> drivers/tty/serial/fsl_lpuart.c:642:29: warning: unused variable 'sport' [-Wunused-variable]
     642 |         struct lpuart_port *sport = container_of(port,
         |                             ^~~~~
   drivers/tty/serial/fsl_lpuart.c: In function 'lpuart32_poll_init':
   drivers/tty/serial/fsl_lpuart.c:696:29: warning: unused variable 'sport' [-Wunused-variable]
     696 |         struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
         |                             ^~~~~


vim +/sport +642 drivers/tty/serial/fsl_lpuart.c

2a41bc2a2b0533 Nicolae Rosia 2016-10-04  639  
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  640  static int lpuart_poll_init(struct uart_port *port)
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  641  {
2a41bc2a2b0533 Nicolae Rosia 2016-10-04 @642  	struct lpuart_port *sport = container_of(port,
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  643  					struct lpuart_port, port);
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  644  	unsigned long flags;
b6a8f6ab2c53e5 Sherry Sun    2025-03-12  645  	u8 temp;
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  646  
3cc16ae096f164 Sherry Sun    2025-03-12  647  	port->fifosize = 0;
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  648  
3cc16ae096f164 Sherry Sun    2025-03-12  649  	uart_port_lock_irqsave(port, &flags);
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  650  	/* Disable Rx & Tx */
3cc16ae096f164 Sherry Sun    2025-03-12  651  	writeb(0, port->membase + UARTCR2);
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  652  
3cc16ae096f164 Sherry Sun    2025-03-12  653  	temp = readb(port->membase + UARTPFIFO);
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  654  	/* Enable Rx and Tx FIFO */
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  655  	writeb(temp | UARTPFIFO_RXFE | UARTPFIFO_TXFE,
3cc16ae096f164 Sherry Sun    2025-03-12  656  			port->membase + UARTPFIFO);
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  657  
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  658  	/* flush Tx and Rx FIFO */
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  659  	writeb(UARTCFIFO_TXFLUSH | UARTCFIFO_RXFLUSH,
3cc16ae096f164 Sherry Sun    2025-03-12  660  			port->membase + UARTCFIFO);
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  661  
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  662  	/* explicitly clear RDRF */
3cc16ae096f164 Sherry Sun    2025-03-12  663  	if (readb(port->membase + UARTSR1) & UARTSR1_RDRF) {
3cc16ae096f164 Sherry Sun    2025-03-12  664  		readb(port->membase + UARTDR);
3cc16ae096f164 Sherry Sun    2025-03-12  665  		writeb(UARTSFIFO_RXUF, port->membase + UARTSFIFO);
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  666  	}
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  667  
3cc16ae096f164 Sherry Sun    2025-03-12  668  	writeb(0, port->membase + UARTTWFIFO);
3cc16ae096f164 Sherry Sun    2025-03-12  669  	writeb(1, port->membase + UARTRWFIFO);
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  670  
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  671  	/* Enable Rx and Tx */
3cc16ae096f164 Sherry Sun    2025-03-12  672  	writeb(UARTCR2_RE | UARTCR2_TE, port->membase + UARTCR2);
3cc16ae096f164 Sherry Sun    2025-03-12  673  	uart_port_unlock_irqrestore(port, flags);
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  674  
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  675  	return 0;
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  676  }
2a41bc2a2b0533 Nicolae Rosia 2016-10-04  677  

:::::: The code at line 642 was first introduced by commit
:::::: 2a41bc2a2b0533afca11335ed7e636c62623d7c6 tty: serial: fsl_lpuart: add polled console functions

:::::: TO: Nicolae Rosia <nicolae_rosia@mentor.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
