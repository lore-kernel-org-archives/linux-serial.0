Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381193C1F
	for <linux-serial@vger.kernel.org>; Mon, 13 Jan 2025 03:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736737899; cv=none; b=tlXZVIcXHwSJNV3S5dxOC99Z1tCIqyqBZYpmva0ZQFrzQsaWcaQHkzb9hORG9B6B4dLzYhJAPVEv/85Sveqk5RPf9KkBR0knw3hbQMom/cNAdO6wbrzGopApWj/epRSc6r3mmXCEChUV14NQJQLLSOQBTg3YfJGW4R/34BKNE5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736737899; c=relaxed/simple;
	bh=KflkC5soX4piWuLiMoqFRUkW0oBEnqtdnMNiAiqdVSM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KfM7vyarcX9VeuU/RyPDG7U0AJMCbBi8dm2DNX+RDln4EwSdc4CJ3h7276SydmGfZ2M6qSv6SmjWMLZMnxEVANRbrEEAYwm/gU+MLm4j7FGaVsclPuG+wH/OHbmimz+BNzFUXnKpiZ3Y739OKJtMcKFqQ+VHMibmAJQ98RHnQQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CAWfrvTt; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAWfrvTt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736737897; x=1768273897;
  h=date:from:to:cc:subject:message-id;
  bh=KflkC5soX4piWuLiMoqFRUkW0oBEnqtdnMNiAiqdVSM=;
  b=CAWfrvTtOis2+8Za0OV3rBH/H/9/4aPzSe5FB6Ifaf/awgV51T+3adMC
   pfJYh3Leejc7rGv3urHZat/25igmeQYdBnW7O24pLxarilgyl40AuAD2I
   ZSbEjflHuiLaO+cB0M3h0lzKcqPBLWok83ITXDtAMrtLtNM8pS3TQcyUd
   h0PnyMV000WTZxlQqh0bjEwYpqy5tLpaUyrdp75nhPywYSgeqFOf3DUnq
   Z7Y0gEZ7qeqljljP/4YCEmHlO0HQvQ5TE8l1sGTGePQrJTd8xoUzZ7kwT
   m+4BoUY/LD5hmVj040xJT7IxxjgGrz567TJgEJvogbTGjvyPS/NW9oiHl
   g==;
X-CSE-ConnectionGUID: wY86HSmvRr+bAwHlgoubYg==
X-CSE-MsgGUID: nmdZTpRXR2uxwyQoAJlPnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="40746967"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40746967"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 19:11:30 -0800
X-CSE-ConnectionGUID: ACaXEXmMQLSaiAtWRoGqXQ==
X-CSE-MsgGUID: u/34pCCHQnyKWYk+P4Z0Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="109326991"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 12 Jan 2025 19:11:29 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tXArO-000Meh-2X;
	Mon, 13 Jan 2025 03:11:26 +0000
Date: Mon, 13 Jan 2025 11:10:37 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 41971e39d3dd7c295133bfd338247dc6a5de32bf
Message-ID: <202501131131.SRQJyGCc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 41971e39d3dd7c295133bfd338247dc6a5de32bf  tty: Permit some TIOCL_SETSEL modes without CAP_SYS_ADMIN

elapsed time: 809m

configs tested: 119
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                     haps_hs_smp_defconfig    gcc-13.2.0
arc                   randconfig-001-20250112    gcc-13.2.0
arc                   randconfig-002-20250112    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250112    clang-20
arm                   randconfig-002-20250112    gcc-14.2.0
arm                   randconfig-003-20250112    clang-20
arm                   randconfig-004-20250112    gcc-14.2.0
arm                        shmobile_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250112    gcc-14.2.0
arm64                 randconfig-002-20250112    clang-17
arm64                 randconfig-003-20250112    clang-19
arm64                 randconfig-004-20250112    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250112    gcc-14.2.0
csky                  randconfig-002-20250112    gcc-14.2.0
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20250112    clang-20
hexagon               randconfig-002-20250112    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250112    gcc-12
i386        buildonly-randconfig-002-20250112    clang-19
i386        buildonly-randconfig-003-20250112    clang-19
i386        buildonly-randconfig-004-20250112    gcc-12
i386        buildonly-randconfig-005-20250112    gcc-12
i386        buildonly-randconfig-006-20250112    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250112    gcc-14.2.0
loongarch             randconfig-002-20250112    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250112    gcc-14.2.0
nios2                 randconfig-002-20250112    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250112    gcc-14.2.0
parisc                randconfig-002-20250112    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                    amigaone_defconfig    gcc-14.2.0
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250112    clang-20
powerpc               randconfig-002-20250112    clang-19
powerpc               randconfig-003-20250112    clang-20
powerpc                     sequoia_defconfig    clang-17
powerpc64             randconfig-002-20250112    gcc-14.2.0
powerpc64             randconfig-003-20250112    clang-19
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250112    clang-20
riscv                 randconfig-002-20250112    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250112    clang-16
s390                  randconfig-002-20250112    clang-18
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250112    gcc-14.2.0
sh                    randconfig-002-20250112    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250112    gcc-14.2.0
sparc                 randconfig-002-20250112    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250112    gcc-14.2.0
sparc64               randconfig-002-20250112    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250112    clang-20
um                    randconfig-002-20250112    clang-20
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250112    gcc-12
x86_64      buildonly-randconfig-002-20250112    clang-19
x86_64      buildonly-randconfig-003-20250112    clang-19
x86_64      buildonly-randconfig-004-20250112    clang-19
x86_64      buildonly-randconfig-005-20250112    clang-19
x86_64      buildonly-randconfig-006-20250112    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250112    gcc-14.2.0
xtensa                randconfig-002-20250112    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
