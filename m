Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDFC8C1F
	for <linux-serial@vger.kernel.org>; Thu, 18 Apr 2024 04:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713413411; cv=none; b=Kta2VkKXx5DChVmt2pznDcEwGzQfN2e9uc2bADyEg55SJ+pzIdHvax7Pp/IOWha9XVTzN+M9YULxzE8DlvwA+C7Ugj4rxoSi9FHoLEhTbRK41z7rU66O9WwUJ4Qwo35SMH4mgOYaXpoOhZp6btfm548euDGnFlckLIGi5vo3J0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713413411; c=relaxed/simple;
	bh=KUmyiv4RPTRu8xXyPhFeYOnwp1bqf0OjBZNTOdnkRhk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=urFimNuFg767QE0J988cFWNIbSm/b14u/lEdyw5ZsyQ6yV7370KzvS9eATtkVK3gARRqNSa1e2BSekgUgfCxu1aIbKDSYMHwbi5LBIWicX5G8TK5XHGWtn3kDBxpD4LgkO6Vaf72gQkPvxgO1Aqdtxp5/GU57Q0SEQEpSPtL1W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDo+cPX4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDo+cPX4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713413409; x=1744949409;
  h=date:from:to:cc:subject:message-id;
  bh=KUmyiv4RPTRu8xXyPhFeYOnwp1bqf0OjBZNTOdnkRhk=;
  b=SDo+cPX4TCjpaBW7+4yJLrqi7qlLKFKVBx82Co4E0NvzXNxpLKPaldsx
   T/qMgCU3039IixuLKllcq2Qz1uzcs+ow9NjENT/lzoc1WBHFYPlAB8Rsd
   i0iIp/GQG92Mes2RzdEEkUYANjHJyOE2Ne71OZy+n2sYJhoocH/+P7SAr
   v3GqD8zGVUBsXjRZGJ770+oskVCEAQ+2XWfTNuBhCbHll4AprrvPYtSk6
   hxSLigtyVfHa6fIQoff7/8jImriBmeS0dvn3kMKsAsYe4JWhq4EF9Qoo3
   A+xf0UlIJxAXc17xX2HZSUGGmdQpZeI8lw823vWptxGM2snumaaWQcotm
   w==;
X-CSE-ConnectionGUID: ylYXDsEpQmy8nVj88EGxRw==
X-CSE-MsgGUID: woEt2h8dSQufZdV/dGAe2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12719715"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="12719715"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 21:10:08 -0700
X-CSE-ConnectionGUID: 5cDsMJ9QR4Ovx2b4uuhnrQ==
X-CSE-MsgGUID: 6XpXrGFQRTqX8ybTuI5lbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="22904647"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 17 Apr 2024 21:10:07 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxJ64-0007HO-2L;
	Thu, 18 Apr 2024 04:10:04 +0000
Date: Thu, 18 Apr 2024 12:09:11 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 b86ae40ffcf5a16b9569b1016da4a08c4f352ca2
Message-ID: <202404181208.0zCZIKoB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: b86ae40ffcf5a16b9569b1016da4a08c4f352ca2  serial: exar: adding missing CTI and Exar PCI ids

elapsed time: 993m

configs tested: 172
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
arc                   randconfig-001-20240418   gcc  
arc                   randconfig-002-20240418   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                   randconfig-001-20240418   gcc  
arm                   randconfig-002-20240418   gcc  
arm                   randconfig-003-20240418   gcc  
arm                   randconfig-004-20240418   gcc  
arm                           sama5_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240418   gcc  
arm64                 randconfig-003-20240418   gcc  
arm64                 randconfig-004-20240418   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240418   gcc  
csky                  randconfig-002-20240418   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240417   clang
i386         buildonly-randconfig-001-20240418   gcc  
i386         buildonly-randconfig-002-20240417   gcc  
i386         buildonly-randconfig-002-20240418   gcc  
i386         buildonly-randconfig-003-20240417   clang
i386         buildonly-randconfig-004-20240417   gcc  
i386         buildonly-randconfig-004-20240418   gcc  
i386         buildonly-randconfig-005-20240417   gcc  
i386         buildonly-randconfig-006-20240417   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240417   clang
i386                  randconfig-001-20240418   gcc  
i386                  randconfig-002-20240417   gcc  
i386                  randconfig-002-20240418   gcc  
i386                  randconfig-003-20240417   gcc  
i386                  randconfig-004-20240417   clang
i386                  randconfig-004-20240418   gcc  
i386                  randconfig-005-20240417   clang
i386                  randconfig-005-20240418   gcc  
i386                  randconfig-006-20240417   clang
i386                  randconfig-006-20240418   gcc  
i386                  randconfig-011-20240417   gcc  
i386                  randconfig-012-20240417   gcc  
i386                  randconfig-013-20240417   clang
i386                  randconfig-013-20240418   gcc  
i386                  randconfig-014-20240417   gcc  
i386                  randconfig-014-20240418   gcc  
i386                  randconfig-015-20240417   gcc  
i386                  randconfig-015-20240418   gcc  
i386                  randconfig-016-20240417   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240418   gcc  
loongarch             randconfig-002-20240418   gcc  
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
nios2                 randconfig-001-20240418   gcc  
nios2                 randconfig-002-20240418   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240418   gcc  
parisc                randconfig-002-20240418   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc                      ppc64e_defconfig   gcc  
powerpc               randconfig-001-20240418   gcc  
powerpc               randconfig-003-20240418   gcc  
powerpc64             randconfig-001-20240418   gcc  
powerpc64             randconfig-002-20240418   gcc  
powerpc64             randconfig-003-20240418   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240418   gcc  
riscv                 randconfig-002-20240418   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                    randconfig-001-20240418   gcc  
sh                    randconfig-002-20240418   gcc  
sh                             sh03_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240418   gcc  
sparc64               randconfig-002-20240418   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240418   gcc  
um                    randconfig-002-20240418   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-005-20240418   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240418   gcc  
x86_64                randconfig-003-20240418   gcc  
x86_64                randconfig-005-20240418   gcc  
x86_64                randconfig-006-20240418   gcc  
x86_64                randconfig-012-20240418   gcc  
x86_64                randconfig-014-20240418   gcc  
x86_64                randconfig-015-20240418   gcc  
x86_64                randconfig-016-20240418   gcc  
x86_64                randconfig-071-20240418   gcc  
x86_64                randconfig-074-20240418   gcc  
x86_64                randconfig-075-20240418   gcc  
x86_64                randconfig-076-20240418   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240418   gcc  
xtensa                randconfig-002-20240418   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
