Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82B3DB625;
	Mon, 31 Aug 2026 08:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164783; cv=none; b=dgBG7SF+De4B3fzzEep7UnMFEI2kjy1yqSPsjoNlGpUSELWDoPfKY8+ZtbiSMCur/tGZIf4ccBBiPInDXHHOW2NY8fuZ9sNpFTIDxQfKRcPhlngupUynoqnLwEzStT4O9WPyNY4AH1ZS6QCYZR7dvWT7BfSAJU/vbcUEKN4Z+mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164783; c=relaxed/simple;
	bh=Wl239s/AM/Sr8vhO/IDHQFgREfJt5DhgmCR6RGQN63k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsqgpfP5ZQuxAw4SqEpU955tOInVf+dpWjVvyCWdUlXkVuouGxRD36Blth8fyMpAIWnykbA7jv3D+JueO41bFnz8QJcQYXO2Mbq1rJ1LgwB9/tnl9g6jPb0lhyT6kgXCDUhhMM44grNrKTu47pWKsY/y1VBdZ98qilAdK1IvAxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O3GRprwv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O3GRprwv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788164782; x=1819700782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wl239s/AM/Sr8vhO/IDHQFgREfJt5DhgmCR6RGQN63k=;
  b=O3GRprwvTlIc5oSIXLh/OKsnVpHleegd7Pn3N3IaWTTqbnrNz0ZEPRcD
   M+kVH/HNxBRbTy+t3mr4bpyj9C4B13oSLWt0UBqY17Bm4X6UNm5rULJ7h
   mWBVGfUhWANjc5C3Mg8+V2l2WLMFX5VdhkEyV6tCf23vlNZ6dfqlwEtOA
   1eF8ji/3odXA+09++/UrvjIXyet2c4JA5fa3YkqtIY6UmgUPAX/Ern4WE
   ZKAJFw389AGnc7ySqQDCHwAqYrfPzxl3dxVLB45yjil2c4h4FXk6gWGOY
   kmaXcNJGJCab7RoJCyJI07R4tA0Z+j0pQL0/q4V8ICruxXrnblKXQuujl
   w==;
X-CSE-ConnectionGUID: iZCMdPgRTtO2v2ITALgzDw==
X-CSE-MsgGUID: Vpjf8i0oR1S5+IraWpbdWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="99916926"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="99916926"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 01:26:21 -0700
X-CSE-ConnectionGUID: PpWLn4f2Q86PSomyiiInEA==
X-CSE-MsgGUID: HPMMGgMETXmDjjzTVFde2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="262606057"
Received: from lkp-server01.sh.intel.com (HELO 78edef60ff5d) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 31 Aug 2026 01:26:19 -0700
Received: from kbuild by 78edef60ff5d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x0xLM-000000000A3-4BVd;
	Mon, 31 Aug 2026 08:26:16 +0000
Date: Mon, 31 Aug 2026 16:25:23 +0800
From: kernel test robot <lkp@intel.com>
To: Tate Whiteberg <whiteberg@arista.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Tate Whiteberg <whiteberg@arista.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_mid: wait for LSR tx empty before setting
 termios
Message-ID: <202608311414.nybi87OD-lkp@intel.com>
References: <20260828144617.1210599-2-whiteberg@arista.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828144617.1210599-2-whiteberg@arista.com>

Hi Tate,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master next-20260828]
[cannot apply to v7.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tate-Whiteberg/serial-8250_mid-wait-for-LSR-tx-empty-before-setting-termios/20260828-144517
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20260828144617.1210599-2-whiteberg%40arista.com
patch subject: [PATCH] serial: 8250_mid: wait for LSR tx empty before setting termios
config: alpha-randconfig-r073-20260829 (https://download.01.org/0day-ci/archive/20260831/202608311414.nybi87OD-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 8.5.0
smatch: v0.5.0-9187-g5189e3fb
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260831/202608311414.nybi87OD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608311414.nybi87OD-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux: 'saved_config' is COMMON symbol
>> WARNING: modpost: drivers/tty/serial/8250/8250_mid.ko: module uses symbol 'serial8250_wait_for_xmitr' from namespace 'SERIAL_8250', but does not import it.

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
