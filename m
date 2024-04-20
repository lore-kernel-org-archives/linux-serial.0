Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23108205E36
	for <linux-serial@vger.kernel.org>; Sat, 20 Apr 2024 22:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713651733; cv=none; b=hopszUkgi8fi6/k1kCqEsy/F5eawH7kz29g2OLUfxHd49cWelBhX/Rz5DwIQCGg6wK4Lo36uZwMqzyK//DqsXPB/GvnDM+uEyLjW/HGbCVAV9etcLc+dEEbjfqySJqMhnkF9yCZQvm9dLIifzRTcMr2Cke31niqULaGosJ2F5Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713651733; c=relaxed/simple;
	bh=+Df7jcPb5tobLCnqgEyLBOLKrkr5oMUWRdY6y7v54Io=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IPfG4hfSIG1luFcZibB1HZ393rpyOMOSeJJ8KvEMK/U87q9EMEmOV5Ujtva6LjpMrG+fW/INBaM55YQn0XIVX7sEyIJnYivkI4Iu/ysgGeFRHgWUbenPHRfxwH0PmgDrcxG9h2n4ud+DfdC7tr0XnnPFjLIpVsGXHQLOG5xKo6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fmXRE9Sn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fmXRE9Sn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713651732; x=1745187732;
  h=date:from:to:cc:subject:message-id;
  bh=+Df7jcPb5tobLCnqgEyLBOLKrkr5oMUWRdY6y7v54Io=;
  b=fmXRE9SnoxuUTkyROBg93gqGzFmjcDBTtqKfb4V4XkSa2lKQz0zYV7qu
   AHhyOQMgHrQQiP95ML6Ap23Pw3tB0nw3hTsyaVR0pjlAmKnkL4xEvgqJU
   bIQOguUUQ/kTecpproPcfCMlSkkWUZwSawyV+DXFiJ7pQso+Olw0+PfAb
   Hm3DgKdtTnLLYVGeA84tPDs1+8BGiZMlNwHY/tNqcig76U/QV1Z4oIIJp
   l26s5h3ufcv9bWoRVjnej+WuFcTJ5ju2L5i2c7xj8njAJydbLUFCvg2HP
   Q39oIUQeEb61bzLlSmbLWySrtNZvy/pibYClRkuo4YYDkcDW/llBAzXUg
   w==;
X-CSE-ConnectionGUID: BtpuYo1MRV636v5zbtsPVQ==
X-CSE-MsgGUID: kktYla0RQ6S25sDRdOIHew==
X-IronPort-AV: E=McAfee;i="6600,9927,11050"; a="19782718"
X-IronPort-AV: E=Sophos;i="6.07,217,1708416000"; 
   d="scan'208";a="19782718"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2024 15:22:11 -0700
X-CSE-ConnectionGUID: 5BMqh+5qSb2Wpux3Mizuww==
X-CSE-MsgGUID: TKaQlpYNRFeruRy33wcIuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,217,1708416000"; 
   d="scan'208";a="24176909"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 20 Apr 2024 15:22:09 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ryJ5y-000BX6-0x;
	Sat, 20 Apr 2024 22:22:06 +0000
Date: Sun, 21 Apr 2024 06:21:06 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 f70f95b485d78838ad28dbec804b986d11ad7bb0
Message-ID: <202404210603.rJIcJdUb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: f70f95b485d78838ad28dbec804b986d11ad7bb0  serial: msm: check dma_map_sg() return value properly

elapsed time: 967m

configs tested: 165
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240420   gcc  
arc                   randconfig-002-20240420   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240420   gcc  
arm                   randconfig-002-20240420   gcc  
arm                   randconfig-003-20240420   clang
arm                   randconfig-004-20240420   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240420   clang
arm64                 randconfig-002-20240420   clang
arm64                 randconfig-003-20240420   gcc  
arm64                 randconfig-004-20240420   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240420   gcc  
csky                  randconfig-002-20240420   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240420   clang
hexagon               randconfig-002-20240420   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240420   gcc  
i386         buildonly-randconfig-002-20240420   clang
i386         buildonly-randconfig-003-20240420   gcc  
i386         buildonly-randconfig-004-20240420   gcc  
i386         buildonly-randconfig-005-20240420   gcc  
i386         buildonly-randconfig-006-20240420   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240420   clang
i386                  randconfig-002-20240420   gcc  
i386                  randconfig-003-20240420   gcc  
i386                  randconfig-004-20240420   gcc  
i386                  randconfig-005-20240420   clang
i386                  randconfig-006-20240420   gcc  
i386                  randconfig-011-20240420   clang
i386                  randconfig-012-20240420   clang
i386                  randconfig-013-20240420   clang
i386                  randconfig-014-20240420   clang
i386                  randconfig-015-20240420   clang
i386                  randconfig-016-20240420   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240420   gcc  
loongarch             randconfig-002-20240420   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240420   gcc  
nios2                 randconfig-002-20240420   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240420   gcc  
parisc                randconfig-002-20240420   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240420   gcc  
powerpc               randconfig-002-20240420   clang
powerpc               randconfig-003-20240420   clang
powerpc64             randconfig-001-20240420   clang
powerpc64             randconfig-002-20240420   gcc  
powerpc64             randconfig-003-20240420   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240420   clang
riscv                 randconfig-002-20240420   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240420   clang
s390                  randconfig-002-20240420   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240420   gcc  
sh                    randconfig-002-20240420   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240420   gcc  
sparc64               randconfig-002-20240420   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240420   clang
um                    randconfig-002-20240420   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240420   gcc  
x86_64       buildonly-randconfig-002-20240420   clang
x86_64       buildonly-randconfig-003-20240420   gcc  
x86_64       buildonly-randconfig-004-20240420   gcc  
x86_64       buildonly-randconfig-005-20240420   clang
x86_64       buildonly-randconfig-006-20240420   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240420   clang
x86_64                randconfig-002-20240420   clang
x86_64                randconfig-003-20240420   gcc  
x86_64                randconfig-004-20240420   clang
x86_64                randconfig-005-20240420   clang
x86_64                randconfig-006-20240420   gcc  
x86_64                randconfig-011-20240420   gcc  
x86_64                randconfig-012-20240420   gcc  
x86_64                randconfig-013-20240420   gcc  
x86_64                randconfig-014-20240420   gcc  
x86_64                randconfig-015-20240420   clang
x86_64                randconfig-016-20240420   gcc  
x86_64                randconfig-071-20240420   gcc  
x86_64                randconfig-072-20240420   gcc  
x86_64                randconfig-073-20240420   gcc  
x86_64                randconfig-074-20240420   gcc  
x86_64                randconfig-075-20240420   gcc  
x86_64                randconfig-076-20240420   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240420   gcc  
xtensa                randconfig-002-20240420   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
