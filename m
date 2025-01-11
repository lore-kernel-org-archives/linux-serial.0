Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84B11712;
	Sat, 11 Jan 2025 01:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736559377; cv=none; b=sXmaEh/nAInSE9RzkwzOgx7FwoDZSXkIdJ9Z2yp6IjGL5QoYsDj40C3jyRV90isWW2sDo1DjcniEOLwWMVSkrmU7iZScQzwqyKwWcDwPszRrSTiaTPmLIf8cmbigfA3t6Oe8V/E+/gS71utTluW0W2wgImOXVip4oo/K0ujNumQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736559377; c=relaxed/simple;
	bh=nH5FRp3nXdkjLOn0YL3BC6d3eSUR0xqSaGqIR/SlXuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUeGONULoif85FjPd9hkrosKP4leUdj6iSolRWlFdgXiddt/SxgUKBeg6bgZ6kMy6LErVx6yIjlf3q7cG16OStW03lJ/t9OeX2YoLwX6M7bV7Fsmqb+z+Yq2qGWALHmaYhtN/4NlSTI7ZvJFuNv1ac33ALVlJaWVI3Cc52xSsNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kApDHED6; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kApDHED6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736559376; x=1768095376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nH5FRp3nXdkjLOn0YL3BC6d3eSUR0xqSaGqIR/SlXuY=;
  b=kApDHED60Jkv4+D+UnE7kjXvbf6VRu6X0IvyXCxbcCucTZFlBiTlqYZw
   vnbs3grLMW5j4gxuIQhhi/yAt/YmTeAa2w8rZTGtKXqfQo6qhgC3W7ZmJ
   pmnseeoGwubF0LKBV4K0kxTTWU6afzyA0eiqgnPPp4HfXQcjD6MKzFggs
   rvinmh+dCpsZQnJIEHQF2NiBfGBofH5sM2kp04sXWYuHpbrhFuDvHugyf
   u9gPScTjKC2viTmKlaFtGqFm5I17+dKUZcdhKJFmYV+DQ7+Z5YJZhYEru
   j13EJi/vjMeA5H7NzQaDjxxRYbyzwbcbMrvYS1qo9dbRwFPoWheMIJNb5
   A==;
X-CSE-ConnectionGUID: qvpztQKVT+SsUMhRUoA5zA==
X-CSE-MsgGUID: UKSb8F6bTQ+z4vNEI8LVvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="48234331"
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="48234331"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 17:36:15 -0800
X-CSE-ConnectionGUID: PLo3wlCYTx2fqRn9EWHP0g==
X-CSE-MsgGUID: 1jUy/QrVTn+qsIVUbePwDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="104447926"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 10 Jan 2025 17:36:10 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWQQ4-000K0j-1E;
	Sat, 11 Jan 2025 01:36:08 +0000
Date: Sat, 11 Jan 2025 09:35:45 +0800
From: kernel test robot <lkp@intel.com>
To: WangYuli <wangyuli@uniontech.com>, gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, andriy.shevchenko@linux.intel.com,
	arnd@kernel.org, schnelle@linux.ibm.com, pnewman@connecttech.com,
	sunilvl@ventanamicro.com, paulmck@kernel.org, arnd@arndb.de,
	zhanjun@uniontech.com, guanwentao@uniontech.com,
	Zhuozhen He <hezhuozhen@uniontech.com>,
	Guowei Chen <chenguowei@uniontech.com>
Subject: Re: [PATCH] serial: 8250_it8768e: Create iTE IT8768E specific 8250
 driver
Message-ID: <202501110920.kLUGElwx-lkp@intel.com>
References: <41B1320691916DE6+20250109120808.559950-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B1320691916DE6+20250109120808.559950-1-wangyuli@uniontech.com>

Hi WangYuli,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.13-rc6 next-20250110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/WangYuli/serial-8250_it8768e-Create-iTE-IT8768E-specific-8250-driver/20250109-201036
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/41B1320691916DE6%2B20250109120808.559950-1-wangyuli%40uniontech.com
patch subject: [PATCH] serial: 8250_it8768e: Create iTE IT8768E specific 8250 driver
config: i386-randconfig-062-20250111 (https://download.01.org/0day-ci/archive/20250111/202501110920.kLUGElwx-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250111/202501110920.kLUGElwx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501110920.kLUGElwx-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/tty/serial/8250/8250_it8768e.c:39:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] __iomem sio_base @@     got void [noderef] __iomem * @@
   drivers/tty/serial/8250/8250_it8768e.c:39:18: sparse:     expected void *[noderef] __iomem sio_base
   drivers/tty/serial/8250/8250_it8768e.c:39:18: sparse:     got void [noderef] __iomem *
>> drivers/tty/serial/8250/8250_it8768e.c:58:33: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __iomem *membase @@     got void *[noderef] __iomem sio_base @@
   drivers/tty/serial/8250/8250_it8768e.c:58:33: sparse:     expected unsigned char [noderef] __iomem *membase
   drivers/tty/serial/8250/8250_it8768e.c:58:33: sparse:     got void *[noderef] __iomem sio_base
>> drivers/tty/serial/8250/8250_it8768e.c:40:14: sparse: sparse: dereference of noderef expression

vim +39 drivers/tty/serial/8250/8250_it8768e.c

    26	
    27	static int it8768e_probe(struct platform_device *pdev)
    28	{
    29		struct it8768e_data *data;
    30		struct resource *res;
    31		void *__iomem sio_base;
    32	
    33		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    34		if (!res) {
    35			dev_err(&pdev->dev, "memory resource not found\n");
    36			return -EINVAL;
    37		}
    38	
  > 39		sio_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
  > 40		if (!sio_base) {
    41			dev_err(&pdev->dev, "devm_ioremap error\n");
    42			return -ENOMEM;
    43		}
    44	
    45		data = devm_kcalloc(&pdev->dev, 1,
    46				sizeof(struct it8768e_data),
    47				GFP_KERNEL);
    48		if (!data) {
    49			dev_err(&pdev->dev, "Failed to alloc private mem struct.\n");
    50			return -ENOMEM;
    51		}
    52	
    53		spin_lock_init(&data->uart.port.lock);
    54		data->uart.port.dev = &pdev->dev;
    55		data->uart.port.regshift = 0;
    56		data->uart.port.iotype = UPIO_MEM;
    57		data->uart.port.type = PORT_16550A;
  > 58		data->uart.port.membase = sio_base;
    59		data->uart.port.mapbase = res->start;
    60		data->uart.port.uartclk = 1843200;
    61		data->uart.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_SKIP_TEST;
    62	
    63		data->line = serial8250_register_8250_port(&data->uart);
    64		if (data->line < 0) {
    65			dev_err(&pdev->dev,
    66				"unable to resigter 8250 port (MEM%llx): %d\n",
    67				(unsigned long long)res->start, 0);
    68			return data->line;
    69		}
    70	
    71		dev_set_drvdata(&pdev->dev, data);
    72		return 0;
    73	}
    74	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
