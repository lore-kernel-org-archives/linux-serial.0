Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6AF20DD51
	for <linux-serial@vger.kernel.org>; Sat,  4 Jul 2026 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783164515; cv=none; b=JQEz9LbQqnsyUFLjvKv7Km/77/gpEuddCLLwQ5kxxs/F4PPOw1NyWEUM9uUgXIE3Xsl2Xo3OBSeEorGOvHN/DtEToBAsUeXwvSEyAaPkNqQmUrRx/vWjCIebtTaAVQUfqsOTFqh03k3PbPo9HOB59Y7Nc1F1TASlH/ublKWXPvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783164515; c=relaxed/simple;
	bh=WJLjZrHsUGxoW40WAnYm6rUwpg0Q5DEBy5o8i5kvgbQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LGvYgmjTj0W9spPo5vsFstLJL3G/iYm09RC6ulu7DwwUqKHa40eC09LzfoWM2Ro/SowtlYVpL28c7nm1AGCiSF9/PoQaC/l8HjZZS0mstpoB1lJUdSTP/T7FjevgBZLhsACS2WF+OoO8gNdH49IIiQY1G6ybh5m7lXVZed8ht14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k9kjwgOU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9kjwgOU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783164513; x=1814700513;
  h=date:from:to:cc:subject:message-id;
  bh=WJLjZrHsUGxoW40WAnYm6rUwpg0Q5DEBy5o8i5kvgbQ=;
  b=k9kjwgOUsEilmmQq7c9FKYOn0NMuWladrESisVIDLcr0J4gm28GqsSIY
   Rx6pN7HTxQRJOlvYZQSnYTrkJLVGZzHAG0gCBkQ4Cl0kX1tHdgiV9+26K
   fhRPpPC71npMYlluOdCfZXsbqM7FaLscqMdofGXToC67lyX6ErYg/6uka
   WJIq0BGe3Eu8ITGwuvNXrOb3HUgBPFBCiASAGMeFl8m6uT1R3GXI3lnNA
   GuBRDYvhjBR9OZvmGidEhEHbESG4K5nqP4lj+IG3xmdBzMLlBENCjempE
   YrNNiO/DqIEOQyWwJeIDOVH5eGhYw43q29EfideVhSgR06aJWf7BVZEJj
   g==;
X-CSE-ConnectionGUID: 3gQ9taV0QWabF8dcQdK6yQ==
X-CSE-MsgGUID: 7SUpvoulQfuKbL2OcNhSSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="101424786"
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="101424786"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 04:28:32 -0700
X-CSE-ConnectionGUID: pjDb7TyTQbSOl7AaTU8A9Q==
X-CSE-MsgGUID: vaqCDJ/KRTCuDXp2wUIXPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="249942701"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 04 Jul 2026 04:28:30 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wfyXZ-00000000D1x-2gz7;
	Sat, 04 Jul 2026 11:28:13 +0000
Date: Sat, 04 Jul 2026 19:27:33 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 e508a176d86f5ca0916ac1caf80806f9ad3d91ef
Message-ID: <202607041923.oNPr02qY-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: e508a176d86f5ca0916ac1caf80806f9ad3d91ef  tty: goldfish: use guard() for locks

elapsed time: 793m

configs tested: 260
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-16.1.0
arc                         haps_hs_defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-16.1.0
arc                   randconfig-001-20260704    gcc-16.1.0
arc                   randconfig-001-20260704    gcc-8.5.0
arc                            randconfig-002    gcc-16.1.0
arc                   randconfig-002-20260704    gcc-16.1.0
arc                   randconfig-002-20260704    gcc-8.5.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                         at91_dt_defconfig    clang-17
arm                                 defconfig    gcc-16.1.0
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260704    gcc-16.1.0
arm                   randconfig-001-20260704    gcc-8.5.0
arm                            randconfig-002    gcc-16.1.0
arm                   randconfig-002-20260704    gcc-16.1.0
arm                   randconfig-002-20260704    gcc-8.5.0
arm                            randconfig-003    gcc-16.1.0
arm                   randconfig-003-20260704    gcc-16.1.0
arm                   randconfig-003-20260704    gcc-8.5.0
arm                            randconfig-004    gcc-16.1.0
arm                   randconfig-004-20260704    gcc-16.1.0
arm                   randconfig-004-20260704    gcc-8.5.0
arm                         s3c6400_defconfig    gcc-16.1.0
arm                          sp7021_defconfig    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    gcc-16.1.0
arm64                 randconfig-001-20260704    gcc-16.1.0
arm64                          randconfig-002    gcc-16.1.0
arm64                 randconfig-002-20260704    gcc-16.1.0
arm64                          randconfig-003    gcc-16.1.0
arm64                 randconfig-003-20260704    gcc-16.1.0
arm64                          randconfig-004    gcc-16.1.0
arm64                 randconfig-004-20260704    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    gcc-16.1.0
csky                  randconfig-001-20260704    gcc-16.1.0
csky                           randconfig-002    gcc-16.1.0
csky                  randconfig-002-20260704    gcc-16.1.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260704    gcc-11.5.0
hexagon               randconfig-001-20260704    gcc-16.1.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260704    gcc-11.5.0
hexagon               randconfig-002-20260704    gcc-16.1.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260704    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260704    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260704    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260704    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260704    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260704    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260704    gcc-14
i386                  randconfig-002-20260704    gcc-14
i386                  randconfig-003-20260704    gcc-14
i386                  randconfig-004-20260704    gcc-14
i386                  randconfig-005-20260704    gcc-14
i386                  randconfig-006-20260704    gcc-14
i386                  randconfig-007-20260704    gcc-14
i386                           randconfig-011    gcc-13
i386                  randconfig-011-20260704    gcc-13
i386                           randconfig-012    gcc-13
i386                  randconfig-012-20260704    gcc-13
i386                           randconfig-013    gcc-13
i386                  randconfig-013-20260704    gcc-13
i386                           randconfig-014    gcc-13
i386                  randconfig-014-20260704    gcc-13
i386                           randconfig-015    gcc-13
i386                  randconfig-015-20260704    gcc-13
i386                           randconfig-016    gcc-13
i386                  randconfig-016-20260704    gcc-13
i386                           randconfig-017    gcc-13
i386                  randconfig-017-20260704    gcc-13
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260704    gcc-11.5.0
loongarch             randconfig-001-20260704    gcc-16.1.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260704    gcc-11.5.0
loongarch             randconfig-002-20260704    gcc-16.1.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                          eyeq5_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260704    gcc-11.5.0
nios2                 randconfig-001-20260704    gcc-16.1.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260704    gcc-11.5.0
nios2                 randconfig-002-20260704    gcc-16.1.0
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260704    clang-23
parisc                randconfig-002-20260704    clang-23
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260704    clang-23
powerpc               randconfig-002-20260704    clang-23
powerpc64             randconfig-001-20260704    clang-23
powerpc64             randconfig-002-20260704    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260704    gcc-10.5.0
riscv                 randconfig-002-20260704    gcc-10.5.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260704    gcc-10.5.0
s390                  randconfig-002-20260704    gcc-10.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                            hp6xx_defconfig    gcc-16.1.0
sh                    randconfig-001-20260704    gcc-10.5.0
sh                    randconfig-002-20260704    gcc-10.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-16.1.0
sparc                 randconfig-001-20260704    gcc-16.1.0
sparc                          randconfig-002    gcc-16.1.0
sparc                 randconfig-002-20260704    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-16.1.0
sparc64               randconfig-001-20260704    gcc-16.1.0
sparc64                        randconfig-002    gcc-16.1.0
sparc64               randconfig-002-20260704    gcc-16.1.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-16.1.0
um                    randconfig-001-20260704    gcc-16.1.0
um                             randconfig-002    gcc-16.1.0
um                    randconfig-002-20260704    gcc-16.1.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260704    gcc-14
x86_64      buildonly-randconfig-002-20260704    gcc-14
x86_64      buildonly-randconfig-003-20260704    gcc-14
x86_64      buildonly-randconfig-004-20260704    gcc-14
x86_64      buildonly-randconfig-005-20260704    gcc-14
x86_64      buildonly-randconfig-006-20260704    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    clang-22
x86_64                randconfig-001-20260704    clang-22
x86_64                         randconfig-002    clang-22
x86_64                randconfig-002-20260704    clang-22
x86_64                         randconfig-003    clang-22
x86_64                randconfig-003-20260704    clang-22
x86_64                         randconfig-004    clang-22
x86_64                randconfig-004-20260704    clang-22
x86_64                         randconfig-005    clang-22
x86_64                randconfig-005-20260704    clang-22
x86_64                         randconfig-006    clang-22
x86_64                randconfig-006-20260704    clang-22
x86_64                         randconfig-011    clang-22
x86_64                randconfig-011-20260704    clang-22
x86_64                         randconfig-012    clang-22
x86_64                randconfig-012-20260704    clang-22
x86_64                randconfig-012-20260704    gcc-14
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260704    clang-22
x86_64                         randconfig-014    clang-22
x86_64                randconfig-014-20260704    clang-22
x86_64                         randconfig-015    clang-22
x86_64                randconfig-015-20260704    clang-22
x86_64                randconfig-015-20260704    gcc-14
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260704    clang-22
x86_64                randconfig-016-20260704    gcc-14
x86_64                         randconfig-071    gcc-14
x86_64                randconfig-071-20260704    gcc-14
x86_64                         randconfig-072    gcc-14
x86_64                randconfig-072-20260704    gcc-14
x86_64                         randconfig-073    gcc-14
x86_64                randconfig-073-20260704    gcc-14
x86_64                         randconfig-074    gcc-14
x86_64                randconfig-074-20260704    gcc-14
x86_64                         randconfig-075    gcc-14
x86_64                randconfig-075-20260704    gcc-14
x86_64                         randconfig-076    gcc-14
x86_64                randconfig-076-20260704    gcc-14
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
xtensa                         randconfig-001    gcc-16.1.0
xtensa                randconfig-001-20260704    gcc-16.1.0
xtensa                         randconfig-002    gcc-16.1.0
xtensa                randconfig-002-20260704    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
