Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6BB314B91;
	Wed, 10 Sep 2025 11:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503573; cv=none; b=ikIeoxaipgYs7nfNgzRiwi573UT2RG8dyo42yUSt1k6o0askvFcGMN0lQdr+tBdLRONQwfG4ZHuV7uFKd3ZJneRpefUqN7tOl/42YyBfmp2+SUTXQT/1Ra08M0lOu/T3Xgzux2c3yRvv/G1kpA967rx3bbOZMCmwaK0+3x0I4Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503573; c=relaxed/simple;
	bh=g1ZcYK7z0kSGnHDL6z7Fn7KjrnhP0j0B1BZniWcndEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkaJ+wuqXYvwQQO+UrN9WxCST2jAE+qAlEys1u3tvsaSEmkeNJ0nUpvLX3GpRNJHazb1dYfNZY1DjBX+dFLFz3xxgY/yEpRkDhYI57hCAtEKobKlYEEg5/dwkEg2gceBRHtq3imJrhsCnQb3E21Y2fUwrNO4tMAj8u9MFHtmhRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L0FwgFMm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L0FwgFMm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757503571; x=1789039571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g1ZcYK7z0kSGnHDL6z7Fn7KjrnhP0j0B1BZniWcndEk=;
  b=L0FwgFMmr9wn306EF5UN0kBMW0SMoKXFWtKUX6S626JJuKOFdDscU0bl
   YcQQ6D2ZFWo6W9oE+I2Euaavh6FNLBZFu+j1kjCGqudlgzzIdvvvnYDRJ
   U1K1h8yOsrSP8K9nYRDBrJNcQprI2bQYoRuFA4m0IW4qiD8npGcRMJxFU
   LJMO1KsKBp3gF1i4VHLhy/rJtjZw8omaPXcD8f/ZobpL3L8ORn+Ac6axe
   Y90Xggve/GqoDGn6xlrrxMSB9yvHwhiZ+WgOzFtY016voUizeIR6DeNHn
   TUs4RZdfEiE1QfVR2CrXtF/G57k4Cio5fooQ+JxRP4IbCqMblfTVNl7uv
   w==;
X-CSE-ConnectionGUID: ecn41i2iQ2GLT1L60Zhk7A==
X-CSE-MsgGUID: UcA4XL2bSCSzCVUgI5veDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59731083"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59731083"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 04:26:11 -0700
X-CSE-ConnectionGUID: qM09ER3pRp2gbsaxIz/f+Q==
X-CSE-MsgGUID: rw4ZeemyT0OvU3znIurURg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="178570009"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 10 Sep 2025 04:26:07 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwIxh-0005sZ-18;
	Wed, 10 Sep 2025 11:26:05 +0000
Date: Wed, 10 Sep 2025 19:26:01 +0800
From: kernel test robot <lkp@intel.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>,
	Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Haowei Zheng <zhenghaowei@loongson.cn>
Cc: oe-kbuild-all@lists.linux.dev, Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev, devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 2/3] serial: 8250: Add Loongson uart driver support
Message-ID: <202509102107.dmwhCV71-lkp@intel.com>
References: <91ae8cd4f903ac452e337e4662bbabf8a412b061.1757318368.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91ae8cd4f903ac452e337e4662bbabf8a412b061.1757318368.git.zhoubinbin@loongson.cn>

Hi Binbin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b601e1f41edd4667062aa7cccb4e5199814979a3]

url:    https://github.com/intel-lab-lkp/linux/commits/Binbin-Zhou/dt-bindings-serial-Add-Loongson-UART-controller/20250909-201640
base:   b601e1f41edd4667062aa7cccb4e5199814979a3
patch link:    https://lore.kernel.org/r/91ae8cd4f903ac452e337e4662bbabf8a412b061.1757318368.git.zhoubinbin%40loongson.cn
patch subject: [PATCH v4 2/3] serial: 8250: Add Loongson uart driver support
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20250910/202509102107.dmwhCV71-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250910/202509102107.dmwhCV71-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509102107.dmwhCV71-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/tty/serial/8250/8250_loongson.c: In function 'loongson_uart_probe':
   drivers/tty/serial/8250/8250_loongson.c:102:9: error: implicit declaration of function 'device_property_read_u32' [-Wimplicit-function-declaration]
     102 |         device_property_read_u32(dev, "clock-frequency", &uart.port.uartclk);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_loongson.c:117:28: error: implicit declaration of function 'device_get_match_data'; did you mean 'device_match_any'? [-Wimplicit-function-declaration]
     117 |         flags = (uintptr_t)device_get_match_data(dev);
         |                            ^~~~~~~~~~~~~~~~~~~~~
         |                            device_match_any
   drivers/tty/serial/8250/8250_loongson.c: At top level:
   drivers/tty/serial/8250/8250_loongson.c:179:34: error: array type has incomplete element type 'struct of_device_id'
     179 | static const struct of_device_id loongson_uart_of_ids[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_loongson.c:179:34: warning: 'loongson_uart_of_ids' defined but not used [-Wunused-variable]


vim +/loongson_uart_of_ids +179 drivers/tty/serial/8250/8250_loongson.c

   175	
   176	static DEFINE_SIMPLE_DEV_PM_OPS(loongson_uart_pm_ops, loongson_uart_suspend,
   177					loongson_uart_resume);
   178	
 > 179	static const struct of_device_id loongson_uart_of_ids[] = {
   180		{ .compatible = "loongson,ls2k0500-uart", .data = (void *)LS2K0500_UART_FLAG },
   181		{ .compatible = "loongson,ls2k1500-uart", .data = (void *)LS2K1500_UART_FLAG },
   182		{ /* sentinel */ },
   183	};
   184	MODULE_DEVICE_TABLE(of, loongson_uart_of_ids);
   185	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
