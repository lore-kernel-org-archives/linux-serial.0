Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F851A5BA3;
	Sat, 26 Apr 2025 06:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647244; cv=none; b=WqlTLsJxKypTPbtI5e4QmlYwWjtkYMTxzoLBtFjaYuBYJ/R9/4C8ryYLgmCiakaS5BBZVe6i9KXezK0UPg3A7mEkwQI4phWzw8Z+r1zIYQjMYL98E8KQRK8zDoKwagTp1pONL30s80TLUqErytrj5Gk7sTZoNcAfq/UCC4OsogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647244; c=relaxed/simple;
	bh=DHN+2XwaGWSWPVgZUpkQ5NWYnVCsHjEBcx8IoO728h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyUPkC9FgBBXTSKohoMrRnrTkRzdm0IG3XrFcQe5DAX+42U3yJqWKpzbb6Tdm2q+HbntoyfQaO0oRcRy0cgf4UBNTo8SjIAVWKmpauxsivZv3Ul/BTFMf6lfuHkVWw7wwIm9s2P5oY6rgWHHH6vfZIIpc/QOVBDgX0P4Ykt+vrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWKotXnk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWKotXnk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745647242; x=1777183242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DHN+2XwaGWSWPVgZUpkQ5NWYnVCsHjEBcx8IoO728h0=;
  b=VWKotXnkCmPbL7t8bSLFLpjAKyRKWmweuVZJ/yn+E6Pf7tiu3xgQVx5e
   7He+YqtrBaOy56lSE84+65riWkRc8hwqsddgfH4wpLByi5AZF68Y8s9Ru
   qyJI7Xossz3+BM/rgy/R7dGmoCtezLwAwDKRR03w6jmIADGcV/LSVD4cG
   X7i/D6dKKpvWoVM5jDqZdxn4G+z1/WETA7KqVDRS9t6jp0TWD5rAJLUIY
   RBJNKSNFrI6/tixUJw2wklHCVwq2KsZ+LJ+s0KhAnYDl13BA34LXOhoFN
   WwngoXGg5LzZ2rk6iUXaSRs5v4vEQucX+0+Ezfb3fXLBn/C6hR/WUzWtw
   g==;
X-CSE-ConnectionGUID: HJjMGsXYTkuHqTAsWRnvag==
X-CSE-MsgGUID: tObNXKajTUeVpydfi7I6Mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="57951641"
X-IronPort-AV: E=Sophos;i="6.15,241,1739865600"; 
   d="scan'208";a="57951641"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 23:00:41 -0700
X-CSE-ConnectionGUID: fGVsoJFCSU20yY+XSe/Qyg==
X-CSE-MsgGUID: ckQjLZxXSfiXaCohK5TDOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,241,1739865600"; 
   d="scan'208";a="170290518"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 25 Apr 2025 23:00:37 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u8YaX-0005iR-2e;
	Sat, 26 Apr 2025 06:00:33 +0000
Date: Sat, 26 Apr 2025 13:59:57 +0800
From: kernel test robot <lkp@intel.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>, arnd@arndb.de,
	andriy.shevchenko@linux.intel.com, benjamin.larsson@genexis.eu,
	gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com, jirislaby@kernel.org,
	jkeeping@inmusicbrands.com, john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	markus.mayer@linaro.org, matt.porter@linaro.org,
	namcao@linutronix.de, paulmck@kernel.org, pmladek@suse.com,
	schnelle@linux.ibm.com, sunilvl@ventanamicro.com,
	tim.kryger@linaro.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4 2/4] serial: 8250: introduce serial8250_discard_data()
Message-ID: <202504261327.CEtXsr6g-lkp@intel.com>
References: <20250425062425.68761-2-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425062425.68761-2-cuiyunhui@bytedance.com>

Hi Yunhui,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[cannot apply to tty/tty-testing tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.15-rc3 next-20250424]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yunhui-Cui/serial-8250-introduce-serial8250_discard_data/20250425-142655
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20250425062425.68761-2-cuiyunhui%40bytedance.com
patch subject: [PATCH v4 2/4] serial: 8250: introduce serial8250_discard_data()
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20250426/202504261327.CEtXsr6g-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250426/202504261327.CEtXsr6g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504261327.CEtXsr6g-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/tty/serial/8250/8250_port.c:2146:32: error: use of undeclared identifier 'flags'
    2146 |         uart_port_lock_irqsave(port, &flags);
         |                                       ^
   drivers/tty/serial/8250/8250_port.c:2150:36: error: use of undeclared identifier 'flags'
    2150 |         uart_port_unlock_irqrestore(port, flags);
         |                                           ^
   2 errors generated.


vim +/flags +2146 drivers/tty/serial/8250/8250_port.c

  2131	
  2132	#ifdef CONFIG_CONSOLE_POLL
  2133	/*
  2134	 * Console polling routines for writing and reading from the uart while
  2135	 * in an interrupt or debug context.
  2136	 */
  2137	
  2138	static int serial8250_get_poll_char(struct uart_port *port)
  2139	{
  2140		struct uart_8250_port *up = up_to_u8250p(port);
  2141		int status = NO_POLL_CHAR;
  2142		u16 lsr;
  2143	
  2144		serial8250_rpm_get(up);
  2145	
> 2146		uart_port_lock_irqsave(port, &flags);
  2147		lsr = serial_port_in(port, UART_LSR);
  2148		if ((lsr & UART_LSR_DR))
  2149			status = serial_port_in(port, UART_RX);
  2150		uart_port_unlock_irqrestore(port, flags);
  2151	out:
  2152		serial8250_rpm_put(up);
  2153		return status;
  2154	}
  2155	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
