Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701A2311964
	for <linux-serial@vger.kernel.org>; Wed, 29 Oct 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753519; cv=none; b=TOEOiNCPHI5JC6yzkZy9UKCLiwYCHSBQjOjvnePF2KmgBuh/nNhQbDLzr6HfnF2buq+K13Pt9MrOt3RFT7r3EEVVeZq8exFxOvl9/HmnRsokBdPlJn5wLXYzOiCAwk7Sy+HaHhodII/DEu9y2ulKBB9C0qdfGtJvFTqHSIeAE4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753519; c=relaxed/simple;
	bh=X2C/4UA/ZoleAT7Vp6OR54tPOlXNRWeV3G0NiEEe0GM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=il9ZMZjwthEnzfcBonjsRO4JW3J8XUag/uembToNWv0NEDCNm85SMoScpeJPK18BJcidUynAvK4nzRggejniN6bIVbVQKhsou6g8PuC9eBkr+m8mPI08Y75gjzfnAzBXu8adliJE4DrWOcrXmS9vuS2gJOLyZZ7KTw4lnAiu9+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfMQ+ead; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfMQ+ead"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761753518; x=1793289518;
  h=date:from:to:cc:subject:message-id;
  bh=X2C/4UA/ZoleAT7Vp6OR54tPOlXNRWeV3G0NiEEe0GM=;
  b=TfMQ+eadw6WBbhdaSFCw8oNQhMDxq0pi3eD6PBCHHnLyI8arLunof9xo
   mVoATM18IT+Wl402ix6vo+1/ukrD32/MtCHJkRPui3lKxk80Tw/XcOO0R
   guqgixduGuEEOGxJO4CNECSCUuGKws4VzaSLeRVYWiGeRmM1tueYSzW6G
   FUdnf3F3XB/J8TyDY2+c+YJszlum1iKWQtZfPU53lFWNEywkU8Fi40bcB
   4MvnftiM2s+1CkAK9rlbf9Mh1CCe691GpIIxZhRFkGg4Xn8lRDsjYZNi7
   dUpxRSxTxYN3vHhpAKFnOxeq0onYtjx7E6l3+M7LlJ8J5TVLw7TrDXLwd
   Q==;
X-CSE-ConnectionGUID: dt8xDvEJTeK4kNgx4fFBqg==
X-CSE-MsgGUID: jURB8AZSROygxb97mod9vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="67742161"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="67742161"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:58:37 -0700
X-CSE-ConnectionGUID: TR08aEjDQzSt/HkjWtrbJA==
X-CSE-MsgGUID: dQWr7267S1OsB7xXIjy3mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="190836252"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 29 Oct 2025 08:58:36 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vE8ZA-000Kkj-0J;
	Wed, 29 Oct 2025 15:58:30 +0000
Date: Wed, 29 Oct 2025 23:57:50 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 719f3df3e113e03d2c8cf324827da1fd17a9bd8f
Message-ID: <202510292345.t2j5kpa9-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 719f3df3e113e03d2c8cf324827da1fd17a9bd8f  serial: sh-sci: Merge sh-sci.h into sh-sci.c

elapsed time: 1453m

configs tested: 157
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20251029    gcc-15.1.0
arc                   randconfig-002-20251029    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                      footbridge_defconfig    clang-17
arm                       multi_v4t_defconfig    clang-16
arm                   randconfig-001-20251029    gcc-8.5.0
arm                   randconfig-002-20251029    clang-22
arm                   randconfig-003-20251029    clang-22
arm                   randconfig-004-20251029    clang-22
arm                         wpcm450_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251029    gcc-12.5.0
arm64                 randconfig-002-20251029    clang-22
arm64                 randconfig-003-20251029    gcc-13.4.0
arm64                 randconfig-004-20251029    gcc-11.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                  randconfig-001-20251029    gcc-9.5.0
csky                  randconfig-002-20251029    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251029    clang-20
hexagon               randconfig-002-20251029    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251029    gcc-14
i386        buildonly-randconfig-002-20251029    gcc-14
i386        buildonly-randconfig-003-20251029    clang-20
i386        buildonly-randconfig-004-20251029    gcc-14
i386        buildonly-randconfig-005-20251029    gcc-14
i386        buildonly-randconfig-006-20251029    gcc-14
i386                  randconfig-001-20251029    gcc-14
i386                  randconfig-002-20251029    gcc-14
i386                  randconfig-003-20251029    clang-20
i386                  randconfig-004-20251029    gcc-14
i386                  randconfig-005-20251029    clang-20
i386                  randconfig-006-20251029    gcc-14
i386                  randconfig-007-20251029    clang-20
i386                  randconfig-011-20251029    gcc-14
i386                  randconfig-012-20251029    clang-20
i386                  randconfig-013-20251029    gcc-14
i386                  randconfig-014-20251029    gcc-14
i386                  randconfig-015-20251029    gcc-14
i386                  randconfig-016-20251029    gcc-14
i386                  randconfig-017-20251029    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251029    clang-22
loongarch             randconfig-002-20251029    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        maltaup_defconfig    clang-22
mips                           xway_defconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251029    gcc-11.5.0
nios2                 randconfig-002-20251029    gcc-9.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251029    gcc-12.5.0
parisc                randconfig-002-20251029    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                     ksi8560_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251029    clang-22
powerpc               randconfig-002-20251029    gcc-12.5.0
powerpc                     sequoia_defconfig    clang-17
powerpc64             randconfig-001-20251029    clang-22
powerpc64             randconfig-002-20251029    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251029    clang-20
riscv                 randconfig-002-20251029    clang-19
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251029    gcc-11.5.0
s390                  randconfig-002-20251029    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251029    gcc-11.5.0
sh                    randconfig-002-20251029    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251029    gcc-8.5.0
sparc                 randconfig-002-20251029    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251029    clang-20
sparc64               randconfig-002-20251029    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251029    clang-22
um                    randconfig-002-20251029    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251029    gcc-14
x86_64      buildonly-randconfig-002-20251029    clang-20
x86_64      buildonly-randconfig-003-20251029    clang-20
x86_64      buildonly-randconfig-004-20251029    clang-20
x86_64      buildonly-randconfig-005-20251029    clang-20
x86_64      buildonly-randconfig-006-20251029    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251029    gcc-14
x86_64                randconfig-002-20251029    gcc-14
x86_64                randconfig-003-20251029    clang-20
x86_64                randconfig-004-20251029    gcc-14
x86_64                randconfig-005-20251029    gcc-12
x86_64                randconfig-006-20251029    gcc-14
x86_64                randconfig-011-20251029    clang-20
x86_64                randconfig-012-20251029    clang-20
x86_64                randconfig-013-20251029    gcc-14
x86_64                randconfig-014-20251029    clang-20
x86_64                randconfig-015-20251029    gcc-13
x86_64                randconfig-016-20251029    gcc-13
x86_64                randconfig-071-20251029    clang-20
x86_64                randconfig-072-20251029    clang-20
x86_64                randconfig-073-20251029    gcc-14
x86_64                randconfig-074-20251029    gcc-14
x86_64                randconfig-075-20251029    gcc-14
x86_64                randconfig-076-20251029    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251029    gcc-8.5.0
xtensa                randconfig-002-20251029    gcc-8.5.0
xtensa                         virt_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
