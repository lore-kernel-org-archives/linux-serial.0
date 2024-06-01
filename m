Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C73014E2E7;
	Sat,  1 Jun 2024 09:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717234036; cv=none; b=l3A3f1QfgUijO+P9YNoWCb81038CJlXSiUNUwotQy+gCbUbmm90XF01PIX7IB6JAGI8G7641lrebPDn0a66JwGpIMJ5jjfgwePYzIeCwOk/GIqGfTagbXqN+NFZk7dHUvbrf6CYvYtLQjnBH1B9S+NgH+DrDURiNZmGnBA6yknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717234036; c=relaxed/simple;
	bh=QBWnFCFndIQ273BjFNgpk2O53sifvVexYsbTKkuXgdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/ZQpzmnkLrFg7tJ2+FAgBs3xWSEwmIOO77h/kf3rBI2rsLVbXBotv23Eo8P2ZSptoLO18xgZsWjHpozpcD4cvAoKUiZrLqc8xFg+wfYgpu1QlWUv9CBz0lO3t+xUrapg5eeDpc8noioI2WPpJLKr3k239mJMxB89w1IXjEvtCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhqWE5Dq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhqWE5Dq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717234035; x=1748770035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QBWnFCFndIQ273BjFNgpk2O53sifvVexYsbTKkuXgdc=;
  b=jhqWE5DqIXDYWTwRgD2oxtFE/hEZrcK3Lp8JCW1q6kQ4cGIZyqXIMa99
   m2Sqo/irms9HDld7FkrrqFNHFoyNZIV33oi/YIZeb0QNpzfcUpAAA6jN8
   HlY5mrsDsBZEVZS0kPZb/dacI4Gz/zFb/ciHjO9SFPUTkWkAGwJHGuuOX
   8gsvT5armneW0QhgvP95xWb6pVx2nyRST6SF/Vshj5HS4O4/qpi5SI1XJ
   HalTak7KO6X/4jOFMTo7WfcJnth4YtxblgK+R+4vmyVg4hfNf5nBlaqf5
   9BQETVe7q/P8tyGuSnKQCAyCu1n6MCHJJzhTTmb6NcKT2CBPV2s8l2Z4P
   g==;
X-CSE-ConnectionGUID: YlCGMHhLTVmR+2xc62rUyg==
X-CSE-MsgGUID: 68TeEhH0RXGhdaMVyhOHLg==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="24414515"
X-IronPort-AV: E=Sophos;i="6.08,207,1712646000"; 
   d="scan'208";a="24414515"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2024 02:27:14 -0700
X-CSE-ConnectionGUID: 43VX1QtNQ36aoAqlDm2bFQ==
X-CSE-MsgGUID: paCIO5gSS1O9d0DiF8e87Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,207,1712646000"; 
   d="scan'208";a="41476726"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 01 Jun 2024 02:27:13 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDL14-000Icf-1R;
	Sat, 01 Jun 2024 09:27:10 +0000
Date: Sat, 1 Jun 2024 17:26:21 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Mack <daniel@zonque.org>, gregkh@linuxfoundation.org,
	hvilleneuve@dimonoff.com
Cc: oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] serial: sc16is7xx: set driver name
Message-ID: <202406011748.tHQQJ8TB-lkp@intel.com>
References: <20240531101959.181457-1-daniel@zonque.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531101959.181457-1-daniel@zonque.org>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.10-rc1 next-20240531]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Mack/serial-sc16is7xx-set-driver-name/20240531-182824
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20240531101959.181457-1-daniel%40zonque.org
patch subject: [PATCH] serial: sc16is7xx: set driver name
config: x86_64-randconfig-123-20240601 (https://download.01.org/0day-ci/archive/20240601/202406011748.tHQQJ8TB-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240601/202406011748.tHQQJ8TB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406011748.tHQQJ8TB-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/tty/serial/sc16is7xx.c:352:10: sparse: sparse: Initializer entry defined twice
   drivers/tty/serial/sc16is7xx.c:354:10: sparse:   also defined here

vim +352 drivers/tty/serial/sc16is7xx.c

c64349722d1417 Jakub Kicinski  2015-07-31  349  
c64349722d1417 Jakub Kicinski  2015-07-31  350  static struct uart_driver sc16is7xx_uart = {
c64349722d1417 Jakub Kicinski  2015-07-31  351  	.owner		= THIS_MODULE,
d9ffadaf9df1c8 Hugo Villeneuve 2023-12-21 @352  	.driver_name    = SC16IS7XX_NAME,
c64349722d1417 Jakub Kicinski  2015-07-31  353  	.dev_name	= "ttySC",
cb1c18ea6be1d7 Daniel Mack     2024-05-31  354  	.driver_name	= SC16IS7XX_NAME,
c64349722d1417 Jakub Kicinski  2015-07-31  355  	.nr		= SC16IS7XX_MAX_DEVS,
c64349722d1417 Jakub Kicinski  2015-07-31  356  };
c64349722d1417 Jakub Kicinski  2015-07-31  357  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
