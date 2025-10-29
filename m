Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E262A337BBA
	for <linux-serial@vger.kernel.org>; Wed, 29 Oct 2025 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761738372; cv=none; b=rurxcyvNpnY6ma977tkLHlRAcTV8RSVLhwFOlYT/s6D21GRjngH/b7cr/TJjlVDOsTCgUEO60E2TrMk93bdYcOOspbjmPMPN747agfbKfL+yMGm4EW4R0P2BrJp8v55L9nj6O5slRgKu6DGe4Yzm/07GjI7rvLIWVyv1UfPf1Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761738372; c=relaxed/simple;
	bh=FwlPw/pj4nXPvMsAL9HSnfMeohWGtt5+BqXfTTOHXdE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Dfd0Ck+uJimJ4Fmd5puOxWFW1NYGWjakbE6hP8ASIdJKZGbvrmtMI6cjDn1qqmzMnxyI+qoNiU8kzrDOv3/eolW99lLoOsXRX17Hzw8yV4sgRlwZf4x8T2tOEaJ4IIhTC6aaA/FcGuhlPAHcfGgbgK9+dDxpkABMLdbD3ksgZkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UmHdAKhC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UmHdAKhC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761738370; x=1793274370;
  h=date:from:to:cc:subject:message-id;
  bh=FwlPw/pj4nXPvMsAL9HSnfMeohWGtt5+BqXfTTOHXdE=;
  b=UmHdAKhC0U0jPGJcpxVRr+7+RWvMT+Zu9D6vVkvjEEi7oVaAKAJAu6RJ
   ylbezpcojjli1GDZASMItNn0I1BClxcRJLVcrSyXkTBZ9QnP7jzbEAuHk
   P6teheUio/MvixY60f7OV957IUh6xRBCREPEozlygyCQV3/Yuc5kxtlXp
   r5TUvJUrGTzAs62+4qpR6ZFMibNv8TNyz/wVeKVNmXzIGA3x0evVtDNLT
   UJyN89D01Zi7/tsviMhlkPTpKIGDk3I33/UGMQqHGHrZV/xV6Ckzjvsu0
   yxi/v1UnfBfTJpivzksO3kWk6ek0Zpdg5Wvi+/TyRhQPH3DGhZXOOMPBO
   w==;
X-CSE-ConnectionGUID: zjmUdT1UQVqyuOhEBgd5wQ==
X-CSE-MsgGUID: 3bXeSuN/QqqQolMmej8nhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="63557462"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="63557462"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 04:46:09 -0700
X-CSE-ConnectionGUID: KIa8+GeLQx29GYI4sNJZvw==
X-CSE-MsgGUID: 3Ym4UyznQAO8HH/KC9Wv9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="185987376"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 29 Oct 2025 04:46:06 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vE4ck-000KZ3-0n;
	Wed, 29 Oct 2025 11:45:56 +0000
Date: Wed, 29 Oct 2025 19:45:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 eb4917f557d43c7a1c805dd73ffcdfddb2aba39a
Message-ID: <202510291943.NWq32Nuf-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: eb4917f557d43c7a1c805dd73ffcdfddb2aba39a  serial: amba-pl011: prefer dma_mapping_error() over explicit address checking

elapsed time: 1201m

configs tested: 217
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251029    clang-22
arc                   randconfig-001-20251029    gcc-15.1.0
arc                   randconfig-002-20251029    clang-22
arc                   randconfig-002-20251029    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                     am200epdkit_defconfig    gcc-15.1.0
arm                        clps711x_defconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                   randconfig-001-20251029    clang-22
arm                   randconfig-001-20251029    gcc-8.5.0
arm                   randconfig-002-20251029    clang-22
arm                   randconfig-003-20251029    clang-22
arm                   randconfig-004-20251029    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251029    gcc-12.5.0
arm64                 randconfig-002-20251029    clang-22
arm64                 randconfig-003-20251029    gcc-13.4.0
arm64                 randconfig-004-20251029    gcc-11.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251029    gcc-9.5.0
csky                  randconfig-002-20251029    gcc-11.5.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251029    clang-20
hexagon               randconfig-002-20251029    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251029    gcc-14
i386        buildonly-randconfig-002-20251029    gcc-14
i386        buildonly-randconfig-003-20251029    clang-20
i386        buildonly-randconfig-003-20251029    gcc-14
i386        buildonly-randconfig-004-20251029    gcc-14
i386        buildonly-randconfig-005-20251029    gcc-14
i386        buildonly-randconfig-006-20251029    gcc-14
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251029    clang-20
i386                  randconfig-001-20251029    gcc-14
i386                  randconfig-002-20251029    clang-20
i386                  randconfig-002-20251029    gcc-14
i386                  randconfig-003-20251029    clang-20
i386                  randconfig-004-20251029    clang-20
i386                  randconfig-004-20251029    gcc-14
i386                  randconfig-005-20251029    clang-20
i386                  randconfig-006-20251029    clang-20
i386                  randconfig-006-20251029    gcc-14
i386                  randconfig-007-20251029    clang-20
i386                  randconfig-011-20251029    gcc-14
i386                  randconfig-012-20251029    gcc-14
i386                  randconfig-013-20251029    gcc-14
i386                  randconfig-014-20251029    gcc-14
i386                  randconfig-015-20251029    gcc-14
i386                  randconfig-016-20251029    gcc-14
i386                  randconfig-017-20251029    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251029    clang-22
loongarch             randconfig-002-20251029    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                          hp300_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251029    gcc-11.5.0
nios2                 randconfig-002-20251029    gcc-9.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251029    gcc-12.5.0
parisc                randconfig-001-20251029    gcc-8.5.0
parisc                randconfig-002-20251029    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      katmai_defconfig    gcc-15.1.0
powerpc                     mpc83xx_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251029    clang-22
powerpc               randconfig-001-20251029    gcc-8.5.0
powerpc               randconfig-002-20251029    gcc-12.5.0
powerpc               randconfig-002-20251029    gcc-8.5.0
powerpc64             randconfig-001-20251029    clang-22
powerpc64             randconfig-001-20251029    gcc-8.5.0
powerpc64             randconfig-002-20251029    clang-22
powerpc64             randconfig-002-20251029    gcc-8.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251029    clang-20
riscv                 randconfig-002-20251029    clang-19
riscv                 randconfig-002-20251029    clang-20
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251029    clang-20
s390                  randconfig-001-20251029    gcc-11.5.0
s390                  randconfig-002-20251029    clang-20
s390                  randconfig-002-20251029    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                          landisk_defconfig    gcc-15.1.0
sh                    randconfig-001-20251029    clang-20
sh                    randconfig-001-20251029    gcc-11.5.0
sh                    randconfig-002-20251029    clang-20
sh                    randconfig-002-20251029    gcc-15.1.0
sh                     sh7710voipgw_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251029    clang-22
sparc                 randconfig-001-20251029    gcc-8.5.0
sparc                 randconfig-002-20251029    clang-22
sparc                 randconfig-002-20251029    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251029    clang-20
sparc64               randconfig-001-20251029    clang-22
sparc64               randconfig-002-20251029    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251029    clang-22
um                    randconfig-002-20251029    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251029    clang-20
x86_64      buildonly-randconfig-001-20251029    gcc-14
x86_64      buildonly-randconfig-002-20251029    clang-20
x86_64      buildonly-randconfig-003-20251029    clang-20
x86_64      buildonly-randconfig-004-20251029    clang-20
x86_64      buildonly-randconfig-005-20251029    clang-20
x86_64      buildonly-randconfig-006-20251029    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251029    gcc-12
x86_64                randconfig-002-20251029    gcc-12
x86_64                randconfig-003-20251029    gcc-12
x86_64                randconfig-004-20251029    gcc-12
x86_64                randconfig-005-20251029    gcc-12
x86_64                randconfig-006-20251029    gcc-12
x86_64                randconfig-011-20251029    clang-20
x86_64                randconfig-011-20251029    gcc-13
x86_64                randconfig-012-20251029    clang-20
x86_64                randconfig-012-20251029    gcc-13
x86_64                randconfig-013-20251029    gcc-13
x86_64                randconfig-013-20251029    gcc-14
x86_64                randconfig-014-20251029    clang-20
x86_64                randconfig-014-20251029    gcc-13
x86_64                randconfig-015-20251029    gcc-13
x86_64                randconfig-016-20251029    gcc-13
x86_64                randconfig-071-20251029    clang-20
x86_64                randconfig-072-20251029    clang-20
x86_64                randconfig-073-20251029    clang-20
x86_64                randconfig-074-20251029    clang-20
x86_64                randconfig-075-20251029    clang-20
x86_64                randconfig-076-20251029    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251029    clang-22
xtensa                randconfig-001-20251029    gcc-8.5.0
xtensa                randconfig-002-20251029    clang-22
xtensa                randconfig-002-20251029    gcc-8.5.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
