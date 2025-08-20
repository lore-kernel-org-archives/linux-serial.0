Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9681F287274
	for <linux-serial@vger.kernel.org>; Wed, 20 Aug 2025 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755671615; cv=none; b=Aj19iKqpTkbGIxAFucqUMVzbGNal0fstqvwMMJx1bHa4o2sL53zPsXHP6YYzegtspBbCCMBZnU8EOnJacKETYBIPv0hKNw3oa/qlCXQ9iOKYKVYaPKq2K2iFBcY9Xth1wIuWAGZahOqhyvwONzcVK2jogXC0Ntu2aCk7zHNKSxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755671615; c=relaxed/simple;
	bh=8nDM6nTHiiFML4TapApgSgfK4ngRjxpt5mSRXH+m8SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHHPzvKABeU3iy4qW3Z4tt12Yw205obnXsxU4LS55t26U1oApRqvsj+/B5zgHtO+qz9wSRohMFdeF43nk3nFL/lHQJSe381TIY6JHSWWEglmnII0jTnbchefoFw6uZ2g4YkZv3r32UAb63JopX9XULErFelc3oNNWFW53lH3j+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlE2vTHl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlE2vTHl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755671613; x=1787207613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8nDM6nTHiiFML4TapApgSgfK4ngRjxpt5mSRXH+m8SI=;
  b=nlE2vTHlh09gdxzkJrjqYfBnQZ0DsU+yfwktHvj+ZZkrrIQFcSZ1Y9kW
   I8FVbP90Ua0ygjF/pgFTMRvUSoJ397ZtyG6rs6M/gnu4gqREIpik+CnjJ
   AZ4T76/8L9dXpv3PHxR6bXVaNrePhiiY7tCb70nfOJOidZAK5MO8QyKmC
   e5o+kKdpBlQM+sRYrt8GfFmnTo+pNAndXyOCoQ8ytDcQnBQiWfJyuersf
   Y3Nha0Dm7GB4OXbtP8bnhS4lFhtEmoul2HjeYDh1cWSD0T6oohSzgzQxB
   T6U678KJ/uNoe1CGZmKECXgPt0TcMC9YxW6VwTZUIncKV4BQ7Of59vyBx
   A==;
X-CSE-ConnectionGUID: Hg99oqDaSe2nVVHGXK7pqw==
X-CSE-MsgGUID: gwLEC5dSR06l3y+4p8ovUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="83354503"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="83354503"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 23:33:33 -0700
X-CSE-ConnectionGUID: J+2z0+zBSa+b9AGtOKLM/Q==
X-CSE-MsgGUID: FtNj7xz7TNScOHGijQi/dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167549493"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 19 Aug 2025 23:33:31 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uocO0-000IHv-1e;
	Wed, 20 Aug 2025 06:33:28 +0000
Date: Wed, 20 Aug 2025 14:33:02 +0800
From: kernel test robot <lkp@intel.com>
To: adriana@arista.com, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.rg
Cc: oe-kbuild-all@lists.linux.dev, ilpo.jarvinnen@linux.intel.com,
	andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, john.ogness@linutronix.de,
	Adriana Nicolae <adriana@arista.com>
Subject: Re: [PATCH v2] serial: 8250 dw: clear FIFO before writting LCR
Message-ID: <202508201459.9CiUfUhb-lkp@intel.com>
References: <20250819191314.3452283-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819191314.3452283-1-adriana@arista.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus linus/master v6.17-rc2 next-20250819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/adriana-arista-com/serial-8250-dw-clear-FIFO-before-writting-LCR/20250820-031410
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20250819191314.3452283-1-adriana%40arista.com
patch subject: [PATCH v2] serial: 8250 dw: clear FIFO before writting LCR
config: i386-randconfig-002-20250820 (https://download.01.org/0day-ci/archive/20250820/202508201459.9CiUfUhb-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250820/202508201459.9CiUfUhb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508201459.9CiUfUhb-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/tty/serial/8250/8250_dw.c: In function 'dw8250_serial_outapb':
>> drivers/tty/serial/8250/8250_dw.c:267:17: error: too few arguments to function 'dw8250_check_lcr'
     267 |                 dw8250_check_lcr(p, value);
         |                 ^~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:155:13: note: declared here
     155 | static void dw8250_check_lcr(struct uart_port *p, unsigned int offset, u32 value)
         |             ^~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c: In function 'dw8250_quirks':
>> drivers/tty/serial/8250/8250_dw.c:571:22: error: 'DW_UART_QUIRK_DWAPB' undeclared (first use in this function); did you mean 'DW_UART_QUIRK_APB'?
     571 |         if (quirks & DW_UART_QUIRK_DWAPB) {
         |                      ^~~~~~~~~~~~~~~~~~~
         |                      DW_UART_QUIRK_APB
   drivers/tty/serial/8250/8250_dw.c:571:22: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/tty/serial/8250/8250_dw.c:574:31: error: assignment to 'void (*)(struct uart_port *, unsigned int,  u32)' {aka 'void (*)(struct uart_port *, unsigned int,  unsigned int)'} from incompatible pointer type 'void (*)(struct uart_port *, int,  int)' [-Werror=incompatible-pointer-types]
     574 |                 p->serial_out = dw8250_serial_outapb;
         |                               ^
   cc1: some warnings being treated as errors


vim +/dw8250_check_lcr +267 drivers/tty/serial/8250/8250_dw.c

   254	
   255	static void dw8250_serial_outapb(struct uart_port *p, int offset, int value)
   256	{
   257	       struct dw8250_data *d = to_dw8250_data(p->private_data);
   258	
   259		if(offset == UART_LCR && !d->uart_16550_compatible)
   260			dw8250_tx_wait_empty_apb(p);
   261	
   262		writel(value, DW8250_REG(p, offset));
   263	
   264		if (offset == UART_LCR && !d->uart_16550_compatible) {
   265			/* Check FIFO is left enabled and LCR was written */
   266			writel(UART_FCR_ENABLE_FIFO, DW8250_REG(p, UART_FCR));
 > 267			dw8250_check_lcr(p, value);
   268		}
   269	}
   270	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
