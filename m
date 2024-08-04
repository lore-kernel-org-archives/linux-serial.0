Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32F261FCF;
	Sun,  4 Aug 2024 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722784311; cv=none; b=RhwL8uxL2VqUUIgVpucp6oFtv1yqbmDTKUfUPf9XwoW9uze+LMJbxoyaX8U57kChqzSQcwuOrYJYBphXiwa4Mou8KeeYKS1mH9hNlrltBw7C1t8Pc3sS+lCeNuj5E1mdhxBjA+bWJM1wgO8Y+6F//jaw4rWjcOQFXBddS1U9YWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722784311; c=relaxed/simple;
	bh=Zhi1Y/og0cWe4Q4rMi/KieLjzrfywbdgNBTRJ/VZ1Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewh2BD1xmt4YpbgKQ74M8OlwO0rO46ZtzUEsUdchpK5XhUDs6PpzCENr+161Du4y7JNZBFeh1xzV+AhVLhBHO1XIv5feInnTy8axHMsHLyUgfL2BaNXZVPrGDPYWwd5lQWgvMcyOSf6vjFftHnFOZP1qEkalODyH/uZAunNS8ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUosQiuG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUosQiuG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722784308; x=1754320308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zhi1Y/og0cWe4Q4rMi/KieLjzrfywbdgNBTRJ/VZ1Cg=;
  b=bUosQiuGZesceoc2Pn6lJxZxv6OepgqpvftGL6wiL5DnOLwyTDWAl2+k
   ThAly7fvfp/lPLysXU92sO06oWhyyXkivAgBr69n/IgT/Aa8z0H/RU6Aw
   oVcaiPOFB0UsXYzdITNoq4W5NQiUgffknioicX8xxQPuDNJ1ZXRvGngtZ
   RF6X+qenK/7ERexVyOhK2pnPxcd5SCwOT7e4zBmgxAwNSsk+MjF7lb8wo
   s+5HriX/2jyWxt1FdezOdTIIQjJzMJlS5le5tUzI6mywXJIarTwJ3dXhy
   cQHLAod0LHVGCMEYw3h8j8iyTvn8LVS46EOGAYdDdtEC737Bd4AMLCtj1
   w==;
X-CSE-ConnectionGUID: PTGBgRCMRqmSwiO+kFSOkQ==
X-CSE-MsgGUID: GfHGXxFgQWO3cMqsm6SOlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="23660039"
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="23660039"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 08:11:48 -0700
X-CSE-ConnectionGUID: MRZcdSQqR8WQDWbR7wdhlw==
X-CSE-MsgGUID: LNlWNa+gRM2fJwes5cZcNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="55838409"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 04 Aug 2024 08:11:44 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sactZ-0001Tl-2O;
	Sun, 04 Aug 2024 15:11:41 +0000
Date: Sun, 4 Aug 2024 23:11:03 +0800
From: kernel test robot <lkp@intel.com>
To: zhenghaowei@loongson.cn, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
	p.zabel@pengutronix.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, loongarch@lists.linux.dev
Subject: Re: [PATCH v2 2/3] tty: serial: 8250: Add loongson uart driver
 support
Message-ID: <202408042241.zkkSuA60-lkp@intel.com>
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
config: mips-gpr_defconfig (https://download.01.org/0day-ci/archive/20240804/202408042241.zkkSuA60-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 423aec6573df4424f90555468128e17073ddc69e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240804/202408042241.zkkSuA60-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408042241.zkkSuA60-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/tty/serial/8250/8250_loongson.c:14:
   In file included from drivers/tty/serial/8250/8250.h:11:
   In file included from include/linux/serial_8250.h:11:
   In file included from include/linux/serial_core.h:16:
   In file included from include/linux/tty.h:11:
   In file included from include/linux/tty_port.h:5:
   In file included from include/linux/kfifo.h:40:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/tty/serial/8250/8250_loongson.c:200:21: error: call to undeclared function 'of_match_ptr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     200 |                 .of_match_table = of_match_ptr(of_platform_serial_table),
         |                                   ^
>> drivers/tty/serial/8250/8250_loongson.c:200:21: error: incompatible integer to pointer conversion initializing 'const struct of_device_id *' with an expression of type 'int' [-Wint-conversion]
     200 |                 .of_match_table = of_match_ptr(of_platform_serial_table),
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_loongson.c:200:21: error: initializer element is not a compile-time constant
     200 |                 .of_match_table = of_match_ptr(of_platform_serial_table),
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 3 errors generated.


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
