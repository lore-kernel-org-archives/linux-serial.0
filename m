Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E911C02
	for <linux-serial@vger.kernel.org>; Sun,  5 May 2024 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714894915; cv=none; b=iX5ElbCW7R6A058Zy37FmcJhQ9OLU/ycmcCSxJBPI262Sbbmg0hiGsGgJz641NyUH+Tgs52nzoSnV1jKz6QsvmMB412oDRjoRaA1lIpvfrL3b3HttbQiio0rjtnUZwhdnDUvBBVF5b2S1MZjwY9dQHUuT9Qn+ER/1VyyK+Chdlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714894915; c=relaxed/simple;
	bh=h2jUpfquVBHERazRXAkhXoTXTT+iH6+n/cM6RtUgXlo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=t8P/cKAUXwYNrZ62Qg2tpRZDtDDldmuMAZjY4xoeEJXHrackTBSLNVImP+d6B66zU2ETCNLxGBupuKUVmc6gddSFytIWGpC7AIh5vMub9vGj/3mstYjmrX3ZPZDpf0VGQWsngkVQbMBPbznYz8Wlr36usrlu3ixlMtRnUENhaps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EFKVWgqD; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EFKVWgqD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714894913; x=1746430913;
  h=date:from:to:cc:subject:message-id;
  bh=h2jUpfquVBHERazRXAkhXoTXTT+iH6+n/cM6RtUgXlo=;
  b=EFKVWgqDzM+61ty1Tlae+YPjLiKyzonm0S9mDEi7EsWRzdpi0lV4pan8
   hFP5GOK1oh/6XPu2WCdM51Keu4Troa1JfLLHTdHX+GirVasr/hxI5XeJX
   ppwGzmJmUN6ILIyNhjyXYhpiiOnvCtcRYTpLnwhQ7M67nBdoT8aSYyIWg
   KzJ7VjbfgPfZiXiFgCAPANCPjVkfA1Vxx9RkkpEiWWlLs+/njHUnqgI3W
   j1PvS/d5BwlPHnvRL+V0iynDDDnPzkxRZ36OzzvKCMIPiWysd36JlBc1i
   Tw8oFvDdlCC6ZIqUiw3zDkq95wAHrXIj89s4q0uQ9G1t+JlB8UCDKNCWf
   w==;
X-CSE-ConnectionGUID: ZLWaS0uYT02J9KhOLQqwjg==
X-CSE-MsgGUID: Af0UJ9GGQ8WqA0czG/qJWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10487205"
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="10487205"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2024 00:41:51 -0700
X-CSE-ConnectionGUID: En5kjTiHRrmRs+jGSnFLpg==
X-CSE-MsgGUID: u5yjGG7kSvOrl7mhEbyrAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="27922042"
Received: from lkp-server01.sh.intel.com (HELO 123fad1cf874) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 05 May 2024 00:41:50 -0700
Received: from kbuild by 123fad1cf874 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s3WVI-00003Y-08;
	Sun, 05 May 2024 07:41:48 +0000
Date: Sun, 05 May 2024 15:41:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 6bd23e0c2bb6c65d4f5754d1456bc9a4427fc59b
Message-ID: <202405051533.UJI2w4mX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 6bd23e0c2bb6c65d4f5754d1456bc9a4427fc59b  tty: add the option to have a tty reject a new ldisc

elapsed time: 876m

configs tested: 147
configs skipped: 4

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
arc                   randconfig-001-20240505   gcc  
arc                   randconfig-002-20240505   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240505   clang
arm                   randconfig-002-20240505   gcc  
arm                   randconfig-003-20240505   gcc  
arm                   randconfig-004-20240505   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240505   clang
arm64                 randconfig-002-20240505   clang
arm64                 randconfig-003-20240505   clang
arm64                 randconfig-004-20240505   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240505   gcc  
csky                  randconfig-002-20240505   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240505   clang
hexagon               randconfig-002-20240505   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240505   clang
i386         buildonly-randconfig-002-20240505   clang
i386         buildonly-randconfig-003-20240505   clang
i386         buildonly-randconfig-004-20240505   gcc  
i386         buildonly-randconfig-005-20240505   clang
i386         buildonly-randconfig-006-20240505   clang
i386                                defconfig   clang
i386                  randconfig-001-20240505   clang
i386                  randconfig-002-20240505   clang
i386                  randconfig-003-20240505   gcc  
i386                  randconfig-005-20240505   gcc  
i386                  randconfig-006-20240505   gcc  
i386                  randconfig-011-20240505   gcc  
i386                  randconfig-012-20240505   gcc  
i386                  randconfig-013-20240505   clang
i386                  randconfig-014-20240505   gcc  
i386                  randconfig-015-20240505   gcc  
i386                  randconfig-016-20240505   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240505   gcc  
loongarch             randconfig-002-20240505   gcc  
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
nios2                 randconfig-001-20240505   gcc  
nios2                 randconfig-002-20240505   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240505   gcc  
parisc                randconfig-002-20240505   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240505   gcc  
powerpc               randconfig-002-20240505   clang
powerpc               randconfig-003-20240505   clang
powerpc64             randconfig-001-20240505   gcc  
powerpc64             randconfig-002-20240505   clang
powerpc64             randconfig-003-20240505   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240505   clang
riscv                 randconfig-002-20240505   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240505   gcc  
s390                  randconfig-002-20240505   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240505   gcc  
sh                    randconfig-002-20240505   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240505   gcc  
sparc64               randconfig-002-20240505   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240505   gcc  
um                    randconfig-002-20240505   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240505   gcc  
x86_64       buildonly-randconfig-002-20240505   clang
x86_64       buildonly-randconfig-003-20240505   clang
x86_64       buildonly-randconfig-004-20240505   clang
x86_64       buildonly-randconfig-005-20240505   gcc  
x86_64       buildonly-randconfig-006-20240505   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240505   clang
x86_64                randconfig-002-20240505   gcc  
x86_64                randconfig-003-20240505   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240505   gcc  
xtensa                randconfig-002-20240505   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
