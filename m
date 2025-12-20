Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703941531C8;
	Sat, 20 Dec 2025 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766244201; cv=none; b=d78neomNCJiKUEsIjWlynl4xAnEv8rHPLaIrn7olAH7fKnl6Aghhh/37jisilIdr7lcw+slv25bcmY5S8jXrm9m0GdsVl0PAX3eeYsAr9yUiGVYRMkym5OgvjwNKZkH8z5BJJRoxD/RPusGGblwuTGICq/AtdTjzjm/wSkeVHT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766244201; c=relaxed/simple;
	bh=a7aA/V9EvvL+19B0Kkb8JqjoPHRuFbxxgE9bFYw1JrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cN+3A0hR/7TMo/CWuFfyYx0Rw9LEIA0e6fmwjQRt+ReCQoQ13LnLmYD8dznGjytd9ruMhxWAikhJAZtSh7V18zfLM1PNnDPveeGFnAQsF2NK1ieyNGizb+IvOXnj2m8/qoU06JYnN95V79IthmUNXgOLi4rXJoQSRpXeqjQ5xAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XtwUD6G/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XtwUD6G/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766244199; x=1797780199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a7aA/V9EvvL+19B0Kkb8JqjoPHRuFbxxgE9bFYw1JrM=;
  b=XtwUD6G/85d8vFVmI7a8xvgv5kvYnIqE91QAvUKFIJpx6YdaeXsecDSB
   T0snDBaxvWdLcC9TTS/pe/lJ2mVspg4WlUNtNk8JQMujAy2j2Z2lgTzGa
   4EAOAbyhrQFprIsMWULCv515wHhuRh87c1fOwKiI8+bHFaVrz4MIRBFcI
   qq8nu+xaEkoTWkIPsnXes3V6w1TgRsTh4hIHEVDcxrI0ID7zb7JSJvcn1
   5RDM6MiS862JbCO07Lg7yQ+YNZLERbTbjj7W0gRvtJT5jugXd07nDylbe
   cIsL6R8GL9tkXVuoY4zb6oIb2xaWusAYbpNpM/TPpQq5bh86DqCBosLmU
   Q==;
X-CSE-ConnectionGUID: vaS4i0h5Tce2+HJ8jP2MIw==
X-CSE-MsgGUID: qS/Mf7q+RVuTVR308vgCBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="78494902"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="78494902"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 07:23:19 -0800
X-CSE-ConnectionGUID: YHhaTyrKTBel+oEgLWblGQ==
X-CSE-MsgGUID: byjzN7fXRuW8Bpbc4O1sNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="203642738"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 20 Dec 2025 07:23:15 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWynZ-000000004jx-01ea;
	Sat, 20 Dec 2025 15:23:13 +0000
Date: Sat, 20 Dec 2025 23:22:25 +0800
From: kernel test robot <lkp@intel.com>
To: "j.turek" <jakub.turek@elsta.tech>, gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	michal.simek@amd.com, namcao@linutronix.de, tglx@linutronix.de,
	zack.rusin@broadcom.com, sean.anderson@linux.dev, hshah@axiado.com,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, "j.turek" <jakub.turek@elsta.tech>
Subject: Re: [PATCH] serial: xilinx_uartps: fix rs485 delay_rts_after_send
Message-ID: <202512202351.ovK2vDUR-lkp@intel.com>
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
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20251220/202512202351.ovK2vDUR-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512202351.ovK2vDUR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512202351.ovK2vDUR-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/tty/serial/xilinx_uartps.c:438:4: error: use of undeclared identifier 'rts_delay'
     438 |                         rts_delay = ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart));
         |                         ^
   drivers/tty/serial/xilinx_uartps.c:439:40: error: use of undeclared identifier 'rts_delay'; did you mean '__delay'?
     439 |                         hrtimer_start(&cdns_uart->tx_timer, rts_delay, HRTIMER_MODE_REL);
         |                                                             ^~~~~~~~~
         |                                                             __delay
   arch/hexagon/include/asm/delay.h:11:13: note: '__delay' declared here
      11 | extern void __delay(unsigned long cycles);
         |             ^
   2 errors generated.


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
