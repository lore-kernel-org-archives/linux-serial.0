Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89193DCDBF;
	Fri, 16 Oct 2026 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136618; cv=none; b=Hluwjz0kZCxp88Nu5Btgt9SY1HRZY/NM1uMYKXgqG/Ry5gJgObAYRZSiHE0dhSrGgzr8VIRiYpaczaZHSD/KTQteov8MMo4RAkLE2YWVJJMqoaGrb+KlsbLX7VAS2MrGs2lHaMeiHSCNuuIy26MCFgshFO95GA0XhzvHZzWeOqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136618; c=relaxed/simple;
	bh=FGGPjqRCeeV74Cjl9VTeHKOGCZ5V86IQl1cesp1fthU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTsfR6SE0DuIUwOdPw/CgQjYOIFVMLYdxxnSVR398dD9Zz1y5bEE2VqDojZ29vM7VmQ3Qz4QwGelDzQ+aYFTWE5hY3KIndtNUNN+WR+4ZRv5d82NtPkHlbwdId2ehH8GJgucLWyQcuO7mMevabDqQ1b+0IL5UbzkcfbIqqs4Lq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJO4JtoY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJO4JtoY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792136615; x=1823672615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FGGPjqRCeeV74Cjl9VTeHKOGCZ5V86IQl1cesp1fthU=;
  b=QJO4JtoY7fgjFxpyRsryousbtvzA8hjAOwRvMUbE8y/FYq48GJ8CXfUZ
   Fcfxo/rcpbNXF/IkdnM3CXsd0TSyixOeXPbJsPh9CTHO5+vCnlQ183t2C
   lxnBn/u5Mdh7Gn8ObghBPd3fky2/c7D1CSFZ2joWfgwOa7ILGj/l4B9Ku
   CfLg1isoOdlklC9JbbtRMyP9rUjIYNm2/Ze3SPCMjvTMBGOA4cjcTevgp
   NQ6n1GIyEu33tOrKj45L8rLsJCkO917e8L6VCXHsDPkdXa38r2d+yxNRN
   Bb1phR5ePzrqkm0qxaKQgxNKly85b1Q2hZvcEjBArM1phuhMRFryW6LhY
   Q==;
X-CSE-ConnectionGUID: m/TrTbvhSkiMw0S/yLoVWw==
X-CSE-MsgGUID: 7JFCBIuoSVelwRlLBI8UQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="820309"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="820309"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 00:43:34 -0700
X-CSE-ConnectionGUID: D+A0irt3RiKFM0rd4f0kIg==
X-CSE-MsgGUID: aYmDwfO1QqKmpeIa8ntcJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2247453"
Received: from igk-lkp-server01.igk.intel.com (HELO d0de6c2a75a7) ([10.211.93.152])
  by fmviesa009.fm.intel.com with ESMTP; 16 Oct 2026 00:43:31 -0700
Received: from kbuild by d0de6c2a75a7 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHcbA-00000000C7n-2LQc;
	Fri, 16 Oct 2026 07:43:28 +0000
Date: Fri, 16 Oct 2026 09:43:01 +0200
From: kernel test robot <lkp@intel.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Donald Shannon <donalds@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	llvm@lists.linux.dev,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>, Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH 10/11] tty: Add NVIDIA LSTP UART driver
Message-ID: <202610160913.yN6dyp5f-lkp@intel.com>
References: <20261012-lstp-usb-adapter-v1-10-aambrozewicz@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-lstp-usb-adapter-v1-10-aambrozewicz@nvidia.com>

Hi Adrian,

kernel test robot noticed the following build errors:

[auto build test ERROR on bbf6b99a57b2479bf51c3c8ad0946f4b8c33ed69]

url:    https://github.com/intel-lab-lkp/linux/commits/Adrian-Ambrozewicz/dt-bindings-gpio-Add-NVIDIA-LSTP-GPIO/20261012-203559
base:   bbf6b99a57b2479bf51c3c8ad0946f4b8c33ed69
patch link:    https://lore.kernel.org/r/20261012-lstp-usb-adapter-v1-10-aambrozewicz%40nvidia.com
patch subject: [PATCH 10/11] tty: Add NVIDIA LSTP UART driver
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20261016/202610160913.yN6dyp5f-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261016/202610160913.yN6dyp5f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610160913.yN6dyp5f-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/tty/lstp_tty.c: In function 'lstp_baud_to_speed':
>> drivers/tty/lstp_tty.c:167:74: error: 'B2500000' undeclared (first use in this function); did you mean 'B1500000'?
     167 |                 { 1500000, B1500000 }, { 2000000, B2000000 }, { 2500000, B2500000 },
         |                                                                          ^~~~~~~~
         |                                                                          B1500000
   drivers/tty/lstp_tty.c:167:74: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/tty/lstp_tty.c:168:28: error: 'B3000000' undeclared (first use in this function); did you mean 'B1000000'?
     168 |                 { 3000000, B3000000 }, { 3500000, B3500000 }, { 4000000, B4000000 },
         |                            ^~~~~~~~
         |                            B1000000
>> drivers/tty/lstp_tty.c:168:51: error: 'B3500000' undeclared (first use in this function); did you mean 'B1500000'?
     168 |                 { 3000000, B3000000 }, { 3500000, B3500000 }, { 4000000, B4000000 },
         |                                                   ^~~~~~~~
         |                                                   B1500000
>> drivers/tty/lstp_tty.c:168:74: error: 'B4000000' undeclared (first use in this function); did you mean 'B1000000'?
     168 |                 { 3000000, B3000000 }, { 3500000, B3500000 }, { 4000000, B4000000 },
         |                                                                          ^~~~~~~~
         |                                                                          B1000000


vim +167 drivers/tty/lstp_tty.c

   151	
   152	/* clang-format off */
   153	static speed_t lstp_baud_to_speed(u32 baud)
   154	{
   155		static const struct {
   156			u32     baud;
   157			speed_t speed;
   158		} map[] = {
   159			{      50, B50      }, {      75, B75      }, {     110, B110     },
   160			{     134, B134     }, {     150, B150     }, {     200, B200     },
   161			{     300, B300     }, {     600, B600     }, {    1200, B1200    },
   162			{    1800, B1800    }, {    2400, B2400    }, {    4800, B4800    },
   163			{    9600, B9600    }, {   19200, B19200   }, {   38400, B38400   },
   164			{   57600, B57600   }, {  115200, B115200  }, {  230400, B230400  },
   165			{  460800, B460800  }, {  500000, B500000  }, {  576000, B576000  },
   166			{  921600, B921600  }, { 1000000, B1000000 }, { 1152000, B1152000 },
 > 167			{ 1500000, B1500000 }, { 2000000, B2000000 }, { 2500000, B2500000 },
 > 168			{ 3000000, B3000000 }, { 3500000, B3500000 }, { 4000000, B4000000 },
   169		};
   170	
   171		for (size_t i = 0; i < ARRAY_SIZE(map); i++)
   172			if (map[i].baud == baud)
   173				return map[i].speed;
   174	
   175		return B0;
   176	}
   177	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
