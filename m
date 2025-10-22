Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA81348454
	for <linux-serial@vger.kernel.org>; Wed, 22 Oct 2025 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141020; cv=none; b=Tgp5Y3wsLH5ZIHqjaJRDp3Ua9+pMeulUMPZUa9Gpf+MQ8mr1sdH0Evhh2bCIFwY+mJ4FZl51CLmdNB1gtNRfpKgcxUThtUppls1irws/kluv/wRW5A9RgjPMtu6oEzziyQ1wb8gPtGRaAnYOwrkqPMEljbSB2IxTMrLsJQZk+Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141020; c=relaxed/simple;
	bh=FOryICHK+pWxBCLgW55XSKsEfoc17pOZrwVLDy5Yfew=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jszICkpIyrTZlAAMTto1P9MEWlB0NAAGAr0je736pHzXsvuIsOHbMUjmQU+5T0REySqHO0oqDvCc23d/VIeVsduHkKOrqhK0PH2+z4oZHW8rTktXAsvkG3FtI5S5+OWYrPnox7FXGgXUHrgcKMRwhVRP30IMQRao/fmrSwVXjz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+FA7M52; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+FA7M52"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761141018; x=1792677018;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FOryICHK+pWxBCLgW55XSKsEfoc17pOZrwVLDy5Yfew=;
  b=k+FA7M52dj7xpKNc0RhKkryJdge1XArvCRQIpk6b2MEPvU9ksh3fbcjm
   G1Di2Wvq0FM+FfxYp3T/t0kgr39s9DqII8XGPTmHK+XPrkvkTx/qr3dXT
   U0cE1iKTvYUwF4VbuWN98LySlQniVPMmjClvT1mbErNmcwrK8GiuBaL3C
   7bAx5yJtd8BkKtLTr5LpukfuCLOnzArBhP+SbCTYdZuZpGhv+EG5XOfip
   oztZhNiS42MlXEnzdDyX6Vrd3DCd6K/kEDOdTs0sdVa9XI/CEfEkqQdUE
   TUm3VskKwOzpMrU7U1Is6oPc7Zhrmk94rS2y5gXatYjuMmqNCiVuZ1Poz
   g==;
X-CSE-ConnectionGUID: 41jyaGTVS/m9LpTEaLYsyA==
X-CSE-MsgGUID: 8dkNi4t6SRCCdH/ankrfhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="80917608"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="80917608"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 06:50:17 -0700
X-CSE-ConnectionGUID: 8bBdo0e7TC6hyGdwZIM5EQ==
X-CSE-MsgGUID: UJhSuAq0Tj6FEmxhrKnZ8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="214821863"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 22 Oct 2025 06:50:16 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBZED-000CPD-1e;
	Wed, 22 Oct 2025 13:50:13 +0000
Date: Wed, 22 Oct 2025 21:48:34 +0800
From: kernel test robot <lkp@intel.com>
To: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 11/22] drivers/tty/serial/sc16is7xx.c:596:2: error:
 call to undeclared function 'sc16is7xx_efr_lock'; ISO C99 and later do not
 support implicit function declarations
Message-ID: <202510222116.kkZML444-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-001-20251022 (https://download.01.org/0day-ci/archive/20251022/202510222116.kkZML444-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251022/202510222116.kkZML444-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510222116.kkZML444-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/tty/serial/sc16is7xx.c:596:2: error: call to undeclared function 'sc16is7xx_efr_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     596 |         sc16is7xx_efr_lock(port);
         |         ^
   drivers/tty/serial/sc16is7xx.c:596:2: note: did you mean 'sc16is7xx_regs_lock'?
   drivers/tty/serial/sc16is7xx.c:441:13: note: 'sc16is7xx_regs_lock' declared here
     441 | static void sc16is7xx_regs_lock(struct uart_port *port, u8 register_set)
         |             ^
>> drivers/tty/serial/sc16is7xx.c:600:2: error: call to undeclared function 'sc16is7xx_efr_unlock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     600 |         sc16is7xx_efr_unlock(port);
         |         ^
   2 errors generated.


vim +/sc16is7xx_efr_lock +596 drivers/tty/serial/sc16is7xx.c

dbf4ab821804df Hugo Villeneuve 2023-12-11  572  
8492bd91aa0559 Hugo Villeneuve 2024-04-30  573  /*
8492bd91aa0559 Hugo Villeneuve 2024-04-30  574   * Configure programmable baud rate generator (divisor) according to the
8492bd91aa0559 Hugo Villeneuve 2024-04-30  575   * desired baud rate.
8492bd91aa0559 Hugo Villeneuve 2024-04-30  576   *
8492bd91aa0559 Hugo Villeneuve 2024-04-30  577   * From the datasheet, the divisor is computed according to:
8492bd91aa0559 Hugo Villeneuve 2024-04-30  578   *
8492bd91aa0559 Hugo Villeneuve 2024-04-30  579   *              XTAL1 input frequency
8492bd91aa0559 Hugo Villeneuve 2024-04-30  580   *             -----------------------
8492bd91aa0559 Hugo Villeneuve 2024-04-30  581   *                    prescaler
8492bd91aa0559 Hugo Villeneuve 2024-04-30  582   * divisor = ---------------------------
8492bd91aa0559 Hugo Villeneuve 2024-04-30  583   *            baud-rate x sampling-rate
8492bd91aa0559 Hugo Villeneuve 2024-04-30  584   */
dfeae619d781de Jon Ringle      2014-04-24  585  static int sc16is7xx_set_baud(struct uart_port *port, int baud)
dfeae619d781de Jon Ringle      2014-04-24  586  {
8492bd91aa0559 Hugo Villeneuve 2024-04-30  587  	unsigned int prescaler = 1;
dfeae619d781de Jon Ringle      2014-04-24  588  	unsigned long clk = port->uartclk, div = clk / 16 / baud;
dfeae619d781de Jon Ringle      2014-04-24  589  
2e57cefc447765 Hugo Villeneuve 2023-12-21  590  	if (div >= BIT(16)) {
8492bd91aa0559 Hugo Villeneuve 2024-04-30  591  		prescaler = 4;
8492bd91aa0559 Hugo Villeneuve 2024-04-30  592  		div /= prescaler;
dfeae619d781de Jon Ringle      2014-04-24  593  	}
dfeae619d781de Jon Ringle      2014-04-24  594  
dfeae619d781de Jon Ringle      2014-04-24  595  	/* Enable enhanced features */
0c84bea0cabc4e Hugo Villeneuve 2023-12-21 @596  	sc16is7xx_efr_lock(port);
c112653b89e0ce Lech Perczak    2022-02-21  597  	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
c112653b89e0ce Lech Perczak    2022-02-21  598  			      SC16IS7XX_EFR_ENABLE_BIT,
dfeae619d781de Jon Ringle      2014-04-24  599  			      SC16IS7XX_EFR_ENABLE_BIT);
0c84bea0cabc4e Hugo Villeneuve 2023-12-21 @600  	sc16is7xx_efr_unlock(port);
30ec514d440cf2 Phil Elwell     2018-09-12  601  
8492bd91aa0559 Hugo Villeneuve 2024-04-30  602  	/* If bit MCR_CLKSEL is set, the divide by 4 prescaler is activated. */
dfeae619d781de Jon Ringle      2014-04-24  603  	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
dfeae619d781de Jon Ringle      2014-04-24  604  			      SC16IS7XX_MCR_CLKSEL_BIT,
8492bd91aa0559 Hugo Villeneuve 2024-04-30  605  			      prescaler == 1 ? 0 : SC16IS7XX_MCR_CLKSEL_BIT);
dfeae619d781de Jon Ringle      2014-04-24  606  
5a91e16ba44d98 Hugo Villeneuve 2025-10-02  607  	/* Access special register set (DLL/DLH) */
5a91e16ba44d98 Hugo Villeneuve 2025-10-02  608  	sc16is7xx_regs_lock(port, SC16IS7XX_LCR_REG_SET_SPECIAL);
dfeae619d781de Jon Ringle      2014-04-24  609  
dfeae619d781de Jon Ringle      2014-04-24  610  	/* Write the new divisor */
dfeae619d781de Jon Ringle      2014-04-24  611  	sc16is7xx_port_write(port, SC16IS7XX_DLH_REG, div / 256);
dfeae619d781de Jon Ringle      2014-04-24  612  	sc16is7xx_port_write(port, SC16IS7XX_DLL_REG, div % 256);
dfeae619d781de Jon Ringle      2014-04-24  613  
5a91e16ba44d98 Hugo Villeneuve 2025-10-02  614  	/* Restore access to general register set */
5a91e16ba44d98 Hugo Villeneuve 2025-10-02  615  	sc16is7xx_regs_unlock(port);
7d3b793faaab13 Hugo Villeneuve 2024-07-23  616  
8492bd91aa0559 Hugo Villeneuve 2024-04-30  617  	return DIV_ROUND_CLOSEST((clk / prescaler) / 16, div);
dfeae619d781de Jon Ringle      2014-04-24  618  }
dfeae619d781de Jon Ringle      2014-04-24  619  

:::::: The code at line 596 was first introduced by commit
:::::: 0c84bea0cabc4e2b98a3de88eeb4ff798931f056 serial: sc16is7xx: refactor EFR lock

:::::: TO: Hugo Villeneuve <hvilleneuve@dimonoff.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
