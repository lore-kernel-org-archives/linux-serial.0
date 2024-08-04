Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E592D03B;
	Sun,  4 Aug 2024 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722789800; cv=none; b=canuI6Mc/vd1JUSqsDaSVHxgHutu5nu04W1sUubQtMKLRGOK3B0ruJXGWUkz+BCGPLlyvCbGKKs0ZjFywJFyh2QWbdB1DcM9s5JjCuESiP4Y0Fbc9NVFRno2Ljl5w+PBtKbcfj1a/yQRpj5PQ+4jaE1bLmmhRUh6/3nVtgPEXw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722789800; c=relaxed/simple;
	bh=HNyFFfVNO+jBUsoZ+Wz9kLjM5s7uzZZ8sEH1bOQtruM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEwzlv/m0eaUhWCAFuhuuiknIFg0g1bSTDgwyqZ55FnILvE7ykDQCwfMdLupoY+ayx3+DLZNAAlt+ksrnm96Tefuj8iBkjU1XaEP7oeLNCcXrm4WmWbAj7yUt1IUlVQVjSOYwEgfhq4Hzbv+YMCeAvmccoZAr6pv4ak652/2aIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jVpPDQir; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVpPDQir"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722789799; x=1754325799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HNyFFfVNO+jBUsoZ+Wz9kLjM5s7uzZZ8sEH1bOQtruM=;
  b=jVpPDQir7Pd9NT/6Xx0rwh+6XIbwPwSKtnblU3radQQU4y5rXt5aEKaI
   Nevhw3QQVg7cEGx1C7kgSwqCuiD+dLfG3rrbJBLc3e+0hpA7Uktn+L5Gb
   crVqxE0WsRTa0nuQ7Z56yyWUe5etXsa+8YMtxqxMp2WgEONzl/d7Iq7Yr
   7JAKIQ45YLf0puMr+qs2EjHnHbj5lQRkkDiFMAZcX05tQkXmFg3N7d6qi
   1MK1w0uR4jc9dMWUQh/TNRFZNOe7WTQ/kkUYEDphNd0kA2TSUMVqwQzVy
   HND6618kjAj6xIcfKIIcf9084Mc3YxaYxT1J2yKwCdOG6vL82mA06XHOp
   g==;
X-CSE-ConnectionGUID: fu3yutisRdKB38R1JDCGNw==
X-CSE-MsgGUID: nVZjtx9OSZyYrC0c+XElYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="31405545"
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="31405545"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 09:43:18 -0700
X-CSE-ConnectionGUID: u6Pnklg0TqWgDnh9Ko0luA==
X-CSE-MsgGUID: ci8I1AuCRjmzQLt9AVKhOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="55884556"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 04 Aug 2024 09:43:15 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1saeK8-0001Xm-2A;
	Sun, 04 Aug 2024 16:43:12 +0000
Date: Mon, 5 Aug 2024 00:42:51 +0800
From: kernel test robot <lkp@intel.com>
To: zhenghaowei@loongson.cn, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
	p.zabel@pengutronix.de
Cc: oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH v2 2/3] tty: serial: 8250: Add loongson uart driver
 support
Message-ID: <202408050031.dYYkSqDM-lkp@intel.com>
References: <20240804063834.70022-2-zhenghaowei@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804063834.70022-2-zhenghaowei@loongson.cn>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus robh/for-next usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.11-rc1 next-20240802]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/zhenghaowei-loongson-cn/tty-serial-8250-Add-loongson-uart-driver-support/20240804-145047
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20240804063834.70022-2-zhenghaowei%40loongson.cn
patch subject: [PATCH v2 2/3] tty: serial: 8250: Add loongson uart driver support
config: mips-lemote2f_defconfig (https://download.01.org/0day-ci/archive/20240805/202408050031.dYYkSqDM-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240805/202408050031.dYYkSqDM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408050031.dYYkSqDM-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/tty/serial/8250/8250_loongson.c:200:35: error: implicit declaration of function 'of_match_ptr' [-Werror=implicit-function-declaration]
     200 |                 .of_match_table = of_match_ptr(of_platform_serial_table),
         |                                   ^~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_loongson.c:200:35: warning: initialization of 'const struct of_device_id *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   drivers/tty/serial/8250/8250_loongson.c:200:35: note: (near initialization for 'loongson_uart_driver.driver.of_match_table')
>> drivers/tty/serial/8250/8250_loongson.c:200:35: error: initializer element is not constant
   drivers/tty/serial/8250/8250_loongson.c:200:35: note: (near initialization for 'loongson_uart_driver.driver.of_match_table')
   cc1: some warnings being treated as errors


vim +/of_match_ptr +200 drivers/tty/serial/8250/8250_loongson.c

   193	
   194	static struct platform_driver loongson_uart_driver = {
   195		.probe = loongson_uart_probe,
   196		.remove = loongson_uart_remove,
   197		.driver = {
   198			.name = "ls7a-uart",
   199			.pm = &loongson_uart_pm_ops,
 > 200			.of_match_table = of_match_ptr(of_platform_serial_table),
   201		},
   202	};
   203	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
