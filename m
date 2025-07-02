Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429191E5B6D
	for <linux-serial@vger.kernel.org>; Wed,  2 Jul 2025 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751444365; cv=none; b=FNOBE/wEU/7+T4cpKa+n3uK94+ndRj1HnXQADerkECvg6LtbiPoTnRV6kBjdx17b70Qcl1jgmvjMH0zNI4V4TEId7XM5U2lGnCm+bXCVgBaJt+dnmTUjImL2FgqQVE143tk5iEmw9BaxLOGdreHowqLb9YR5j0RZp0ICySPjBvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751444365; c=relaxed/simple;
	bh=8vXzB4t7XiO8F2zCzh/CxzZTnZ7DAJjUfC8HFFxfLTY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uN0tQfa6EWCm6N/NghdBPUQqVpCeu7MFniLK8LpXSEuVqgqqLw7nvqLhejJ8v7Y/NZUShr7WVSTQKnbN8lce+jZz3pZanJAL9y7z3zXJISRukouWGROpehwZq+tEoJUbB8MbvTwLTbZ2uwnotbQz47Q4UTNsbAoUxQQSarurYl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3UZr3qL; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3UZr3qL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751444363; x=1782980363;
  h=date:from:to:cc:subject:message-id;
  bh=8vXzB4t7XiO8F2zCzh/CxzZTnZ7DAJjUfC8HFFxfLTY=;
  b=h3UZr3qL6TnwmG6nhWM09c9Qc+pKG6BUaSAvdWldHQOk3zutfJsPp9bd
   QGkSxsDkdXevqTQYnj7Mg2q9DhxEtk8urHaXyKnA9StW5o2rlgo+TRQW0
   LEgyh9nAxAujxmAT5HzD8zvZXZ7PbebhLKEuiP4cJgo14XvsU36AMfeKZ
   KYDMlF4Jx4C7FJiUQ62D2wcsnD/OFZQSdtkq4GLWBvE9ci2fQ2uCcwPtS
   S1jyqdPDVmlsQOXRMmjOJ1hhtaej1vylrHy8jRNuCoSwj+IzYQxs4D+w/
   K66DMCLOGLoaTScxjqfIdlTTicxkfbGIaTfAOWsXrsuh8pn97m7mItbzY
   g==;
X-CSE-ConnectionGUID: tYaQE+RATAyBrSe+xtPfQw==
X-CSE-MsgGUID: rVo4Kp9iT/GT4FO506K9UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53659537"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="53659537"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 01:19:22 -0700
X-CSE-ConnectionGUID: HuRY4quxTGitaJapxqgOBg==
X-CSE-MsgGUID: p+atdZdySdKZ3qI/kZyWIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="153783405"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 02 Jul 2025 01:19:21 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWsgY-0000Ml-22;
	Wed, 02 Jul 2025 08:19:18 +0000
Date: Wed, 02 Jul 2025 16:18:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 0c8a3a284a4fb56f0540f216f7428b39ba911ac8
Message-ID: <202507021606.Uq713uv3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 0c8a3a284a4fb56f0540f216f7428b39ba911ac8  dt-bindings: serial: mediatek,uart: add MT6572

elapsed time: 1349m

configs tested: 259
configs skipped: 7

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
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250701    gcc-13.3.0
arc                   randconfig-001-20250702    clang-19
arc                   randconfig-002-20250701    gcc-15.1.0
arc                   randconfig-002-20250702    clang-19
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                          gemini_defconfig    gcc-15.1.0
arm                      integrator_defconfig    gcc-15.1.0
arm                        multi_v7_defconfig    gcc-15.1.0
arm                        mvebu_v7_defconfig    gcc-15.1.0
arm                   randconfig-001-20250701    clang-17
arm                   randconfig-001-20250702    clang-19
arm                   randconfig-002-20250701    gcc-8.5.0
arm                   randconfig-002-20250702    clang-19
arm                   randconfig-003-20250701    clang-21
arm                   randconfig-003-20250702    clang-19
arm                   randconfig-004-20250701    clang-21
arm                   randconfig-004-20250702    clang-19
arm                           u8500_defconfig    gcc-15.1.0
arm                         wpcm450_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250701    clang-21
arm64                 randconfig-001-20250702    clang-19
arm64                 randconfig-002-20250701    gcc-15.1.0
arm64                 randconfig-002-20250702    clang-19
arm64                 randconfig-003-20250701    clang-18
arm64                 randconfig-003-20250702    clang-19
arm64                 randconfig-004-20250701    gcc-8.5.0
arm64                 randconfig-004-20250702    clang-19
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250701    gcc-11.5.0
csky                  randconfig-001-20250702    gcc-14.2.0
csky                  randconfig-002-20250701    gcc-10.5.0
csky                  randconfig-002-20250702    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250701    clang-21
hexagon               randconfig-001-20250702    gcc-14.2.0
hexagon               randconfig-002-20250701    clang-21
hexagon               randconfig-002-20250702    gcc-14.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250701    gcc-12
i386        buildonly-randconfig-001-20250702    clang-20
i386        buildonly-randconfig-002-20250701    gcc-12
i386        buildonly-randconfig-002-20250702    clang-20
i386        buildonly-randconfig-003-20250701    gcc-12
i386        buildonly-randconfig-003-20250702    clang-20
i386        buildonly-randconfig-004-20250701    gcc-12
i386        buildonly-randconfig-004-20250702    clang-20
i386        buildonly-randconfig-005-20250701    gcc-12
i386        buildonly-randconfig-005-20250702    clang-20
i386        buildonly-randconfig-006-20250701    clang-20
i386        buildonly-randconfig-006-20250702    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250702    clang-20
i386                  randconfig-002-20250702    clang-20
i386                  randconfig-003-20250702    clang-20
i386                  randconfig-004-20250702    clang-20
i386                  randconfig-005-20250702    clang-20
i386                  randconfig-006-20250702    clang-20
i386                  randconfig-007-20250702    clang-20
i386                  randconfig-011-20250702    gcc-12
i386                  randconfig-012-20250702    gcc-12
i386                  randconfig-013-20250702    gcc-12
i386                  randconfig-014-20250702    gcc-12
i386                  randconfig-015-20250702    gcc-12
i386                  randconfig-016-20250702    gcc-12
i386                  randconfig-017-20250702    gcc-12
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250701    gcc-13.3.0
loongarch             randconfig-001-20250702    gcc-14.2.0
loongarch             randconfig-002-20250701    gcc-15.1.0
loongarch             randconfig-002-20250702    gcc-14.2.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
m68k                           virt_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip32_defconfig    gcc-15.1.0
mips                         rt305x_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250701    gcc-14.2.0
nios2                 randconfig-001-20250702    gcc-14.2.0
nios2                 randconfig-002-20250701    gcc-13.3.0
nios2                 randconfig-002-20250702    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250701    gcc-14.3.0
parisc                randconfig-001-20250702    gcc-14.2.0
parisc                randconfig-002-20250701    gcc-10.5.0
parisc                randconfig-002-20250702    gcc-14.2.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      chrp32_defconfig    gcc-15.1.0
powerpc                       ebony_defconfig    gcc-15.1.0
powerpc                     mpc512x_defconfig    gcc-15.1.0
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250701    gcc-13.3.0
powerpc               randconfig-001-20250702    gcc-14.2.0
powerpc               randconfig-002-20250701    clang-21
powerpc               randconfig-002-20250702    gcc-14.2.0
powerpc               randconfig-003-20250701    clang-21
powerpc               randconfig-003-20250702    gcc-14.2.0
powerpc                     sequoia_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250701    clang-21
powerpc64             randconfig-001-20250702    gcc-14.2.0
powerpc64             randconfig-002-20250701    clang-21
powerpc64             randconfig-002-20250702    gcc-14.2.0
powerpc64             randconfig-003-20250701    gcc-10.5.0
powerpc64             randconfig-003-20250702    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250701    gcc-14.3.0
riscv                 randconfig-001-20250702    clang-21
riscv                 randconfig-002-20250701    gcc-10.5.0
riscv                 randconfig-002-20250702    clang-21
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250701    gcc-9.3.0
s390                  randconfig-001-20250702    clang-21
s390                  randconfig-002-20250701    clang-17
s390                  randconfig-002-20250702    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                        edosk7705_defconfig    gcc-15.1.0
sh                             espt_defconfig    gcc-15.1.0
sh                    randconfig-001-20250701    gcc-15.1.0
sh                    randconfig-001-20250702    clang-21
sh                    randconfig-002-20250701    gcc-13.3.0
sh                    randconfig-002-20250702    clang-21
sh                           se7722_defconfig    gcc-15.1.0
sh                     sh7710voipgw_defconfig    gcc-15.1.0
sh                        sh7763rdp_defconfig    gcc-15.1.0
sh                  sh7785lcr_32bit_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250701    gcc-10.3.0
sparc                 randconfig-001-20250702    clang-21
sparc                 randconfig-002-20250701    gcc-15.1.0
sparc                 randconfig-002-20250702    clang-21
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250701    gcc-8.5.0
sparc64               randconfig-001-20250702    clang-21
sparc64               randconfig-002-20250701    gcc-12.4.0
sparc64               randconfig-002-20250702    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250701    gcc-12
um                    randconfig-001-20250702    clang-21
um                    randconfig-002-20250701    gcc-12
um                    randconfig-002-20250702    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250701    gcc-12
x86_64      buildonly-randconfig-001-20250702    gcc-11
x86_64      buildonly-randconfig-002-20250701    gcc-12
x86_64      buildonly-randconfig-002-20250702    gcc-11
x86_64      buildonly-randconfig-003-20250701    gcc-12
x86_64      buildonly-randconfig-003-20250702    gcc-11
x86_64      buildonly-randconfig-004-20250701    gcc-12
x86_64      buildonly-randconfig-004-20250702    gcc-11
x86_64      buildonly-randconfig-005-20250701    clang-20
x86_64      buildonly-randconfig-005-20250702    gcc-11
x86_64      buildonly-randconfig-006-20250701    clang-20
x86_64      buildonly-randconfig-006-20250702    gcc-11
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-004-20250702    gcc-12
x86_64                randconfig-005-20250702    gcc-12
x86_64                randconfig-006-20250702    gcc-12
x86_64                randconfig-007-20250702    gcc-12
x86_64                randconfig-008-20250702    gcc-12
x86_64                randconfig-071-20250702    clang-20
x86_64                randconfig-072-20250702    clang-20
x86_64                randconfig-073-20250702    clang-20
x86_64                randconfig-074-20250702    clang-20
x86_64                randconfig-075-20250702    clang-20
x86_64                randconfig-076-20250702    clang-20
x86_64                randconfig-077-20250702    clang-20
x86_64                randconfig-078-20250702    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  cadence_csp_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250701    gcc-15.1.0
xtensa                randconfig-001-20250702    clang-21
xtensa                randconfig-002-20250701    gcc-13.3.0
xtensa                randconfig-002-20250702    clang-21

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
