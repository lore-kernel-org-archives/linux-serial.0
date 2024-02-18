Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14FD36D
	for <linux-serial@vger.kernel.org>; Sun, 18 Feb 2024 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708216236; cv=none; b=pTDszey4Xva6STxBQxvm29QHDJmfe9dlkEAcznXaIbVgbmp1gSqS2j+safdt+dhHLf7j5JggaYVnSFdQN/GHif+X1TeGtQNxjuOnEP9FOyqfkTWcF1x2qUqrK9DnWtGfxjdS+v17PCbSaRENj4kkNfhK30O5EX6Qa7Tm4Ng+Lnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708216236; c=relaxed/simple;
	bh=VG3qSW7GGysxUuJS9ekaXw6qh5jnAyfQnUzV+hFGbyA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=otiyTKmb22NRoWbesbHwpuDtUnVbmga/5qM+ilbIrZsjyWa3cwFnp0fgrh7m5dylbvhuoImt3eBmz58wz63JBhuadO0iv2hj04mfiC3SxIADzZit6ST2h+Utx8C4mA0+e3KyTgxowQae0NzDKIRA0+3yp0QgM8JdtTaVWHzqbp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4vB0QKU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4vB0QKU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708216234; x=1739752234;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VG3qSW7GGysxUuJS9ekaXw6qh5jnAyfQnUzV+hFGbyA=;
  b=X4vB0QKU3oX36nU83/nBWRWsV6s8W0yFTT8LRsw/fQMjwnnD8WMVRTdD
   hc4XATMViboivs1Tf5NsDMHQ89aQ2lUMtzMr00zjsvbVy4m21Ivs1LLaP
   sFtd96w2Fo6QuGmC8eLA9G9lPYq8uGh4y417KLnNMNqlfFEAB4vQegx6e
   yMej3sT3fSG86ci2XSjLy2Gi/pCnzdLu3iO+hxKxsY6KqHDOzD5TldUHf
   vUSRW0kk9iWAfgvr0oCpADXRxFpWbqVpkgeNJImojmjtG6k+BywzNC4B9
   ZHXYlz2AQURuSeGE2DjAB615vtyjUQJn5UXcWRxK2CMQqMf17f5F7Mo6/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2188084"
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="2188084"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 16:30:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="27320346"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 17 Feb 2024 16:30:31 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbV4f-0002dW-16;
	Sun, 18 Feb 2024 00:30:29 +0000
Date: Sun, 18 Feb 2024 08:29:54 +0800
From: kernel test robot <lkp@intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [tty:tty-testing 31/36] drivers/tty/serial/st-asc.c:525:7: warning:
 variable 'manual_rts' is used uninitialized whenever 'if' condition is false
Message-ID: <202402180801.2LNKohCO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   b8badbf3b592d3f8b70efc66be2c2c4d9698de51
commit: baa864d1ac1f2901499f52e6a7e67b4dfe42ccff [31/36] serial: st-asc: don't get/put GPIOs in atomic context
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240218/202402180801.2LNKohCO-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240218/202402180801.2LNKohCO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402180801.2LNKohCO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/st-asc.c:525:7: warning: variable 'manual_rts' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (!ascport->rts && ascport->states[NO_HW_FLOWCTRL])
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/st-asc.c:586:6: note: uninitialized use occurs here
           if (manual_rts) {
               ^~~~~~~~~~
   drivers/tty/serial/st-asc.c:525:3: note: remove the 'if' if its condition is always true
                   if (!ascport->rts && ascport->states[NO_HW_FLOWCTRL])
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/tty/serial/st-asc.c:525:7: warning: variable 'manual_rts' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
                   if (!ascport->rts && ascport->states[NO_HW_FLOWCTRL])
                       ^~~~~~~~~~~~~
   drivers/tty/serial/st-asc.c:586:6: note: uninitialized use occurs here
           if (manual_rts) {
               ^~~~~~~~~~
   drivers/tty/serial/st-asc.c:525:7: note: remove the '&&' if its condition is always true
                   if (!ascport->rts && ascport->states[NO_HW_FLOWCTRL])
                       ^~~~~~~~~~~~~~~~
   drivers/tty/serial/st-asc.c:521:7: warning: variable 'manual_rts' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (ascport->rts)
                       ^~~~~~~~~~~~
   drivers/tty/serial/st-asc.c:586:6: note: uninitialized use occurs here
           if (manual_rts) {
               ^~~~~~~~~~
   drivers/tty/serial/st-asc.c:521:3: note: remove the 'if' if its condition is always true
                   if (ascport->rts)
                   ^~~~~~~~~~~~~~~~~
   drivers/tty/serial/st-asc.c:470:17: note: initialize the variable 'manual_rts' to silence this warning
           bool manual_rts;
                          ^
                           = 0
   3 warnings generated.


vim +525 drivers/tty/serial/st-asc.c

   463	
   464	static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
   465				    const struct ktermios *old)
   466	{
   467		struct asc_port *ascport = to_asc_port(port);
   468		struct gpio_desc *gpiod;
   469		unsigned int baud;
   470		bool manual_rts;
   471		u32 ctrl_val;
   472		tcflag_t cflag;
   473		unsigned long flags;
   474	
   475		/* Update termios to reflect hardware capabilities */
   476		termios->c_cflag &= ~(CMSPAR |
   477				 (ascport->hw_flow_control ? 0 : CRTSCTS));
   478	
   479		port->uartclk = clk_get_rate(ascport->clk);
   480	
   481		baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16);
   482		cflag = termios->c_cflag;
   483	
   484		uart_port_lock_irqsave(port, &flags);
   485	
   486		/* read control register */
   487		ctrl_val = asc_in(port, ASC_CTL);
   488	
   489		/* stop serial port and reset value */
   490		asc_out(port, ASC_CTL, (ctrl_val & ~ASC_CTL_RUN));
   491		ctrl_val = ASC_CTL_RXENABLE | ASC_CTL_FIFOENABLE;
   492	
   493		/* reset fifo rx & tx */
   494		asc_out(port, ASC_TXRESET, 1);
   495		asc_out(port, ASC_RXRESET, 1);
   496	
   497		/* set character length */
   498		if ((cflag & CSIZE) == CS7) {
   499			ctrl_val |= ASC_CTL_MODE_7BIT_PAR;
   500			cflag |= PARENB;
   501		} else {
   502			ctrl_val |= (cflag & PARENB) ?  ASC_CTL_MODE_8BIT_PAR :
   503							ASC_CTL_MODE_8BIT;
   504			cflag &= ~CSIZE;
   505			cflag |= CS8;
   506		}
   507		termios->c_cflag = cflag;
   508	
   509		/* set stop bit */
   510		ctrl_val |= (cflag & CSTOPB) ? ASC_CTL_STOP_2BIT : ASC_CTL_STOP_1BIT;
   511	
   512		/* odd parity */
   513		if (cflag & PARODD)
   514			ctrl_val |= ASC_CTL_PARITYODD;
   515	
   516		/* hardware flow control */
   517		if ((cflag & CRTSCTS)) {
   518			ctrl_val |= ASC_CTL_CTSENABLE;
   519	
   520			/* If flow-control selected, stop handling RTS manually */
   521			if (ascport->rts)
   522				manual_rts = false;
   523		} else {
   524			/* If flow-control disabled, it's safe to handle RTS manually */
 > 525			if (!ascport->rts && ascport->states[NO_HW_FLOWCTRL])
   526				manual_rts = true;
   527		}
   528	
   529		if ((baud < 19200) && !ascport->force_m1) {
   530			asc_out(port, ASC_BAUDRATE, (port->uartclk / (16 * baud)));
   531		} else {
   532			/*
   533			 * MODE 1: recommended for high bit rates (above 19.2K)
   534			 *
   535			 *                   baudrate * 16 * 2^16
   536			 * ASCBaudRate =   ------------------------
   537			 *                          inputclock
   538			 *
   539			 * To keep maths inside 64bits, we divide inputclock by 16.
   540			 */
   541			u64 dividend = (u64)baud * (1 << 16);
   542	
   543			do_div(dividend, port->uartclk / 16);
   544			asc_out(port, ASC_BAUDRATE, dividend);
   545			ctrl_val |= ASC_CTL_BAUDMODE;
   546		}
   547	
   548		uart_update_timeout(port, cflag, baud);
   549	
   550		ascport->port.read_status_mask = ASC_RXBUF_DUMMY_OE;
   551		if (termios->c_iflag & INPCK)
   552			ascport->port.read_status_mask |= ASC_RXBUF_FE | ASC_RXBUF_PE;
   553		if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
   554			ascport->port.read_status_mask |= ASC_RXBUF_DUMMY_BE;
   555	
   556		/*
   557		 * Characters to ignore
   558		 */
   559		ascport->port.ignore_status_mask = 0;
   560		if (termios->c_iflag & IGNPAR)
   561			ascport->port.ignore_status_mask |= ASC_RXBUF_FE | ASC_RXBUF_PE;
   562		if (termios->c_iflag & IGNBRK) {
   563			ascport->port.ignore_status_mask |= ASC_RXBUF_DUMMY_BE;
   564			/*
   565			 * If we're ignoring parity and break indicators,
   566			 * ignore overruns too (for real raw support).
   567			 */
   568			if (termios->c_iflag & IGNPAR)
   569				ascport->port.ignore_status_mask |= ASC_RXBUF_DUMMY_OE;
   570		}
   571	
   572		/*
   573		 * Ignore all characters if CREAD is not set.
   574		 */
   575		if (!(termios->c_cflag & CREAD))
   576			ascport->port.ignore_status_mask |= ASC_RXBUF_DUMMY_RX;
   577	
   578		/* Set the timeout */
   579		asc_out(port, ASC_TIMEOUT, 20);
   580	
   581		/* write final value and enable port */
   582		asc_out(port, ASC_CTL, (ctrl_val | ASC_CTL_RUN));
   583	
   584		uart_port_unlock_irqrestore(port, flags);
   585	
   586		if (manual_rts) {
   587			pinctrl_select_state(ascport->pinctrl,
   588					     ascport->states[NO_HW_FLOWCTRL]);
   589	
   590			gpiod = devm_gpiod_get(port->dev, "rts", GPIOD_OUT_LOW);
   591			if (!IS_ERR(gpiod)) {
   592				gpiod_set_consumer_name(gpiod,
   593							port->dev->of_node->name);
   594				ascport->rts = gpiod;
   595			} else {
   596				devm_gpiod_put(port->dev, ascport->rts);
   597				ascport->rts = NULL;
   598				pinctrl_select_state(ascport->pinctrl,
   599						     ascport->states[DEFAULT]);
   600			}
   601		}
   602	}
   603	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
