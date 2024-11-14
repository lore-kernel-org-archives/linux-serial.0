Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AFD14B06C
	for <linux-serial@vger.kernel.org>; Thu, 14 Nov 2024 03:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731556187; cv=none; b=VooF/a1EoBuLa+AnStrRKNUWKXPYpfpC2xF4AkiZIyXrXU8Hh+rHMPI6t1ceWVybYUcxHpTjLJExSAJYhmeqK5EVSyqXY9g7hG+FBN+VvRelV/6BA7do69EdMsrA4ZxwbAMskSVwZIzlG/1qWopWTsT6MnBZGQ9YDPwEbMTdpbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731556187; c=relaxed/simple;
	bh=yNQ0X5agHNrWqcJeCBGsAl4u+r449u8Ht+jeADxMYqA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JZXET9aKyYOwCoW3f80vg5zSm0agZZCEtlj4MOk0sqH1tiTFx5IBkP/uodiv6W1bPJ5F1rbiRhNt4/Eo9NoL1bbDSYpVhJLi92Yy/UC5wiVnOPXrXGpcKaVKwsUMSynSr1F5yCXGqFhfanWLFX89hvn4wwNyCMXE9G4gyPI+6L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LS5ULTnU; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LS5ULTnU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731556186; x=1763092186;
  h=date:from:to:cc:subject:message-id;
  bh=yNQ0X5agHNrWqcJeCBGsAl4u+r449u8Ht+jeADxMYqA=;
  b=LS5ULTnURkXKXXimrKLk21Dzn+0tUydHPXcZdNwG2iW1KRkyh+EAilS8
   QwCSsldD9nNRmJFmxoXbt2IU0Y9fy2gDHMfnA3DXrTuqqTqDRwOMlO9Qa
   Ka1zbymzabVKawCuuIZZCzSMh7wyZTXHh8V2rbhS/UQX2yY6xkejbRrIp
   ZBbxPpYLhdxBlRfgOAyWfppj/Yd1NzuHrpkspsYIsH+HdVIawVi0yDRHK
   4GNMh396HQwW64oQhu2PBLfWXoBEbDlrdozuePkJ0nqVw4xsXyR3VLKAo
   TBkPMNbEA2qhLgFOpATETnY6FCbIJLNObjY7WhH4qc6F8cgufdgykWhla
   A==;
X-CSE-ConnectionGUID: lXWkO0iJRtSVPBtw9n9BEw==
X-CSE-MsgGUID: 3X3x4I7NRZC5Bc7XpuNNxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31341521"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31341521"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 19:49:43 -0800
X-CSE-ConnectionGUID: 7bunnkJARKiWLo9bVVSnPA==
X-CSE-MsgGUID: CEhYDkYPSpqJFO+M/GdLGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="118894001"
Received: from lkp-server01.sh.intel.com (HELO b014a344d658) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2024 19:49:41 -0800
Received: from kbuild by b014a344d658 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBQrS-00005f-1E;
	Thu, 14 Nov 2024 03:49:38 +0000
Date: Thu, 14 Nov 2024 11:49:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 027a4f81102a39ea835bac599519b311ed3497e3
Message-ID: <202411141110.4SPN0hu1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 027a4f81102a39ea835bac599519b311ed3497e3  dt-bindings: serial: Add a new compatible string for ums9632

elapsed time: 734m

configs tested: 95
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                allnoconfig    gcc-14.2.0
alpha               allyesconfig    clang-20
alpha               allyesconfig    gcc-14.2.0
alpha                  defconfig    gcc-14.2.0
arc                 allmodconfig    clang-20
arc                  allnoconfig    gcc-14.2.0
arc                 allyesconfig    clang-20
arc                    defconfig    gcc-14.2.0
arc           vdk_hs38_defconfig    gcc-14.2.0
arm                 alldefconfig    gcc-14.2.0
arm                 allmodconfig    clang-20
arm                  allnoconfig    gcc-14.2.0
arm                 allyesconfig    clang-20
arm                    defconfig    gcc-14.2.0
arm               dove_defconfig    gcc-14.2.0
arm            socfpga_defconfig    gcc-14.2.0
arm64               allmodconfig    clang-20
arm64                allnoconfig    gcc-14.2.0
arm64                  defconfig    gcc-14.2.0
csky                 allnoconfig    gcc-14.2.0
csky                   defconfig    gcc-14.2.0
hexagon             allmodconfig    clang-20
hexagon              allnoconfig    gcc-14.2.0
hexagon             allyesconfig    clang-20
hexagon                defconfig    gcc-14.2.0
i386                allmodconfig    clang-19
i386                 allnoconfig    clang-19
i386                allyesconfig    clang-19
i386                   defconfig    clang-19
loongarch           allmodconfig    gcc-14.2.0
loongarch            allnoconfig    gcc-14.2.0
loongarch              defconfig    gcc-14.2.0
m68k                allmodconfig    gcc-14.2.0
m68k                 allnoconfig    gcc-14.2.0
m68k                allyesconfig    gcc-14.2.0
m68k                   defconfig    gcc-14.2.0
m68k           m5272c3_defconfig    gcc-14.2.0
m68k           m5307c3_defconfig    gcc-14.2.0
m68k               q40_defconfig    gcc-14.2.0
microblaze          allmodconfig    gcc-14.2.0
microblaze           allnoconfig    gcc-14.2.0
microblaze          allyesconfig    gcc-14.2.0
microblaze             defconfig    gcc-14.2.0
mips                 allnoconfig    gcc-14.2.0
mips         bmips_stb_defconfig    gcc-14.2.0
mips        loongson1b_defconfig    gcc-14.2.0
nios2                allnoconfig    gcc-14.2.0
nios2                  defconfig    gcc-14.2.0
openrisc             allnoconfig    clang-20
openrisc            allyesconfig    gcc-14.2.0
openrisc               defconfig    gcc-12
openrisc     or1klitex_defconfig    gcc-14.2.0
parisc              allmodconfig    gcc-14.2.0
parisc               allnoconfig    clang-20
parisc              allyesconfig    gcc-14.2.0
parisc                 defconfig    gcc-12
parisc64               defconfig    gcc-14.2.0
powerpc             allmodconfig    gcc-14.2.0
powerpc              allnoconfig    clang-20
powerpc             allyesconfig    gcc-14.2.0
powerpc           cell_defconfig    gcc-14.2.0
powerpc          ebony_defconfig    gcc-14.2.0
powerpc        mpc83xx_defconfig    gcc-14.2.0
powerpc       socrates_defconfig    gcc-14.2.0
riscv               allmodconfig    gcc-14.2.0
riscv                allnoconfig    clang-20
riscv               allyesconfig    gcc-14.2.0
riscv                  defconfig    gcc-12
s390                allmodconfig    clang-20
s390                allmodconfig    gcc-14.2.0
s390                 allnoconfig    clang-20
s390                allyesconfig    gcc-14.2.0
s390                   defconfig    gcc-12
sh                  allmodconfig    gcc-14.2.0
sh                   allnoconfig    gcc-14.2.0
sh                  allyesconfig    gcc-14.2.0
sh                     defconfig    gcc-12
sh              se7721_defconfig    gcc-14.2.0
sparc               allmodconfig    gcc-14.2.0
sparc64                defconfig    gcc-12
um                  allmodconfig    clang-20
um                   allnoconfig    clang-20
um                  allyesconfig    clang-20
um                  allyesconfig    gcc-12
um                     defconfig    gcc-12
um                i386_defconfig    gcc-12
um              x86_64_defconfig    gcc-12
x86_64               allnoconfig    clang-19
x86_64              allyesconfig    clang-19
x86_64                 defconfig    clang-19
x86_64                     kexec    clang-19
x86_64                     kexec    gcc-12
x86_64                  rhel-8.3    gcc-12
xtensa               allnoconfig    gcc-14.2.0
xtensa             iss_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
