Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA3B46A4
	for <linux-serial@vger.kernel.org>; Tue,  7 May 2024 02:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715050759; cv=none; b=RE9aQuvhy4XNgNzCCdSnllAm/TlH/zm6b+8vpdyp6xmvPMi6umtn30/4IOry0qTCxaVzNdNV+1vUf2eTOFM3A64GbYPvB3KEmsdR1ocmjOO/4o85+gUXBfCKW6R3kVku5tHK5MzeA3XDosFBoEIu2mdGt2JP7hwrroFkSm4HY/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715050759; c=relaxed/simple;
	bh=1/dvarCpp3GMpTMqc5Uu14UP10j1fObasZVSi9H7sQM=;
	h=Date:From:To:Subject:Message-ID; b=QLmlof9q41nGF4JVWfdGDHfR8RLvQAadKcnNpb7hTrREY6GnqhGnSt/iEGjvLum6FtN3BFC1riAh81p935AZQ+RRG9Dm2R7GQ54MoAwLSkqK84Gsm2je8LYz/P0TVSjZ80+ZcMtC7A4Z7O9vzfV6Vz1mIPHcLOujdiHYdfZz39c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FVn2caS6; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FVn2caS6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715050757; x=1746586757;
  h=date:from:to:subject:message-id;
  bh=1/dvarCpp3GMpTMqc5Uu14UP10j1fObasZVSi9H7sQM=;
  b=FVn2caS6dts4ATsQLnN6yM2fvWK/cfAbaWl+D/a8/zq7j/ulw2RFanv+
   2fVUklujfXCs0LyxTHvmLL6XHh9mF47jhLGkpZgPTILhom41sC7hFV2tU
   9v6+I6I8r6NrzRyybG3yCMH+Lkr+uGfAKzdGYZyjdbhqocj2QElch5aKJ
   Y9SdhxlLEc1Rr3DnjHgFak1GW3B5c03afed7fd94aL7L0O6kPIndZjx9z
   J67lybAec4kcMflx1jQ5q0o6XP29+VBTnWmI/mMJXcNpc+RrSiL3w5Tym
   WfcpbpoZqBG0K8ouZ6skM0cTwQ8WzHkHcn+/NCha/4dhVIsjs2vgHsZEh
   g==;
X-CSE-ConnectionGUID: H0CEAqLcQcaIcP3jYGRbVQ==
X-CSE-MsgGUID: v2nIB5XrTICFC5jim/Vnqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10946946"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="10946946"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 19:59:16 -0700
X-CSE-ConnectionGUID: Pa3rXbcSRI6mTqinkkT7ow==
X-CSE-MsgGUID: CG4/AJdERzG/5pLxysNsfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="59219603"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 06 May 2024 19:59:15 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4B2u-0001GM-1P
	for linux-serial@vger.kernel.org;
	Tue, 07 May 2024 02:59:12 +0000
Date: Tue, 07 May 2024 10:58:19 +0800
From: kernel test robot <lkp@intel.com>
To: linux-serial@vger.kernel.org
Subject: [BUILD SUCCESS] LAST PATCH: [PATCH v1 2/2] serial: 8250:
 Extract platform driver
Message-ID: <202405071018.q4o4yXDD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/serial-8250-Extract-RSA-bits/20240506-220437
base:   next-20240506
patch link:    https://lore.kernel.org/r/20240506140308.4040735-3-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 2/2] serial: 8250: Extract platform driver

[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

elapsed time: 769m

configs tested: 147
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
arc                   randconfig-001-20240507   gcc  
arc                   randconfig-002-20240507   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240507   gcc  
arm                   randconfig-002-20240507   clang
arm                   randconfig-003-20240507   gcc  
arm                   randconfig-004-20240507   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240507   clang
arm64                 randconfig-002-20240507   clang
arm64                 randconfig-003-20240507   clang
arm64                 randconfig-004-20240507   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240507   gcc  
csky                  randconfig-002-20240507   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240507   clang
hexagon               randconfig-002-20240507   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240507   clang
i386         buildonly-randconfig-002-20240507   clang
i386         buildonly-randconfig-003-20240507   clang
i386         buildonly-randconfig-004-20240507   gcc  
i386         buildonly-randconfig-005-20240507   gcc  
i386         buildonly-randconfig-006-20240507   clang
i386                                defconfig   clang
i386                  randconfig-001-20240507   clang
i386                  randconfig-002-20240507   gcc  
i386                  randconfig-003-20240507   clang
i386                  randconfig-004-20240507   clang
i386                  randconfig-005-20240507   clang
i386                  randconfig-006-20240507   clang
i386                  randconfig-011-20240507   gcc  
i386                  randconfig-012-20240507   clang
i386                  randconfig-013-20240507   clang
i386                  randconfig-014-20240507   gcc  
i386                  randconfig-015-20240507   gcc  
i386                  randconfig-016-20240507   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240507   gcc  
loongarch             randconfig-002-20240507   gcc  
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
nios2                 randconfig-001-20240507   gcc  
nios2                 randconfig-002-20240507   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240507   gcc  
parisc                randconfig-002-20240507   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240507   gcc  
powerpc               randconfig-002-20240507   clang
powerpc               randconfig-003-20240507   clang
powerpc64             randconfig-001-20240507   gcc  
powerpc64             randconfig-002-20240507   gcc  
powerpc64             randconfig-003-20240507   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240507   clang
riscv                 randconfig-002-20240507   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240507   gcc  
s390                  randconfig-002-20240507   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240507   gcc  
sh                    randconfig-002-20240507   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240507   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240507   clang
x86_64       buildonly-randconfig-002-20240507   clang
x86_64       buildonly-randconfig-003-20240507   clang
x86_64       buildonly-randconfig-004-20240507   clang
x86_64       buildonly-randconfig-005-20240507   clang
x86_64       buildonly-randconfig-006-20240507   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240507   gcc  
x86_64                randconfig-002-20240507   clang
x86_64                randconfig-003-20240507   clang
x86_64                randconfig-004-20240507   gcc  
x86_64                randconfig-005-20240507   gcc  
x86_64                randconfig-006-20240507   gcc  
x86_64                randconfig-011-20240507   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
