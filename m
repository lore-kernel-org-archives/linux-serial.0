Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0062505AA
	for <linux-serial@vger.kernel.org>; Fri, 13 Feb 2026 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771005048; cv=none; b=Iupympv1i9265gthCdJgigroTrQ/afTeqkOZu1zfXjxDcUPurMNigUJucOiNBJkW1If/IOI9QXEzbdbuZMdiTv5f9Bx10Mxlj/aG959WekUF0MYa047jDBLdp75fITJL9xq77fcl1b80nb3ORXMbtJURpXn8/CykrBrqjOYo3UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771005048; c=relaxed/simple;
	bh=Hn/YbMCFPNwy7WqclUnTHTDS9PREVwpYJ6OC8kfWHYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvXK9DDR6H64vj7J9uQapiO+0z7cELMg0pZhVmx8j0JPE1A+kRg//rZrehe8243moup1ycsbvMKimC+UONdsSHKLRlvWhMt8qpJq0qeWP5p/06hH6ZqaTUxi6N3kOeJ2qSe7re6UxXDcmxAwExWkwqXJIHTeY7O3BQSgT5AArds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAaxG2qN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAaxG2qN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771005047; x=1802541047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hn/YbMCFPNwy7WqclUnTHTDS9PREVwpYJ6OC8kfWHYQ=;
  b=lAaxG2qNH4ZlQSogjeXake+jOm5hDzzCm/aBXaiubv6FjmkIshyW69a2
   B9JUvwb9zEufM83GEzytGhw/Zzf8TS846J1QssbiTomyZ82HX5l7kx/L7
   O0PW9AB13ZWMZdqpHtlPovHQ7qiATMdYXIjQXPU6q4AaAnUOyKc3Xr7hD
   +ydrVWl9T3Lfp9zVu2RT8sJpvIMXlVQLRxaL/grtVpw3mJkmkmV2jsRL0
   bivlc0MqzcWnz6Z8Fgo/iqCLfqrAeQl/gAzV3cxIoYG+HArTLKJ27lOEl
   rMUOxpcRpQDPRtmWTh9cdoQxNHLIBJl/OyPUN3+2TXvP3kuN0FEltADLF
   Q==;
X-CSE-ConnectionGUID: 9b0ibA3bSEC666gYxwgkBg==
X-CSE-MsgGUID: lQc0CsQwSn65otBFkK6TvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="76042147"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="76042147"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 09:50:46 -0800
X-CSE-ConnectionGUID: HsqJDspKS4WjuQjo+NXLxQ==
X-CSE-MsgGUID: bqD5zFG7TJa7NeOs2yrG/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="212227967"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 13 Feb 2026 09:50:40 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vqxJN-00000000viu-43MR;
	Fri, 13 Feb 2026 17:50:38 +0000
Date: Sat, 14 Feb 2026 01:50:20 +0800
From: kernel test robot <lkp@intel.com>
To: LiuQingtao <qtliu@mail.ustc.edu.cn>, gregkh@linuxfoundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, neil.armstrong@linaro.org,
	bjorn.andersson@oss.qualcomm.com, marex@nabladev.com, dev@kael-k.io,
	mani@kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
	liu.wenhong35@zte.com.cn, liu.qingtao2@zte.com.cn,
	hu.yuye@zte.com.cn, dai.hualiang@zte.com.cn,
	deng.weixian@zte.com.cn, jia.yunxiang@zte.com.cn,
	bai.lu5@zte.com.cn, yang.susheng@zte.com.cn, shen.lin1@zte.com.cn,
	tan.hu@zte.com.cn, zuo.jiang@zte.com.cn
Subject: Re: [PATCH v1 2/2] LRW UART: serial: add driver for the LRW UART
Message-ID: <202602140108.kLMOYbwS-lkp@intel.com>
References: <20260213093334.9217-3-qtliu@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213093334.9217-3-qtliu@mail.ustc.edu.cn>

Hi LiuQingtao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus robh/for-next usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.19 next-20260212]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/LiuQingtao/LRW-UART-dt-bindings-Add-binding-for-LRW-UART/20260213-173610
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20260213093334.9217-3-qtliu%40mail.ustc.edu.cn
patch subject: [PATCH v1 2/2] LRW UART: serial: add driver for the LRW UART
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20260214/202602140108.kLMOYbwS-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260214/202602140108.kLMOYbwS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602140108.kLMOYbwS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/lrw_uart.c:2266:3: warning: variable 'new_mcfg' is uninitialized when used here [-Wuninitialized]
                   new_mcfg |= UARTMCFG_UARTEN | UARTMCFG_TXE;
                   ^~~~~~~~
   drivers/tty/serial/lrw_uart.c:2246:37: note: initialize the variable 'new_mcfg' to silence this warning
           unsigned int old_mcfg = 0, new_mcfg;
                                              ^
                                               = 0
   1 warning generated.


vim +/new_mcfg +2266 drivers/tty/serial/lrw_uart.c

  2240	
  2241	static void
  2242	lrw_uart_console_write(struct console *co, const char *s, unsigned int count)
  2243	{
  2244		struct lrw_uart_port *sup = lrw_uart_console_ports[co->index];
  2245		unsigned int old_fccr = 0, new_fccr;
  2246		unsigned int old_mcfg = 0, new_mcfg;
  2247		unsigned long flags;
  2248		int locked = 1;
  2249	
  2250		clk_enable(sup->clk);
  2251	
  2252		if (oops_in_progress)
  2253			locked = uart_port_trylock_irqsave(&sup->port, &flags);
  2254		else
  2255			uart_port_lock_irqsave(&sup->port, &flags);
  2256	
  2257		/*
  2258		 *	First save the FCCR then disable the interrupts
  2259		 */
  2260		if (!sup->vendor->always_enabled) {
  2261			old_fccr = lrw_uart_read(sup, REG_FCCR);
  2262			new_fccr = old_fccr & ~UARTFCCR_CTSEN;
  2263			lrw_uart_write(new_fccr, sup, REG_FCCR);
  2264	
  2265			old_mcfg = lrw_uart_read(sup, REG_MCFG);
> 2266			new_mcfg |= UARTMCFG_UARTEN | UARTMCFG_TXE;
  2267			lrw_uart_write(new_mcfg, sup, REG_MCFG);
  2268		}
  2269	
  2270		uart_console_write(&sup->port, s, count, lrw_uart_console_putchar);
  2271	
  2272		/*
  2273		 *	Finally, wait for transmitter to become empty and restore the
  2274		 *	TCR. Allow feature register bits to be inverted to work around
  2275		 *	errata.
  2276		 */
  2277		while ((lrw_uart_read(sup, REG_FR) ^ sup->vendor->inv_fr)
  2278							& sup->vendor->fr_busy)
  2279			cpu_relax();
  2280		if (!sup->vendor->always_enabled) {
  2281			lrw_uart_write(old_fccr, sup, REG_FCCR);
  2282			lrw_uart_write(old_mcfg, sup, REG_MCFG);
  2283		}
  2284	
  2285		if (locked)
  2286			uart_port_unlock_irqrestore(&sup->port, flags);
  2287	
  2288		clk_disable(sup->clk);
  2289	}
  2290	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
