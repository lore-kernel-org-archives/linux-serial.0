Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743A5194A5E;
	Fri,  7 Jun 2024 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768153; cv=none; b=oBzO+YYkY0H5EqYB8CqzpNA6J7q1ke4zmolboTsLYyaQ/RIXor11u9KjKuYGK5TXq9G1Dy/zv9x48MgsqlBHBPKhWfW67W3CNL6IEAh0lLGMOCSBHsIvWyVc1iuNXo89At3sNfTKvyMEZLYv3zhjRZHGJ1SS4mfdvO22fJediHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768153; c=relaxed/simple;
	bh=KPSZpnEK85cOffft4HH+s5Xl8C3xTVIGwUsb+Bh9liA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbjVgWPebSQonqhZhvyqTr6bGcOUrGm7FUWUNVn+liQy+lyBNe/VpKUVrV0mcRdrP/LX4RELA5cSNoIbIN0PBCW230dm5Kaqu38UnTUiA1EudGGYq+H53nVz12EJ5++B+P/Yu8j3Upi09AMuHooav4s8jzjNYupr2YLjyfXu2Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOCcQgRX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOCcQgRX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717768152; x=1749304152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KPSZpnEK85cOffft4HH+s5Xl8C3xTVIGwUsb+Bh9liA=;
  b=FOCcQgRXR6uKQV6je+sdjBcDA9B0FkyIHZauBaJlEVFgNqL2hSWP+Myd
   pOrntlUg6LnfQoL3yzD4SAV1oKsYACy9IbQsVtS4F1I7n6ommaaAy3nNB
   K4KWybY/Abi8plP9fdlrkBXg+bCuXZLqEO90PYAtWXDGEVsrb952WiJ/z
   UbrkbmvR7fBo2ppJ+J2hcQV7vJoHKcTcSY6/ML0CSaWvkmOkTIkSVlYSI
   D9oM+E5CVOhOv2MDZXr7oUfQfrHLC0l9i6UiKpF8sgm/YgI/i8Bu+LQQz
   74LYiH6IzAH+x9DaOYBO7cLDBbVeaJfeXllScjnWDSJJGnDCL7xISfZ5W
   Q==;
X-CSE-ConnectionGUID: j23NaTtrSF+NeWwSePCcHg==
X-CSE-MsgGUID: r/yZRwvET+uKj53n0svfOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="31983856"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="31983856"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 06:49:12 -0700
X-CSE-ConnectionGUID: 6gXWBjRtRTCD2v+JIMzvEg==
X-CSE-MsgGUID: D2JevSG2Sl6TgLqomuPF2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="75814895"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 07 Jun 2024 06:49:11 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFZxs-0004sY-0g;
	Fri, 07 Jun 2024 13:49:08 +0000
Date: Fri, 7 Jun 2024 21:48:51 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_platform: Explicitly show we
 initialise ISA ports only once
Message-ID: <202406072102.SGp8FYYi-lkp@intel.com>
References: <20240606184841.3102545-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606184841.3102545-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next next-20240607]
[cannot apply to tty/tty-linus linus/master v6.10-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/serial-8250_platform-Explicitly-show-we-initialise-ISA-ports-only-once/20240607-025109
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20240606184841.3102545-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] serial: 8250_platform: Explicitly show we initialise ISA ports only once
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20240607/202406072102.SGp8FYYi-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406072102.SGp8FYYi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406072102.SGp8FYYi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/8250/8250_platform.o: warning: objtool: __jump_table+0x0: special: can't find orig instruction


objdump-func vmlinux.o __jump_table:

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
