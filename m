Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EB2370
	for <linux-serial@vger.kernel.org>; Thu, 15 Aug 2024 23:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723765712; cv=none; b=NhIexVX/2TJ8/cZPt0DLrX3TJVYh6UpYk27nSXOWzB0ckL42VF3ZdmWvd8qIaCi6rwAX/zNy6PRC8iy3d2mG3PuRZFmzzKlf3trUUm1vWEsQw3yktGfUUobpsBXmLBxK0n66SX79W4WDgQUxE7/uQdWLnrZpYVf3H+e0Y6FxGcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723765712; c=relaxed/simple;
	bh=nco0XopIYLkstb+O/JeOKiguE47LuL54G2WUGMlcsuI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bQIYXbEgWTyH/vCRuSU0BBBGCeiGPiOWT28LackfsghVSkcEEpEyAMdLzU41XDnX7NIUlTiKwG449ouxJNhYKrJyViG79e5WmV01w2MJ82d0Hi3kn8O8SZaBAGsuJDVbhFxYg4KYDKLxL1qn/tB3isBnwn6PEYfSJz+0TEV8tUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuAUxSXW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuAUxSXW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723765711; x=1755301711;
  h=date:from:to:cc:subject:message-id;
  bh=nco0XopIYLkstb+O/JeOKiguE47LuL54G2WUGMlcsuI=;
  b=iuAUxSXW8/g2Rve1Q9jIIf9YOoduNG+9ZSSn0TCSqCIB1AKzqa9UxVBJ
   03c9vYnEV3EgdbY9+d62A2ceETA4gKWe+jcWaHuTZm+hmAKsq3XtLVHc5
   RGt/yo85XEW5jOzzyoOh31+3+7PvlUkCgvvSdYARFeEwTKag47MljUgF9
   JK1cEuBO1pLM3aRqs19NhBnUc+8zvfev/ymc650tYYv+8DXywbF+ginEz
   uifr6gY2zzo7X1weABOx9rErK+ZszaRoQQryZMYPLC7khj02uhj9tD2XN
   60dUWcGC3G0/d2EN/JnqJBaft58vg0xMN9U3tK+7JoDOJKAUxFyc90bO+
   w==;
X-CSE-ConnectionGUID: ziV4qJWPSfmYZm8rx8iBKg==
X-CSE-MsgGUID: E/DeafcORZugCAfG/NVZFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="25917961"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="25917961"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 16:48:30 -0700
X-CSE-ConnectionGUID: LdxTDuq3T4q2Sm0mcKUMUA==
X-CSE-MsgGUID: mbVfaNZqTHiKciGDUq4OCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="59503352"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 15 Aug 2024 16:48:29 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sekCg-0005ik-3D;
	Thu, 15 Aug 2024 23:48:27 +0000
Date: Fri, 16 Aug 2024 07:48:05 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 0863bffda1131fd2fa9c05b653ad9ee3d8db127e
Message-ID: <202408160703.swjZ5kiX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 0863bffda1131fd2fa9c05b653ad9ee3d8db127e  Revert "serial: 8250_omap: Set the console genpd always on if no console suspend"

elapsed time: 1047m

configs tested: 150
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arm                              alldefconfig   gcc-14.1.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                        clps711x_defconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240815   gcc-12
i386         buildonly-randconfig-002-20240815   clang-18
i386         buildonly-randconfig-002-20240815   gcc-12
i386         buildonly-randconfig-003-20240815   clang-18
i386         buildonly-randconfig-003-20240815   gcc-12
i386         buildonly-randconfig-004-20240815   clang-18
i386         buildonly-randconfig-004-20240815   gcc-12
i386         buildonly-randconfig-005-20240815   clang-18
i386         buildonly-randconfig-005-20240815   gcc-12
i386         buildonly-randconfig-006-20240815   clang-18
i386         buildonly-randconfig-006-20240815   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240815   gcc-12
i386                  randconfig-002-20240815   clang-18
i386                  randconfig-002-20240815   gcc-12
i386                  randconfig-003-20240815   clang-18
i386                  randconfig-003-20240815   gcc-12
i386                  randconfig-004-20240815   gcc-12
i386                  randconfig-005-20240815   gcc-12
i386                  randconfig-006-20240815   gcc-12
i386                  randconfig-011-20240815   clang-18
i386                  randconfig-011-20240815   gcc-12
i386                  randconfig-012-20240815   clang-18
i386                  randconfig-012-20240815   gcc-12
i386                  randconfig-013-20240815   gcc-12
i386                  randconfig-014-20240815   clang-18
i386                  randconfig-014-20240815   gcc-12
i386                  randconfig-015-20240815   clang-18
i386                  randconfig-015-20240815   gcc-12
i386                  randconfig-016-20240815   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                  cavium_octeon_defconfig   gcc-14.1.0
mips                           ci20_defconfig   gcc-14.1.0
mips                  decstation_64_defconfig   gcc-14.1.0
mips                          malta_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                        cell_defconfig   gcc-14.1.0
powerpc                     sequoia_defconfig   gcc-14.1.0
powerpc                     tqm8548_defconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                 kfr2r09-romimage_defconfig   gcc-14.1.0
sh                          kfr2r09_defconfig   gcc-14.1.0
sh                      rts7751r2d1_defconfig   gcc-14.1.0
sh                           se7750_defconfig   gcc-14.1.0
sh                   sh7724_generic_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc64_defconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240815   gcc-12
x86_64       buildonly-randconfig-002-20240815   gcc-12
x86_64       buildonly-randconfig-003-20240815   gcc-12
x86_64       buildonly-randconfig-004-20240815   gcc-12
x86_64       buildonly-randconfig-005-20240815   gcc-12
x86_64       buildonly-randconfig-006-20240815   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240815   gcc-12
x86_64                randconfig-002-20240815   gcc-12
x86_64                randconfig-003-20240815   gcc-12
x86_64                randconfig-004-20240815   gcc-12
x86_64                randconfig-005-20240815   gcc-12
x86_64                randconfig-006-20240815   gcc-12
x86_64                randconfig-011-20240815   gcc-12
x86_64                randconfig-012-20240815   gcc-12
x86_64                randconfig-013-20240815   gcc-12
x86_64                randconfig-014-20240815   gcc-12
x86_64                randconfig-015-20240815   gcc-12
x86_64                randconfig-016-20240815   gcc-12
x86_64                randconfig-071-20240815   gcc-12
x86_64                randconfig-072-20240815   gcc-12
x86_64                randconfig-073-20240815   gcc-12
x86_64                randconfig-074-20240815   gcc-12
x86_64                randconfig-075-20240815   gcc-12
x86_64                randconfig-076-20240815   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
