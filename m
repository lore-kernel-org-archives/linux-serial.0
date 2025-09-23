Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED822FE56B;
	Tue, 23 Sep 2025 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758652067; cv=none; b=C37nhdz0cMVZEew4zlL0zsszaYHM6KI36b+dBtuttMeK+RSN40CgzYadOMxR+NVcXc/Bj0kNDequXyaN3d/kr5Go8hpfl5T7B0pvyz7DUg7g5TPSpgb3ot9oauZn2srDkxe72HdIohm2kB+VcbdNualjv9MtDlTkf4+04Skny/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758652067; c=relaxed/simple;
	bh=u4+PrGZdgCauoOlW4112fdJ4hZl7Vp6GjCfbithZYI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eY4WVkDGtCDoVvESR/if39x25KOphDT8dq5CUj25RUlIa8+EoyByLpJcs6kopf3BjTKhlSzwAPG6GZwkKbYDskteLHf5xfYf/vs0Ry11bQYQDj26+zkKXFLSyursyFTVYpqv9bcqPh/Pf3ZxOLg9Ogo97zQiBzVI7FIxQA+TpPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dpv3QQap; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dpv3QQap"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758652066; x=1790188066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=u4+PrGZdgCauoOlW4112fdJ4hZl7Vp6GjCfbithZYI8=;
  b=dpv3QQapc1zRrrn82nonv6qSg5gc5WcmlWR7LjHd55L2ltehNDfBnGux
   NgRTmng98Yro6gxNE+NrcQl0ez4jbQsdBZB5eTiDvlegugHAbo+CYMU/q
   I0nc9aPOU48BLIiuYjYLeKC0ddTutzonM8wK1jxn/us2jdDbj/CB9Gl1F
   13t7+1HXnkHi4V9w/D7K8KOZR9pIrOO51ZYmk8HBb9joSjgReqdkSb9lR
   a+VpqFH6m62tClHtk01a4JmZaRfA80aILyguZTsq+75Ir7CERmjDatdKa
   sce6ql+NuwZQ/8FRgGc632F7spG00EdqoLKypoPmF+4LDWi8JDkOxfGkP
   Q==;
X-CSE-ConnectionGUID: Cn6/ClIbSRqVjLSag6tLNw==
X-CSE-MsgGUID: 3PdZR3FhSXmE7uPmpnjTOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="64580401"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="64580401"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 11:27:40 -0700
X-CSE-ConnectionGUID: stv7vfFCSdeHBPP5LF+uSw==
X-CSE-MsgGUID: aPOfJi39TMSEQztG3b8yRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="177620568"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 23 Sep 2025 11:27:36 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v17ji-0003Q5-1C;
	Tue, 23 Sep 2025 18:27:34 +0000
Date: Wed, 24 Sep 2025 02:27:20 +0800
From: kernel test robot <lkp@intel.com>
To: Sherry Sun <sherry.sun@nxp.com>, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, shenwei.wang@nxp.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 2/2] tty: serial: imx: Add missing wakeup event reporting
Message-ID: <202509240214.bHWiT4Db-lkp@intel.com>
References: <20250923031613.2448073-3-sherry.sun@nxp.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923031613.2448073-3-sherry.sun@nxp.com>

Hi Sherry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shawnguo/for-next]
[also build test WARNING on tty/tty-testing tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.17-rc7 next-20250922]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sherry-Sun/tty-serial-imx-Only-configure-the-wake-register-when-device-is-set-as-wakeup-source/20250923-111951
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
patch link:    https://lore.kernel.org/r/20250923031613.2448073-3-sherry.sun%40nxp.com
patch subject: [PATCH 2/2] tty: serial: imx: Add missing wakeup event reporting
config: arm-randconfig-004-20250923 (https://download.01.org/0day-ci/archive/20250924/202509240214.bHWiT4Db-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project cafc064fc7a96b3979a023ddae1da2b499d6c954)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250924/202509240214.bHWiT4Db-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509240214.bHWiT4Db-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/imx.c:2721:6: warning: variable 'wake_active' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    2721 |         if (on) {
         |             ^~
   drivers/tty/serial/imx.c:2742:6: note: uninitialized use occurs here
    2742 |         if (wake_active && irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq)))
         |             ^~~~~~~~~~~
   drivers/tty/serial/imx.c:2721:2: note: remove the 'if' if its condition is always false
    2721 |         if (on) {
         |         ^~~~~~~~~
    2722 |                 imx_uart_writel(sport, USR1_AWAKE, USR1);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    2723 |                 ucr3 |= UCR3_AWAKEN;
         |                 ~~~~~~~~~~~~~~~~~~~~
    2724 |         } else {
         |         ~~~~~~
   drivers/tty/serial/imx.c:2704:28: note: initialize the variable 'wake_active' to silence this warning
    2704 |         bool may_wake, wake_active;
         |                                   ^
         |                                    = 0
   drivers/tty/serial/imx.c:2707:6: warning: variable 'may_wake' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    2707 |         if (tty) {
         |             ^~~
   drivers/tty/serial/imx.c:2714:7: note: uninitialized use occurs here
    2714 |         if (!may_wake)
         |              ^~~~~~~~
   drivers/tty/serial/imx.c:2707:2: note: remove the 'if' if its condition is always true
    2707 |         if (tty) {
         |         ^~~~~~~~
   drivers/tty/serial/imx.c:2704:15: note: initialize the variable 'may_wake' to silence this warning
    2704 |         bool may_wake, wake_active;
         |                      ^
         |                       = 0
   2 warnings generated.


vim +2721 drivers/tty/serial/imx.c

c868cbb7e5c6d3 Eduardo Valentin 2015-08-11  2696  
3c199ed5bd6469 Esben Haabendal  2024-09-13  2697  /* called with irq off */
9d1a50a2cceb3a Uwe Kleine-König 2018-03-02  2698  static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
189550b8644ef5 Eduardo Valentin 2015-08-11  2699  {
519ca97b8a2e94 Sherry Sun       2025-09-23  2700  	struct tty_port *port = &sport->port.state->port;
519ca97b8a2e94 Sherry Sun       2025-09-23  2701  	struct tty_struct *tty;
519ca97b8a2e94 Sherry Sun       2025-09-23  2702  	struct device *tty_dev;
2e33c984e6b3d6 Sherry Sun       2025-09-23  2703  	u32 ucr3, usr1;
2e33c984e6b3d6 Sherry Sun       2025-09-23  2704  	bool may_wake, wake_active;
519ca97b8a2e94 Sherry Sun       2025-09-23  2705  
519ca97b8a2e94 Sherry Sun       2025-09-23  2706  	tty = tty_port_tty_get(port);
519ca97b8a2e94 Sherry Sun       2025-09-23  2707  	if (tty) {
519ca97b8a2e94 Sherry Sun       2025-09-23  2708  		tty_dev = tty->dev;
519ca97b8a2e94 Sherry Sun       2025-09-23  2709  		may_wake = tty_dev && device_may_wakeup(tty_dev);
519ca97b8a2e94 Sherry Sun       2025-09-23  2710  		tty_kref_put(tty);
519ca97b8a2e94 Sherry Sun       2025-09-23  2711  	}
519ca97b8a2e94 Sherry Sun       2025-09-23  2712  
519ca97b8a2e94 Sherry Sun       2025-09-23  2713  	/* only configure the wake register when device set as wakeup source */
519ca97b8a2e94 Sherry Sun       2025-09-23  2714  	if (!may_wake)
519ca97b8a2e94 Sherry Sun       2025-09-23  2715  		return;
189550b8644ef5 Eduardo Valentin 2015-08-11  2716  
fbd22c4fa737f9 Xiaolei Wang     2024-12-11  2717  	uart_port_lock_irq(&sport->port);
3c199ed5bd6469 Esben Haabendal  2024-09-13  2718  
2e33c984e6b3d6 Sherry Sun       2025-09-23  2719  	usr1 = imx_uart_readl(sport, USR1);
4444dcf1fe7ea5 Uwe Kleine-König 2018-03-02  2720  	ucr3 = imx_uart_readl(sport, UCR3);
09df0b3464e528 Martin Kaiser    2018-01-05 @2721  	if (on) {
27c844261b87f8 Uwe Kleine-König 2018-03-02  2722  		imx_uart_writel(sport, USR1_AWAKE, USR1);
4444dcf1fe7ea5 Uwe Kleine-König 2018-03-02  2723  		ucr3 |= UCR3_AWAKEN;
4444dcf1fe7ea5 Uwe Kleine-König 2018-03-02  2724  	} else {
4444dcf1fe7ea5 Uwe Kleine-König 2018-03-02  2725  		ucr3 &= ~UCR3_AWAKEN;
2e33c984e6b3d6 Sherry Sun       2025-09-23  2726  		wake_active = usr1 & USR1_AWAKE;
09df0b3464e528 Martin Kaiser    2018-01-05  2727  	}
4444dcf1fe7ea5 Uwe Kleine-König 2018-03-02  2728  	imx_uart_writel(sport, ucr3, UCR3);
bc85734b126f81 Eduardo Valentin 2015-08-11  2729  
38b1f0fb42f772 Fabio Estevam    2018-01-04  2730  	if (sport->have_rtscts) {
4444dcf1fe7ea5 Uwe Kleine-König 2018-03-02  2731  		u32 ucr1 = imx_uart_readl(sport, UCR1);
c67643b46c28fc Fugang Duan      2021-11-25  2732  		if (on) {
c67643b46c28fc Fugang Duan      2021-11-25  2733  			imx_uart_writel(sport, USR1_RTSD, USR1);
4444dcf1fe7ea5 Uwe Kleine-König 2018-03-02  2734  			ucr1 |= UCR1_RTSDEN;
c67643b46c28fc Fugang Duan      2021-11-25  2735  		} else {
4444dcf1fe7ea5 Uwe Kleine-König 2018-03-02  2736  			ucr1 &= ~UCR1_RTSDEN;
2e33c984e6b3d6 Sherry Sun       2025-09-23  2737  			wake_active |= usr1 & USR1_RTSD;
c67643b46c28fc Fugang Duan      2021-11-25  2738  		}
4444dcf1fe7ea5 Uwe Kleine-König 2018-03-02  2739  		imx_uart_writel(sport, ucr1, UCR1);
189550b8644ef5 Eduardo Valentin 2015-08-11  2740  	}
3c199ed5bd6469 Esben Haabendal  2024-09-13  2741  
2e33c984e6b3d6 Sherry Sun       2025-09-23  2742  	if (wake_active && irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq)))
2e33c984e6b3d6 Sherry Sun       2025-09-23  2743  		pm_wakeup_event(tty_port_tty_get(port)->dev, 0);
2e33c984e6b3d6 Sherry Sun       2025-09-23  2744  
fbd22c4fa737f9 Xiaolei Wang     2024-12-11  2745  	uart_port_unlock_irq(&sport->port);
38b1f0fb42f772 Fabio Estevam    2018-01-04  2746  }
189550b8644ef5 Eduardo Valentin 2015-08-11  2747  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
