Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C45166F1A
	for <linux-serial@vger.kernel.org>; Thu, 14 Aug 2025 22:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755210117; cv=none; b=deS+e7PPTS5p69pDblGtBySyL6H8EiU8Hyy2Gj2AgGfewLZYkK4M8QSDh5gcZpUWbrnyb3kkEki891khHbbwbDgsDH2YSjl/7cxYkWr8/fXKcSZuRjeNu2xNRpZRFZ1VzSK2grU0oL6QGPWihi7ZN6kP5GUa3bkbX37jsrsYcl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755210117; c=relaxed/simple;
	bh=Yr1wikq9vas0u4VLHfMwU2BkdKimlUzLJQ+qvqD1o7k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WiZEjcaKmodNrQvisxUvGsddsTTXQTF4h/Gnyf0s6EHKxdA+WeMD6Jv9NOWzAu4vBESmKsIFTge2BiQ0TafOhF6f6BZryHFDihnXkI34kptCTdwnbp6y5cTa7QuFt84AEnE9cPJSyzh13aLxAHLnVeFu35ah7BbWD/kuifx0OOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3db0en5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3db0en5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755210116; x=1786746116;
  h=date:from:to:cc:subject:message-id;
  bh=Yr1wikq9vas0u4VLHfMwU2BkdKimlUzLJQ+qvqD1o7k=;
  b=c3db0en5DDi+8ivTQWJ6LZHUHbbreUkEG/mjKRf4ZeZDT1X4OldNJhGv
   LgDBuufdVYQCzuTHeo8T1c3dJr/Kd6RnktVW02q1XWWsCGjtCMYG7xwkE
   YHRAoShe0nd+icKuZMfx2LdbDNg+yXGdjOGr/WUVHCdY6a5dReF0bQ2+8
   CZ1NfQIpFukOf5Ly8Ii1Hc5O/pWw1VeSvTUBThAKt7zrs1GhBEKLOC9P8
   kCWh13VlJJresyb3d9IEZf3ToZtZrjyZ9Suk3cFaj1E9Lsof20PQE/HnL
   Ptz8/YYXN9pwOpEnceGnbH80i3y8UFySIt31Yj0+C1Ed1x0Q/Oto47nzx
   A==;
X-CSE-ConnectionGUID: +WjxrzufSfaAI72B9PekbA==
X-CSE-MsgGUID: S54B5D3gRl6RLkcHMV6vpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="82974149"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="82974149"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 15:21:56 -0700
X-CSE-ConnectionGUID: 0dhSm8RXSt69lLvmLpkvXg==
X-CSE-MsgGUID: ty8rRYl9Qcam/wpkJ1CDmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="171070126"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 14 Aug 2025 15:21:54 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umgKR-000BMC-1w;
	Thu, 14 Aug 2025 22:21:49 +0000
Date: Fri, 15 Aug 2025 06:21:39 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 9391ab1ed9b3fe0d1af7d7858d9bf42f476628c8
Message-ID: <202508150630.WHna6c9j-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 9391ab1ed9b3fe0d1af7d7858d9bf42f476628c8  serial: qcom-geni: Make UART port count configurable via Kconfig

elapsed time: 723m

configs tested: 239
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                     haps_hs_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20250814    gcc-12.5.0
arc                   randconfig-001-20250815    clang-22
arc                   randconfig-002-20250814    gcc-13.4.0
arc                   randconfig-002-20250815    clang-22
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                      footbridge_defconfig    gcc-15.1.0
arm                        mvebu_v5_defconfig    gcc-15.1.0
arm                       omap2plus_defconfig    gcc-15.1.0
arm                   randconfig-001-20250814    clang-22
arm                   randconfig-001-20250815    clang-22
arm                   randconfig-002-20250814    clang-22
arm                   randconfig-002-20250815    clang-22
arm                   randconfig-003-20250814    gcc-10.5.0
arm                   randconfig-003-20250815    clang-22
arm                   randconfig-004-20250814    gcc-8.5.0
arm                   randconfig-004-20250815    clang-22
arm                        vexpress_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250814    clang-17
arm64                 randconfig-001-20250815    clang-22
arm64                 randconfig-002-20250814    gcc-8.5.0
arm64                 randconfig-002-20250815    clang-22
arm64                 randconfig-003-20250814    gcc-10.5.0
arm64                 randconfig-003-20250815    clang-22
arm64                 randconfig-004-20250814    gcc-13.4.0
arm64                 randconfig-004-20250815    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250814    gcc-15.1.0
csky                  randconfig-001-20250815    gcc-11.5.0
csky                  randconfig-002-20250814    gcc-15.1.0
csky                  randconfig-002-20250815    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250814    clang-20
hexagon               randconfig-001-20250815    gcc-11.5.0
hexagon               randconfig-002-20250814    clang-22
hexagon               randconfig-002-20250815    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250814    clang-20
i386        buildonly-randconfig-001-20250815    gcc-12
i386        buildonly-randconfig-002-20250814    gcc-12
i386        buildonly-randconfig-002-20250815    gcc-12
i386        buildonly-randconfig-003-20250814    gcc-12
i386        buildonly-randconfig-003-20250815    gcc-12
i386        buildonly-randconfig-004-20250814    clang-20
i386        buildonly-randconfig-004-20250815    gcc-12
i386        buildonly-randconfig-005-20250814    gcc-12
i386        buildonly-randconfig-005-20250815    gcc-12
i386        buildonly-randconfig-006-20250814    gcc-12
i386        buildonly-randconfig-006-20250815    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250815    gcc-12
i386                  randconfig-002-20250815    gcc-12
i386                  randconfig-003-20250815    gcc-12
i386                  randconfig-004-20250815    gcc-12
i386                  randconfig-005-20250815    gcc-12
i386                  randconfig-006-20250815    gcc-12
i386                  randconfig-007-20250815    gcc-12
i386                  randconfig-011-20250815    gcc-12
i386                  randconfig-012-20250815    gcc-12
i386                  randconfig-013-20250815    gcc-12
i386                  randconfig-014-20250815    gcc-12
i386                  randconfig-015-20250815    gcc-12
i386                  randconfig-016-20250815    gcc-12
i386                  randconfig-017-20250815    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250814    clang-22
loongarch             randconfig-001-20250815    gcc-11.5.0
loongarch             randconfig-002-20250814    gcc-15.1.0
loongarch             randconfig-002-20250815    gcc-11.5.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        qi_lb60_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250814    gcc-10.5.0
nios2                 randconfig-001-20250815    gcc-11.5.0
nios2                 randconfig-002-20250814    gcc-9.5.0
nios2                 randconfig-002-20250815    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250814    gcc-10.5.0
parisc                randconfig-001-20250815    gcc-11.5.0
parisc                randconfig-002-20250814    gcc-13.4.0
parisc                randconfig-002-20250815    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250814    gcc-8.5.0
powerpc               randconfig-001-20250815    gcc-11.5.0
powerpc               randconfig-002-20250814    gcc-8.5.0
powerpc               randconfig-002-20250815    gcc-11.5.0
powerpc               randconfig-003-20250814    gcc-10.5.0
powerpc               randconfig-003-20250815    gcc-11.5.0
powerpc64             randconfig-001-20250814    clang-22
powerpc64             randconfig-001-20250815    gcc-11.5.0
powerpc64             randconfig-002-20250814    clang-22
powerpc64             randconfig-002-20250815    gcc-11.5.0
powerpc64             randconfig-003-20250814    clang-22
powerpc64             randconfig-003-20250815    gcc-11.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250814    clang-22
riscv                 randconfig-001-20250815    gcc-8.5.0
riscv                 randconfig-002-20250814    clang-22
riscv                 randconfig-002-20250815    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250814    clang-22
s390                  randconfig-001-20250815    gcc-8.5.0
s390                  randconfig-002-20250814    gcc-8.5.0
s390                  randconfig-002-20250815    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250814    gcc-9.5.0
sh                    randconfig-001-20250815    gcc-8.5.0
sh                    randconfig-002-20250814    gcc-15.1.0
sh                    randconfig-002-20250815    gcc-8.5.0
sh                             shx3_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250814    gcc-14.3.0
sparc                 randconfig-001-20250815    gcc-8.5.0
sparc                 randconfig-002-20250814    gcc-12.5.0
sparc                 randconfig-002-20250815    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250814    clang-22
sparc64               randconfig-001-20250815    gcc-8.5.0
sparc64               randconfig-002-20250814    gcc-8.5.0
sparc64               randconfig-002-20250815    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250814    clang-22
um                    randconfig-001-20250815    gcc-8.5.0
um                    randconfig-002-20250814    clang-22
um                    randconfig-002-20250815    gcc-8.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250814    clang-20
x86_64      buildonly-randconfig-001-20250815    gcc-12
x86_64      buildonly-randconfig-002-20250814    clang-20
x86_64      buildonly-randconfig-002-20250815    gcc-12
x86_64      buildonly-randconfig-003-20250814    gcc-12
x86_64      buildonly-randconfig-003-20250815    gcc-12
x86_64      buildonly-randconfig-004-20250814    clang-20
x86_64      buildonly-randconfig-004-20250815    gcc-12
x86_64      buildonly-randconfig-005-20250814    gcc-12
x86_64      buildonly-randconfig-005-20250815    gcc-12
x86_64      buildonly-randconfig-006-20250814    gcc-12
x86_64      buildonly-randconfig-006-20250815    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250815    gcc-12
x86_64                randconfig-002-20250815    gcc-12
x86_64                randconfig-003-20250815    gcc-12
x86_64                randconfig-004-20250815    gcc-12
x86_64                randconfig-005-20250815    gcc-12
x86_64                randconfig-006-20250815    gcc-12
x86_64                randconfig-007-20250815    gcc-12
x86_64                randconfig-008-20250815    gcc-12
x86_64                randconfig-071-20250815    clang-20
x86_64                randconfig-072-20250815    clang-20
x86_64                randconfig-073-20250815    clang-20
x86_64                randconfig-074-20250815    clang-20
x86_64                randconfig-075-20250815    clang-20
x86_64                randconfig-076-20250815    clang-20
x86_64                randconfig-077-20250815    clang-20
x86_64                randconfig-078-20250815    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250814    gcc-8.5.0
xtensa                randconfig-001-20250815    gcc-8.5.0
xtensa                randconfig-002-20250814    gcc-10.5.0
xtensa                randconfig-002-20250815    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
