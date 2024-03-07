Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB3312FB1B
	for <linux-serial@vger.kernel.org>; Thu,  7 Mar 2024 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829491; cv=none; b=dfmyhxJx+sR0ayUnp9A29YNA62tV6Y0WhKL0wpI9dOxPyf19/Wqlp61wCcuTuLrtGdxiCG599Ap2Lj5z7PZ7/+icSqhoFZyneyQ9uGpl3hn2MaeskdNYs0jKKPBrFo7RCSBbvW7rkYToa1nPVaD7T+Jnn8VVa6yVqCI1FKHTmBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829491; c=relaxed/simple;
	bh=IdluYdLNz5UmLDiyo89P16+fDTno4KjOZQQZljeBtQM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fCCLiLNHm+xP+nGUZiD7atcF592s+F1OT9jmJHpCj4tIp7nLdb5VwOOeBh30IPCt7CsWXOXnXFWa/eie1EFwk3d4PEX0hpyMoNDij+UiovgKm7HeXvKSqe0rGp9MyOAtaQ9XXClO806zYTXAHMlZrA08XJbZxb4QwxsdTvRveDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+FsAPnH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+FsAPnH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709829490; x=1741365490;
  h=date:from:to:cc:subject:message-id;
  bh=IdluYdLNz5UmLDiyo89P16+fDTno4KjOZQQZljeBtQM=;
  b=X+FsAPnHrNt2uZq44gorkbRR9fqL8myONlTiYSFZGxsEL1TpRuNbKiKy
   9q5zv2NkZ7PTD1PnCJAfrLPwyZ89Wpy++vPYI7nKinzfK06zGomXXAIAV
   NBRpALWj4apQt3oIICtkvJ5ptbSoVonOechuel3K26LKUQDKWzCpxlgGI
   I7Fdzr4Yf5/rOTj7VZGVq28SdQcPus23XfM5d942OVq9ggmI2js5hPGGM
   gCk/8dDPWLSQt2SLTi+C/UFDMimLD1djjEyeJneitu2QAmk10nFFA3VQl
   iETADx/PuASjkMQckoxe/f08skC+T3/G3cqZToTWEmMRckTSLQndK/SpM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="8325339"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="8325339"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 08:38:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="10309932"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 Mar 2024 08:38:07 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1riGku-0005Nx-2q;
	Thu, 07 Mar 2024 16:38:04 +0000
Date: Fri, 08 Mar 2024 00:37:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 173b097dcc8d74d6e135aed1bad38dbfa21c4d04
Message-ID: <202403080012.eHnRl819-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 173b097dcc8d74d6e135aed1bad38dbfa21c4d04  serial: 8250_dw: Replace ACPI device check by a quirk

elapsed time: 1039m

configs tested: 101
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
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240307   clang
i386         buildonly-randconfig-002-20240307   gcc  
i386         buildonly-randconfig-003-20240307   clang
i386         buildonly-randconfig-004-20240307   gcc  
i386         buildonly-randconfig-005-20240307   gcc  
i386         buildonly-randconfig-006-20240307   clang
i386                                defconfig   clang
i386                  randconfig-001-20240307   gcc  
i386                  randconfig-002-20240307   gcc  
i386                  randconfig-003-20240307   clang
i386                  randconfig-004-20240307   gcc  
i386                  randconfig-005-20240307   gcc  
i386                  randconfig-006-20240307   clang
i386                  randconfig-011-20240307   clang
i386                  randconfig-012-20240307   gcc  
i386                  randconfig-013-20240307   clang
i386                  randconfig-014-20240307   clang
i386                  randconfig-015-20240307   clang
i386                  randconfig-016-20240307   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
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
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
