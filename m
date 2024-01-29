Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76174190
	for <linux-serial@vger.kernel.org>; Mon, 29 Jan 2024 00:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706487175; cv=none; b=L3HqT9c2odNWna6RZrkbk9arH2w255H00kWcQvPjNadzZvNT75YTzxp+l+DiWlzlhAhBL/y4iJn1Uad23K/XLdoFV4hYHLCWO2uSuObcQGeaOxvDPx0p2De4f+xufTR7StCUy+VQCAp0WXgELMaX/7mySh8Hbl1tuevhzjISigw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706487175; c=relaxed/simple;
	bh=+6zO+AM4iuZjGfrVqh8KsR72sDDkiPtvk3g0ydg6SoA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I2W1ZxskUZi3E08k8JtsjExgXL9nN9048wG3cKqpZqeD1uh/Lks1F3g282zklYpIsgJH5awuDj4YFbdU4fYrD9+xJHEq++5bJP/j2kWx0fzjdLLgr0yueEshq/QO07Qr2rkirk0VL9AHYnYmfGE4eTW7lW1fAADAJt0P68iopGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S44ftxbA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S44ftxbA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706487173; x=1738023173;
  h=date:from:to:cc:subject:message-id;
  bh=+6zO+AM4iuZjGfrVqh8KsR72sDDkiPtvk3g0ydg6SoA=;
  b=S44ftxbAtTNTyi4IPrrwcS9o6FXdqPQmCstcuD7gG0HO1QHgy4hs3pM1
   tqkYGNVF4glHTkhw3JdYYPxt5ta3whAqJvwy/OmEEEWH5XfXKkLn4/ori
   na0AmsfSz39h2EbvUidWe920PThSDeb38tZteyuEuH1tx4/0vtbYi7d/7
   r+el5lknLBRc+JJeO5guUunUdLiQmia0L3u2NK7SMR9BcqNWqWzh7Ja2U
   bEcfQPvPrpfi5GqePAZCz/HzYBwuU/L6RVYvIurzPjXC6lPUNqOMlXfEJ
   fPPqDxQeCap02/XOZM/tuIYnMyszEQSctax6OqMWoSYCLY68D/69X5C4D
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="16343012"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="16343012"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 16:12:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="1118772130"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="1118772130"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jan 2024 16:12:51 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUFGb-0003sU-1n;
	Mon, 29 Jan 2024 00:12:49 +0000
Date: Mon, 29 Jan 2024 08:12:20 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 b35f8dbbce818b02c730dc85133dc7754266e084
Message-ID: <202401290817.1bVHvJgV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: b35f8dbbce818b02c730dc85133dc7754266e084  serial: max310x: prevent infinite while() loop in port startup

elapsed time: 1238m

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
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240128   gcc  
arc                   randconfig-002-20240128   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   clang
arm                         s3c6400_defconfig   gcc  
arm                        shmobile_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240128   gcc  
csky                  randconfig-002-20240128   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240128   clang
i386         buildonly-randconfig-002-20240128   clang
i386         buildonly-randconfig-003-20240128   clang
i386         buildonly-randconfig-004-20240128   clang
i386         buildonly-randconfig-005-20240128   clang
i386         buildonly-randconfig-006-20240128   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240128   clang
i386                  randconfig-002-20240128   clang
i386                  randconfig-003-20240128   clang
i386                  randconfig-004-20240128   clang
i386                  randconfig-005-20240128   clang
i386                  randconfig-006-20240128   clang
i386                  randconfig-011-20240128   gcc  
i386                  randconfig-012-20240128   gcc  
i386                  randconfig-013-20240128   gcc  
i386                  randconfig-014-20240128   gcc  
i386                  randconfig-015-20240128   gcc  
i386                  randconfig-016-20240128   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240128   gcc  
loongarch             randconfig-002-20240128   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240128   gcc  
nios2                 randconfig-002-20240128   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240128   gcc  
parisc                randconfig-002-20240128   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       holly_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240128   gcc  
s390                  randconfig-002-20240128   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                    randconfig-001-20240128   gcc  
sh                    randconfig-002-20240128   gcc  
sh                           se7721_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240128   gcc  
sparc64               randconfig-002-20240128   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240128   clang
x86_64       buildonly-randconfig-002-20240128   clang
x86_64       buildonly-randconfig-003-20240128   clang
x86_64       buildonly-randconfig-004-20240128   clang
x86_64       buildonly-randconfig-005-20240128   clang
x86_64       buildonly-randconfig-006-20240128   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20240128   clang
x86_64                randconfig-012-20240128   clang
x86_64                randconfig-013-20240128   clang
x86_64                randconfig-014-20240128   clang
x86_64                randconfig-015-20240128   clang
x86_64                randconfig-016-20240128   clang
x86_64                randconfig-071-20240128   clang
x86_64                randconfig-072-20240128   clang
x86_64                randconfig-073-20240128   clang
x86_64                randconfig-074-20240128   clang
x86_64                randconfig-075-20240128   clang
x86_64                randconfig-076-20240128   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240128   gcc  
xtensa                randconfig-002-20240128   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
