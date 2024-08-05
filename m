Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DC213D53B;
	Mon,  5 Aug 2024 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722881441; cv=none; b=k2Aa3RkQ36Q0V1eCChiYpY9fPnQxDXo6/yToFbSk8QR5gb7GU1oRUE5+xISdGOjT95WU8HYCkAZhlXquizUpifu6lwdPGVjizKdoMBaEKy5VaU1zZQ/hrcBoLrHy/4CxEQCYxlALiB1rQGyEtOgmFq25+KBHE9Gc/0LkjexDebk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722881441; c=relaxed/simple;
	bh=CrDqFr+VrgDXOiK1trVs9vkeQE9/1cV8jNg7kkkmz4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfsL8Jcx1i9mh7J3wzMUjvyyv0Firz4PiQ/BEtJupLgZK2U/0Awe+DoMvVyURedhMqC7oZ+Q+dfKWbnqnUq/oc4sRJwxfAFJoEvRqshhPrk86v7QblBhuoIpqdNn4AvG3zLNQZSpZiTdPPKTUnbTlo7mTD91RJJ7Y9cbUV22rbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U3U0wt4C; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U3U0wt4C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722881438; x=1754417438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CrDqFr+VrgDXOiK1trVs9vkeQE9/1cV8jNg7kkkmz4o=;
  b=U3U0wt4C8HiP18a/vv/xVJOOLop1Gc6oxJQfKZcvqdIJajGhNxvYZxiB
   5SVVLH230tOV9T89TsL4CMeH4p07sug2EaQ6aHbzxs0d6C0DbwQgmCE70
   HQ5AYwHDu3idWIhwRcUIJKD79k2QVvBeLPrnTnSaFaB+8SXBTAFWuCqm9
   RMJT8PvqkRyaJVEaVVLlxLenFhvEf+xAPqFvYNUMoTMtiPihtmzfESmfP
   Q0DjZDcFUSycwEFNp7FKOc1//GxIhVXszSkak5yuLrtQQs0HtUgcvVLff
   yybZIgmZPtuz90qKN/3N09BlUsuc994uIVrsR+0MbV0pN1dXd9ZZKwnho
   g==;
X-CSE-ConnectionGUID: Kks3x4XNT1iR5LVpP80Hlg==
X-CSE-MsgGUID: ClAqXnY1SlmZ8NfbRcCDMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20827885"
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="20827885"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 11:10:38 -0700
X-CSE-ConnectionGUID: Q7XxXmixSMWk9jb4Ntb59w==
X-CSE-MsgGUID: qQ3/dJsuRDyHpyYA44Ss6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="79497391"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 05 Aug 2024 11:10:35 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sb2AD-0003PY-0X;
	Mon, 05 Aug 2024 18:10:33 +0000
Date: Tue, 6 Aug 2024 02:09:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: Re: [PATCH 05/13] serial: use guards for simple mutex locks
Message-ID: <202408060140.glPvoH1S-lkp@intel.com>
References: <20240805102046.307511-6-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240805102046.307511-6-jirislaby@kernel.org>

Hi Jiri,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.11-rc2 next-20240805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiri-Slaby-SUSE/tty-simplify-tty_dev_name_to_number-using-guard-mutex/20240805-184227
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20240805102046.307511-6-jirislaby%40kernel.org
patch subject: [PATCH 05/13] serial: use guards for simple mutex locks
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240806/202408060140.glPvoH1S-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240806/202408060140.glPvoH1S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408060140.glPvoH1S-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/tty/serial/serial_core.c: In function 'uart_suspend_port':
>> drivers/tty/serial/serial_core.c:2400:17: error: label 'unlock' used but not defined
    2400 |                 goto unlock;
         |                 ^~~~


vim +/unlock +2400 drivers/tty/serial/serial_core.c

b3b708fa2780cd drivers/serial/serial_core.c     Guennadi Liakhovetski   2007-10-16  2369  
ccce6debb62d94 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2370  int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
^1da177e4c3f41 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2371  {
ccce6debb62d94 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2372  	struct uart_state *state = drv->state + uport->line;
ccce6debb62d94 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2373  	struct tty_port *port = &state->port;
b3b708fa2780cd drivers/serial/serial_core.c     Guennadi Liakhovetski   2007-10-16  2374  	struct device *tty_dev;
ccce6debb62d94 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2375  	struct uart_match match = {uport, drv};
^1da177e4c3f41 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2376  
d2d8bbc5cc74b7 drivers/tty/serial/serial_core.c Jiri Slaby (SUSE        2024-08-05  2377) 	guard(mutex)(&port->mutex);
^1da177e4c3f41 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2378  
b286f4e87e325b drivers/tty/serial/serial_core.c Tony Lindgren           2023-11-13  2379  	tty_dev = device_find_child(&uport->port_dev->dev, &match, serial_match_port);
88e2582e90bb89 drivers/tty/serial/serial_core.c Lucas Stach             2017-05-11  2380  	if (tty_dev && device_may_wakeup(tty_dev)) {
aef3ad103a686f drivers/tty/serial/serial_core.c Andy Shevchenko         2017-08-13  2381  		enable_irq_wake(uport->irq);
b3b708fa2780cd drivers/serial/serial_core.c     Guennadi Liakhovetski   2007-10-16  2382  		put_device(tty_dev);
b3b708fa2780cd drivers/serial/serial_core.c     Guennadi Liakhovetski   2007-10-16  2383  		return 0;
b3b708fa2780cd drivers/serial/serial_core.c     Guennadi Liakhovetski   2007-10-16  2384  	}
5a65dcc04cda41 drivers/tty/serial/serial_core.c Federico Vaga           2013-04-15  2385  	put_device(tty_dev);
5a65dcc04cda41 drivers/tty/serial/serial_core.c Federico Vaga           2013-04-15  2386  
c9d2325cdb92fd drivers/tty/serial/serial_core.c Vijaya Krishna Nivarthi 2022-05-16  2387  	/*
c9d2325cdb92fd drivers/tty/serial/serial_core.c Vijaya Krishna Nivarthi 2022-05-16  2388  	 * Nothing to do if the console is not suspending
c9d2325cdb92fd drivers/tty/serial/serial_core.c Vijaya Krishna Nivarthi 2022-05-16  2389  	 * except stop_rx to prevent any asynchronous data
cfab87c2c27157 drivers/tty/serial/serial_core.c Vijaya Krishna Nivarthi 2022-06-08  2390  	 * over RX line. However ensure that we will be
cfab87c2c27157 drivers/tty/serial/serial_core.c Vijaya Krishna Nivarthi 2022-06-08  2391  	 * able to Re-start_rx later.
c9d2325cdb92fd drivers/tty/serial/serial_core.c Vijaya Krishna Nivarthi 2022-05-16  2392  	 */
c9d2325cdb92fd drivers/tty/serial/serial_core.c Vijaya Krishna Nivarthi 2022-05-16  2393  	if (!console_suspend_enabled && uart_console(uport)) {
abcb0cf1f5b2d9 drivers/tty/serial/serial_core.c John Ogness             2023-05-25  2394  		if (uport->ops->start_rx) {
559c7ff4e32455 drivers/tty/serial/serial_core.c Thomas Gleixner         2023-09-14  2395  			uart_port_lock_irq(uport);
c9d2325cdb92fd drivers/tty/serial/serial_core.c Vijaya Krishna Nivarthi 2022-05-16  2396  			uport->ops->stop_rx(uport);
559c7ff4e32455 drivers/tty/serial/serial_core.c Thomas Gleixner         2023-09-14  2397  			uart_port_unlock_irq(uport);
abcb0cf1f5b2d9 drivers/tty/serial/serial_core.c John Ogness             2023-05-25  2398  		}
a47cf07f60dcb0 drivers/tty/serial/serial_core.c Claudiu Beznea          2024-04-30  2399  		device_set_awake_path(uport->dev);
b164c9721e3ea4 drivers/tty/serial/serial_core.c Peter Hurley            2015-01-22 @2400  		goto unlock;
c9d2325cdb92fd drivers/tty/serial/serial_core.c Vijaya Krishna Nivarthi 2022-05-16  2401  	}
b164c9721e3ea4 drivers/tty/serial/serial_core.c Peter Hurley            2015-01-22  2402  
ccce6debb62d94 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2403  	uport->suspended = 1;
b3b708fa2780cd drivers/serial/serial_core.c     Guennadi Liakhovetski   2007-10-16  2404  
d41861ca19c9e9 drivers/tty/serial/serial_core.c Peter Hurley            2016-04-09  2405  	if (tty_port_initialized(port)) {
ccce6debb62d94 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2406  		const struct uart_ops *ops = uport->ops;
c8c6bfa39d6bd7 drivers/serial/serial_core.c     Russell King            2008-02-04  2407  		int tries;
18c9d4a3c249e9 drivers/tty/serial/serial_core.c Al Cooper               2022-03-24  2408  		unsigned int mctrl;
^1da177e4c3f41 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2409  
75b20a2ac425b9 drivers/tty/serial/serial_core.c Ilpo Järvinen           2023-01-17  2410  		tty_port_set_suspended(port, true);
515be7baeddb04 drivers/tty/serial/serial_core.c Ilpo Järvinen           2023-01-17  2411  		tty_port_set_initialized(port, false);
a6b93a90850881 drivers/serial/serial_core.c     Russell King            2006-10-01  2412  
559c7ff4e32455 drivers/tty/serial/serial_core.c Thomas Gleixner         2023-09-14  2413  		uart_port_lock_irq(uport);
ccce6debb62d94 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2414  		ops->stop_tx(uport);
7c7f9bc986e698 drivers/tty/serial/serial_core.c Lukas Wunner            2022-09-22  2415  		if (!(uport->rs485.flags & SER_RS485_ENABLED))
ccce6debb62d94 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2416  			ops->set_mctrl(uport, 0);
18c9d4a3c249e9 drivers/tty/serial/serial_core.c Al Cooper               2022-03-24  2417  		/* save mctrl so it can be restored on resume */
18c9d4a3c249e9 drivers/tty/serial/serial_core.c Al Cooper               2022-03-24  2418  		mctrl = uport->mctrl;
18c9d4a3c249e9 drivers/tty/serial/serial_core.c Al Cooper               2022-03-24  2419  		uport->mctrl = 0;
ccce6debb62d94 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2420  		ops->stop_rx(uport);
559c7ff4e32455 drivers/tty/serial/serial_core.c Thomas Gleixner         2023-09-14  2421  		uart_port_unlock_irq(uport);
^1da177e4c3f41 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2422  
^1da177e4c3f41 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2423  		/*
^1da177e4c3f41 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2424  		 * Wait for the transmitter to empty.
^1da177e4c3f41 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2425  		 */
ccce6debb62d94 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2426  		for (tries = 3; !ops->tx_empty(uport) && tries; tries--)
^1da177e4c3f41 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2427  			msleep(10);
c8c6bfa39d6bd7 drivers/serial/serial_core.c     Russell King            2008-02-04  2428  		if (!tries)
cade3580f79aeb drivers/tty/serial/serial_core.c Andy Shevchenko         2017-03-31  2429  			dev_err(uport->dev, "%s: Unable to drain transmitter\n",
cade3580f79aeb drivers/tty/serial/serial_core.c Andy Shevchenko         2017-03-31  2430  				uport->name);
^1da177e4c3f41 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2431  
ccce6debb62d94 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2432  		ops->shutdown(uport);
18c9d4a3c249e9 drivers/tty/serial/serial_core.c Al Cooper               2022-03-24  2433  		uport->mctrl = mctrl;
^1da177e4c3f41 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2434  	}
^1da177e4c3f41 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2435  
^1da177e4c3f41 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2436  	/*
^1da177e4c3f41 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2437  	 * Disable the console device before suspending.
^1da177e4c3f41 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2438  	 */
b164c9721e3ea4 drivers/tty/serial/serial_core.c Peter Hurley            2015-01-22  2439  	if (uart_console(uport))
ccce6debb62d94 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2440  		console_stop(uport->cons);
^1da177e4c3f41 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2441  
6f538fe31c1d45 drivers/tty/serial/serial_core.c Linus Walleij           2012-12-07  2442  	uart_change_pm(state, UART_PM_STATE_OFF);
^1da177e4c3f41 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2443  
^1da177e4c3f41 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2444  	return 0;
^1da177e4c3f41 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2445  }
15dc475bcc1739 drivers/tty/serial/serial_core.c Jiri Slaby              2022-01-24  2446  EXPORT_SYMBOL(uart_suspend_port);
^1da177e4c3f41 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2447  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
