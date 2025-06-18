Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB84B209F56
	for <linux-serial@vger.kernel.org>; Wed, 18 Jun 2025 22:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750284164; cv=none; b=uqEQ2d2RGNLWAIpo2bLfbg5rzJ/hROgN77/ckMWh4phowze5XTUki2gHaiSjmieCbqHAYothHDXLK7zxnsfegqmSTXuKtw5USNW79Qb/BguczqK5Kl+4UD+CByqdkN5Absnn6RCoK4GgTNbk+JM2ru2wm+SM7Kedv50Uej5vgew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750284164; c=relaxed/simple;
	bh=BMbyp7nBPmyzjB6SfQtJoyolabQgGKPKZ0aYaOJhATI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U1qOtm5G/LswsU+5hL3gnERgGKU3d1zh65P07WLqXAF13F0I2HmOrlWG1Ssw+q2oYWp9OJZ4QN5cK+mRJKyNTbWlpCaooSaiKWxd/CTTp1UCFP4c74ttj/h1xZXDKsVJON/oEZqobkxARQuptk2YFcb0VjwC18q9U4yOJJMF/Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YvKO/auH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YvKO/auH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750284163; x=1781820163;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BMbyp7nBPmyzjB6SfQtJoyolabQgGKPKZ0aYaOJhATI=;
  b=YvKO/auHTLoXBb1/DlKPDJaDEHBoUDiPbVvoYw+dIj7+TcYi2l1YERkO
   5KwYDr6AeUhi/5I25VQd7l09S5aM3uEkcj2cLActWqO8e/4pMJtVs1aYT
   ln7mPV+vmwa2ngXf6lwuEy7U8z4ixK6SnhmSHClWsS0MiHe14/9pwIGAE
   ajGsmU/tNYLyiGWMnCR8JMBhgstFC0YJiuUGQAtQxAkQ1F22AMUHMFr2y
   86RmMX7gTqnyYlsgH4XuQHIcMi3jSrY3LDWH3lnu5dH8Ll0Op624z6m1j
   HCb/Eqbr1NsfpHv0HY8E3UDHNmM6nDi3YNACNHECiG43RMHIw+Q81U77Y
   g==;
X-CSE-ConnectionGUID: GLzDQu90QB2vNnMOK4gvFA==
X-CSE-MsgGUID: viuMk57gTQCxF6aIFzh0PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52617995"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="52617995"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 15:02:43 -0700
X-CSE-ConnectionGUID: dSZ0sXXtSOKj9r26oYXPOg==
X-CSE-MsgGUID: rJ1MUyCXQDSXmh1xQP4dwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="150067589"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2025 15:02:41 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uS0re-000KDM-0q;
	Wed, 18 Jun 2025 22:02:38 +0000
Date: Thu, 19 Jun 2025 06:01:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [tty:tty-next 8/33] arch/x86/platform/ce4100/ce4100.c:107:16: error:
 incompatible function pointer types assigning to 'u32 (*)(struct uart_port
 *, unsigned int)' (aka 'unsigned int (*)(struct uart_port *, unsigned int)')
 from 'unsigned int (struct uart_port *, int)'
Message-ID: <202506190552.TqNasrC3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   20ca8be9ad2e05015833b07f4325a398e614cf15
commit: fc9ceb501e38cc21066c1638993500b30eda8bdb [8/33] serial: 8250: sanitize uart_port::serial_{in,out}() types
config: i386-randconfig-007-20250619 (https://download.01.org/0day-ci/archive/20250619/202506190552.TqNasrC3-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250619/202506190552.TqNasrC3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506190552.TqNasrC3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/platform/ce4100/ce4100.c:107:16: error: incompatible function pointer types assigning to 'u32 (*)(struct uart_port *, unsigned int)' (aka 'unsigned int (*)(struct uart_port *, unsigned int)') from 'unsigned int (struct uart_port *, int)' [-Wincompatible-function-pointer-types]
     107 |         up->serial_in = ce4100_mem_serial_in;
         |                       ^ ~~~~~~~~~~~~~~~~~~~~
>> arch/x86/platform/ce4100/ce4100.c:108:17: error: incompatible function pointer types assigning to 'void (*)(struct uart_port *, unsigned int, u32)' (aka 'void (*)(struct uart_port *, unsigned int, unsigned int)') from 'void (struct uart_port *, int, int)' [-Wincompatible-function-pointer-types]
     108 |         up->serial_out = ce4100_mem_serial_out;
         |                        ^ ~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +107 arch/x86/platform/ce4100/ce4100.c

5ec6960f6f0c7b Dirk Brandewie 2010-11-22   81  
5ec6960f6f0c7b Dirk Brandewie 2010-11-22   82  static void ce4100_serial_fixup(int port, struct uart_port *up,
a97673a1c43d00 Ingo Molnar    2018-12-03   83  	u32 *capabilities)
5ec6960f6f0c7b Dirk Brandewie 2010-11-22   84  {
5ec6960f6f0c7b Dirk Brandewie 2010-11-22   85  #ifdef CONFIG_EARLY_PRINTK
5ec6960f6f0c7b Dirk Brandewie 2010-11-22   86  	/*
5ec6960f6f0c7b Dirk Brandewie 2010-11-22   87  	 * Over ride the legacy port configuration that comes from
5ec6960f6f0c7b Dirk Brandewie 2010-11-22   88  	 * asm/serial.h. Using the ioport driver then switching to the
5ec6960f6f0c7b Dirk Brandewie 2010-11-22   89  	 * PCI memmaped driver hangs the IOAPIC
5ec6960f6f0c7b Dirk Brandewie 2010-11-22   90  	 */
5ec6960f6f0c7b Dirk Brandewie 2010-11-22   91  	if (up->iotype !=  UPIO_MEM32) {
5ec6960f6f0c7b Dirk Brandewie 2010-11-22   92  		up->uartclk  = 14745600;
5ec6960f6f0c7b Dirk Brandewie 2010-11-22   93  		up->mapbase = 0xdffe0200;
5ec6960f6f0c7b Dirk Brandewie 2010-11-22   94  		set_fixmap_nocache(FIX_EARLYCON_MEM_BASE,
5ec6960f6f0c7b Dirk Brandewie 2010-11-22   95  				up->mapbase & PAGE_MASK);
5ec6960f6f0c7b Dirk Brandewie 2010-11-22   96  		up->membase =
5ec6960f6f0c7b Dirk Brandewie 2010-11-22   97  			(void __iomem *)__fix_to_virt(FIX_EARLYCON_MEM_BASE);
5ec6960f6f0c7b Dirk Brandewie 2010-11-22   98  		up->membase += up->mapbase & ~PAGE_MASK;
08ec212c0f92cb Maxime Bizon   2012-10-19   99  		up->mapbase += port * 0x100;
08ec212c0f92cb Maxime Bizon   2012-10-19  100  		up->membase += port * 0x100;
5ec6960f6f0c7b Dirk Brandewie 2010-11-22  101  		up->iotype   = UPIO_MEM32;
5ec6960f6f0c7b Dirk Brandewie 2010-11-22  102  		up->regshift = 2;
08ec212c0f92cb Maxime Bizon   2012-10-19  103  		up->irq = 4;
5ec6960f6f0c7b Dirk Brandewie 2010-11-22  104  	}
5ec6960f6f0c7b Dirk Brandewie 2010-11-22  105  #endif
5ec6960f6f0c7b Dirk Brandewie 2010-11-22  106  	up->iobase = 0;
5ec6960f6f0c7b Dirk Brandewie 2010-11-22 @107  	up->serial_in = ce4100_mem_serial_in;
5ec6960f6f0c7b Dirk Brandewie 2010-11-22 @108  	up->serial_out = ce4100_mem_serial_out;
5ec6960f6f0c7b Dirk Brandewie 2010-11-22  109  
a97673a1c43d00 Ingo Molnar    2018-12-03  110  	*capabilities |= (1 << 12);
5ec6960f6f0c7b Dirk Brandewie 2010-11-22  111  }
5ec6960f6f0c7b Dirk Brandewie 2010-11-22  112  

:::::: The code at line 107 was first introduced by commit
:::::: 5ec6960f6f0c7be9cc6e5506fdf0070add3b6e08 ce4100: Add errata fixes for UART on CE4100

:::::: TO: Dirk Brandewie <dirk.brandewie@gmail.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
