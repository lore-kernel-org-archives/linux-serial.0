Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D29349CD5
	for <linux-serial@vger.kernel.org>; Tue, 12 May 2026 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778586800; cv=none; b=od8DRUZdGkzr8rI3HrLbOfH6Mw9uDv4LRImlUra//nqocDY0yuLb+d+5waatIs2Q4zp50oBWJtay9lZxbd6YLLYlpoRwXKDK9Nmjngr4qaeh8Mkn0Onf7zH8iUa7EBh7Zw8nA8pABBi6q8GbIHeRAQG+pYcX//9NfnOc6EJnsMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778586800; c=relaxed/simple;
	bh=Ae0kvDEEdkoRInjRNHCCFi9CDJrwpt+SeKm9WveINIQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bkx3vYL2JAWcqCw+qBXZZxOGA5fhTo6HDn8EuIqabaQBObAMoQo0+E8vzaLrDrHArXN9qLTsV16Q2LYjV2HZa9MlLx3pTq3gvbM2zCpjGg5PkCIFYyhbUyfQPNf3K1hiAreMmGdtzcgWP6xhN0ezBEpVSA1hdqdRC+BVLMKJ/rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lc+9HEYQ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lc+9HEYQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778586797; x=1810122797;
  h=date:from:to:cc:subject:message-id;
  bh=Ae0kvDEEdkoRInjRNHCCFi9CDJrwpt+SeKm9WveINIQ=;
  b=Lc+9HEYQmp1oDwXYCqIqslOHOxcO8WAwVDD2TYTBkXRyE6XUFUzGIBlo
   gLurqlDvuy3LP82qzKZX9Ts6N66MUOMm/Tn8qk2VJjGHYOAHgTNEluvJl
   TM3MK5ICEy9u2L6U2iWGkp7KmOYdcLFJSlUv99leHADCbZSYiQq6T1KQ5
   dGIqIa1ugxkJnpqkD78UVJuoupgMjAaufFALVZdpyj9FHOTHMphRB4lz5
   zu7crJvWpqDlGuFAsmjn7lcfEI2Jy/Zbj3UKuwIXfZzwWcpAp8e2JkxnT
   EoU7fgKCcyfJ8eY0zc0SJ6EwFnRXLO3l8S+Cyzp5cOOXDMwQSoB5CS68f
   g==;
X-CSE-ConnectionGUID: xG+1UIjnSnOmhAzTnqbtSg==
X-CSE-MsgGUID: fWic5nEpSaaPJrejmJ3kTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79603175"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79603175"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 04:53:16 -0700
X-CSE-ConnectionGUID: xKH5qLOIRn2/pXK579cwzw==
X-CSE-MsgGUID: nU/i4E/wQJCk/rN7rQrK5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="242742608"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 12 May 2026 04:53:15 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMlfj-00000000255-2Sye;
	Tue, 12 May 2026 11:53:11 +0000
Date: Tue, 12 May 2026 19:52:54 +0800
From: kernel test robot <lkp@intel.com>
To: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: [tty:tty-next 28/31] drivers/tty/serial/max310x.c:1727:25:
 error: use of undeclared identifier 'max310x_spi_driver'; did you mean
 'max310x_i2c_driver'?
Message-ID: <202605121900.SP8ZoaTw-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   16e95bfb79b5d9d01dc7651d98caf3c2ace331cd
commit: 20ffe4b3330a8bde9e933e9ba2323d5e9386caa5 [28/31] serial: max310x: allow driver to be built with SPI or I2C
config: sparc64-randconfig-r122-20260512 (https://download.01.org/0day-ci/archive/20260512/202605121900.SP8ZoaTw-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260512/202605121900.SP8ZoaTw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605121900.SP8ZoaTw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/tty/serial/max310x.c:1727:25: error: use of undeclared identifier 'max310x_spi_driver'; did you mean 'max310x_i2c_driver'?
    1727 |         spi_unregister_driver(&max310x_spi_driver);
         |                                ^~~~~~~~~~~~~~~~~~
         |                                max310x_i2c_driver
   drivers/tty/serial/max310x.c:1689:26: note: 'max310x_i2c_driver' declared here
    1689 | static struct i2c_driver max310x_i2c_driver = {
         |                          ^
>> drivers/tty/serial/max310x.c:1727:24: error: incompatible pointer types passing 'struct i2c_driver *' to parameter of type 'struct spi_driver *' [-Wincompatible-pointer-types]
    1727 |         spi_unregister_driver(&max310x_spi_driver);
         |                               ^~~~~~~~~~~~~~~~~~~
   include/linux/spi/spi.h:378:61: note: passing argument to parameter 'sdrv' here
     378 | static inline void spi_unregister_driver(struct spi_driver *sdrv)
         |                                                             ^
   2 errors generated.


vim +1727 drivers/tty/serial/max310x.c

6286767ad3afc88 Alexander Shiyan 2016-06-07  1722  
2e1f2d9a9bdbe12 Cosmin Tanislav  2022-06-05  1723  	return 0;
2e1f2d9a9bdbe12 Cosmin Tanislav  2022-06-05  1724  
2e1f2d9a9bdbe12 Cosmin Tanislav  2022-06-05  1725  #ifdef CONFIG_I2C
2e1f2d9a9bdbe12 Cosmin Tanislav  2022-06-05  1726  err_i2c_register:
2e1f2d9a9bdbe12 Cosmin Tanislav  2022-06-05 @1727  	spi_unregister_driver(&max310x_spi_driver);
2e1f2d9a9bdbe12 Cosmin Tanislav  2022-06-05  1728  #endif
2e1f2d9a9bdbe12 Cosmin Tanislav  2022-06-05  1729  
2e1f2d9a9bdbe12 Cosmin Tanislav  2022-06-05  1730  err_spi_register:
2e1f2d9a9bdbe12 Cosmin Tanislav  2022-06-05  1731  	uart_unregister_driver(&max310x_uart);
2e1f2d9a9bdbe12 Cosmin Tanislav  2022-06-05  1732  
51f689cc1133394 Kangjie Lu       2018-12-25  1733  	return ret;
6286767ad3afc88 Alexander Shiyan 2016-06-07  1734  }
6286767ad3afc88 Alexander Shiyan 2016-06-07  1735  module_init(max310x_uart_init);
6286767ad3afc88 Alexander Shiyan 2016-06-07  1736  

:::::: The code at line 1727 was first introduced by commit
:::::: 2e1f2d9a9bdbe12ee475c82a45ac46a278e8049a serial: max310x: implement I2C support

:::::: TO: Cosmin Tanislav <cosmin.tanislav@analog.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
