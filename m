Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9234C13959D
	for <linux-serial@vger.kernel.org>; Wed, 28 Jan 2026 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769592092; cv=none; b=X1udIpvY31loYiW9cGUaM4Pq5qCyQG4yX2sr0e70dNH6FQ2huKjL9llJx/6ToOBJD9fE88IQSC4C/0YW8XuXIvp1e4p+nu3wWfAdqsH5P8D8iiRx75ffbVByloxlkfCnvt5mn2hus7AKTO8ak4er2yf3Jmgk6U+lC15f+vKym54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769592092; c=relaxed/simple;
	bh=yBFAuA0SZ8JbxTlPM7mmCjsUlwQejvRk0nShID3wFX0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VeqOn2F+kF5jRHgxd3IB3SaKUUfD0BoA9c/y9pgKKRZDA1eig6VQBoX+YozTMCK9taG/Z+J7pJvqgg0pfOqOqRUywbgZsAim/B98KtowerPZ3Wsp4X7wBbu4QnZhr8j/SJinzXi/pkRY3nVYV/Q/3K7RUeapbGNJdsDZ0y/As0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJ5NlTR8; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJ5NlTR8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769592091; x=1801128091;
  h=date:from:to:cc:subject:message-id;
  bh=yBFAuA0SZ8JbxTlPM7mmCjsUlwQejvRk0nShID3wFX0=;
  b=IJ5NlTR8A0oAlVYhkhgrvlf7sPOpjhJBrIqhZOHZWhgv/WMhEt0kGv4K
   wN0O4yU96ZkgG/ONTyEJo8rrhFcdsTTISqN8ZVPjid88zB7Wk986VTkHN
   3fD/7mi11Tpezd7fhNjviG1mpLTSkQhlA6avt4PUjBgrM8NJsFoEZ4bp3
   SuTOyjJRCZqst3xyv4Chv+F2HFoszvkETVhyJts0ENwBlyPJdXHUKWATn
   +MkKCZgi9QkbozJNzki6LK+I6GY7Etni6T7+xp+f0I70Z6wGFZefKtgWz
   OzRLYaADuGLawMnEjsa3mLwqa8yj6kGbhM6myZyiBt6fkRJ3gjMEjf/n/
   Q==;
X-CSE-ConnectionGUID: s9Y1YTG1RX6lzrjkocVL7Q==
X-CSE-MsgGUID: CrQFnC6KSpeyTI8nxCKZVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="74659089"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="74659089"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 01:21:30 -0800
X-CSE-ConnectionGUID: V0ra20E+TJuaNP3cUx9rVw==
X-CSE-MsgGUID: DbXnJ7sWSsqCsuy1gQGD1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="212317501"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 28 Jan 2026 01:21:28 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vl1jp-00000000ZVI-1GcT;
	Wed, 28 Jan 2026 09:21:25 +0000
Date: Wed, 28 Jan 2026 17:20:25 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 0a15f43b92ddaa2fdb476891a12ac2e207c7fcd2
Message-ID: <202601281720.YjoaVgCI-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 0a15f43b92ddaa2fdb476891a12ac2e207c7fcd2  Revert "tty: tty_port: add workqueue to flip TTY buffer"

elapsed time: 1198m

configs tested: 227
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                      axs103_smp_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                     haps_hs_smp_defconfig    clang-22
arc                            hsdk_defconfig    clang-22
arc                   randconfig-001-20260128    gcc-8.5.0
arc                   randconfig-002-20260128    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                       aspeed_g4_defconfig    clang-22
arm                         at91_dt_defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                        mvebu_v5_defconfig    gcc-15.2.0
arm                          pxa3xx_defconfig    gcc-15.2.0
arm                   randconfig-001-20260128    gcc-8.5.0
arm                   randconfig-002-20260128    gcc-8.5.0
arm                   randconfig-003-20260128    gcc-8.5.0
arm                   randconfig-004-20260128    gcc-8.5.0
arm64                            alldefconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260128    gcc-14.3.0
arm64                 randconfig-002-20260128    gcc-14.3.0
arm64                 randconfig-003-20260128    gcc-14.3.0
arm64                 randconfig-004-20260128    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260128    gcc-14.3.0
csky                  randconfig-002-20260128    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260128    clang-22
hexagon               randconfig-002-20260128    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260128    clang-20
i386        buildonly-randconfig-002-20260128    clang-20
i386        buildonly-randconfig-003-20260128    clang-20
i386        buildonly-randconfig-004-20260128    clang-20
i386        buildonly-randconfig-005-20260128    clang-20
i386        buildonly-randconfig-006-20260128    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260128    gcc-14
i386                  randconfig-002-20260128    gcc-14
i386                  randconfig-003-20260128    gcc-14
i386                  randconfig-004-20260128    gcc-14
i386                  randconfig-005-20260128    gcc-14
i386                  randconfig-006-20260128    gcc-14
i386                  randconfig-007-20260128    gcc-14
i386                  randconfig-011-20260128    clang-20
i386                  randconfig-012-20260128    clang-20
i386                  randconfig-013-20260128    clang-20
i386                  randconfig-014-20260128    clang-20
i386                  randconfig-015-20260128    clang-20
i386                  randconfig-016-20260128    clang-20
i386                  randconfig-017-20260128    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260128    clang-22
loongarch             randconfig-002-20260128    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                          atari_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                       m5275evb_defconfig    clang-22
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                  cavium_octeon_defconfig    gcc-15.2.0
mips                         db1xxx_defconfig    gcc-15.2.0
mips                           ip27_defconfig    gcc-15.2.0
mips                           ip30_defconfig    gcc-15.2.0
mips                           ip32_defconfig    gcc-15.2.0
mips                      loongson3_defconfig    gcc-15.2.0
mips                          malta_defconfig    gcc-15.2.0
mips                      malta_kvm_defconfig    gcc-15.2.0
mips                        maltaup_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260128    clang-22
nios2                 randconfig-002-20260128    clang-22
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                  or1klitex_defconfig    clang-22
openrisc                       virt_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260128    gcc-11.5.0
parisc                randconfig-002-20260128    gcc-11.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      chrp32_defconfig    gcc-15.2.0
powerpc                        fsp2_defconfig    gcc-15.2.0
powerpc                 linkstation_defconfig    clang-22
powerpc                      mgcoge_defconfig    gcc-15.2.0
powerpc                     mpc83xx_defconfig    gcc-15.2.0
powerpc                    mvme5100_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260128    gcc-11.5.0
powerpc               randconfig-002-20260128    gcc-11.5.0
powerpc64             randconfig-001-20260128    gcc-11.5.0
powerpc64             randconfig-002-20260128    gcc-11.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260128    gcc-13.4.0
riscv                 randconfig-002-20260128    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260128    gcc-13.4.0
s390                  randconfig-002-20260128    gcc-13.4.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260128    gcc-13.4.0
sh                    randconfig-002-20260128    gcc-13.4.0
sparc                            alldefconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260128    gcc-11.5.0
sparc                 randconfig-002-20260128    gcc-11.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260128    gcc-11.5.0
sparc64               randconfig-002-20260128    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260128    gcc-11.5.0
um                    randconfig-002-20260128    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260128    gcc-14
x86_64      buildonly-randconfig-002-20260128    gcc-14
x86_64      buildonly-randconfig-003-20260128    gcc-14
x86_64      buildonly-randconfig-004-20260128    gcc-14
x86_64      buildonly-randconfig-005-20260128    gcc-14
x86_64      buildonly-randconfig-006-20260128    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260128    gcc-13
x86_64                randconfig-002-20260128    gcc-13
x86_64                randconfig-003-20260128    gcc-13
x86_64                randconfig-004-20260128    gcc-13
x86_64                randconfig-005-20260128    gcc-13
x86_64                randconfig-006-20260128    gcc-13
x86_64                randconfig-011-20260128    clang-20
x86_64                randconfig-012-20260128    clang-20
x86_64                randconfig-013-20260128    clang-20
x86_64                randconfig-014-20260128    clang-20
x86_64                randconfig-015-20260128    clang-20
x86_64                randconfig-016-20260128    clang-20
x86_64                randconfig-071-20260128    clang-20
x86_64                randconfig-072-20260128    clang-20
x86_64                randconfig-073-20260128    clang-20
x86_64                randconfig-074-20260128    clang-20
x86_64                randconfig-075-20260128    clang-20
x86_64                randconfig-076-20260128    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                           allyesconfig    gcc-15.2.0
xtensa                  cadence_csp_defconfig    gcc-15.2.0
xtensa                generic_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260128    gcc-11.5.0
xtensa                randconfig-002-20260128    gcc-11.5.0
xtensa                    xip_kc705_defconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
