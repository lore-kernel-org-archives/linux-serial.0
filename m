Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A62C1CAAF
	for <linux-serial@vger.kernel.org>; Mon, 19 Aug 2024 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091301; cv=none; b=h13ffE724R61I9P/rUIgdBKhJOYj49F06hnUhk9iPqDGiIC5Q4w42+cKiJk1yvZcBwHNt7AHYCTSRyrAiyX2WLB07jmzUqBRjXZP8uuW/9CV99TXGrnGZH6l76k67H6soi/Cqo/rXk8GFEso+N1pVaYNQ9z6gn6/JXQAVGRWwoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091301; c=relaxed/simple;
	bh=zJ7dQ5NJDZEdfxpGh1eaZNxaivhPnh90Bi3Z8T0idPQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TTOeMjnGTFmK3MyRaKQ2wie32F8Kkw/Rf6Xn5LmcoglwVGqs7sIVfb+8ffw796x0Skw9uy0mWcTDyic1J0+I9BxgY4+83s5F3SxyPpmYwnopvzfV4hWNuTk1ufagl4yS3omtVwYhk/Eh27/J+V8MaRiIdqxLsZSAx5D8GxgmogU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aOLNICHN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aOLNICHN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724091299; x=1755627299;
  h=date:from:to:cc:subject:message-id;
  bh=zJ7dQ5NJDZEdfxpGh1eaZNxaivhPnh90Bi3Z8T0idPQ=;
  b=aOLNICHNLnTUNILUofVwsCOzHcjMiXWgkCnJbZuW3k50pzu7YpT8LDm0
   sPkit+dAwP00ez+qTU6jsBoD5vyRa/ZWAdf1N7Mgxxr62RCf5JuG6OUhS
   tfjHgo5PjApii0Sgog/K/5I97IU08QHREGgu6no7+jXw5am7b8+8ekuvp
   lmTPJ9lHR4Puzvxb353sCmjQDZ/dKlKvmKea3A9FnsYV7rQaLVU2l/RRO
   BtyYdQ+30IbtMZJTN5MpAyK+z5VX9NIP55LdKROomXYtSUmtgCVZ+d101
   EDuBbvqGjmOzRCtBuRNN4cptPhZNHjOvcPcc9gNfPKCiI+w82JPlb7pkC
   w==;
X-CSE-ConnectionGUID: 6hs0XkAoTLS7huaRzIENEg==
X-CSE-MsgGUID: DwUB++9gSSOxNYhnRZ57+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="25259685"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="25259685"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 11:14:57 -0700
X-CSE-ConnectionGUID: yrI8TruDRiKYUhjqw+7Tsg==
X-CSE-MsgGUID: IcrusaE4QdOw3AR6aGQXdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="64633299"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 Aug 2024 11:14:57 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sg6u6-0009IY-1j;
	Mon, 19 Aug 2024 18:14:54 +0000
Date: Tue, 20 Aug 2024 02:14:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 ebbe30f4bba127505c5664dd67f519e5e06d16be
Message-ID: <202408200229.AJQ5dL7d-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: ebbe30f4bba127505c5664dd67f519e5e06d16be  Merge 6.11-rc4 into tty-next

elapsed time: 768m

configs tested: 164
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs103_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsim_700_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                         socfpga_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240819   clang-18
i386         buildonly-randconfig-002-20240819   clang-18
i386         buildonly-randconfig-002-20240819   gcc-12
i386         buildonly-randconfig-003-20240819   clang-18
i386         buildonly-randconfig-003-20240819   gcc-11
i386         buildonly-randconfig-004-20240819   clang-18
i386         buildonly-randconfig-005-20240819   clang-18
i386         buildonly-randconfig-005-20240819   gcc-12
i386         buildonly-randconfig-006-20240819   clang-18
i386         buildonly-randconfig-006-20240819   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240819   clang-18
i386                  randconfig-001-20240819   gcc-12
i386                  randconfig-002-20240819   clang-18
i386                  randconfig-003-20240819   clang-18
i386                  randconfig-003-20240819   gcc-12
i386                  randconfig-004-20240819   clang-18
i386                  randconfig-004-20240819   gcc-12
i386                  randconfig-005-20240819   clang-18
i386                  randconfig-005-20240819   gcc-12
i386                  randconfig-006-20240819   clang-18
i386                  randconfig-006-20240819   gcc-12
i386                  randconfig-011-20240819   clang-18
i386                  randconfig-011-20240819   gcc-12
i386                  randconfig-012-20240819   clang-18
i386                  randconfig-012-20240819   gcc-12
i386                  randconfig-013-20240819   clang-18
i386                  randconfig-013-20240819   gcc-12
i386                  randconfig-014-20240819   clang-18
i386                  randconfig-014-20240819   gcc-12
i386                  randconfig-015-20240819   clang-18
i386                  randconfig-015-20240819   gcc-12
i386                  randconfig-016-20240819   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                        m5407c3_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
nios2                         3c120_defconfig   gcc-13.2.0
nios2                            alldefconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
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
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                       ebony_defconfig   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                               j2_defconfig   gcc-13.2.0
sh                      rts7751r2d1_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc64_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240819   gcc-12
x86_64       buildonly-randconfig-002-20240819   gcc-12
x86_64       buildonly-randconfig-003-20240819   gcc-12
x86_64       buildonly-randconfig-004-20240819   gcc-12
x86_64       buildonly-randconfig-005-20240819   gcc-12
x86_64       buildonly-randconfig-006-20240819   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240819   gcc-12
x86_64                randconfig-002-20240819   gcc-12
x86_64                randconfig-003-20240819   gcc-12
x86_64                randconfig-004-20240819   gcc-12
x86_64                randconfig-005-20240819   gcc-12
x86_64                randconfig-006-20240819   gcc-12
x86_64                randconfig-011-20240819   gcc-12
x86_64                randconfig-012-20240819   gcc-12
x86_64                randconfig-013-20240819   gcc-12
x86_64                randconfig-014-20240819   gcc-12
x86_64                randconfig-015-20240819   gcc-12
x86_64                randconfig-016-20240819   gcc-12
x86_64                randconfig-071-20240819   gcc-12
x86_64                randconfig-072-20240819   gcc-12
x86_64                randconfig-073-20240819   gcc-12
x86_64                randconfig-074-20240819   gcc-12
x86_64                randconfig-075-20240819   gcc-12
x86_64                randconfig-076-20240819   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  audio_kc705_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
