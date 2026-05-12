Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ED33A6F08
	for <linux-serial@vger.kernel.org>; Tue, 12 May 2026 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583579; cv=none; b=mPJqCaAMVy8d+W9YZCcuPsPUhwuNXwWIZnGSDVX1qqEr/GEZRPWdMD43Tmk1iaZrrCz6qKQq6E2F6kmNgfIjiHGXUp1JHT1wHTUpYfDz3rllOA7Qb7Xci3zqB2RK0zfKSvJEj+hEXHwvDV/7eITRp+duOzfWZm9qDJMCv+D3eDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583579; c=relaxed/simple;
	bh=8qR93Org775h7ioY+6uQva9HQiZ3wEkg6xOkjULi3Jg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SdpDZhD5LxmLriDovrGsVd68DCO9aDNiYkMShxwBtm1rWHjDvAfV8hd5HE8QxhToN4yWV+S2XOhM4vBA/Mp1+P5MkX3zQQVGmGWBES26eKI6VhuWcA5gKOqmLi8SjsK7XjAIeGEcQFDEFZEfVnb3eM0TJfx+2KAHZlkyB1/6eAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJSFXJ7K; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJSFXJ7K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778583577; x=1810119577;
  h=date:from:to:cc:subject:message-id;
  bh=8qR93Org775h7ioY+6uQva9HQiZ3wEkg6xOkjULi3Jg=;
  b=IJSFXJ7KStlLEZ+pyK61LYIyBSMWFNFOo1bM5sotXoEXByCtX5+ds/Zq
   fgzIN2eG3lKhegMyiq5J6GV8iGMxAYVNPT4BFUxTPzqmrkRcv/4s6cSOO
   pW3vmEuOaF1PJpK2uFadqTQsIXjxUTyFhSVdcxpDMyk/vHCMYrHSOHpzu
   7kdK49x5xfq/eY7TtOs5ztGTShfXg/RsPKFKIbddzdS9B5ARtqMGmG0y6
   tKM7As0R2pTfNDvaqRffo+jk6/ZMaK3RaXaX5RtK6hCismjJyh8LPUmhd
   AQoRNz6vXnjVR6Wjsg7jvhBcEFPXbtXYb3ULqClI86+4am++R2OFMiXG5
   A==;
X-CSE-ConnectionGUID: f2XXUA0YS6SxWp7XG7PG1A==
X-CSE-MsgGUID: +ZrLu9qzSrafYRFPnkjQKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90871688"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="90871688"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 03:59:36 -0700
X-CSE-ConnectionGUID: TbE87D6UQHWkSRKg2kZAWA==
X-CSE-MsgGUID: cHDq0IE4TbGVPbWqBumfQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="237675385"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 12 May 2026 03:59:35 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMkpo-00000000210-0sti;
	Tue, 12 May 2026 10:59:32 +0000
Date: Tue, 12 May 2026 18:59:17 +0800
From: kernel test robot <lkp@intel.com>
To: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: [tty:tty-next 28/31] drivers/tty/serial/max310x.c:1727:32:
 error: 'max310x_spi_driver' undeclared; did you mean 'max310x_i2c_driver'?
Message-ID: <202605121847.N9DVLNg2-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Hi Hugo,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   16e95bfb79b5d9d01dc7651d98caf3c2ace331cd
commit: 20ffe4b3330a8bde9e933e9ba2323d5e9386caa5 [28/31] serial: max310x: allow driver to be built with SPI or I2C
config: um-randconfig-r112-20260512 (https://download.01.org/0day-ci/archive/20260512/202605121847.N9DVLNg2-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260512/202605121847.N9DVLNg2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605121847.N9DVLNg2-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/tty/serial/max310x.c: In function 'max310x_uart_init':
>> drivers/tty/serial/max310x.c:1727:32: error: 'max310x_spi_driver' undeclared (first use in this function); did you mean 'max310x_i2c_driver'?
    1727 |         spi_unregister_driver(&max310x_spi_driver);
         |                                ^~~~~~~~~~~~~~~~~~
         |                                max310x_i2c_driver
   drivers/tty/serial/max310x.c:1727:32: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/tty/serial/max310x.c:1730:1: warning: label 'err_spi_register' defined but not used [-Wunused-label]
    1730 | err_spi_register:
         | ^~~~~~~~~~~~~~~~
   drivers/tty/serial/max310x.c: At top level:
>> drivers/tty/serial/max310x.c:1492:29: warning: 'regcfg' defined but not used [-Wunused-variable]
    1492 | static struct regmap_config regcfg = {
         |                             ^~~~~~


vim +1727 drivers/tty/serial/max310x.c

6286767ad3afc88 Alexander Shiyan 2016-06-07  1722  
2e1f2d9a9bdbe12 Cosmin Tanislav  2022-06-05  1723  	return 0;
2e1f2d9a9bdbe12 Cosmin Tanislav  2022-06-05  1724  
2e1f2d9a9bdbe12 Cosmin Tanislav  2022-06-05  1725  #ifdef CONFIG_I2C
2e1f2d9a9bdbe12 Cosmin Tanislav  2022-06-05  1726  err_i2c_register:
2e1f2d9a9bdbe12 Cosmin Tanislav  2022-06-05 @1727  	spi_unregister_driver(&max310x_spi_driver);
2e1f2d9a9bdbe12 Cosmin Tanislav  2022-06-05  1728  #endif
2e1f2d9a9bdbe12 Cosmin Tanislav  2022-06-05  1729  
2e1f2d9a9bdbe12 Cosmin Tanislav  2022-06-05 @1730  err_spi_register:
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
