Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A17E313539
	for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2026 23:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783727239; cv=none; b=F0AFbm22HP9flh0zqQ0pGP8ykf8/yx6wVrtiDTEA8TeO2SxtvQDVhaUJjGX83RhBH3HzrcWl600EkHBlSEzqmNoKMxbBCR8V2YiXZGrpLVp5IwUh85RHuiHgYVe5EzHtARwC7OKxbPb0KkSYFv6bEj2au8+NafYxlWD/8Mwc5aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783727239; c=relaxed/simple;
	bh=beyYj5zQq3y0aZrlBSnCoESDZP1unvFKo/c+uW8GWzU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uQucPVT6c9ZGQEDCxXlLdLbSUDBzUsfRvdUQQtUdzuFoWQgqkiz6TQDW/H2XU0Xz+ea9LsMD4Dq7Jfhmdz+juswBOojV9xvQt0Z5RT9uuQQ/EDbwcXXSFj/8Qsj6d5r+vqDFn93dxfYPToM0M5ueVTktkLlug0lE67LQWOvsOa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mmd0X94l; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mmd0X94l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783727238; x=1815263238;
  h=date:from:to:cc:subject:message-id;
  bh=beyYj5zQq3y0aZrlBSnCoESDZP1unvFKo/c+uW8GWzU=;
  b=mmd0X94l5Nj/EAQOMVMkskh7yU0JRkouvTT80fZPxyYLu7WSffDdfMax
   vxCix8/MEAdFtSbmBg+1QLxnJmVGgJdPFJi3K871JNRXglWa8AeiMokSD
   opTZPhmwn/EV3EiqUEhJ4A+1YGK51mHI2C7jEwSaFXH4ITTi9fd9QI+nu
   Y3m6E60LuGBAcCkpztNTlDolRl7d97oOfsCwZrtyaqSdGAwHHYyLfYVEC
   znPC2yn7/ZlkGdhOLasPL/pkC8++2jfoDXAc6cwdrLfADMugrD3322uZp
   JV6q4LUJfFwXb8gLwsE831qzI109u11x2xCxGkQk+llBtY90sBsiZXmvO
   g==;
X-CSE-ConnectionGUID: vSflKK2ESPWoKVhFezYrAw==
X-CSE-MsgGUID: QGP/YDKcRf+JKCrQW0hbnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84529341"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84529341"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 16:47:17 -0700
X-CSE-ConnectionGUID: kmCLIBl+TuCkl2O4mst9pA==
X-CSE-MsgGUID: XFjQbGZaTwyE/2O2xwJ76A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="256957202"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 10 Jul 2026 16:47:15 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wiKw4-00000000JVA-3DO1;
	Fri, 10 Jul 2026 23:47:12 +0000
Date: Sat, 11 Jul 2026 07:46:24 +0800
From: kernel test robot <lkp@intel.com>
To: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 32/41]
 drivers/tty/serial/8250/8250_hub6.c:44:6: warning: no previous prototype for
 'hub6_match_port'
Message-ID: <202607110715.VGT2dVVz-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   bef5e068b89b0f0cf974c987ebba9869a14b44c6
commit: 3d406299d8829747fe2e8692f4c29fe3dc1d101f [32/41] serial: 8250_hub6: add hub6_match_port()
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20260711/202607110715.VGT2dVVz-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260711/202607110715.VGT2dVVz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607110715.VGT2dVVz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/8250/8250_hub6.c:44:6: warning: no previous prototype for 'hub6_match_port' [-Wmissing-prototypes]
      44 | bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)
         |      ^~~~~~~~~~~~~~~


vim +/hub6_match_port +44 drivers/tty/serial/8250/8250_hub6.c

    43	
  > 44	bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)
    45	{
    46		return port1->iobase == port2->iobase && port1->hub6 == port2->hub6;
    47	}
    48	EXPORT_SYMBOL_GPL(hub6_match_port);
    49	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
