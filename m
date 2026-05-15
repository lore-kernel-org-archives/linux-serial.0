Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF0F3D300A;
	Fri, 15 May 2026 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778839756; cv=none; b=EkfUc2qLNLWTpe58XPIWOx43HfjizIcrrlNUiQSHwyoESmEZZsGFpeHKIvDLU2Wxw3y94/52yNueHj29Sc5vxCUTqAaLYgvv7Zv0nmgt4KmlbDONif4m6Itm5Vg/Hk77vKmF2mVytZoKgcBtJp90HXVK9qxy/bWnBalSTLBAAos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778839756; c=relaxed/simple;
	bh=i6YFF1i3pMGju9ciPXiva6Il9wQ3uoNXpWZF28Ki2+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myJKDZIfZxomW4+qaZB4d6wqcWCBhKJ8WuuezKdUZmA1lYZ4JMs9CMVSRwcC9xV3xq7SnVwAYuVofKtW0a5NW2pq3GXWFXyBabVnxM2ii9UXI22ZTk6Y+hpe6bBmsQuPT37tkhpd5VJL8M6zCwcmy8OL6Mg7WO2vzNvp1cvS6HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QHmmwWxv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QHmmwWxv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778839754; x=1810375754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=i6YFF1i3pMGju9ciPXiva6Il9wQ3uoNXpWZF28Ki2+Y=;
  b=QHmmwWxvvyaUUr7WVr5uQ8KWDdBUfB0Pu4UxA5wSOazBtEZygS9Yqfp2
   oSNq6p4Jz2L0/4B99lP0aVrx2VpVJoA9jWPe/J8lGqExYP5hXFcc/3Mm1
   o6hTokqHDdCNB4GFiX76/q03f3KV4RgvyqRi0Eg9H39U3+MMDuRSYI2xg
   QMDTc8ncoXEZIyUyxme+RPLCoKhatdZK+mxMUWMtkBIPX0HEnJ0mgxjbU
   P6UxVOzlk2CtHd0kPzNGLAOzTrM6isBAA1/Lt91x1tyCnvmvwU86y6B87
   4s/9ncvSmp7GOfJSLxcerAr+qh2tW1MWZfkRKs3b/jY+e92z66rzyPWKl
   w==;
X-CSE-ConnectionGUID: 9HqIzxLWQ7a6tqH9NrcKiQ==
X-CSE-MsgGUID: QwY7vmlSRTyN/rgTbRMFXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="83408530"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="83408530"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 03:09:14 -0700
X-CSE-ConnectionGUID: C0SvFc0USAaAUHzX0vh+6g==
X-CSE-MsgGUID: 6P7Dvx8vQmq1oSZitC6THQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="238536691"
Received: from lkp-server02.sh.intel.com (HELO 7a33ad3e7d27) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 15 May 2026 03:09:12 -0700
Received: from kbuild by 7a33ad3e7d27 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNpT1-000000001Jr-2EAO;
	Fri, 15 May 2026 10:08:39 +0000
Date: Fri, 15 May 2026 18:05:29 +0800
From: kernel test robot <lkp@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: oe-kbuild-all@lists.linux.dev, hugo@hugovil.com,
	linux-serial@vger.kernel.org, kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: max310x: fix compile errors if CONFIG_SPI_MASTER
 is disabled
Message-ID: <202605151854.fLunCPPN-lkp@intel.com>
References: <20260512152749.1767622-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512152749.1767622-1-hugo@hugovil.com>

Hi Hugo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 16e95bfb79b5d9d01dc7651d98caf3c2ace331cd]

url:    https://github.com/intel-lab-lkp/linux/commits/Hugo-Villeneuve/serial-max310x-fix-compile-errors-if-CONFIG_SPI_MASTER-is-disabled/20260515-014130
base:   16e95bfb79b5d9d01dc7651d98caf3c2ace331cd
patch link:    https://lore.kernel.org/r/20260512152749.1767622-1-hugo%40hugovil.com
patch subject: [PATCH] serial: max310x: fix compile errors if CONFIG_SPI_MASTER is disabled
config: alpha-randconfig-r063-20260515 (https://download.01.org/0day-ci/archive/20260515/202605151854.fLunCPPN-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260515/202605151854.fLunCPPN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605151854.fLunCPPN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/tty/serial/max310x.c:1510:20: warning: 'max310x_regmap_name' defined but not used [-Wunused-function]
    1510 | static const char *max310x_regmap_name(u8 port_id)
         |                    ^~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/max310x.c:1482:13: warning: 'max310x_remove' defined but not used [-Wunused-function]
    1482 | static void max310x_remove(struct device *dev)
         |             ^~~~~~~~~~~~~~
   drivers/tty/serial/max310x.c:1298:12: warning: 'max310x_probe' defined but not used [-Wunused-function]
    1298 | static int max310x_probe(struct device *dev, const struct max310x_devtype *devtype,
         |            ^~~~~~~~~~~~~
>> drivers/tty/serial/max310x.c:515:13: warning: 'max310x_reg_noinc' defined but not used [-Wunused-function]
     515 | static bool max310x_reg_noinc(struct device *dev, unsigned int reg)
         |             ^~~~~~~~~~~~~~~~~
>> drivers/tty/serial/max310x.c:502:13: warning: 'max310x_reg_precious' defined but not used [-Wunused-function]
     502 | static bool max310x_reg_precious(struct device *dev, unsigned int reg)
         |             ^~~~~~~~~~~~~~~~~~~~
>> drivers/tty/serial/max310x.c:482:13: warning: 'max310x_reg_volatile' defined but not used [-Wunused-function]
     482 | static bool max310x_reg_volatile(struct device *dev, unsigned int reg)
         |             ^~~~~~~~~~~~~~~~~~~~
>> drivers/tty/serial/max310x.c:467:13: warning: 'max310x_reg_writeable' defined but not used [-Wunused-function]
     467 | static bool max310x_reg_writeable(struct device *dev, unsigned int reg)
         |             ^~~~~~~~~~~~~~~~~~~~~


vim +/max310x_reg_noinc +515 drivers/tty/serial/max310x.c

003236d9ac4d027 Alexander Shiyan 2013-06-29  466  
10d8b34a421716d Alexander Shiyan 2013-06-29 @467  static bool max310x_reg_writeable(struct device *dev, unsigned int reg)
f65444187a66bf5 Alexander Shiyan 2012-08-06  468  {
6ef281daf020592 Cosmin Tanislav  2022-06-05  469  	switch (reg) {
f65444187a66bf5 Alexander Shiyan 2012-08-06  470  	case MAX310X_IRQSTS_REG:
f65444187a66bf5 Alexander Shiyan 2012-08-06  471  	case MAX310X_LSR_IRQSTS_REG:
f65444187a66bf5 Alexander Shiyan 2012-08-06  472  	case MAX310X_SPCHR_IRQSTS_REG:
f65444187a66bf5 Alexander Shiyan 2012-08-06  473  	case MAX310X_STS_IRQSTS_REG:
f65444187a66bf5 Alexander Shiyan 2012-08-06  474  	case MAX310X_TXFIFOLVL_REG:
f65444187a66bf5 Alexander Shiyan 2012-08-06  475  	case MAX310X_RXFIFOLVL_REG:
f65444187a66bf5 Alexander Shiyan 2012-08-06  476  		return false;
f65444187a66bf5 Alexander Shiyan 2012-08-06  477  	default:
f65444187a66bf5 Alexander Shiyan 2012-08-06  478  		return true;
f65444187a66bf5 Alexander Shiyan 2012-08-06  479  	}
d5dd265cda8083c Hugo Villeneuve  2024-01-18  480  }
f65444187a66bf5 Alexander Shiyan 2012-08-06  481  
f65444187a66bf5 Alexander Shiyan 2012-08-06 @482  static bool max310x_reg_volatile(struct device *dev, unsigned int reg)
f65444187a66bf5 Alexander Shiyan 2012-08-06  483  {
6ef281daf020592 Cosmin Tanislav  2022-06-05  484  	switch (reg) {
f65444187a66bf5 Alexander Shiyan 2012-08-06  485  	case MAX310X_RHR_REG:
f65444187a66bf5 Alexander Shiyan 2012-08-06  486  	case MAX310X_IRQSTS_REG:
f65444187a66bf5 Alexander Shiyan 2012-08-06  487  	case MAX310X_LSR_IRQSTS_REG:
f65444187a66bf5 Alexander Shiyan 2012-08-06  488  	case MAX310X_SPCHR_IRQSTS_REG:
f65444187a66bf5 Alexander Shiyan 2012-08-06  489  	case MAX310X_STS_IRQSTS_REG:
f65444187a66bf5 Alexander Shiyan 2012-08-06  490  	case MAX310X_TXFIFOLVL_REG:
f65444187a66bf5 Alexander Shiyan 2012-08-06  491  	case MAX310X_RXFIFOLVL_REG:
f65444187a66bf5 Alexander Shiyan 2012-08-06  492  	case MAX310X_GPIODATA_REG:
10d8b34a421716d Alexander Shiyan 2013-06-29  493  	case MAX310X_BRGDIVLSB_REG:
10d8b34a421716d Alexander Shiyan 2013-06-29  494  	case MAX310X_REG_05:
10d8b34a421716d Alexander Shiyan 2013-06-29  495  	case MAX310X_REG_1F:
f65444187a66bf5 Alexander Shiyan 2012-08-06  496  		return true;
f65444187a66bf5 Alexander Shiyan 2012-08-06  497  	default:
f65444187a66bf5 Alexander Shiyan 2012-08-06  498  		return false;
f65444187a66bf5 Alexander Shiyan 2012-08-06  499  	}
d5dd265cda8083c Hugo Villeneuve  2024-01-18  500  }
f65444187a66bf5 Alexander Shiyan 2012-08-06  501  
f65444187a66bf5 Alexander Shiyan 2012-08-06 @502  static bool max310x_reg_precious(struct device *dev, unsigned int reg)
f65444187a66bf5 Alexander Shiyan 2012-08-06  503  {
6ef281daf020592 Cosmin Tanislav  2022-06-05  504  	switch (reg) {
f65444187a66bf5 Alexander Shiyan 2012-08-06  505  	case MAX310X_RHR_REG:
f65444187a66bf5 Alexander Shiyan 2012-08-06  506  	case MAX310X_IRQSTS_REG:
f65444187a66bf5 Alexander Shiyan 2012-08-06  507  	case MAX310X_SPCHR_IRQSTS_REG:
f65444187a66bf5 Alexander Shiyan 2012-08-06  508  	case MAX310X_STS_IRQSTS_REG:
f65444187a66bf5 Alexander Shiyan 2012-08-06  509  		return true;
f65444187a66bf5 Alexander Shiyan 2012-08-06  510  	default:
f65444187a66bf5 Alexander Shiyan 2012-08-06  511  		return false;
f65444187a66bf5 Alexander Shiyan 2012-08-06  512  	}
d5dd265cda8083c Hugo Villeneuve  2024-01-18  513  }
f65444187a66bf5 Alexander Shiyan 2012-08-06  514  
3f42b142ea11719 Jan Kundrát      2023-04-05 @515  static bool max310x_reg_noinc(struct device *dev, unsigned int reg)
3f42b142ea11719 Jan Kundrát      2023-04-05  516  {
3f42b142ea11719 Jan Kundrát      2023-04-05  517  	return reg == MAX310X_RHR_REG;
3f42b142ea11719 Jan Kundrát      2023-04-05  518  }
3f42b142ea11719 Jan Kundrát      2023-04-05  519  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
