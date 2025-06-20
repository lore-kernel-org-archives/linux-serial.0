Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A680321C17D
	for <linux-serial@vger.kernel.org>; Fri, 20 Jun 2025 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750423759; cv=none; b=PsJAbW9y+nUDqRenV7KEDWXnmvIQbGZ3+d1XvH3MpTNuq+xJ7ASysfOlN/F+IXvXK5OBJlkC9PAvHzBWnqtLAWuGZVSRvL+6xsB05lzgWBKYAD8m62XZN7WTs19WspebXLGFr4pFMtUpl4bW8aeP4A6qbEvJNAv4TzgfEFV7ryk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750423759; c=relaxed/simple;
	bh=k1epC5lNS+UUBYEuA/9kPXGLjI3IrmBHBe0QIrEE1yQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hJR0zLBK3faXZ+MvK4pwVetwo4D9SGC9KQeDAu0RvRzpnIHnKnO16o94z2Nj/4DH53sJa0i9tJmzqa/7TARw4lbVxZxUF6cxB75LcqDowp73RehlVFInHaWkrNGEyP3Mc4MWfo9bIAG4rCAhlfZKp3AGizHoQbz7KJf1dR71Ug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+aWTsLg; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+aWTsLg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750423757; x=1781959757;
  h=date:from:to:cc:subject:message-id;
  bh=k1epC5lNS+UUBYEuA/9kPXGLjI3IrmBHBe0QIrEE1yQ=;
  b=Z+aWTsLg4PrYNyZlYTigcpxu0qubEp9hRpnFsjiqbJPboRf1dA2ILT71
   aAT4F0VCqcQuCAnoHmzx74lwuGCpJJLBHtRNuAY30Pzc9igSV3WoGdb99
   VwOuLolsHl3OU5Re6blCaEQ6yEldmMIk8SmPy/8xQHE9V9zK4rtWqs+xE
   xlwTQn9XmCmsfu5Cq3ktRQlMlyU0Qn+oCmqrnZsJzsIG7mbYA0wI6maDm
   yBroPQ+Yp4ux14OS3KtKeFQ4W2D99fKhy0SFqkLxhI30RDazXCXEHOdnR
   4ZEj3YS4UxNlHmmmlvnewzyYWY+eih3S0jSEWHJ8O241t33HnVPsLFwaU
   A==;
X-CSE-ConnectionGUID: FefQYbIBTnm/tBlZvgWGkg==
X-CSE-MsgGUID: SXcdUN5yQY62xgyoC4jrwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="63738404"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="63738404"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 05:49:17 -0700
X-CSE-ConnectionGUID: P/OwhZ6PR3eByyPlDpmjeg==
X-CSE-MsgGUID: fAjlUOoWSuCuQf3UECbucQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="188121276"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 20 Jun 2025 05:49:16 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSbBB-000LlV-2z;
	Fri, 20 Jun 2025 12:49:13 +0000
Date: Fri, 20 Jun 2025 20:49:06 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 7dfd023dc7a9050554b28a16a31b8b06f76bb862
Message-ID: <202506202055.GLQfJzFq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 7dfd023dc7a9050554b28a16a31b8b06f76bb862  dt-bindings: serial: renesas,rsci: Document RZ/N2H support

Unverified Warning (likely false positive, kindly check if interested):

    drivers/tty/serial/8250/8250_port.c:2259 serial8250_initialize() warn: bitwise AND condition is false here

Warning ids grouped by kconfigs:

recent_errors
`-- hexagon-randconfig-r072-20250619
    `-- drivers-tty-serial-8250_port.c-serial8250_initialize()-warn:bitwise-AND-condition-is-false-here

elapsed time: 1454m

configs tested: 244
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                          axs103_defconfig    clang-21
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250619    gcc-15.1.0
arc                   randconfig-001-20250620    clang-21
arc                   randconfig-002-20250619    gcc-15.1.0
arc                   randconfig-002-20250620    clang-21
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         axm55xx_defconfig    clang-21
arm                                 defconfig    gcc-15.1.0
arm                          ixp4xx_defconfig    clang-21
arm                            mps2_defconfig    clang-21
arm                   randconfig-001-20250619    clang-21
arm                   randconfig-001-20250620    clang-21
arm                   randconfig-002-20250619    gcc-8.5.0
arm                   randconfig-002-20250620    clang-21
arm                   randconfig-003-20250619    gcc-8.5.0
arm                   randconfig-003-20250620    clang-21
arm                   randconfig-004-20250619    gcc-10.5.0
arm                   randconfig-004-20250620    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250619    gcc-8.5.0
arm64                 randconfig-001-20250620    clang-21
arm64                 randconfig-002-20250619    gcc-9.5.0
arm64                 randconfig-002-20250620    clang-21
arm64                 randconfig-003-20250619    gcc-10.5.0
arm64                 randconfig-003-20250620    clang-21
arm64                 randconfig-004-20250619    gcc-10.5.0
arm64                 randconfig-004-20250620    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250620    clang-21
csky                  randconfig-001-20250620    gcc-13.3.0
csky                  randconfig-002-20250620    clang-21
csky                  randconfig-002-20250620    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250620    clang-21
hexagon               randconfig-002-20250620    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250619    gcc-12
i386        buildonly-randconfig-001-20250620    clang-20
i386        buildonly-randconfig-002-20250619    gcc-12
i386        buildonly-randconfig-002-20250620    clang-20
i386        buildonly-randconfig-003-20250619    clang-20
i386        buildonly-randconfig-003-20250620    clang-20
i386        buildonly-randconfig-004-20250619    clang-20
i386        buildonly-randconfig-004-20250620    clang-20
i386        buildonly-randconfig-005-20250619    clang-20
i386        buildonly-randconfig-005-20250620    clang-20
i386        buildonly-randconfig-006-20250619    clang-20
i386        buildonly-randconfig-006-20250620    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250620    gcc-12
i386                  randconfig-002-20250620    gcc-12
i386                  randconfig-003-20250620    gcc-12
i386                  randconfig-004-20250620    gcc-12
i386                  randconfig-005-20250620    gcc-12
i386                  randconfig-006-20250620    gcc-12
i386                  randconfig-007-20250620    gcc-12
i386                  randconfig-011-20250620    gcc-12
i386                  randconfig-012-20250620    gcc-12
i386                  randconfig-013-20250620    gcc-12
i386                  randconfig-014-20250620    gcc-12
i386                  randconfig-015-20250620    gcc-12
i386                  randconfig-016-20250620    gcc-12
i386                  randconfig-017-20250620    gcc-12
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250620    clang-21
loongarch             randconfig-001-20250620    gcc-14.3.0
loongarch             randconfig-002-20250620    clang-21
loongarch             randconfig-002-20250620    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          atari_defconfig    clang-21
m68k                                defconfig    gcc-15.1.0
m68k                           virt_defconfig    clang-21
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                      bmips_stb_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250620    clang-21
nios2                 randconfig-001-20250620    gcc-8.5.0
nios2                 randconfig-002-20250620    clang-21
nios2                 randconfig-002-20250620    gcc-10.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250620    clang-21
parisc                randconfig-001-20250620    gcc-10.5.0
parisc                randconfig-002-20250620    clang-21
parisc                randconfig-002-20250620    gcc-12.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      cm5200_defconfig    clang-21
powerpc                     mpc5200_defconfig    clang-21
powerpc               mpc834x_itxgp_defconfig    clang-21
powerpc                     ppa8548_defconfig    clang-21
powerpc               randconfig-001-20250620    clang-21
powerpc               randconfig-002-20250620    clang-21
powerpc               randconfig-002-20250620    gcc-11.5.0
powerpc               randconfig-003-20250620    clang-21
powerpc                     stx_gp3_defconfig    clang-21
powerpc64             randconfig-001-20250620    clang-21
powerpc64             randconfig-001-20250620    gcc-14.3.0
powerpc64             randconfig-002-20250620    clang-21
powerpc64             randconfig-003-20250620    clang-19
powerpc64             randconfig-003-20250620    clang-21
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250619    gcc-11.5.0
riscv                 randconfig-001-20250620    gcc-13.3.0
riscv                 randconfig-002-20250619    clang-16
riscv                 randconfig-002-20250620    gcc-13.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250619    clang-19
s390                  randconfig-001-20250620    gcc-13.3.0
s390                  randconfig-002-20250619    gcc-13.2.0
s390                  randconfig-002-20250620    gcc-13.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                         ecovec24_defconfig    clang-21
sh                            hp6xx_defconfig    clang-21
sh                    randconfig-001-20250619    gcc-9.3.0
sh                    randconfig-001-20250620    gcc-13.3.0
sh                    randconfig-002-20250619    gcc-9.3.0
sh                    randconfig-002-20250620    gcc-13.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250619    gcc-14.3.0
sparc                 randconfig-001-20250620    gcc-13.3.0
sparc                 randconfig-002-20250619    gcc-10.3.0
sparc                 randconfig-002-20250620    gcc-13.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250619    gcc-13.3.0
sparc64               randconfig-001-20250620    gcc-13.3.0
sparc64               randconfig-002-20250619    gcc-8.5.0
sparc64               randconfig-002-20250620    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250619    clang-19
um                    randconfig-001-20250620    gcc-13.3.0
um                    randconfig-002-20250619    clang-21
um                    randconfig-002-20250620    gcc-13.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250619    clang-20
x86_64      buildonly-randconfig-001-20250620    gcc-12
x86_64      buildonly-randconfig-002-20250619    gcc-12
x86_64      buildonly-randconfig-002-20250620    gcc-12
x86_64      buildonly-randconfig-003-20250619    clang-20
x86_64      buildonly-randconfig-003-20250620    gcc-12
x86_64      buildonly-randconfig-004-20250619    gcc-12
x86_64      buildonly-randconfig-004-20250620    gcc-12
x86_64      buildonly-randconfig-005-20250619    clang-20
x86_64      buildonly-randconfig-005-20250620    gcc-12
x86_64      buildonly-randconfig-006-20250619    gcc-12
x86_64      buildonly-randconfig-006-20250620    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250620    clang-20
x86_64                randconfig-002-20250620    clang-20
x86_64                randconfig-003-20250620    clang-20
x86_64                randconfig-004-20250620    clang-20
x86_64                randconfig-005-20250620    clang-20
x86_64                randconfig-006-20250620    clang-20
x86_64                randconfig-007-20250620    clang-20
x86_64                randconfig-008-20250620    clang-20
x86_64                randconfig-071-20250620    clang-20
x86_64                randconfig-072-20250620    clang-20
x86_64                randconfig-073-20250620    clang-20
x86_64                randconfig-074-20250620    clang-20
x86_64                randconfig-075-20250620    clang-20
x86_64                randconfig-076-20250620    clang-20
x86_64                randconfig-077-20250620    clang-20
x86_64                randconfig-078-20250620    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250619    gcc-9.3.0
xtensa                randconfig-001-20250620    gcc-13.3.0
xtensa                randconfig-002-20250619    gcc-8.5.0
xtensa                randconfig-002-20250620    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
