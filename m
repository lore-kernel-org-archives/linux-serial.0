Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1CA29B0;
	Sat, 26 Apr 2025 04:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745642859; cv=none; b=KBtTWA5wjUgMpV8zDa0HNDH8KVlq4xexcrGkI8yE20UUxA57MXThAWwZ+WNyf2lWqn63Bps87hUmEMPzBfF8w+g4hG1hAG2eDHrQd26oYfyT1+r45niJUJ0vjt0fUJgpU1u9itP7Oiqe/plCkONPHgEJxUEWqKv/TFfIXmBhI+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745642859; c=relaxed/simple;
	bh=Pwj2pD0Y5iJR/YgIKVz2ShrUKt3/7MLRgBv+br9tb80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2/GVUIDt4hCx+3XSBh5PZyGQTf0pPZs+20X4OpC38YpOkTcvZdM4OG6Vk4rh6hOAVB058/GMqil24SD/9Nq4a/6SBJjEyvVKPy7FjtfapSAwvszMFaiEmPAaZedYwRpMm+12nVTGe9eX3JZSGzA8xUHPoHB1gtV6yW1hukOW/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TCTG3cXT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TCTG3cXT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745642856; x=1777178856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pwj2pD0Y5iJR/YgIKVz2ShrUKt3/7MLRgBv+br9tb80=;
  b=TCTG3cXTndX3djbAkLuijIZ4Zd7DhB9Br6ugFTkLFEWXJ0KhMAd/KgJr
   8IZt0RhTv+pbwiJ8sWkzJ0+kVsopB11ENTniz2Fhv6/0QOaYEFCZKPjbQ
   kM1PrM5gJuBpzs2vCsN054Fm3MxUGjtDqW38QO8vJASro4Nuu5S0O/RGg
   Jk5iTnwTaIKDRJ1z/ZF2x/picUpgV3q+7X+/2pZZG+BUT5bc2LquynvHf
   kTBhJnWY8cvD2ZqWf3poTjTkVODJZ0yySDpsdFtZ23+lkgYen+0hAvMpQ
   2AnGIVdluZAMYl1b0GMF/lZcAFvhYIM8+j/xYXQQM0FOYvwGKK2CAp4Rv
   A==;
X-CSE-ConnectionGUID: 1GqAV/KWSRKvcs7RJoL+HQ==
X-CSE-MsgGUID: /Xywdna1T5KRdMNk4bX5PA==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="64836051"
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="64836051"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 21:47:35 -0700
X-CSE-ConnectionGUID: v6lAdVMuR3S8iK9FVPvOhw==
X-CSE-MsgGUID: 1Ev+ij+nRgWV74SWSDegzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="133377135"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 25 Apr 2025 21:47:31 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u8XRp-0005hR-0Y;
	Sat, 26 Apr 2025 04:47:29 +0000
Date: Sat, 26 Apr 2025 12:47:09 +0800
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
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4 2/4] serial: 8250: introduce serial8250_discard_data()
Message-ID: <202504261249.RVGiOFHl-lkp@intel.com>
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
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250426/202504261249.RVGiOFHl-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250426/202504261249.RVGiOFHl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504261249.RVGiOFHl-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/tty/serial/8250/8250_port.c: In function 'serial8250_get_poll_char':
>> drivers/tty/serial/8250/8250_port.c:2146:39: error: 'flags' undeclared (first use in this function)
    2146 |         uart_port_lock_irqsave(port, &flags);
         |                                       ^~~~~
   drivers/tty/serial/8250/8250_port.c:2146:39: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/tty/serial/8250/8250_port.c:2151:1: warning: label 'out' defined but not used [-Wunused-label]
    2151 | out:
         | ^~~


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
> 2151	out:
  2152		serial8250_rpm_put(up);
  2153		return status;
  2154	}
  2155	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
