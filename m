Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D93219A76;
	Thu,  9 Jan 2025 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438302; cv=none; b=h02JFjCofQ62C4he+3KfDmMukzQYVulF+MHyJHGfQOTkFBYyXjm1G1W2k7GfzzLWo+nADnKj+2RK9jih+0Qi6BQFB92FmynTAv+FfG/JKa4LNg6nXjzQlgH6r1C7rS8yd9C+P68lx4bCmlm3NbTUz8AGN79K5OzZpTBDXjY6qjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438302; c=relaxed/simple;
	bh=u0Q3qMre0aMHaDk85LcQYX7xMhhq2kI0NBFqwqx45t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7dyyQvTVXGOf1nytlNbi6eY1t80VrAC/dcLUDwqyFoWtrsz1FsFCNBOfC2nC9oMTwcB9hjR1vdWIFZE58mNvNH1zqhc3lbbUavfcnI+PImfNNrIaC2aXASq7Tt2MXuQ5xRk72ErFBYuCc/1CB10cGSQCVwGGISKjUoqiKuogzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OoaPzjmd; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OoaPzjmd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736438301; x=1767974301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u0Q3qMre0aMHaDk85LcQYX7xMhhq2kI0NBFqwqx45t8=;
  b=OoaPzjmd2XD30JycM1srpN4H6ZtND3txLCSWo/qs/utDZ7gmko+TVR1M
   B6okt3ty3FzjufytWsAZ4qMPTypYK55l1fjEZZe0eooVwCsY1Iwt5pHsZ
   lLoNTbjNFHxEM7vgN7m/ikjW7uQ6ojaQleNi9I8H0Ei0KFSWgvwrwKZdk
   n9ARVFH6tv+I5kwjne0Ge3+ROJcRSSJMnkWa1tIFfDIagIx2IUouVC+Dg
   SyO9wQ+5t4LqQopEyA4twpSA9SxfJBxIbmX4BlKYYSnmmfKpU8PES1wdm
   1FLiYR6mniAsJB71gyk4KozVrnfsHvFZ9r2aRyeb4t6yi39763ABGxJlm
   A==;
X-CSE-ConnectionGUID: feHcTCJITmC6HLU7O0IjZg==
X-CSE-MsgGUID: EJkqkTyQRqqYYU0NfFjgQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="62084563"
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="62084563"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 07:58:20 -0800
X-CSE-ConnectionGUID: ejKYjoAETXOFREmHOzu4cw==
X-CSE-MsgGUID: ITW0uxELTgG7RqmwdaaPGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="103414324"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 09 Jan 2025 07:58:18 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVuvI-000HmZ-24;
	Thu, 09 Jan 2025 15:58:16 +0000
Date: Thu, 9 Jan 2025 23:57:29 +0800
From: kernel test robot <lkp@intel.com>
To: Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>,
	Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	fj6611ie@aa.jp.fujitsu.com
Subject: Re: [PATCH] serial: amba-pl011: Implement nbcon console
Message-ID: <202501092346.Q71aj5kq-lkp@intel.com>
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
config: arm64-randconfig-003-20250109 (https://download.01.org/0day-ci/archive/20250109/202501092346.Q71aj5kq-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250109/202501092346.Q71aj5kq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501092346.Q71aj5kq-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/tty/serial/amba-pl011.c: In function 'pl011_register_port':
>> drivers/tty/serial/amba-pl011.c:2851:25: error: implicit declaration of function 'pl011_console_switch_to_nbcon' [-Wimplicit-function-declaration]
    2851 |                         pl011_console_switch_to_nbcon(amba_reg.cons);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


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
