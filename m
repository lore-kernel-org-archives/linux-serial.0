Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535CC8F58;
	Sun, 12 Jan 2025 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736687054; cv=none; b=oBgiDLGhvjYB/mW5C+ipAW1XYYTC0tDAwkpHcWOtpSew6N43gZbBCYSZbN0kQ3RMIc/f68IhTAdwIQL4Ib7KGSXwsu/yhB+blEi6udbnFMWo5s8B+balqyZ88TaNpj7vBnJwBZNJRXjVk/743O4W6ZvPYEF/GsgAtS5d2dPkgZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736687054; c=relaxed/simple;
	bh=Hn3dydyfTlJbV5r1Av3VGoNL6Ugia52Cv5EnLxMPhzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9uyulZd80p9Ty+KdiBmjcjH9rBmH74gOCm+1K/oNiUZ0iVfx8tmgGCDR3CX4rE9M0Az+CrFcScb3lnjmGivOiaCDSTHvmJ/HZDGGFt/cKWCGEC2hh0qntDaIs2ZLL8ht0GiASduLvIF66MCmCUcwKogWJlfh3Exk+e+n2o7nfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIdZuInt; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIdZuInt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736687052; x=1768223052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hn3dydyfTlJbV5r1Av3VGoNL6Ugia52Cv5EnLxMPhzA=;
  b=GIdZuIntZiV6BwD4F4Uc1i8bUec2BOAfJMdahhnYhsRIyK98hk/m1WFT
   HTHohefbGbIS39SSCsKoIsaNygV+hmuUYbqBMO0HUaKypuaG72tVNmbSn
   SoCHNjgJ240vm4AhyFdvg+OEeNwfi4+H2vnDEADLusXHMqODbHzPpjhUa
   MTF2Q8cR0ZsYCgMIK/aUvu6lcA9VoYrp3qy6rBHss0PFJgkMxzk80zO/X
   13Kn7Z2sGyRjuDU1wI/X9lHnoRyr26Gz5Q0wn6ORHSW9zcp3NB0Z8PToq
   AURh/wrzk4suspWnG2g2vJ76AEXRziWzwTeZw4oEJCwz3uIwbWqdSV5Yh
   A==;
X-CSE-ConnectionGUID: QxhasGnMQCuhF2rkDczM/g==
X-CSE-MsgGUID: T/khm9bLTLWOZxgCYmr56A==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="54470058"
X-IronPort-AV: E=Sophos;i="6.12,309,1728975600"; 
   d="scan'208";a="54470058"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 05:04:11 -0800
X-CSE-ConnectionGUID: wzfyStBZT1aaQyCd1kyJfg==
X-CSE-MsgGUID: PSWINvAtRp6E2G9/eHURDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,309,1728975600"; 
   d="scan'208";a="104129280"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 12 Jan 2025 05:04:10 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWxdP-000Ly7-2g;
	Sun, 12 Jan 2025 13:04:07 +0000
Date: Sun, 12 Jan 2025 21:04:02 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Larsson <benjamin.larsson@genexis.eu>,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ansuelsmth@gmail.com, lorenzo@kernel.org,
	krzk@kernel.org, gregkh@linuxfoundation.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>
Subject: Re: [PATCH 2/2] serial: Airoha SoC UART and HSUART support
Message-ID: <202501122042.DwBZgyJe-lkp@intel.com>
References: <20250111132250.3642694-3-benjamin.larsson@genexis.eu>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111132250.3642694-3-benjamin.larsson@genexis.eu>

Hi Benjamin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus linus/master v6.13-rc6 next-20250110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Larsson/dt-bindings-serial-8250-Add-Airoha-compatibles/20250111-212544
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20250111132250.3642694-3-benjamin.larsson%40genexis.eu
patch subject: [PATCH 2/2] serial: Airoha SoC UART and HSUART support
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20250112/202501122042.DwBZgyJe-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250112/202501122042.DwBZgyJe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501122042.DwBZgyJe-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/8250/8250_airoha.c:48: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * airoha8250_set_baud_rate() baud rate calculation routine


vim +48 drivers/tty/serial/8250/8250_airoha.c

    46	
    47	/**
  > 48	 * airoha8250_set_baud_rate() baud rate calculation routine
    49	 * @port: uart port
    50	 * @baud: requested uart baud rate
    51	 * @hs: uart type selector, 0 for regular uart and 1 for high-speed uart
    52	 *
    53	 */
    54	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
