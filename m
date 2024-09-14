Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4D41CF29F;
	Sat, 14 Sep 2024 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726320424; cv=none; b=cn6IzJZvGvmZcZY8s+Yv3N5+0R2WRcxVZ0s/fZAGSY2Vdkr39z4eHPdGYy4tgTcnc169UTPHy126ivAkcXLt8hPvpAv+JgBPhUwJchaTAop7ZaVC/+DLsnWXG//pHcnCkHofSy06fBz/QjmzRHxN6DYT/wUdkJZijvPvC8jdtGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726320424; c=relaxed/simple;
	bh=0iCbeeeXJT3CsVcE5IfF7h0YLO40dMvutHLSliTDO1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2e2oIYgj6c3xZuToKcnKdzFW3Mju/JWpO5T3f7Xd028ceJIwTnRdAobKXCO3EEs8TvHMZxN6kTw5ZHesKRFkcQxLUsyI/csYNRToCOx6ejPbIPiJVRIC3LhVgC2mBpk4rjVO84Ag5RoBy71v6IxGR6R4ViYwAv0Zg/JJytd9FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3s+JIeY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3s+JIeY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726320423; x=1757856423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0iCbeeeXJT3CsVcE5IfF7h0YLO40dMvutHLSliTDO1k=;
  b=i3s+JIeYrV+i2rs1SEAcPSwlMF/N7AmcLcppItCn3b5/554ZxFd1UI62
   u3q+tT7hVPoPv0wpU5P+N31gzqZqy37dtXHVFpGTwzrqs4mqatodCpEhP
   XQLxMCPiZyRPvI0K2H1O71yAViJtsIQMQWEECBq5njVRhX1EmUjjNc0+m
   HaiAK/TwTYR2zWyfQXAihU0KIG4Aheuq21w+jcou4Jxg6cevYSiEX+Wg8
   KdPnCBbcj5N3QjNUUtvAPOXCh9J+xwsSTkUFm8diHi/xmol9IWsdXS6tF
   9pJcATRj9OakfGyPqf8Dw3HqMjuu+W7ZgjnqoP07Ux/VbhJeL1JbZ/UxO
   w==;
X-CSE-ConnectionGUID: LrBVB0OzQziyrwTjQzQMnA==
X-CSE-MsgGUID: avmW+4oVSNKt1+MoHMbYsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="24698589"
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="24698589"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 06:27:02 -0700
X-CSE-ConnectionGUID: TrLKQcrGS8uu6BPCPQD6bw==
X-CSE-MsgGUID: 4nJvjZHzRDSvfJc3DHXEMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="68268766"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 14 Sep 2024 06:27:00 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spSnh-0007mI-2M;
	Sat, 14 Sep 2024 13:26:57 +0000
Date: Sat, 14 Sep 2024 21:26:27 +0800
From: kernel test robot <lkp@intel.com>
To: Parker Newman <parker@finest.io>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 4/6] serial: 8250_exar: Replace custom EEPROM read
 with eeprom_93cx6
Message-ID: <202409142138.yCOHBlL1-lkp@intel.com>
References: <78dead78311ea619e0be99cc32ee0df1610a480d.1726237379.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78dead78311ea619e0be99cc32ee0df1610a480d.1726237379.git.pnewman@connecttech.com>

Hi Parker,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5ed771f174726ae879945d4f148a9005ac909cb7]

url:    https://github.com/intel-lab-lkp/linux/commits/Parker-Newman/misc-eeprom-eeprom_93cx6-Add-quirk-for-extra-read-clock-cycle/20240913-230345
base:   5ed771f174726ae879945d4f148a9005ac909cb7
patch link:    https://lore.kernel.org/r/78dead78311ea619e0be99cc32ee0df1610a480d.1726237379.git.pnewman%40connecttech.com
patch subject: [PATCH v1 4/6] serial: 8250_exar: Replace custom EEPROM read with eeprom_93cx6
config: x86_64-randconfig-122-20240914 (https://download.01.org/0day-ci/archive/20240914/202409142138.yCOHBlL1-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409142138.yCOHBlL1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409142138.yCOHBlL1-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/tty/serial/8250/8250_exar.c:739:13: sparse: sparse: restricted __le32 degrades to integer

vim +739 drivers/tty/serial/8250/8250_exar.c

   721	
   722	/**
   723	 * cti_read_osc_freq() - Read the UART oscillator frequency from EEPROM
   724	 * @priv: Device's private structure
   725	 * @eeprom_offset: Offset where the oscillator frequency is stored
   726	 *
   727	 * CTI XR17x15X and XR17V25X cards have the serial boards oscillator frequency
   728	 * stored in the EEPROM. FPGA and XR17V35X based cards use the PCI/PCIe clock.
   729	 *
   730	 * Return: frequency on success, negative error code on failure
   731	 */
   732	static int cti_read_osc_freq(struct exar8250 *priv, u8 eeprom_offset)
   733	{
   734		__le32 osc_freq_le;
   735	
   736		eeprom_93cx6_multiread(&priv->eeprom, eeprom_offset,
   737					(__le16 *)&osc_freq_le, 2);
   738	
 > 739		if (osc_freq_le == 0xFFFFFFFF)
   740			return -EIO;
   741	
   742		return le32_to_cpu(osc_freq_le);
   743	}
   744	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
