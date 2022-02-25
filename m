Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DFFC433F5
	for <linux-serial@archiver.kernel.org>; Fri, 25 Feb 2022 18:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbiBYSfG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Feb 2022 13:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiBYSfB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Feb 2022 13:35:01 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0A01A8CBD
        for <linux-serial@vger.kernel.org>; Fri, 25 Feb 2022 10:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645814068; x=1677350068;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AWcWqNTCdAVoq0CzsMS2d/hoo3sz2Vx6l2pyUzXy78w=;
  b=ZmKWBoUfYgrcU7ulSO6BHUq7BPdn15eOuAE4KfetdXb38p1OBosjnEgz
   4ZGQk9+UGNfRXzILcAa6S/CBGfJDsJuDzAfimT7gPqAiijOMDTEfGokwE
   uHtH1qKvvIJhqlQy4UExSJZndxTala/I0u8+HnNC0KcUZICUWXpJ9x73K
   EDFiRPUMw5RWr1fHgAWsKil2zmOcn/88iQYqn98km5T3jj5sP/usVrU65
   8SMSHwiyfpPKTEAP6nhBHsunmPp6vlw2qvFaOiJ8LBeUMu3cP5BMwD1ar
   e0jo12yUtvDYvmMAbbAfkRjJbNXUXyXX6SWG6rXZljkLPsOBJ20IljLe5
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="250135001"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="250135001"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 10:34:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="549371034"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 25 Feb 2022 10:34:22 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNfQ5-0004bp-Ks; Fri, 25 Feb 2022 18:34:21 +0000
Date:   Sat, 26 Feb 2022 02:34:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 31/42] drivers/mmc/core/sdio_uart.c:253:9: error:
 implicit declaration of function 'UART_LCR_WLEN'
Message-ID: <202202260016.JwqeCxcs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   a6d8f09319fff9e6e7a91cadb19923b8cb2573e0
commit: b6f8eaea0cf1afe2500f8af7b6cc805647fe4889 [31/42] sdio_uart: make use of UART_LCR_WLEN() + tty_get_char_size()
config: arm-s3c2410_defconfig (https://download.01.org/0day-ci/archive/20220226/202202260016.JwqeCxcs-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?id=b6f8eaea0cf1afe2500f8af7b6cc805647fe4889
        git remote add tty https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
        git fetch --no-tags tty tty-testing
        git checkout b6f8eaea0cf1afe2500f8af7b6cc805647fe4889
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/mmc/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/mmc/core/sdio_uart.c:253:9: error: implicit declaration of function 'UART_LCR_WLEN' [-Werror,-Wimplicit-function-declaration]
           cval = UART_LCR_WLEN(tty_get_char_size(termios->c_cflag));
                  ^
   1 error generated.


vim +/UART_LCR_WLEN +253 drivers/mmc/core/sdio_uart.c

   245	
   246	static void sdio_uart_change_speed(struct sdio_uart_port *port,
   247					   struct ktermios *termios,
   248					   struct ktermios *old)
   249	{
   250		unsigned char cval, fcr = 0;
   251		unsigned int baud, quot;
   252	
 > 253		cval = UART_LCR_WLEN(tty_get_char_size(termios->c_cflag));
   254	
   255		if (termios->c_cflag & CSTOPB)
   256			cval |= UART_LCR_STOP;
   257		if (termios->c_cflag & PARENB)
   258			cval |= UART_LCR_PARITY;
   259		if (!(termios->c_cflag & PARODD))
   260			cval |= UART_LCR_EPAR;
   261	
   262		for (;;) {
   263			baud = tty_termios_baud_rate(termios);
   264			if (baud == 0)
   265				baud = 9600;  /* Special case: B0 rate. */
   266			if (baud <= port->uartclk)
   267				break;
   268			/*
   269			 * Oops, the quotient was zero.  Try again with the old
   270			 * baud rate if possible, otherwise default to 9600.
   271			 */
   272			termios->c_cflag &= ~CBAUD;
   273			if (old) {
   274				termios->c_cflag |= old->c_cflag & CBAUD;
   275				old = NULL;
   276			} else
   277				termios->c_cflag |= B9600;
   278		}
   279		quot = (2 * port->uartclk + baud) / (2 * baud);
   280	
   281		if (baud < 2400)
   282			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
   283		else
   284			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10;
   285	
   286		port->read_status_mask = UART_LSR_OE | UART_LSR_THRE | UART_LSR_DR;
   287		if (termios->c_iflag & INPCK)
   288			port->read_status_mask |= UART_LSR_FE | UART_LSR_PE;
   289		if (termios->c_iflag & (BRKINT | PARMRK))
   290			port->read_status_mask |= UART_LSR_BI;
   291	
   292		/*
   293		 * Characters to ignore
   294		 */
   295		port->ignore_status_mask = 0;
   296		if (termios->c_iflag & IGNPAR)
   297			port->ignore_status_mask |= UART_LSR_PE | UART_LSR_FE;
   298		if (termios->c_iflag & IGNBRK) {
   299			port->ignore_status_mask |= UART_LSR_BI;
   300			/*
   301			 * If we're ignoring parity and break indicators,
   302			 * ignore overruns too (for real raw support).
   303			 */
   304			if (termios->c_iflag & IGNPAR)
   305				port->ignore_status_mask |= UART_LSR_OE;
   306		}
   307	
   308		/*
   309		 * ignore all characters if CREAD is not set
   310		 */
   311		if ((termios->c_cflag & CREAD) == 0)
   312			port->ignore_status_mask |= UART_LSR_DR;
   313	
   314		/*
   315		 * CTS flow control flag and modem status interrupts
   316		 */
   317		port->ier &= ~UART_IER_MSI;
   318		if ((termios->c_cflag & CRTSCTS) || !(termios->c_cflag & CLOCAL))
   319			port->ier |= UART_IER_MSI;
   320	
   321		port->lcr = cval;
   322	
   323		sdio_out(port, UART_IER, port->ier);
   324		sdio_out(port, UART_LCR, cval | UART_LCR_DLAB);
   325		sdio_out(port, UART_DLL, quot & 0xff);
   326		sdio_out(port, UART_DLM, quot >> 8);
   327		sdio_out(port, UART_LCR, cval);
   328		sdio_out(port, UART_FCR, fcr);
   329	
   330		sdio_uart_write_mctrl(port, port->mctrl);
   331	}
   332	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
