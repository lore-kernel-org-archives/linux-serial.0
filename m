Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DC52288EE
	for <linux-serial@vger.kernel.org>; Sat,  6 Sep 2025 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757175003; cv=none; b=Go+xEkYLnBO7I59hQV/LCAtfw0+nu6ekmJoRW0KQKwdZMKqcxufrZEEE+c7iic0PGMjxUo2WY4XrycPslxMUKI74t5DxNKi2SZJ/MaEKYLukmS7z2Feu281+/CrMUP9QDZ8HwU3TQ5gtWi2oTA8vd0yL194wgv25ojOGPM4+ss4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757175003; c=relaxed/simple;
	bh=7th8qgGEzSzr0C9MoCap3LXFSkvUNXTxlQ+Fjacr9m0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CEyiYTnftjL1fWuYPlVOSKzJuNMCDkJOqm71rJksGtnYbfLwva5PkXseZpn3EaxrpOln36FnDYh3Vn4qK6bZM9Kj7iwAaQVjP7COUcJnSg0tpyOYlpsLvhyBbEfpqjH5sNQ1F8HmUNhqqWi4C0/7wqLwMf+fTrBTxglrtTvHw6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bR+7c6P6; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bR+7c6P6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757175002; x=1788711002;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7th8qgGEzSzr0C9MoCap3LXFSkvUNXTxlQ+Fjacr9m0=;
  b=bR+7c6P6J8FDW9gfll+akQVgpZvGAkIYp2HouuflX8Iq9Hw7wg6N1If+
   QsagFBl4GsLMjJdveZiIsfqwWVNA1+Sf2x08EVHrPEnt5uiCyKZg1Yi7o
   u3KwuF07XtWrGlEXr+IJ0F03vbrb/ZvVdXDWZyjvLiHtkFfKHxM1BSgsp
   K9IewpYmMFVC7pylcgmBWnBVwjVml7VZZOafAnsmkubXPdrkQ2PaA/asu
   yarnzXy7AFCjaxZz+JRVVz4XgW3arGvVbANMOkysgR0scUy0iOG+YWu/D
   2O/2kU73+E207p2NNW/3nhGCP3Hi8gUVj+WogbmFDjKHV1XjJvUHK+s08
   A==;
X-CSE-ConnectionGUID: +UJHKcrATHiAmgYBGRZGyQ==
X-CSE-MsgGUID: nbHamUGyQJiKIlypNKK6sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="70114896"
X-IronPort-AV: E=Sophos;i="6.18,244,1751266800"; 
   d="scan'208";a="70114896"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 09:10:01 -0700
X-CSE-ConnectionGUID: 3Wt/UkVtQF2UnVlHign5yg==
X-CSE-MsgGUID: OaWGQbZqT1KrroOswEnOsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,244,1751266800"; 
   d="scan'208";a="176752082"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 06 Sep 2025 09:10:00 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuvUD-0001c1-0x;
	Sat, 06 Sep 2025 16:09:57 +0000
Date: Sun, 7 Sep 2025 00:09:51 +0800
From: kernel test robot <lkp@intel.com>
To: Seppo Takalo <seppo.takalo@nordicsemi.no>
Cc: oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 32/37] Warning: drivers/tty/n_gsm.c:4175 function
 parameter 'dlci' not described in 'gsm_modem_send_initial_msc'
Message-ID: <202509070003.ozCgvRti-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   b601e1f41edd4667062aa7cccb4e5199814979a3
commit: 3cf0b3c243e56bc43be560617416c1d9f301f44c [32/37] tty: n_gsm: Don't block input queue by waiting MSC
config: arc-randconfig-002-20250906 (https://download.01.org/0day-ci/archive/20250907/202509070003.ozCgvRti-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250907/202509070003.ozCgvRti-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509070003.ozCgvRti-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/tty/n_gsm.c:4175 function parameter 'dlci' not described in 'gsm_modem_send_initial_msc'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
