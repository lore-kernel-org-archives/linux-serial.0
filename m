Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23703955C7
	for <linux-serial@vger.kernel.org>; Thu, 14 May 2026 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778802682; cv=none; b=Nz6fXJ2vsEWSF7hHzNvk2WR4y6SnVdS3qylDwj73SrzPYDki/mSjoZIshxvF3rTY0SYOV3CwvslKFRnWYE6uBnOylu9pyCZ5LMROMBqCPRHTtgLUl48QQ4K8KT/ik/cHE+DEP3TDPuZS8KM5W1gu+sVW2/adUa7iehuWlovW6ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778802682; c=relaxed/simple;
	bh=PPzeeIquWOLMq6XI4OwiFCTqE6KhnEHdebWcIptDoeo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=B7sJqGeriCgUX5i3p/W99AxYqksdT/K5JhXdwA2oQAeDCks3qPqGqSxhNZvq2b5Pbw2mFv+eD1qXl4RxV4nW/iy12Md2hU394TNm/qRisXj+2Qikn0i2Rlh8GR0vU3g28uc4UswpbXQXEaN/U4OaDbkbxjUQl56JuC47UWAV6j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VrHf7e8B; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VrHf7e8B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778802680; x=1810338680;
  h=date:from:to:cc:subject:message-id;
  bh=PPzeeIquWOLMq6XI4OwiFCTqE6KhnEHdebWcIptDoeo=;
  b=VrHf7e8Byv49esoBaLw6KzwNGE5sZCcjs35mme/LGAE4TsMJIzobVwmX
   rUeWtZbcMuAOGFVFteTXGpSBdW+ofsw4Vu6zlMFVXAPyCyZ1QpA7lZVVs
   x5yjmojsgQGnE9MgXosTkoxcb1UfAC3YnYFflYlcO4K4ZH5VtWZTnzcPX
   LDSnasq0zebwuQFjBZltjNAT5auHs+tei4lPdCbujIRZKJy6/hh76ohth
   n/+3Blvz1at7e/Fg78QcLdibdHhSv4ShAtPC3z9pcOz9SqBy3XIlpk0s5
   q8arn+jrdGLxL2D0ma0ZaD6JOQCnvMHW3swdYOCls555VgPygPZ5SVQTK
   w==;
X-CSE-ConnectionGUID: H4E9FBqGRBqmFy/VHmgnJg==
X-CSE-MsgGUID: RbH+yGB0SC2Pd9ke3m4YnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="90450233"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="90450233"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 16:51:20 -0700
X-CSE-ConnectionGUID: BL2YzbmWRkiyjZBtx28VZw==
X-CSE-MsgGUID: pUmpFWMEQIeBFoGyXwOrNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="262056734"
Received: from lkp-server02.sh.intel.com (HELO 7a33ad3e7d27) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 14 May 2026 16:51:18 -0700
Received: from kbuild by 7a33ad3e7d27 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNfpk-000000000N6-1hHM;
	Thu, 14 May 2026 23:51:16 +0000
Date: Fri, 15 May 2026 07:35:15 +0800
From: kernel test robot <lkp@intel.com>
To: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: [tty:tty-next 28/31] drivers/tty/serial/max310x.c:1730:1:
 warning: unused label 'err_spi_register'
Message-ID: <202605150707.I4LYaT6N-lkp@intel.com>
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
config: i386-randconfig-r121-20260515 (https://download.01.org/0day-ci/archive/20260515/202605150707.I4LYaT6N-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260515/202605150707.I4LYaT6N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605150707.I4LYaT6N-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/max310x.c:1730:1: warning: unused label 'err_spi_register' [-Wunused-label]
    1730 | err_spi_register:
         | ^~~~~~~~~~~~~~~~~
   drivers/tty/serial/max310x.c:1280:12: warning: unused function 'max310x_probe' [-Wunused-function]
    1280 | static int max310x_probe(struct device *dev, const struct max310x_devtype *devtype,
         |            ^~~~~~~~~~~~~
   drivers/tty/serial/max310x.c:1464:13: warning: unused function 'max310x_remove' [-Wunused-function]
    1464 | static void max310x_remove(struct device *dev)
         |             ^~~~~~~~~~~~~~
>> drivers/tty/serial/max310x.c:1492:29: warning: unused variable 'regcfg' [-Wunused-variable]
    1492 | static struct regmap_config regcfg = {
         |                             ^~~~~~
   drivers/tty/serial/max310x.c:1507:20: warning: unused function 'max310x_regmap_name' [-Wunused-function]
    1507 | static const char *max310x_regmap_name(u8 port_id)
         |                    ^~~~~~~~~~~~~~~~~~~
   5 warnings generated.


vim +/err_spi_register +1730 drivers/tty/serial/max310x.c

2e1f2d9a9bdbe12 Cosmin Tanislav  2022-06-05  1729  
2e1f2d9a9bdbe12 Cosmin Tanislav  2022-06-05 @1730  err_spi_register:
2e1f2d9a9bdbe12 Cosmin Tanislav  2022-06-05  1731  	uart_unregister_driver(&max310x_uart);
2e1f2d9a9bdbe12 Cosmin Tanislav  2022-06-05  1732  
51f689cc1133394 Kangjie Lu       2018-12-25  1733  	return ret;
6286767ad3afc88 Alexander Shiyan 2016-06-07  1734  }
6286767ad3afc88 Alexander Shiyan 2016-06-07  1735  module_init(max310x_uart_init);
6286767ad3afc88 Alexander Shiyan 2016-06-07  1736  

:::::: The code at line 1730 was first introduced by commit
:::::: 2e1f2d9a9bdbe12ee475c82a45ac46a278e8049a serial: max310x: implement I2C support

:::::: TO: Cosmin Tanislav <cosmin.tanislav@analog.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
