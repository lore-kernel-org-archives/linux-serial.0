Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A36A3491FB
	for <linux-serial@vger.kernel.org>; Wed, 22 Oct 2025 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138490; cv=none; b=umMAnPkZGzbkhr6imlFswKm13eXDsM1neNbrFu9uIv3JltQzO7ljAi1yeBaezB3IPP9t6b+lqsEtYbS47yTjEtJ8xOEf9dHvfA03qobrMg8JB5f51+Ew7qToLaQf6mGiaUEwJR4hv2fmK27aCPtbJEI/QRDtTnmla0FcpcR255o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138490; c=relaxed/simple;
	bh=ZoTPenGJmIvPF1ZauSj9UEAqI9olcyZxwqnCJExCdYU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bA8KrYk2Q5nXrcfAgBvQTZn7OwXoqFuCEy5o6JW87dGOoCuJN+JTRtVos/l9sSuV9d1hX5VzMWEoGI0kT8uoowAyppDS8cxN/j/j68ACQs0NKhY/DDa9VJP6A77vWpXPOg9WptrXESDXCKbrT4gCjGZw56sys56dUGTvfRNjsZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D5GepoUd; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D5GepoUd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761138488; x=1792674488;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZoTPenGJmIvPF1ZauSj9UEAqI9olcyZxwqnCJExCdYU=;
  b=D5GepoUdKT5pTP9n6PYlCxl0hk2KA7Ihxb+OximWQ+St+9YoKo5xwx7w
   eAbZ0tCY6pB9a1/p4RxL8De9cCOE3X9e9H3WahHeT+rZoPUp2hMzsML5M
   J7FcBiwxaMFn5cn1wx8MFgaQ2fhvtX0BoOH4YR3nKHo+hTIdC/3frY605
   4LksykEx3a7jkoBvawM3MzTGZnetXME7ZLyKR1YoovhXKMeKCICinnVMD
   3ZqQjspCtk1stE8cOPl0LAvsDQzVkyfge9wiGa5fRA5c2smZLyIrQEmkR
   ssVXgV/h93ADqsqJD1XPF+UY2WD6Hz69grf5SfuBjg6CPU3fBI8yhYpxE
   Q==;
X-CSE-ConnectionGUID: DUnppk3hTWq948Zk/4B46w==
X-CSE-MsgGUID: DwYi5SRRQNSAelG98CL1YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62988481"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="62988481"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 06:08:07 -0700
X-CSE-ConnectionGUID: 1LWgONJ8Q6O1LTgbgm1x0A==
X-CSE-MsgGUID: a06OhsB4RVqT+mu6nKmIFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="188274892"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 22 Oct 2025 06:08:06 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBYZP-000CNi-2C;
	Wed, 22 Oct 2025 13:08:03 +0000
Date: Wed, 22 Oct 2025 21:07:24 +0800
From: kernel test robot <lkp@intel.com>
To: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 11/22] drivers/tty/serial/sc16is7xx.c:596:9: error:
 implicit declaration of function 'sc16is7xx_efr_lock'; did you mean
 'sc16is7xx_regs_lock'?
Message-ID: <202510222048.fnK8S60G-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   cdca3a77b423691b0e3780653642cd5b31de8bd8
commit: 5a91e16ba44d9850088278ebe209b5c533f87cb8 [11/22] serial: sc16is7xx: define common register access function
config: x86_64-buildonly-randconfig-003-20251022 (https://download.01.org/0day-ci/archive/20251022/202510222048.fnK8S60G-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251022/202510222048.fnK8S60G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510222048.fnK8S60G-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/tty/serial/sc16is7xx.c: In function 'sc16is7xx_set_baud':
>> drivers/tty/serial/sc16is7xx.c:596:9: error: implicit declaration of function 'sc16is7xx_efr_lock'; did you mean 'sc16is7xx_regs_lock'? [-Wimplicit-function-declaration]
     596 |         sc16is7xx_efr_lock(port);
         |         ^~~~~~~~~~~~~~~~~~
         |         sc16is7xx_regs_lock
>> drivers/tty/serial/sc16is7xx.c:600:9: error: implicit declaration of function 'sc16is7xx_efr_unlock'; did you mean 'sc16is7xx_regs_unlock'? [-Wimplicit-function-declaration]
     600 |         sc16is7xx_efr_unlock(port);
         |         ^~~~~~~~~~~~~~~~~~~~
         |         sc16is7xx_regs_unlock


vim +596 drivers/tty/serial/sc16is7xx.c

dbf4ab821804df0 Hugo Villeneuve 2023-12-11  572  
8492bd91aa05590 Hugo Villeneuve 2024-04-30  573  /*
8492bd91aa05590 Hugo Villeneuve 2024-04-30  574   * Configure programmable baud rate generator (divisor) according to the
8492bd91aa05590 Hugo Villeneuve 2024-04-30  575   * desired baud rate.
8492bd91aa05590 Hugo Villeneuve 2024-04-30  576   *
8492bd91aa05590 Hugo Villeneuve 2024-04-30  577   * From the datasheet, the divisor is computed according to:
8492bd91aa05590 Hugo Villeneuve 2024-04-30  578   *
8492bd91aa05590 Hugo Villeneuve 2024-04-30  579   *              XTAL1 input frequency
8492bd91aa05590 Hugo Villeneuve 2024-04-30  580   *             -----------------------
8492bd91aa05590 Hugo Villeneuve 2024-04-30  581   *                    prescaler
8492bd91aa05590 Hugo Villeneuve 2024-04-30  582   * divisor = ---------------------------
8492bd91aa05590 Hugo Villeneuve 2024-04-30  583   *            baud-rate x sampling-rate
8492bd91aa05590 Hugo Villeneuve 2024-04-30  584   */
dfeae619d781dee Jon Ringle      2014-04-24  585  static int sc16is7xx_set_baud(struct uart_port *port, int baud)
dfeae619d781dee Jon Ringle      2014-04-24  586  {
8492bd91aa05590 Hugo Villeneuve 2024-04-30  587  	unsigned int prescaler = 1;
dfeae619d781dee Jon Ringle      2014-04-24  588  	unsigned long clk = port->uartclk, div = clk / 16 / baud;
dfeae619d781dee Jon Ringle      2014-04-24  589  
2e57cefc4477659 Hugo Villeneuve 2023-12-21  590  	if (div >= BIT(16)) {
8492bd91aa05590 Hugo Villeneuve 2024-04-30  591  		prescaler = 4;
8492bd91aa05590 Hugo Villeneuve 2024-04-30  592  		div /= prescaler;
dfeae619d781dee Jon Ringle      2014-04-24  593  	}
dfeae619d781dee Jon Ringle      2014-04-24  594  
dfeae619d781dee Jon Ringle      2014-04-24  595  	/* Enable enhanced features */
0c84bea0cabc4e2 Hugo Villeneuve 2023-12-21 @596  	sc16is7xx_efr_lock(port);
c112653b89e0cea Lech Perczak    2022-02-21  597  	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
c112653b89e0cea Lech Perczak    2022-02-21  598  			      SC16IS7XX_EFR_ENABLE_BIT,
dfeae619d781dee Jon Ringle      2014-04-24  599  			      SC16IS7XX_EFR_ENABLE_BIT);
0c84bea0cabc4e2 Hugo Villeneuve 2023-12-21 @600  	sc16is7xx_efr_unlock(port);
30ec514d440cf2c Phil Elwell     2018-09-12  601  
8492bd91aa05590 Hugo Villeneuve 2024-04-30  602  	/* If bit MCR_CLKSEL is set, the divide by 4 prescaler is activated. */
dfeae619d781dee Jon Ringle      2014-04-24  603  	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
dfeae619d781dee Jon Ringle      2014-04-24  604  			      SC16IS7XX_MCR_CLKSEL_BIT,
8492bd91aa05590 Hugo Villeneuve 2024-04-30  605  			      prescaler == 1 ? 0 : SC16IS7XX_MCR_CLKSEL_BIT);
dfeae619d781dee Jon Ringle      2014-04-24  606  
5a91e16ba44d985 Hugo Villeneuve 2025-10-02  607  	/* Access special register set (DLL/DLH) */
5a91e16ba44d985 Hugo Villeneuve 2025-10-02  608  	sc16is7xx_regs_lock(port, SC16IS7XX_LCR_REG_SET_SPECIAL);
dfeae619d781dee Jon Ringle      2014-04-24  609  
dfeae619d781dee Jon Ringle      2014-04-24  610  	/* Write the new divisor */
dfeae619d781dee Jon Ringle      2014-04-24  611  	sc16is7xx_port_write(port, SC16IS7XX_DLH_REG, div / 256);
dfeae619d781dee Jon Ringle      2014-04-24  612  	sc16is7xx_port_write(port, SC16IS7XX_DLL_REG, div % 256);
dfeae619d781dee Jon Ringle      2014-04-24  613  
5a91e16ba44d985 Hugo Villeneuve 2025-10-02  614  	/* Restore access to general register set */
5a91e16ba44d985 Hugo Villeneuve 2025-10-02  615  	sc16is7xx_regs_unlock(port);
7d3b793faaab130 Hugo Villeneuve 2024-07-23  616  
8492bd91aa05590 Hugo Villeneuve 2024-04-30  617  	return DIV_ROUND_CLOSEST((clk / prescaler) / 16, div);
dfeae619d781dee Jon Ringle      2014-04-24  618  }
dfeae619d781dee Jon Ringle      2014-04-24  619  

:::::: The code at line 596 was first introduced by commit
:::::: 0c84bea0cabc4e2b98a3de88eeb4ff798931f056 serial: sc16is7xx: refactor EFR lock

:::::: TO: Hugo Villeneuve <hvilleneuve@dimonoff.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
