Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6D21D9337;
	Wed, 15 Jan 2025 20:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736974093; cv=none; b=bxiKVHgfSAZUbFFxpbU9EXA4UTWyG5Sx25Wom2nmKC8cBFjZz9jXUYt8Sj8HCULAkrV3fgGs/w5lcVOWFIb6p34bo0iEACOZSNHvVUgvVhF5IDhjUxOmxw9hzUDXOyfgj1R+FkkvK2kVcr3TISwTWQ2o/qC2OZ9M5dQ0Snjso5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736974093; c=relaxed/simple;
	bh=NBmFqEdQWXlXOmVjvWnaHQhn5HTvwDLz7apgLNcurQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2vcNKA8a9N7PbZywemO6MMkcRHgrJNWEX7L7C1Mh79FvCZwr8/x0rHX//DxWkCryO2TGVPODU9x6I6T3iQibUmXXcabeUT3n5kR7ROdnitM3l3z5her/AHfYLJgu+GnVu+S9b+/wyIMtWxlfeCfH4LIXsCXoCUzsnv3nF5BB30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cZtYe1VQ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cZtYe1VQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736974092; x=1768510092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NBmFqEdQWXlXOmVjvWnaHQhn5HTvwDLz7apgLNcurQo=;
  b=cZtYe1VQtksWHovDATOgoJSzdyw0WxmkatYanEIKAVUqgJqoAC555oCx
   UbCa70aYmat+wfaetijxhD4vVXtbpIV3eWC2itcmh+kvf1hcxlQA4pogU
   sSSh5tRpd1BX0DosOaMXjAp9Pyq16SBTij6nZq/Wn2zC7WsU7kCW+wIbv
   fL2FokMPqGUjLPA3ZO9g2PQVvT2OFhpWTrQXkYUauneuhgffj/GmTYIZA
   BCuxKbk8lZwUw4bVRBAZZkBThO0lbEcLxUoVJGWz5q4QNF7+mDoGDDbod
   n5C0FjHOBIyyz+KFnhX+4X4oOdr6croMdcoS3S9Swink20sNApDmhkD6p
   Q==;
X-CSE-ConnectionGUID: xTRr16ufT5mHri1tbXrX9Q==
X-CSE-MsgGUID: jFEHKu00QmOR43XpxyXnhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37359035"
X-IronPort-AV: E=Sophos;i="6.13,207,1732608000"; 
   d="scan'208";a="37359035"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 12:48:11 -0800
X-CSE-ConnectionGUID: wkYOM2pFTBG7tT3+IK/nSQ==
X-CSE-MsgGUID: Wb4Ztt1ATqGwNcp3rxZurw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105102930"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 15 Jan 2025 12:48:07 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYAJ2-000Qpv-1t;
	Wed, 15 Jan 2025 20:48:04 +0000
Date: Thu, 16 Jan 2025 04:48:00 +0800
From: kernel test robot <lkp@intel.com>
To: Yenchia Chen <yenchia.chen@mediatek.com>, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	yenchia.chen@mediatek.com, yj.chiang@mediatek.com,
	tbergstrom@nvidia.com, yujiaoliang@vivo.com,
	u.kleine-koenig@baylibre.com, treapking@chromium.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] serial: 8250_mtk: Add ACPI support
Message-ID: <202501160444.iXv8byKW-lkp@intel.com>
References: <20250114033324.3533292-1-yenchia.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114033324.3533292-1-yenchia.chen@mediatek.com>

Hi Yenchia,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.13-rc7 next-20250115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yenchia-Chen/serial-8250_mtk-Add-ACPI-support/20250114-113715
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20250114033324.3533292-1-yenchia.chen%40mediatek.com
patch subject: [PATCH] serial: 8250_mtk: Add ACPI support
config: powerpc-randconfig-001-20250116 (https://download.01.org/0day-ci/archive/20250116/202501160444.iXv8byKW-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project f5cd181ffbb7cb61d582fe130d46580d5969d47a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250116/202501160444.iXv8byKW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501160444.iXv8byKW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/8250/8250_mtk.c:662:36: warning: unused variable 'mtk8250_acpi_match' [-Wunused-const-variable]
     662 | static const struct acpi_device_id mtk8250_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/mtk8250_acpi_match +662 drivers/tty/serial/8250/8250_mtk.c

   661	
 > 662	static const struct acpi_device_id mtk8250_acpi_match[] = {
   663		{ "MTKI0511", 0 },
   664		{},
   665	};
   666	MODULE_DEVICE_TABLE(acpi, mtk8250_acpi_match);
   667	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
