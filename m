Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8046A8A1
	for <linux-serial@vger.kernel.org>; Thu,  8 Feb 2024 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386981; cv=none; b=fkXwYbsCymcJT6J7ILbCJNQhPfXhbXlXjHleUmnu+mlsrI6z5G/s4HzE22K25vl59wisZW1euctuNsKONYNN+AX8PBOmp/EEJ24lNVYOLnvNo2J9611AsAa/HOg8vILXyzYh3BCa/veO0QqzseWM/yXWwfQlOQBR6hPZ7abmYWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386981; c=relaxed/simple;
	bh=KA52UJnWBvErZUbNU5pbHg1yo7mt0oNoaJfcrfTPlQQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=n5l8IXIYZ3GuCPubKQSCYko6e6YUCRYV+uEsvChp2XLDustN8I+CyS2tgrsxvPqwzWEBjWDvLX3XfmKVhEYKE9ry2NZGWgZvZIn6iZZXR+ORja3z1+zvyFKnqZa3ji1Nj+yEEsyitCrMgPctUqnULcihH24lVRDWJ+N0mascPuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BpvjwPGr; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BpvjwPGr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707386980; x=1738922980;
  h=date:from:to:cc:subject:message-id;
  bh=KA52UJnWBvErZUbNU5pbHg1yo7mt0oNoaJfcrfTPlQQ=;
  b=BpvjwPGrm07IKmuSTMTHwjdr/O3hADcIG5yI61CKK1umq3vEZk52d1bx
   1aaA/Ln0kfY3wSNFXdUIAl6wK41Lrd7nyk64oderKjINeTs90Y6jB7Tyj
   +amzS5C8TGMTQkzeGXiykJ5NuWnmWLIzS4TkIPB1/Hw03RYkKn/g0qc6n
   Y6VEscehoyabXGC3eNv35o/iDIbXvvJNgxAP7eoaxqEyrFYtT+A1mzpHa
   fOH0ifgKoafWPw4e2GrldCsz23KbNlm1cZGXCaXWeQtDg8Ci4BxlpBSPr
   2uJ8SEg9y2Igkg86Yg33Yl+NbeBJsMIungZede+8CH/Ab1SWmbMyXJYJu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="4970129"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="4970129"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 02:09:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1934561"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 08 Feb 2024 02:09:35 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rY1LZ-0003bw-04;
	Thu, 08 Feb 2024 10:09:33 +0000
Date: Thu, 08 Feb 2024 18:08:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 6cc3028f797a549f256d593867a769ab6a8265f2
Message-ID: <202402081831.RqMopw3q-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 6cc3028f797a549f256d593867a769ab6a8265f2  tty: vt: decrypt magic constants in vc_is_control()

elapsed time: 1446m

configs tested: 252
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
arc                   randconfig-001-20240207   gcc  
arc                   randconfig-001-20240208   gcc  
arc                   randconfig-002-20240207   gcc  
arc                   randconfig-002-20240208   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   clang
arm                         mv78xx0_defconfig   clang
arm                         orion5x_defconfig   clang
arm                   randconfig-001-20240207   clang
arm                   randconfig-001-20240208   gcc  
arm                   randconfig-002-20240207   clang
arm                   randconfig-002-20240208   gcc  
arm                   randconfig-003-20240207   clang
arm                   randconfig-003-20240208   gcc  
arm                   randconfig-004-20240207   gcc  
arm                        spear6xx_defconfig   clang
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240207   clang
arm64                 randconfig-002-20240207   clang
arm64                 randconfig-003-20240207   clang
arm64                 randconfig-004-20240207   clang
arm64                 randconfig-004-20240208   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240207   gcc  
csky                  randconfig-001-20240208   gcc  
csky                  randconfig-002-20240207   gcc  
csky                  randconfig-002-20240208   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240207   clang
hexagon               randconfig-002-20240207   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240207   clang
i386         buildonly-randconfig-001-20240208   gcc  
i386         buildonly-randconfig-002-20240207   clang
i386         buildonly-randconfig-002-20240208   clang
i386         buildonly-randconfig-003-20240207   clang
i386         buildonly-randconfig-003-20240208   gcc  
i386         buildonly-randconfig-004-20240207   clang
i386         buildonly-randconfig-004-20240208   gcc  
i386         buildonly-randconfig-005-20240207   clang
i386         buildonly-randconfig-005-20240208   gcc  
i386         buildonly-randconfig-006-20240207   clang
i386         buildonly-randconfig-006-20240208   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240207   gcc  
i386                  randconfig-001-20240208   gcc  
i386                  randconfig-002-20240207   clang
i386                  randconfig-002-20240208   gcc  
i386                  randconfig-003-20240207   gcc  
i386                  randconfig-003-20240208   gcc  
i386                  randconfig-004-20240207   gcc  
i386                  randconfig-004-20240208   clang
i386                  randconfig-005-20240207   gcc  
i386                  randconfig-005-20240208   gcc  
i386                  randconfig-006-20240207   clang
i386                  randconfig-006-20240208   gcc  
i386                  randconfig-011-20240207   gcc  
i386                  randconfig-011-20240208   clang
i386                  randconfig-012-20240207   gcc  
i386                  randconfig-012-20240208   clang
i386                  randconfig-013-20240207   gcc  
i386                  randconfig-013-20240208   clang
i386                  randconfig-014-20240207   gcc  
i386                  randconfig-014-20240208   clang
i386                  randconfig-015-20240207   gcc  
i386                  randconfig-015-20240208   clang
i386                  randconfig-016-20240207   gcc  
i386                  randconfig-016-20240208   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240207   gcc  
loongarch             randconfig-001-20240208   gcc  
loongarch             randconfig-002-20240207   gcc  
loongarch             randconfig-002-20240208   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                        bcm63xx_defconfig   clang
mips                      pic32mzda_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240207   gcc  
nios2                 randconfig-001-20240208   gcc  
nios2                 randconfig-002-20240207   gcc  
nios2                 randconfig-002-20240208   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240207   gcc  
parisc                randconfig-001-20240208   gcc  
parisc                randconfig-002-20240207   gcc  
parisc                randconfig-002-20240208   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   bluestone_defconfig   clang
powerpc                      chrp32_defconfig   clang
powerpc                       eiger_defconfig   clang
powerpc                    gamecube_defconfig   clang
powerpc                     kilauea_defconfig   clang
powerpc                      mgcoge_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                     mpc83xx_defconfig   clang
powerpc                      pcm030_defconfig   clang
powerpc               randconfig-001-20240207   clang
powerpc               randconfig-002-20240207   clang
powerpc               randconfig-002-20240208   gcc  
powerpc               randconfig-003-20240207   gcc  
powerpc               randconfig-003-20240208   gcc  
powerpc                     tqm8560_defconfig   gcc  
powerpc64                        alldefconfig   clang
powerpc64             randconfig-001-20240207   clang
powerpc64             randconfig-001-20240208   gcc  
powerpc64             randconfig-002-20240207   gcc  
powerpc64             randconfig-002-20240208   gcc  
powerpc64             randconfig-003-20240207   gcc  
powerpc64             randconfig-003-20240208   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240207   clang
riscv                 randconfig-001-20240208   gcc  
riscv                 randconfig-002-20240207   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240207   gcc  
s390                  randconfig-002-20240207   gcc  
s390                  randconfig-002-20240208   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20240207   gcc  
sh                    randconfig-001-20240208   gcc  
sh                    randconfig-002-20240207   gcc  
sh                    randconfig-002-20240208   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240207   gcc  
sparc64               randconfig-001-20240208   gcc  
sparc64               randconfig-002-20240207   gcc  
sparc64               randconfig-002-20240208   gcc  
um                               alldefconfig   clang
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240207   clang
um                    randconfig-002-20240207   gcc  
um                    randconfig-002-20240208   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240207   clang
x86_64       buildonly-randconfig-002-20240207   clang
x86_64       buildonly-randconfig-003-20240207   gcc  
x86_64       buildonly-randconfig-003-20240208   gcc  
x86_64       buildonly-randconfig-004-20240207   clang
x86_64       buildonly-randconfig-005-20240207   clang
x86_64       buildonly-randconfig-006-20240207   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240207   clang
x86_64                randconfig-001-20240208   gcc  
x86_64                randconfig-002-20240207   gcc  
x86_64                randconfig-002-20240208   gcc  
x86_64                randconfig-003-20240207   gcc  
x86_64                randconfig-003-20240208   gcc  
x86_64                randconfig-004-20240207   gcc  
x86_64                randconfig-005-20240207   clang
x86_64                randconfig-005-20240208   gcc  
x86_64                randconfig-006-20240207   clang
x86_64                randconfig-006-20240208   gcc  
x86_64                randconfig-011-20240207   clang
x86_64                randconfig-011-20240208   gcc  
x86_64                randconfig-012-20240207   gcc  
x86_64                randconfig-012-20240208   gcc  
x86_64                randconfig-013-20240207   clang
x86_64                randconfig-014-20240207   clang
x86_64                randconfig-015-20240207   gcc  
x86_64                randconfig-016-20240207   gcc  
x86_64                randconfig-071-20240207   gcc  
x86_64                randconfig-072-20240207   clang
x86_64                randconfig-073-20240207   clang
x86_64                randconfig-073-20240208   gcc  
x86_64                randconfig-074-20240207   gcc  
x86_64                randconfig-075-20240207   gcc  
x86_64                randconfig-075-20240208   gcc  
x86_64                randconfig-076-20240207   clang
x86_64                randconfig-076-20240208   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240207   gcc  
xtensa                randconfig-001-20240208   gcc  
xtensa                randconfig-002-20240207   gcc  
xtensa                randconfig-002-20240208   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
