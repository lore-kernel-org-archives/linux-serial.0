Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FDE1DF271;
	Mon, 10 Nov 2025 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782535; cv=none; b=QcRLsaqs/zxm33uVEpNavjFgoiNZqcoA1uIynh3aOc9+vJKK057WtN0eck8z8yD2otGEp6KAKeCh/VcOrWJIJ/7XBCc1HVmojDUY5exDfU51/WdkOSjQsij+ovBeZmD/5zd9i+kqvMRvKkv60G4JNWNEk01cFHXL2qboNZd4xcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782535; c=relaxed/simple;
	bh=LOyAN0iO2EMSmgKDPwrtHMT6er9B+4VjQSQPgBTISus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhLwMvTZ3PdDZIx0Z9bCnps//wuPXJvVpYiZksOf3gcEBKXNebSnS6bhV3DhWJ2jEva+qhIO8sxtyxJzEbXFAp2KETXs9lB87KPLO3P7pwlqyzQY1wz7MfOTSWTek6za6kaWsaEGMztWNJQhMxwB0ej5A/2/KTyIka0rwitBC3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zxl62qE/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zxl62qE/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762782533; x=1794318533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LOyAN0iO2EMSmgKDPwrtHMT6er9B+4VjQSQPgBTISus=;
  b=Zxl62qE/F8pjfiV+uyQYleO5AnsFg2/uTYj+sRB7Fk9XbeNES4JrdZ12
   vZMyxOPzmR2nKCVhM1r11EMV4D2PXmMAyfjKJjWz3Xdk6WcdxXDYJshz4
   jbMJPBfkeNfCc/eqZVcJHAK9cJzplxEq/IIuN35q4y+HraNWIetkuAk8r
   PH9XvX8B+XXnSDhPwYNZ7FGAHE4FiQDNNq5oZTF8IwzfZmdTNsiwnsixA
   ZvkNM1Y578A84cyi3QK1aze30Qn6l9w7qvzNwz92+ND43cN7T4/x2VsV+
   jW0+nfDet2qxntYU3Czs2DL6lnL96xQzj5G0IXHdzWJSefGqVDcwEWHqR
   Q==;
X-CSE-ConnectionGUID: hRK1iNcsRsmpVOhaLzbJKg==
X-CSE-MsgGUID: SjfAveFiRkyDjqObyaMuag==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="75936348"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="75936348"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:48:53 -0800
X-CSE-ConnectionGUID: ksHDq/jlT0CyTbiAG0Kh1A==
X-CSE-MsgGUID: fTYm8Jd0R7+bZjc6v7kurQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="193060165"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 10 Nov 2025 05:48:50 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vISGF-0000UV-1e;
	Mon, 10 Nov 2025 13:48:47 +0000
Date: Mon, 10 Nov 2025 21:47:48 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, jfalempe@redhat.com,
	javierm@redhat.com, simona@ffwll.ch, airlied@gmail.com,
	mripard@kernel.org, maarten.lankhorst@linux.intel.com,
	gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/3] drm/client: Support emergency restore via sysrq for
 all clients
Message-ID: <202511102156.RRA8JQGz-lkp@intel.com>
References: <20251107142612.467817-3-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107142612.467817-3-tzimmermann@suse.de>

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20251107]
[cannot apply to drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip linus/master v6.18-rc4 v6.18-rc3 v6.18-rc2 v6.18-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Zimmermann/drm-client-Pass-force-parameter-to-client-restore/20251107-223026
base:   next-20251107
patch link:    https://lore.kernel.org/r/20251107142612.467817-3-tzimmermann%40suse.de
patch subject: [PATCH 2/3] drm/client: Support emergency restore via sysrq for all clients
config: powerpc64-randconfig-001-20251110 (https://download.01.org/0day-ci/archive/20251110/202511102156.RRA8JQGz-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 0d786b9a207aa0e6d88dde7fd9ffe0b364db69a4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251110/202511102156.RRA8JQGz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511102156.RRA8JQGz-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: duplicate symbol: drm_client_sysrq_register
   >>> defined at drm_internal.h:65 (drivers/gpu/drm/drm_internal.h:65)
   >>>            drivers/gpu/drm/drm_atomic.o:(drm_client_sysrq_register) in archive vmlinux.a
   >>> defined at drm_internal.h:65 (drivers/gpu/drm/drm_internal.h:65)
   >>>            drivers/gpu/drm/drm_auth.o:(.text+0x0) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: drm_client_sysrq_unregister
   >>> defined at drm_internal.h:67 (drivers/gpu/drm/drm_internal.h:67)
   >>>            drivers/gpu/drm/drm_atomic.o:(drm_client_sysrq_unregister) in archive vmlinux.a
   >>> defined at drm_internal.h:67 (drivers/gpu/drm/drm_internal.h:67)
   >>>            drivers/gpu/drm/drm_auth.o:(.text+0x40) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: drm_client_sysrq_register
   >>> defined at drm_internal.h:65 (drivers/gpu/drm/drm_internal.h:65)
   >>>            drivers/gpu/drm/drm_atomic.o:(drm_client_sysrq_register) in archive vmlinux.a
   >>> defined at drm_internal.h:65 (drivers/gpu/drm/drm_internal.h:65)
   >>>            drivers/gpu/drm/drm_edid.o:(.text+0x0) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: drm_client_sysrq_unregister
   >>> defined at drm_internal.h:67 (drivers/gpu/drm/drm_internal.h:67)
   >>>            drivers/gpu/drm/drm_atomic.o:(drm_client_sysrq_unregister) in archive vmlinux.a
   >>> defined at drm_internal.h:67 (drivers/gpu/drm/drm_internal.h:67)
   >>>            drivers/gpu/drm/drm_edid.o:(.text+0x40) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: drm_client_sysrq_register
   >>> defined at drm_internal.h:65 (drivers/gpu/drm/drm_internal.h:65)
   >>>            drivers/gpu/drm/drm_atomic.o:(drm_client_sysrq_register) in archive vmlinux.a
   >>> defined at drm_internal.h:65 (drivers/gpu/drm/drm_internal.h:65)
   >>>            drivers/gpu/drm/drm_encoder.o:(.text+0x0) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: drm_client_sysrq_unregister
   >>> defined at drm_internal.h:67 (drivers/gpu/drm/drm_internal.h:67)
   >>>            drivers/gpu/drm/drm_atomic.o:(drm_client_sysrq_unregister) in archive vmlinux.a
   >>> defined at drm_internal.h:67 (drivers/gpu/drm/drm_internal.h:67)
   >>>            drivers/gpu/drm/drm_encoder.o:(.text+0x40) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: drm_client_sysrq_register
   >>> defined at drm_internal.h:65 (drivers/gpu/drm/drm_internal.h:65)
   >>>            drivers/gpu/drm/drm_atomic.o:(drm_client_sysrq_register) in archive vmlinux.a
   >>> defined at drm_internal.h:65 (drivers/gpu/drm/drm_internal.h:65)
   >>>            drivers/gpu/drm/drm_file.o:(.text+0x0) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: drm_client_sysrq_unregister
   >>> defined at drm_internal.h:67 (drivers/gpu/drm/drm_internal.h:67)
   >>>            drivers/gpu/drm/drm_atomic.o:(drm_client_sysrq_unregister) in archive vmlinux.a
   >>> defined at drm_internal.h:67 (drivers/gpu/drm/drm_internal.h:67)
   >>>            drivers/gpu/drm/drm_file.o:(.text+0x40) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: drm_client_sysrq_register
   >>> defined at drm_internal.h:65 (drivers/gpu/drm/drm_internal.h:65)
   >>>            drivers/gpu/drm/drm_atomic.o:(drm_client_sysrq_register) in archive vmlinux.a
   >>> defined at drm_internal.h:65 (drivers/gpu/drm/drm_internal.h:65)
   >>>            drivers/gpu/drm/drm_framebuffer.o:(.text+0x0) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: drm_client_sysrq_unregister
   >>> defined at drm_internal.h:67 (drivers/gpu/drm/drm_internal.h:67)
   >>>            drivers/gpu/drm/drm_atomic.o:(drm_client_sysrq_unregister) in archive vmlinux.a
   >>> defined at drm_internal.h:67 (drivers/gpu/drm/drm_internal.h:67)
   >>>            drivers/gpu/drm/drm_framebuffer.o:(.text+0x40) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: drm_client_sysrq_register
   >>> defined at drm_internal.h:65 (drivers/gpu/drm/drm_internal.h:65)
   >>>            drivers/gpu/drm/drm_atomic.o:(drm_client_sysrq_register) in archive vmlinux.a
   >>> defined at drm_internal.h:65 (drivers/gpu/drm/drm_internal.h:65)
   >>>            drivers/gpu/drm/drm_gem.o:(.text+0x0) in archive vmlinux.a
..

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
