Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA6130A54
	for <linux-serial@vger.kernel.org>; Wed,  4 Dec 2024 03:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733282552; cv=none; b=GxMbzgSxgVUBEdgJB3GnqpnIBt7/t9VBttNDgd5BCQ4STZG5UyqOS0+ExN4RuEr9iaKPzxlt5dMVdtflplE9wCakkfK4Tkvo0aoYQ2PyKT1kR2DwltDGSx/Hsb60IhyYR/PQwTD/h573nV2fAvMv4Y2599rbkByfC6icGJ4jpiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733282552; c=relaxed/simple;
	bh=5jYL/DynhOVjlE1nyjOigt53mDCtluRuOoDHlhr7lbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmb8VrE/292LsOwtuYARngLfA2K6yBMnjGelDk31iZPxYBdZJyr+4a2d6ck6JiDaNxyvEMy2BwvEjxvlBqDhxJ7DdCLMj+FZCwLOX9G5/t+3TbY8YZ4cUzZ1sp9xeoihv8P0Ilgue81+iG/6NSJQFAvDSxgea5xvsdlowlfbg3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQ6NhaXj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQ6NhaXj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733282541; x=1764818541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5jYL/DynhOVjlE1nyjOigt53mDCtluRuOoDHlhr7lbY=;
  b=JQ6NhaXjjq+rCnLng0fZ1dA0P/NGYA9K3X1zbrQYX3nN0lMmdkWEZRgl
   FE+lXyH8tn9WCIJ4RYJqbiiwqGjLWm4v4GyV7+dGP4h+zjO2goSGAUiTP
   N8W2P8sdWzYA9rpnQrovyPaSowSQCugqM8Sjpo8VizyxaLn6TLAVY79Ah
   1RXjH2K6dTy3aXIzBtEtoteSneRX4llV2I8GdZ8oVtcpcqDINkMVp3i+3
   71V0NXEdAdaprMvp3WLhm/7o09ukX3banvBGJYuA/wku1dnrsEUBVOEFO
   846JW+YAWqdwQtmba+0ljhKJYFafeHWO0be3KetK3H7kbAgmMXbfl5W5m
   g==;
X-CSE-ConnectionGUID: fZCPsUcmRMKRVJNtqsRmJA==
X-CSE-MsgGUID: b3sng0SPRMiOS4VB/F6rWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="44559543"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="44559543"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 19:22:20 -0800
X-CSE-ConnectionGUID: gg368xs+TyGga3A2WzCx/A==
X-CSE-MsgGUID: I8ONrGhRSPOahWk/Yk52kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98649322"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 03 Dec 2024 19:22:17 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIfxv-0001n7-0T;
	Wed, 04 Dec 2024 03:22:15 +0000
Date: Wed, 4 Dec 2024 11:21:42 +0800
From: kernel test robot <lkp@intel.com>
To: Tobias Klauser <tklauser@distanz.ch>, linux-serial@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2] serial: altera_jtaguart: Use KBUILD_MODNAME
Message-ID: <202412041159.YryCdguf-lkp@intel.com>
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
config: i386-buildonly-randconfig-005-20241204 (https://download.01.org/0day-ci/archive/20241204/202412041159.YryCdguf-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412041159.YryCdguf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412041159.YryCdguf-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/tty/serial/altera_jtaguart.c: In function 'altera_jtaguart_startup':
>> drivers/tty/serial/altera_jtaguart.c:174:25: error: 'DRV_NAME' undeclared (first use in this function)
     174 |                         DRV_NAME, port);
         |                         ^~~~~~~~
   drivers/tty/serial/altera_jtaguart.c:174:25: note: each undeclared identifier is reported only once for each function it appears in


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
