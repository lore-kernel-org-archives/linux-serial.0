Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866741D90C8;
	Tue, 23 Sep 2025 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648971; cv=none; b=hY14xVrK/8nHaTq/PExbT0oJdzYKQ5QWZ93bYfBw4IhRAmH8UKNekf6dzXZrMtYsN9z4NrfSfaI5l2gtx6VaCES4vbUX77rwPy0oIz3m+QpBs53mkSc0YYmTB275zWvetKcqUkC5geAcFqihEe17O6QHH6RszSfREXjQZCeXwmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648971; c=relaxed/simple;
	bh=UO2O51VzC78DSwnhfdoePqLlffRPw7JsQtk2TxHv3IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2Y0eslnzedMLp0F7cjljTx31hQb/NnVEaXHHLPVI4hWj5PlZKjXIYaNjVjRfYTaefzCLLKzICRxLKuuut/LiuwRCSpm2z+eH0GlwZeHFwXwgaroXgycrI6fiK1kRlt/9nfbTA+OLQb1l0rL1P2psdNLDfF+RjYvSuGiYgAStD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cAN4upMG; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cAN4upMG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758648968; x=1790184968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UO2O51VzC78DSwnhfdoePqLlffRPw7JsQtk2TxHv3IM=;
  b=cAN4upMGN0mLp4Hxsg5dzxrC+K+q5kOXMymHs/g7OgOFW15OSL+dWG4g
   SI40OYSib8oJpzjcKiNfrSd1Ppv32+LPVSHhmZe0AkznZmfrKrz5E4MgI
   Wdyz5lUEuyyRgQvJGs1pUkF3qxLOA1ClJI/Ykqqw2KoFreFZg03rXZlWD
   VhBx26+LpeTyuZWywIRt3TemniKzXbq7Sz+GbtxQaFOSgNUv32Ena3H2r
   M2rUSezkF2G9YhRhfxh9g53DlVJ02IfishUT5uMzPEsXidCTYLE0eH633
   JLX8CcXiiMjoLKqbFn3y4OFajtV5FtoxmCtM9+LdkDY6OLTPUlJ8A2pom
   Q==;
X-CSE-ConnectionGUID: QfZfV6NDQEKBgN0xea3LBw==
X-CSE-MsgGUID: nutybuEuRUOBYdg3ijLUfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60637900"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="60637900"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 10:36:07 -0700
X-CSE-ConnectionGUID: zeCWYP7RRuqxfU0nURwVhg==
X-CSE-MsgGUID: yvx2pBrOT+K/zO2LlHrCjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="176419047"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 23 Sep 2025 10:36:04 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v16vp-0003Nh-2B;
	Tue, 23 Sep 2025 17:36:01 +0000
Date: Wed, 24 Sep 2025 01:35:11 +0800
From: kernel test robot <lkp@intel.com>
To: Sherry Sun <sherry.sun@nxp.com>, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, shenwei.wang@nxp.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 2/2] tty: serial: imx: Add missing wakeup event reporting
Message-ID: <202509240146.aj950Liu-lkp@intel.com>
References: <20250923031613.2448073-3-sherry.sun@nxp.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923031613.2448073-3-sherry.sun@nxp.com>

Hi Sherry,

kernel test robot noticed the following build errors:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.17-rc7 next-20250922]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sherry-Sun/tty-serial-imx-Only-configure-the-wake-register-when-device-is-set-as-wakeup-source/20250923-111951
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
patch link:    https://lore.kernel.org/r/20250923031613.2448073-3-sherry.sun%40nxp.com
patch subject: [PATCH 2/2] tty: serial: imx: Add missing wakeup event reporting
config: x86_64-buildonly-randconfig-004-20250923 (https://download.01.org/0day-ci/archive/20250924/202509240146.aj950Liu-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250924/202509240146.aj950Liu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509240146.aj950Liu-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/tty/serial/imx.c:2742:21: error: call to undeclared function 'irqd_is_wakeup_set'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2742 |         if (wake_active && irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq)))
         |                            ^
>> drivers/tty/serial/imx.c:2742:40: error: call to undeclared function 'irq_get_irq_data'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2742 |         if (wake_active && irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq)))
         |                                               ^
   drivers/tty/serial/imx.c:2742:40: note: did you mean 'irq_set_irq_wake'?
   include/linux/interrupt.h:481:12: note: 'irq_set_irq_wake' declared here
     481 | extern int irq_set_irq_wake(unsigned int irq, unsigned int on);
         |            ^
   2 errors generated.


vim +/irqd_is_wakeup_set +2742 drivers/tty/serial/imx.c

  2696	
  2697	/* called with irq off */
  2698	static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
  2699	{
  2700		struct tty_port *port = &sport->port.state->port;
  2701		struct tty_struct *tty;
  2702		struct device *tty_dev;
  2703		u32 ucr3, usr1;
  2704		bool may_wake, wake_active;
  2705	
  2706		tty = tty_port_tty_get(port);
  2707		if (tty) {
  2708			tty_dev = tty->dev;
  2709			may_wake = tty_dev && device_may_wakeup(tty_dev);
  2710			tty_kref_put(tty);
  2711		}
  2712	
  2713		/* only configure the wake register when device set as wakeup source */
  2714		if (!may_wake)
  2715			return;
  2716	
  2717		uart_port_lock_irq(&sport->port);
  2718	
  2719		usr1 = imx_uart_readl(sport, USR1);
  2720		ucr3 = imx_uart_readl(sport, UCR3);
  2721		if (on) {
  2722			imx_uart_writel(sport, USR1_AWAKE, USR1);
  2723			ucr3 |= UCR3_AWAKEN;
  2724		} else {
  2725			ucr3 &= ~UCR3_AWAKEN;
  2726			wake_active = usr1 & USR1_AWAKE;
  2727		}
  2728		imx_uart_writel(sport, ucr3, UCR3);
  2729	
  2730		if (sport->have_rtscts) {
  2731			u32 ucr1 = imx_uart_readl(sport, UCR1);
  2732			if (on) {
  2733				imx_uart_writel(sport, USR1_RTSD, USR1);
  2734				ucr1 |= UCR1_RTSDEN;
  2735			} else {
  2736				ucr1 &= ~UCR1_RTSDEN;
  2737				wake_active |= usr1 & USR1_RTSD;
  2738			}
  2739			imx_uart_writel(sport, ucr1, UCR1);
  2740		}
  2741	
> 2742		if (wake_active && irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq)))
  2743			pm_wakeup_event(tty_port_tty_get(port)->dev, 0);
  2744	
  2745		uart_port_unlock_irq(&sport->port);
  2746	}
  2747	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
