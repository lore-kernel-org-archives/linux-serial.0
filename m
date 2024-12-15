Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022BC440C
	for <linux-serial@vger.kernel.org>; Sun, 15 Dec 2024 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734277493; cv=none; b=bfFVeliADOOZILdaYlvBI/riRu7tj6glw47IJ8iwNWMQ7yzwsyON7HLyrMD8F+5HG3uPl8PiNA4Nr99PKZmTLEntagc9MPOPY3Ux/fY3zroo1kV2HQG4C6GE+GbWogfU4JmYD9nNppcgv01EXYRC4CXLCKD8WKZa07nCBdwZ69s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734277493; c=relaxed/simple;
	bh=vraOYaYPeEBCskNMdPE/rR/OdAbh5Dl0ewi0Gt9mp0Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PhnzPvQhv8l527ketYKezdEUoT8GXgErbYBGcWwZL44xvrtSNZgAoHRMY2jgvgPIgHl3RNkzpSe8ge7Lt8sh2fI6JOUp0Pt0UGAzlFk3YRt1lrouODqk/oLcDoFtD6WWtpz0Ry52MMfdnYpUEdYSKxxNaoDZjWlVJ7g9Ul5oPk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N6VtO0HM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6VtO0HM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734277492; x=1765813492;
  h=date:from:to:cc:subject:message-id;
  bh=vraOYaYPeEBCskNMdPE/rR/OdAbh5Dl0ewi0Gt9mp0Q=;
  b=N6VtO0HMiC4JDtXoYOJs8UZu0YXm9syvDT3b/a4e9sIMkI1+9anXL1I7
   AYanHLCPbzws27jYFQMOrooIvCvIYG+6ltI13ws2Q/rYy/MWAA+tPcLGE
   iYnBxlfaJEwpvbg/nABny0yiweE6eMcQ8wAKq/MH72Yr1gA1fAHIZzhBT
   bVEv6guaUC08BMsy0iK0HOsDwAj9hfW4+qevXFlLUUsOj1zDym4cQ3W5/
   CkjfiejOYB+VIqYvENl/IHz5bLNkd9FadocfCSaDP1VpgRElly5nSX4sa
   CnCA9JDOjc/MWkQSs4FV98O48VpDv7314Ba6P5QXMvoIpD8dI/Fo6f/qR
   g==;
X-CSE-ConnectionGUID: 3pyaH85yQQCMHDaI00BzMg==
X-CSE-MsgGUID: 0hWi9aVJTsixVtD1R5QMSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34816521"
X-IronPort-AV: E=Sophos;i="6.12,236,1728975600"; 
   d="scan'208";a="34816521"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 07:44:51 -0800
X-CSE-ConnectionGUID: RGM7pAhUTUS1R0xJI2TB4w==
X-CSE-MsgGUID: qj6pMlq8Qkqi37YPQFIhqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,236,1728975600"; 
   d="scan'208";a="101830253"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 15 Dec 2024 07:44:51 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMqnY-000Dh0-0q;
	Sun, 15 Dec 2024 15:44:48 +0000
Date: Sun, 15 Dec 2024 23:44:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 aea2654cce40a6e34e91f3be2a31cd040fdea822
Message-ID: <202412152356.cdJ70inB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: aea2654cce40a6e34e91f3be2a31cd040fdea822  tty: Make sysctl table const

elapsed time: 1446m

configs tested: 123
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                         haps_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20241215    gcc-13.2.0
arc                   randconfig-002-20241215    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                     davinci_all_defconfig    clang-20
arm                      integrator_defconfig    clang-15
arm                       netwinder_defconfig    gcc-14.2.0
arm                   randconfig-001-20241215    clang-20
arm                   randconfig-002-20241215    clang-16
arm                   randconfig-003-20241215    gcc-14.2.0
arm                   randconfig-004-20241215    clang-20
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241215    gcc-14.2.0
arm64                 randconfig-002-20241215    gcc-14.2.0
arm64                 randconfig-003-20241215    clang-20
arm64                 randconfig-004-20241215    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241215    gcc-14.2.0
csky                  randconfig-002-20241215    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20241215    clang-20
hexagon               randconfig-002-20241215    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241215    gcc-12
i386        buildonly-randconfig-002-20241215    gcc-12
i386        buildonly-randconfig-003-20241215    gcc-12
i386        buildonly-randconfig-004-20241215    gcc-12
i386        buildonly-randconfig-005-20241215    gcc-12
i386        buildonly-randconfig-006-20241215    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241215    gcc-14.2.0
loongarch             randconfig-002-20241215    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          eyeq5_defconfig    gcc-14.2.0
mips                           ip30_defconfig    gcc-14.2.0
mips                      maltaaprp_defconfig    clang-20
mips                       rbtx49xx_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241215    gcc-14.2.0
nios2                 randconfig-002-20241215    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241215    gcc-14.2.0
parisc                randconfig-002-20241215    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                     ep8248e_defconfig    gcc-14.2.0
powerpc                 linkstation_defconfig    clang-20
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241215    gcc-14.2.0
powerpc               randconfig-002-20241215    clang-20
powerpc               randconfig-003-20241215    gcc-14.2.0
powerpc                     redwood_defconfig    clang-20
powerpc64             randconfig-001-20241215    gcc-14.2.0
powerpc64             randconfig-002-20241215    gcc-14.2.0
powerpc64             randconfig-003-20241215    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20241215    clang-16
riscv                 randconfig-002-20241215    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241215    gcc-14.2.0
s390                  randconfig-002-20241215    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20241215    gcc-14.2.0
sh                    randconfig-002-20241215    gcc-14.2.0
sh                   sh7724_generic_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241215    gcc-14.2.0
sparc                 randconfig-002-20241215    gcc-14.2.0
sparc64               randconfig-001-20241215    gcc-14.2.0
sparc64               randconfig-002-20241215    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20241215    gcc-12
um                    randconfig-002-20241215    clang-18
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241214    gcc-11
x86_64      buildonly-randconfig-002-20241214    clang-19
x86_64      buildonly-randconfig-003-20241214    gcc-12
x86_64      buildonly-randconfig-004-20241214    gcc-12
x86_64      buildonly-randconfig-005-20241214    gcc-12
x86_64      buildonly-randconfig-006-20241214    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241215    gcc-14.2.0
xtensa                randconfig-002-20241215    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
