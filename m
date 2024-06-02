Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B238175A5
	for <linux-serial@vger.kernel.org>; Sun,  2 Jun 2024 03:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717300599; cv=none; b=l3Auwgs8NpbNnnPmKLnn6cCpHLvI3jSVgSn/tIBz7GbVFrPBRi2wNPlIiOEe6zyPML9EE+41xA2Vg0Jnq+xsyONW7YrE3HKMNoKtGc06QaQa2Tyhg8s0W22LjP1B85bx3urzN2bcRPmRGe3KEo5ituG5Z7BKWg3ps9OYXY6Y9WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717300599; c=relaxed/simple;
	bh=iCw9TrN3mVz0t+vKawObw+5QHf/Y08/Vg/DM0vXeAIY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DvU0Q/VnKQHQ9c2xL2eDEAo5PBjy/5Sw1gvws1blaKUmKRTXG7IKBC7sDlVhFtRZuG1phr2Y0UT9EPtQ5SqQHeWTwqgJjbt5jt6hm9sQdMNzdhq8LVnxfLdUQ1IhNAy4ku14wUw1wzqXpFZ8JWXHTsGo2A0b7sjOL8Ymk4GsccA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgSFxTa/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgSFxTa/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717300597; x=1748836597;
  h=date:from:to:cc:subject:message-id;
  bh=iCw9TrN3mVz0t+vKawObw+5QHf/Y08/Vg/DM0vXeAIY=;
  b=hgSFxTa/umsshjO+iNdOGNV7n6n4M9uu8W1z3oc91j3gYjb++Kg0e2es
   A7IrqGZ5RrFoVAj7Rqm6GpaanvjbVpsKTUsDKKjHbITtPKbque8xBitdC
   7Rfg81qt2LBVmoKlI4XrteUNo3yUuZ5CCU2zvfP/qIv8p+nit0bJrJgX7
   AzgyKXf5QDYTCg5fPx4ESElxEqVWlFb6rVE2EAfmbzTDwsO4r2ecyPQYE
   Isizvsmw9eaUuDiglkcBF7GaQAwnimJf4hqR5E127/PyCxx5I7hfG5G+a
   4JU58IUzfV63FvC3y4YTvQvVn3iEEYxLYvYL74uUwgxnf26YT+iZCTcvO
   w==;
X-CSE-ConnectionGUID: iaALoTKISxmpBN/y8iMOlQ==
X-CSE-MsgGUID: vetL9iTRRBmv+z+MSYVdYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="11858057"
X-IronPort-AV: E=Sophos;i="6.08,208,1712646000"; 
   d="scan'208";a="11858057"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2024 20:56:37 -0700
X-CSE-ConnectionGUID: oTEKhH+BT8SGkW4KlRRz4A==
X-CSE-MsgGUID: wgXyQILlQBe2I5DKXxw1Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,208,1712646000"; 
   d="scan'208";a="36641519"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 01 Jun 2024 20:56:35 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDcKe-000Jez-2w;
	Sun, 02 Jun 2024 03:56:32 +0000
Date: Sun, 02 Jun 2024 11:56:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 7bc4244c882a7d7d79f4afefc50893244eb11d07
Message-ID: <202406021159.yoH28AvR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 7bc4244c882a7d7d79f4afefc50893244eb11d07  Revert "VT: Use macros to define ioctls"

elapsed time: 1320m

configs tested: 206
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
arc                   randconfig-001-20240601   gcc  
arc                   randconfig-001-20240602   gcc  
arc                   randconfig-002-20240601   gcc  
arc                   randconfig-002-20240602   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                          collie_defconfig   gcc  
arm                                 defconfig   clang
arm                        mvebu_v5_defconfig   gcc  
arm                   randconfig-001-20240601   clang
arm                   randconfig-002-20240601   clang
arm                   randconfig-003-20240601   gcc  
arm                   randconfig-003-20240602   gcc  
arm                   randconfig-004-20240601   gcc  
arm                           tegra_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240601   gcc  
arm64                 randconfig-002-20240601   clang
arm64                 randconfig-002-20240602   gcc  
arm64                 randconfig-003-20240601   clang
arm64                 randconfig-004-20240601   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240601   gcc  
csky                  randconfig-001-20240602   gcc  
csky                  randconfig-002-20240601   gcc  
csky                  randconfig-002-20240602   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240601   clang
hexagon               randconfig-002-20240601   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240601   clang
i386         buildonly-randconfig-006-20240601   clang
i386                                defconfig   clang
i386                  randconfig-001-20240601   clang
i386                  randconfig-003-20240601   clang
i386                  randconfig-005-20240601   clang
i386                  randconfig-015-20240601   clang
i386                  randconfig-016-20240601   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240601   gcc  
loongarch             randconfig-001-20240602   gcc  
loongarch             randconfig-002-20240601   gcc  
loongarch             randconfig-002-20240602   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip28_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240601   gcc  
nios2                 randconfig-001-20240602   gcc  
nios2                 randconfig-002-20240601   gcc  
nios2                 randconfig-002-20240602   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240601   gcc  
parisc                randconfig-001-20240602   gcc  
parisc                randconfig-002-20240601   gcc  
parisc                randconfig-002-20240602   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                        icon_defconfig   gcc  
powerpc               randconfig-001-20240601   gcc  
powerpc               randconfig-002-20240601   gcc  
powerpc               randconfig-002-20240602   gcc  
powerpc               randconfig-003-20240601   gcc  
powerpc64             randconfig-001-20240601   clang
powerpc64             randconfig-002-20240601   clang
powerpc64             randconfig-002-20240602   gcc  
powerpc64             randconfig-003-20240601   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240601   clang
riscv                 randconfig-002-20240601   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240601   gcc  
s390                  randconfig-001-20240602   gcc  
s390                  randconfig-002-20240601   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                    randconfig-001-20240601   gcc  
sh                    randconfig-001-20240602   gcc  
sh                    randconfig-002-20240601   gcc  
sh                    randconfig-002-20240602   gcc  
sh                           se7722_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240601   gcc  
sparc64               randconfig-001-20240602   gcc  
sparc64               randconfig-002-20240601   gcc  
sparc64               randconfig-002-20240602   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240601   gcc  
um                    randconfig-001-20240602   gcc  
um                    randconfig-002-20240601   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240601   clang
x86_64       buildonly-randconfig-002-20240601   clang
x86_64       buildonly-randconfig-002-20240602   clang
x86_64       buildonly-randconfig-003-20240601   gcc  
x86_64       buildonly-randconfig-003-20240602   clang
x86_64       buildonly-randconfig-004-20240601   gcc  
x86_64       buildonly-randconfig-005-20240601   clang
x86_64       buildonly-randconfig-005-20240602   clang
x86_64       buildonly-randconfig-006-20240601   gcc  
x86_64       buildonly-randconfig-006-20240602   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   clang
x86_64                randconfig-001-20240601   gcc  
x86_64                randconfig-002-20240601   clang
x86_64                randconfig-002-20240602   clang
x86_64                randconfig-003-20240601   clang
x86_64                randconfig-003-20240602   clang
x86_64                randconfig-004-20240601   clang
x86_64                randconfig-005-20240601   gcc  
x86_64                randconfig-005-20240602   clang
x86_64                randconfig-006-20240601   clang
x86_64                randconfig-006-20240602   clang
x86_64                randconfig-011-20240601   clang
x86_64                randconfig-012-20240601   clang
x86_64                randconfig-012-20240602   clang
x86_64                randconfig-013-20240601   clang
x86_64                randconfig-013-20240602   clang
x86_64                randconfig-014-20240601   gcc  
x86_64                randconfig-015-20240601   gcc  
x86_64                randconfig-015-20240602   clang
x86_64                randconfig-016-20240601   gcc  
x86_64                randconfig-071-20240601   clang
x86_64                randconfig-072-20240601   gcc  
x86_64                randconfig-072-20240602   clang
x86_64                randconfig-073-20240601   clang
x86_64                randconfig-074-20240601   gcc  
x86_64                randconfig-074-20240602   clang
x86_64                randconfig-075-20240601   clang
x86_64                randconfig-075-20240602   clang
x86_64                randconfig-076-20240601   gcc  
x86_64                randconfig-076-20240602   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20240601   gcc  
xtensa                randconfig-001-20240602   gcc  
xtensa                randconfig-002-20240601   gcc  
xtensa                randconfig-002-20240602   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
