Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6712206B7;
	Thu,  9 Jan 2025 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439093; cv=none; b=rEX9JJrY2qLeDfG/IJHJHKqNwRjhqovJLiRHNF+rtxnA6D4QNbqB3qZJmTmpZDCt5qkTPRfW6Es+POsLoIe3m0fX5BCei6Hd8r1QoqrrUOm85buzMUlwqTj0iiafpWbRfQ7K9u7+rYRJbu7PpNVAsj3e2e6+xA8hZWd//R9TlSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439093; c=relaxed/simple;
	bh=Emqtas35W+tRsMR+yz4iHAA5AcQzA9KyA6DL+J/Iba0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhCkE8pyiGvzeCVDiuFEcu7Nr7/XFQIFCJeDgMApEP4KjPhKMvZak/KqkK4Vbt7bzsONwDKlS0MVFXWhjgv+gYh+MfzJ0o6lKtCV+8ek0Imfx5Y63sejfjd8TBrX7bg1d+wSLR++JOU5czM27QnJgJtqL4hDwEoUVsZR6nsnHNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P57MYNCT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P57MYNCT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736439092; x=1767975092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Emqtas35W+tRsMR+yz4iHAA5AcQzA9KyA6DL+J/Iba0=;
  b=P57MYNCT0nJ/zTTiukr5+JMnSzp4yrjFDY/b2maum3RzCtjrHHQBTpnQ
   C3nn26s+3yxDxXfsLMUq1LzCuiaKc4BgapHx1peKrpghem+yplRcnH0NX
   j110dFJhfB/YGcaU0J3CIMYP/zhAjfIAvsbVAe1HQIB3Xwz7Pp8IRMHKr
   YxAqvD2KB310aIjOp7cnQnrRN6nmCRvh7qw4Oz1OCz6To/MLzUEQx0H/r
   Dkghqq6g26SBFXO+hdNHJhX83hlYQrukhGw0840REU9ffVUtN1Br/NONc
   jNEdwf247h2nSDuDh6KxOKINEDjCA5hogwQim3swrS0kheb2/CvMcg6Ke
   w==;
X-CSE-ConnectionGUID: 7zwf9t+nShSk8OQ3a+JaJA==
X-CSE-MsgGUID: SQ1quZ4USKmNUeZURnO8Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="47286540"
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="47286540"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 08:11:29 -0800
X-CSE-ConnectionGUID: t7AQ2IhHQ4ifJgb5sRam5A==
X-CSE-MsgGUID: 40E7aMoRT8+QB5GezzapYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="103257370"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 Jan 2025 08:11:27 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVv80-000Hnf-00;
	Thu, 09 Jan 2025 16:11:24 +0000
Date: Fri, 10 Jan 2025 00:10:25 +0800
From: kernel test robot <lkp@intel.com>
To: Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>,
	Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, fj6611ie@aa.jp.fujitsu.com
Subject: Re: [PATCH] serial: amba-pl011: Implement nbcon console
Message-ID: <202501092316.bZPuAcFC-lkp@intel.com>
References: <20250108004730.2302996-1-fj6611ie@aa.jp.fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108004730.2302996-1-fj6611ie@aa.jp.fujitsu.com>

Hi Toshiyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-linus]
[also build test ERROR on usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.13-rc6]
[cannot apply to tty/tty-testing tty/tty-next next-20250109]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Toshiyuki-Sato/serial-amba-pl011-Implement-nbcon-console/20250108-085122
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
patch link:    https://lore.kernel.org/r/20250108004730.2302996-1-fj6611ie%40aa.jp.fujitsu.com
patch subject: [PATCH] serial: amba-pl011: Implement nbcon console
config: arm64-randconfig-002-20250109 (https://download.01.org/0day-ci/archive/20250109/202501092316.bZPuAcFC-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project f5cd181ffbb7cb61d582fe130d46580d5969d47a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250109/202501092316.bZPuAcFC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501092316.bZPuAcFC-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/tty/serial/amba-pl011.c:30:
   In file included from include/linux/amba/bus.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/tty/serial/amba-pl011.c:2851:4: error: call to undeclared function 'pl011_console_switch_to_nbcon'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2851 |                         pl011_console_switch_to_nbcon(amba_reg.cons);
         |                         ^
   3 warnings and 1 error generated.


vim +/pl011_console_switch_to_nbcon +2851 drivers/tty/serial/amba-pl011.c

  2839	
  2840	static int pl011_register_port(struct uart_amba_port *uap)
  2841	{
  2842		int ret, i;
  2843	
  2844		/* Ensure interrupts from this UART are masked and cleared */
  2845		pl011_write(0, uap, REG_IMSC);
  2846		pl011_write(0xffff, uap, REG_ICR);
  2847	
  2848		if (!amba_reg.state) {
  2849			/* Replaces the console descriptor if NBCON is selected. */
  2850			if (amba_reg.cons && use_nbcon)
> 2851				pl011_console_switch_to_nbcon(amba_reg.cons);
  2852	
  2853			ret = uart_register_driver(&amba_reg);
  2854			if (ret < 0) {
  2855				dev_err(uap->port.dev,
  2856					"Failed to register AMBA-PL011 driver\n");
  2857				for (i = 0; i < ARRAY_SIZE(amba_ports); i++)
  2858					if (amba_ports[i] == uap)
  2859						amba_ports[i] = NULL;
  2860				return ret;
  2861			}
  2862		}
  2863	
  2864		ret = uart_add_one_port(&amba_reg, &uap->port);
  2865		if (ret)
  2866			pl011_unregister_port(uap);
  2867	
  2868		return ret;
  2869	}
  2870	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
