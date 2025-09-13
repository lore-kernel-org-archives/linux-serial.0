Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68A4182B4
	for <linux-serial@vger.kernel.org>; Sat, 13 Sep 2025 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757775390; cv=none; b=AgzLngdPv70iWQqwqAatpK/bl4po4I7/BnL15tNtqEZ+YKvcGhEFtHBKVgSYiKWBLxnPS5eQZ07CzTy/9W04Yh5kW5EujZa/Hbgq+ch4S4KOghPgc31/9tXQgwLWxlV2LqcZ4txww9Nb7QnZchLY7PIFLxKDUZQfcpv5LlrwgEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757775390; c=relaxed/simple;
	bh=7wnczrO8umBifKQS+jclUVC8mQiYgtYCIg/5Hy6120U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BC4zPMDrVNRv3YngZ0L4PTUStOVCAqnYRFeoD6QYiRtZQEiGq+jbvdqtu633fT8HQgs32RcmhEh2UMJZvGTvN23DlEk0nUPeDp/S8t4D9yYxFeM0c8uQ5tMUxa93tHVsmdZnAyNWGKwSYT+3iX9ZM8oW6JF5st/L+Vq5LbfNbBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZPkHgYsM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZPkHgYsM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757775388; x=1789311388;
  h=date:from:to:cc:subject:message-id;
  bh=7wnczrO8umBifKQS+jclUVC8mQiYgtYCIg/5Hy6120U=;
  b=ZPkHgYsMLje61jxFQbx1B3IU7+BqgaxG4ETXGrcxvs0fwMwN2R1D8BJU
   z8jfaEZ7GyGVxVvaCMNugfjO1fOdzUjK+NDIg4MUm7aSQvwLJCumC5Th8
   8nzjANtIXE+bUZR/7FV9+6wNxuqzL6mZFf+ybBZ4BcH1bcWYaKlMzS4hZ
   dWiLwREiVtyQ6iDeAjkVepfzkK/6+wS73Ps4088TuwCJLqnhEDKsOyFDy
   F/b/pglXY5WsAUuLtvrfzjY+gSHL4xEPUK+VrVY/PJ6380IjA1EbZta7y
   z1yyAprTEAIzXF4KgMaxOoy4ReXE7hiDn8HmXEsRrLQvudAtDEcFRqygZ
   g==;
X-CSE-ConnectionGUID: FjJgttaNQeiUh2IaIStAsw==
X-CSE-MsgGUID: PGPpZceKT4+74KxQqZDGIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11552"; a="60031905"
X-IronPort-AV: E=Sophos;i="6.18,262,1751266800"; 
   d="scan'208";a="60031905"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2025 07:56:28 -0700
X-CSE-ConnectionGUID: Bn5Bik+wRSCIvkb+k/8h7A==
X-CSE-MsgGUID: kot4cThxSfu8SZDW7luVAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,262,1751266800"; 
   d="scan'208";a="174294133"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 13 Sep 2025 07:56:27 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uxRfs-0001bp-1o;
	Sat, 13 Sep 2025 14:56:24 +0000
Date: Sat, 13 Sep 2025 22:55:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-next] BUILD SUCCESS
 fc702e7df456e219f029d0192fbc7cb357a16f4c
Message-ID: <202509132242.N84X3JKj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
branch HEAD: fc702e7df456e219f029d0192fbc7cb357a16f4c  vt: move vc_saved_screen to within tty allocated judgment

elapsed time: 1452m

configs tested: 101
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250913    gcc-10.5.0
arc                   randconfig-002-20250913    gcc-11.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250913    clang-20
arm                   randconfig-002-20250913    clang-22
arm                   randconfig-003-20250913    clang-22
arm                   randconfig-004-20250913    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250913    clang-22
arm64                 randconfig-002-20250913    gcc-14.3.0
arm64                 randconfig-003-20250913    clang-22
arm64                 randconfig-004-20250913    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250913    gcc-11.5.0
csky                  randconfig-002-20250913    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250913    clang-16
hexagon               randconfig-002-20250913    clang-22
i386        buildonly-randconfig-001-20250912    gcc-14
i386        buildonly-randconfig-002-20250912    clang-20
i386        buildonly-randconfig-003-20250912    gcc-13
i386        buildonly-randconfig-004-20250912    clang-20
i386        buildonly-randconfig-005-20250912    gcc-14
i386        buildonly-randconfig-006-20250912    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250913    clang-18
loongarch             randconfig-002-20250913    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250913    gcc-8.5.0
nios2                 randconfig-002-20250913    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250913    gcc-12.5.0
parisc                randconfig-002-20250913    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250913    gcc-8.5.0
powerpc               randconfig-002-20250913    clang-22
powerpc               randconfig-003-20250913    gcc-10.5.0
powerpc64             randconfig-001-20250913    gcc-10.5.0
powerpc64             randconfig-002-20250913    clang-22
powerpc64             randconfig-003-20250913    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250913    gcc-13.4.0
riscv                 randconfig-002-20250913    clang-20
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250913    clang-22
s390                  randconfig-002-20250913    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250913    gcc-9.5.0
sh                    randconfig-002-20250913    gcc-14.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250913    gcc-15.1.0
sparc                 randconfig-002-20250913    gcc-8.5.0
sparc64               randconfig-001-20250913    gcc-8.5.0
sparc64               randconfig-002-20250913    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250913    gcc-14
um                    randconfig-002-20250913    clang-22
x86_64      buildonly-randconfig-001-20250912    gcc-14
x86_64      buildonly-randconfig-002-20250912    gcc-14
x86_64      buildonly-randconfig-003-20250912    clang-20
x86_64      buildonly-randconfig-004-20250912    clang-20
x86_64      buildonly-randconfig-005-20250912    clang-20
x86_64      buildonly-randconfig-006-20250912    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250913    gcc-14.3.0
xtensa                randconfig-002-20250913    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
