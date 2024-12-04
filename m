Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511DB7DA62
	for <linux-serial@vger.kernel.org>; Wed,  4 Dec 2024 03:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733284440; cv=none; b=kCHu9Fr+VtLEQO9ZPAe6eFkl1nGFp1VQ2peGs/muPeqIBaepCKJt+p3heJyQBsn+ci6vBt69gHyZLr9Hb5H0iZV1uvIeJ4BBEFQcHzQknfKTzCMcHm1d6MlOpiHce+tw7rQMpEo75tgchWw2RZPd37zhRBKKP/Y367l5m8+02l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733284440; c=relaxed/simple;
	bh=31FUpc8bW300BJ83AFyeys8k4DCR2Qf+Gt1CDF1VorQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWskNk3b22tg87gXo0jOMPJiehm0jJC1k53dOxWoN1DvqP0e79OQ3eCc1mf+wvUKhG2KoKgtwdd4PstnbT4k+f4bdONyfuug7I11BLgBy9WdJljxFghKq4xUPrc5dpz2zrEMVS78MPwknf/0tTJ6Ob3ypMBbKpudFSLilOkFTK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yc0RICcW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yc0RICcW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733284438; x=1764820438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=31FUpc8bW300BJ83AFyeys8k4DCR2Qf+Gt1CDF1VorQ=;
  b=Yc0RICcWapmzXM+F4of0nfDD5cPQ1LZbJJLXrmFW7hoSRq9IcFF3xQtr
   1fvrbq6RH37V1EArE8EtTpTMkas59UpxtiBjABzQtxljf9bW+19Sw3dfx
   MSeX/13hnPVd9VrjM1vGyaTAJX5NjkJxNPxPBxinoHRRbEkv/R67Rubdm
   IKR50oYx8WUmqKScNjMe1a3GnC+r6EUN/p/GDQkSWRWjW5e1dxjIiaOVw
   0diCB3/HxobcO1WrJmPVZbIGuACUM8C8SyUnlxE4esPlFDDwVFRRcDqjS
   qa88cJZPoey+9DSHXCbbbu1OKX2/eJvBcQ/X2W6H+z3hyebH+wQfApcnD
   Q==;
X-CSE-ConnectionGUID: WeBbxP+tSZadJnvx4cHOxA==
X-CSE-MsgGUID: 6zEOCxrDQYyTIXb3Bb+37A==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="44010558"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="44010558"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 19:53:58 -0800
X-CSE-ConnectionGUID: z9IJUEsKQnCPvrSzZSqozg==
X-CSE-MsgGUID: NenBQDsHTiG7sU0SzrJGcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="131096108"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 03 Dec 2024 19:53:57 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIgSX-0002Sr-2T;
	Wed, 04 Dec 2024 03:53:53 +0000
Date: Wed, 4 Dec 2024 11:53:05 +0800
From: kernel test robot <lkp@intel.com>
To: Tobias Klauser <tklauser@distanz.ch>, linux-serial@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2] serial: altera_jtaguart: Use KBUILD_MODNAME
Message-ID: <202412041125.xMeUiURB-lkp@intel.com>
References: <20241203131727.9078-1-tklauser@distanz.ch>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203131727.9078-1-tklauser@distanz.ch>

Hi Tobias,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.13-rc1 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tobias-Klauser/serial-altera_jtaguart-Use-KBUILD_MODNAME/20241203-211936
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20241203131727.9078-1-tklauser%40distanz.ch
patch subject: [PATCH v2] serial: altera_jtaguart: Use KBUILD_MODNAME
config: i386-buildonly-randconfig-002-20241204 (https://download.01.org/0day-ci/archive/20241204/202412041125.xMeUiURB-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412041125.xMeUiURB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412041125.xMeUiURB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/tty/serial/altera_jtaguart.c:174:4: error: use of undeclared identifier 'DRV_NAME'
     174 |                         DRV_NAME, port);
         |                         ^
   1 error generated.


vim +/DRV_NAME +174 drivers/tty/serial/altera_jtaguart.c

5bcd601049c6b2a drivers/serial/altera_jtaguart.c     Tobias Klauser    2010-05-05  167  
5bcd601049c6b2a drivers/serial/altera_jtaguart.c     Tobias Klauser    2010-05-05  168  static int altera_jtaguart_startup(struct uart_port *port)
5bcd601049c6b2a drivers/serial/altera_jtaguart.c     Tobias Klauser    2010-05-05  169  {
5bcd601049c6b2a drivers/serial/altera_jtaguart.c     Tobias Klauser    2010-05-05  170  	unsigned long flags;
5bcd601049c6b2a drivers/serial/altera_jtaguart.c     Tobias Klauser    2010-05-05  171  	int ret;
5bcd601049c6b2a drivers/serial/altera_jtaguart.c     Tobias Klauser    2010-05-05  172  
9cfb5c05fee914c drivers/tty/serial/altera_jtaguart.c Yong Zhang        2011-09-22  173  	ret = request_irq(port->irq, altera_jtaguart_interrupt, 0,
5bcd601049c6b2a drivers/serial/altera_jtaguart.c     Tobias Klauser    2010-05-05 @174  			DRV_NAME, port);
5bcd601049c6b2a drivers/serial/altera_jtaguart.c     Tobias Klauser    2010-05-05  175  	if (ret) {
3f356922d4cb9c7 drivers/tty/serial/altera_jtaguart.c Tobias Klauser    2024-11-13  176  		dev_err(port->dev, "unable to attach Altera JTAG UART %d interrupt vector=%d\n",
3f356922d4cb9c7 drivers/tty/serial/altera_jtaguart.c Tobias Klauser    2024-11-13  177  			port->line, port->irq);
5bcd601049c6b2a drivers/serial/altera_jtaguart.c     Tobias Klauser    2010-05-05  178  		return ret;
5bcd601049c6b2a drivers/serial/altera_jtaguart.c     Tobias Klauser    2010-05-05  179  	}
5bcd601049c6b2a drivers/serial/altera_jtaguart.c     Tobias Klauser    2010-05-05  180  
adcdb2c7f0b59a7 drivers/tty/serial/altera_jtaguart.c Thomas Gleixner   2023-09-14  181  	uart_port_lock_irqsave(port, &flags);
5bcd601049c6b2a drivers/serial/altera_jtaguart.c     Tobias Klauser    2010-05-05  182  
5bcd601049c6b2a drivers/serial/altera_jtaguart.c     Tobias Klauser    2010-05-05  183  	/* Enable RX interrupts now */
4e2b16a62d9975c drivers/tty/serial/altera_jtaguart.c Jiri Slaby (SUSE  2022-11-15  184) 	port->read_status_mask = ALTERA_JTAGUART_CONTROL_RE_MSK;
4e2b16a62d9975c drivers/tty/serial/altera_jtaguart.c Jiri Slaby (SUSE  2022-11-15  185) 	writel(port->read_status_mask,
4e2b16a62d9975c drivers/tty/serial/altera_jtaguart.c Jiri Slaby (SUSE  2022-11-15  186) 			port->membase + ALTERA_JTAGUART_CONTROL_REG);
5bcd601049c6b2a drivers/serial/altera_jtaguart.c     Tobias Klauser    2010-05-05  187  
adcdb2c7f0b59a7 drivers/tty/serial/altera_jtaguart.c Thomas Gleixner   2023-09-14  188  	uart_port_unlock_irqrestore(port, flags);
5bcd601049c6b2a drivers/serial/altera_jtaguart.c     Tobias Klauser    2010-05-05  189  
5bcd601049c6b2a drivers/serial/altera_jtaguart.c     Tobias Klauser    2010-05-05  190  	return 0;
5bcd601049c6b2a drivers/serial/altera_jtaguart.c     Tobias Klauser    2010-05-05  191  }
5bcd601049c6b2a drivers/serial/altera_jtaguart.c     Tobias Klauser    2010-05-05  192  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
