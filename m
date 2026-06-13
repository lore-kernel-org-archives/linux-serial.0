Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887E463B9
	for <linux-serial@vger.kernel.org>; Sat, 13 Jun 2026 00:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310926; cv=none; b=mtZpj9YyVbzCW/VBDnfONTnMXD7rRhkTuI0OeZ/JUx2dE5L16c2OUXr5rYQhRp13W70lX+KK3majklG2hdb29aFRqPm32Wt+7aXFmDpin8euiEjY4X3/ufoJyifUW2eNx7phlZ2l82YQ/TogQChWrGAqIogi3XOjv7jJLG7CFsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310926; c=relaxed/simple;
	bh=JYi+WirMyN+mjobB6ikqnneTw6X/z649hnMohi6VV7Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tuHexcdS7xwT/urgUMZlWoMzwLe8EVQd6rPrP/tvA+3gJHrGwRNCQOk8nUZcJsflwrNQDWA0TvT3OJoK2XkooS7qsdJcBtMys8MD2AUxY86bZzdzWnAmRtrYVptlf9ifPhtI46ScowgXi0NY+WUki4hcvFT6pmCnJ63hC1MvO5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZScopns5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZScopns5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781310923; x=1812846923;
  h=date:from:to:cc:subject:message-id;
  bh=JYi+WirMyN+mjobB6ikqnneTw6X/z649hnMohi6VV7Q=;
  b=ZScopns5htmpUdSi5TZ3K8y/HCgKdzLhnGpXJ4/apurHH7WeF5Sv0L94
   VVxsvB02G0rNOyEMOK7ieZCHJxl5MSaOG9dDsBI2i1hBqC0BIljcuG0+a
   DNHUS+jb4hD9cBMpF+BkjyU8OCp1YxxcaFqYcCD3+kdGsdJTokKE64Mma
   PCHJvn4kLKMMMdHULgFWSxYK0KY7+3BJPfBey6bgnJJgxW4LNPnvC/Dzf
   kJgtJZV1Qt9xWMv6YS2mjyi+CIY7NLfObS9athrWhVCQp/UQX5foWdWsQ
   DwI7iPSIErBbRo+eH+TT0i3zzq4nubxg8MfYUa62MyahDtlU/uczH78Mw
   g==;
X-CSE-ConnectionGUID: eLeRol3URgqgyhSkFEcXWg==
X-CSE-MsgGUID: okxzcjerSN6OgOSXtwPSHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="81283420"
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="81283420"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 17:35:23 -0700
X-CSE-ConnectionGUID: MXHluNhJS8a6cV1HrKFYrA==
X-CSE-MsgGUID: jLM15mxHRL6zmMnqn0R0bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="242810213"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 12 Jun 2026 17:35:22 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wYCLH-00000000PXK-1ewQ;
	Sat, 13 Jun 2026 00:35:19 +0000
Date: Sat, 13 Jun 2026 08:35:01 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 426e83cab1f5d53069ac7030cb03e2d7c6367ef1
Message-ID: <202606130850.wjeHu6pf-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 426e83cab1f5d53069ac7030cb03e2d7c6367ef1  serial: 8250_pci: Don't specify conflicting values to pci_device_id members

elapsed time: 857m

configs tested: 308
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260612    gcc-13.4.0
arc                   randconfig-001-20260613    gcc-12.5.0
arc                   randconfig-002-20260612    gcc-13.4.0
arc                   randconfig-002-20260613    gcc-12.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260612    gcc-13.4.0
arm                   randconfig-001-20260613    gcc-12.5.0
arm                   randconfig-002-20260612    gcc-13.4.0
arm                   randconfig-002-20260613    gcc-12.5.0
arm                   randconfig-003-20260612    gcc-13.4.0
arm                   randconfig-003-20260613    gcc-12.5.0
arm                   randconfig-004-20260612    gcc-13.4.0
arm                   randconfig-004-20260613    gcc-12.5.0
arm                       spear13xx_defconfig    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    gcc-13.4.0
arm64                 randconfig-001-20260612    gcc-13.4.0
arm64                 randconfig-001-20260613    gcc-16.1.0
arm64                          randconfig-002    gcc-13.4.0
arm64                 randconfig-002-20260612    gcc-13.4.0
arm64                 randconfig-002-20260613    gcc-16.1.0
arm64                          randconfig-003    gcc-13.4.0
arm64                 randconfig-003-20260612    gcc-13.4.0
arm64                 randconfig-003-20260613    gcc-16.1.0
arm64                          randconfig-004    gcc-13.4.0
arm64                 randconfig-004-20260612    gcc-13.4.0
arm64                 randconfig-004-20260613    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    gcc-13.4.0
csky                  randconfig-001-20260612    gcc-13.4.0
csky                  randconfig-001-20260613    gcc-16.1.0
csky                           randconfig-002    gcc-13.4.0
csky                  randconfig-002-20260612    gcc-13.4.0
csky                  randconfig-002-20260613    gcc-16.1.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260612    gcc-11.5.0
hexagon               randconfig-001-20260613    clang-23
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260612    gcc-11.5.0
hexagon               randconfig-002-20260613    clang-23
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260612    gcc-14
i386        buildonly-randconfig-001-20260613    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260612    gcc-14
i386        buildonly-randconfig-002-20260613    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260612    gcc-14
i386        buildonly-randconfig-003-20260613    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260612    gcc-14
i386        buildonly-randconfig-004-20260613    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260612    gcc-14
i386        buildonly-randconfig-005-20260613    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260612    gcc-14
i386        buildonly-randconfig-006-20260613    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260612    clang-22
i386                  randconfig-001-20260613    clang-22
i386                  randconfig-002-20260612    clang-22
i386                  randconfig-002-20260613    clang-22
i386                  randconfig-003-20260612    clang-22
i386                  randconfig-003-20260613    clang-22
i386                  randconfig-004-20260612    clang-22
i386                  randconfig-004-20260613    clang-22
i386                  randconfig-005-20260612    clang-22
i386                  randconfig-005-20260613    clang-22
i386                  randconfig-006-20260612    clang-22
i386                  randconfig-006-20260613    clang-22
i386                  randconfig-007-20260612    clang-22
i386                  randconfig-007-20260613    clang-22
i386                           randconfig-011    clang-22
i386                  randconfig-011-20260612    clang-22
i386                  randconfig-011-20260613    gcc-14
i386                           randconfig-012    clang-22
i386                  randconfig-012-20260612    clang-22
i386                  randconfig-012-20260613    gcc-14
i386                           randconfig-013    clang-22
i386                  randconfig-013-20260612    clang-22
i386                  randconfig-013-20260613    gcc-14
i386                           randconfig-014    clang-22
i386                  randconfig-014-20260612    clang-22
i386                  randconfig-014-20260613    gcc-14
i386                           randconfig-015    clang-22
i386                  randconfig-015-20260612    clang-22
i386                  randconfig-015-20260613    gcc-14
i386                           randconfig-016    clang-22
i386                  randconfig-016-20260612    clang-22
i386                  randconfig-016-20260613    gcc-14
i386                           randconfig-017    clang-22
i386                  randconfig-017-20260612    clang-22
i386                  randconfig-017-20260613    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260612    gcc-11.5.0
loongarch             randconfig-001-20260613    clang-23
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260612    gcc-11.5.0
loongarch             randconfig-002-20260613    clang-23
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                          atari_defconfig    gcc-16.1.0
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260612    gcc-11.5.0
nios2                 randconfig-001-20260613    clang-23
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260612    gcc-11.5.0
nios2                 randconfig-002-20260613    clang-23
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-23
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260613    gcc-15.2.0
parisc                randconfig-002-20260613    gcc-15.2.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                  mpc885_ads_defconfig    clang-23
powerpc               randconfig-001-20260613    gcc-15.2.0
powerpc               randconfig-002-20260613    gcc-15.2.0
powerpc64             randconfig-001-20260613    gcc-15.2.0
powerpc64             randconfig-002-20260613    gcc-15.2.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-11.5.0
riscv                 randconfig-001-20260612    gcc-11.5.0
riscv                 randconfig-001-20260613    gcc-10.5.0
riscv                          randconfig-002    gcc-11.5.0
riscv                 randconfig-002-20260612    gcc-11.5.0
riscv                 randconfig-002-20260613    gcc-10.5.0
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-11.5.0
s390                  randconfig-001-20260612    gcc-11.5.0
s390                  randconfig-001-20260613    gcc-10.5.0
s390                           randconfig-002    gcc-11.5.0
s390                  randconfig-002-20260612    gcc-11.5.0
s390                  randconfig-002-20260613    gcc-10.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-23
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-11.5.0
sh                    randconfig-001-20260612    gcc-11.5.0
sh                    randconfig-001-20260613    gcc-10.5.0
sh                             randconfig-002    gcc-11.5.0
sh                    randconfig-002-20260612    gcc-11.5.0
sh                    randconfig-002-20260613    gcc-10.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260612    gcc-8.5.0
sparc                 randconfig-001-20260613    gcc-13.4.0
sparc                 randconfig-002-20260612    gcc-8.5.0
sparc                 randconfig-002-20260613    gcc-13.4.0
sparc                       sparc64_defconfig    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260612    gcc-8.5.0
sparc64               randconfig-001-20260613    gcc-13.4.0
sparc64               randconfig-002-20260612    gcc-8.5.0
sparc64               randconfig-002-20260613    gcc-13.4.0
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260612    gcc-8.5.0
um                    randconfig-001-20260613    gcc-13.4.0
um                    randconfig-002-20260612    gcc-8.5.0
um                    randconfig-002-20260613    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260612    gcc-14
x86_64      buildonly-randconfig-001-20260613    clang-22
x86_64      buildonly-randconfig-002-20260612    gcc-14
x86_64      buildonly-randconfig-002-20260613    clang-22
x86_64      buildonly-randconfig-003-20260612    gcc-14
x86_64      buildonly-randconfig-003-20260613    clang-22
x86_64      buildonly-randconfig-004-20260612    gcc-14
x86_64      buildonly-randconfig-004-20260613    clang-22
x86_64      buildonly-randconfig-005-20260612    gcc-14
x86_64      buildonly-randconfig-005-20260613    clang-22
x86_64      buildonly-randconfig-006-20260612    gcc-14
x86_64      buildonly-randconfig-006-20260613    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260612    clang-22
x86_64                randconfig-001-20260613    clang-22
x86_64                randconfig-002-20260612    clang-22
x86_64                randconfig-002-20260613    clang-22
x86_64                randconfig-003-20260612    clang-22
x86_64                randconfig-003-20260613    clang-22
x86_64                randconfig-004-20260612    clang-22
x86_64                randconfig-004-20260613    clang-22
x86_64                randconfig-005-20260612    clang-22
x86_64                randconfig-005-20260613    clang-22
x86_64                randconfig-006-20260612    clang-22
x86_64                randconfig-006-20260613    clang-22
x86_64                         randconfig-011    clang-22
x86_64                randconfig-011-20260612    clang-22
x86_64                randconfig-011-20260613    clang-22
x86_64                         randconfig-012    clang-22
x86_64                randconfig-012-20260612    clang-22
x86_64                randconfig-012-20260613    clang-22
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260612    clang-22
x86_64                randconfig-013-20260613    clang-22
x86_64                         randconfig-014    clang-22
x86_64                randconfig-014-20260612    clang-22
x86_64                randconfig-014-20260613    clang-22
x86_64                         randconfig-015    clang-22
x86_64                randconfig-015-20260612    clang-22
x86_64                randconfig-015-20260613    clang-22
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260612    clang-22
x86_64                randconfig-016-20260613    clang-22
x86_64                randconfig-071-20260612    gcc-14
x86_64                randconfig-071-20260613    clang-22
x86_64                randconfig-072-20260612    gcc-14
x86_64                randconfig-072-20260613    clang-22
x86_64                randconfig-073-20260612    gcc-14
x86_64                randconfig-073-20260613    clang-22
x86_64                randconfig-074-20260612    gcc-14
x86_64                randconfig-074-20260613    clang-22
x86_64                randconfig-075-20260612    gcc-14
x86_64                randconfig-075-20260613    clang-22
x86_64                randconfig-076-20260612    gcc-14
x86_64                randconfig-076-20260613    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260612    gcc-8.5.0
xtensa                randconfig-001-20260613    gcc-13.4.0
xtensa                randconfig-002-20260612    gcc-8.5.0
xtensa                randconfig-002-20260613    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
