Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A5B24BD1A
	for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764249282; cv=none; b=TcGrfiYYXZGM57/KW87JJAQo8KFgNcDAevc71kXpt/1bD5F65gkMI9rO9fFeJlrm00STxHQlaMdKNQRt211jJMPmvH7STlC0blx31UIUN50dL3cx/rWTZSKv95mvdJzs4AmkaKlY4EmI1CJtNYmW071N/CDlZ+paHf/oqcKC0UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764249282; c=relaxed/simple;
	bh=iWbkBH4uC05rKe03f0Mno69DHYQztwSlOH9XdcoDc+k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JPUvLwu6NWcS/d1o0TcQpenvYgwLhds6cJxaf2SWjE8zxPHijTOAcvKM/WDOiXD7W0o/zNrosuv5wSrEkzTTDqpnUX/dBYOmDLq1ADuCPOVxOhFtA9vBqSoIRCBy1r73A+D7izAG34OD5vLfT0/AihxzjooRGh1E6TVINOW2Z8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GHpHXhYp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHpHXhYp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764249281; x=1795785281;
  h=date:from:to:cc:subject:message-id;
  bh=iWbkBH4uC05rKe03f0Mno69DHYQztwSlOH9XdcoDc+k=;
  b=GHpHXhYpPuGvqMEBgbb861dSRasRVgbSLCbgBjCx2YLO63BVKfyCapRv
   vAC7AhgNf3UwJ4YqO7JHfTYGdNSwmNKOTrACnWA1p/dv3LFGUT4UNLrPF
   j3tE3f102JKiuj6fYjcHV3p8XaTojqwYbApkn+fEX1Uho7wkpDwX0lTFa
   WWJmMGlMCaKahzxEhZ3efEjbplqc6aK0GYT7rxaFEhGWayiA4+A9fQX49
   8gP9xm83nUyhcIAAg+hcJLhOQA0o/M2RQp6SdS+ENhltOEvmCDuIWapwu
   5luDd5rkJgeO/f+UodKAEAEygiGfk/DZSRSX2w/dSIirV7IBvnoK533Um
   A==;
X-CSE-ConnectionGUID: CdDQsjwiR3K7RvOrgN1V6g==
X-CSE-MsgGUID: wjiTEPVpQOO0TdE8NQi1qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="70161776"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="70161776"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 05:14:41 -0800
X-CSE-ConnectionGUID: jbLX0VqeRsmtdR4Bu9YwCw==
X-CSE-MsgGUID: /dkrg5VuRtGr4v68Kl/xUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="193032051"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 27 Nov 2025 05:14:40 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vObpU-000000004mf-3xcg;
	Thu, 27 Nov 2025 13:14:36 +0000
Date: Thu, 27 Nov 2025 21:13:55 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 75a9f4c54770f062f4b3813a83667452b326dda3
Message-ID: <202511272149.zvzBkaWq-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 75a9f4c54770f062f4b3813a83667452b326dda3  serial: sh-sci: Fix deadlock during RSCI FIFO overrun error

elapsed time: 1462m

configs tested: 209
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                               defconfig    gcc-15.1.0
arc                              alldefconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251127    clang-22
arc                   randconfig-001-20251127    gcc-15.1.0
arc                   randconfig-002-20251127    clang-22
arc                   randconfig-002-20251127    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.1.0
arm                      integrator_defconfig    clang-22
arm                   randconfig-001-20251127    clang-22
arm                   randconfig-002-20251127    clang-22
arm                   randconfig-003-20251127    clang-22
arm                   randconfig-004-20251127    clang-22
arm                   randconfig-004-20251127    gcc-10.5.0
arm                         s3c6400_defconfig    clang-22
arm                         s3c6400_defconfig    gcc-15.1.0
arm                         socfpga_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-16
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251127    gcc-15.1.0
arm64                 randconfig-002-20251127    gcc-15.1.0
arm64                 randconfig-003-20251127    gcc-15.1.0
arm64                 randconfig-004-20251127    gcc-15.1.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251127    gcc-15.1.0
csky                  randconfig-002-20251127    gcc-15.1.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251127    clang-22
hexagon               randconfig-001-20251127    gcc-15.1.0
hexagon               randconfig-002-20251127    clang-18
hexagon               randconfig-002-20251127    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251127    clang-20
i386        buildonly-randconfig-002-20251127    clang-20
i386        buildonly-randconfig-003-20251127    clang-20
i386        buildonly-randconfig-004-20251127    clang-20
i386        buildonly-randconfig-005-20251127    clang-20
i386        buildonly-randconfig-006-20251127    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251127    clang-20
i386                  randconfig-002-20251127    clang-20
i386                  randconfig-003-20251127    clang-20
i386                  randconfig-004-20251127    clang-20
i386                  randconfig-005-20251127    clang-20
i386                  randconfig-006-20251127    clang-20
i386                  randconfig-007-20251127    clang-20
i386                  randconfig-011-20251127    clang-20
i386                  randconfig-012-20251127    clang-20
i386                  randconfig-013-20251127    clang-20
i386                  randconfig-014-20251127    clang-20
i386                  randconfig-015-20251127    clang-20
i386                  randconfig-016-20251127    clang-20
i386                  randconfig-017-20251127    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251127    clang-22
loongarch             randconfig-001-20251127    gcc-15.1.0
loongarch             randconfig-002-20251127    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                  cavium_octeon_defconfig    gcc-15.1.0
mips                         rt305x_defconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251127    gcc-15.1.0
nios2                 randconfig-001-20251127    gcc-8.5.0
nios2                 randconfig-002-20251127    gcc-11.5.0
nios2                 randconfig-002-20251127    gcc-15.1.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                       virt_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251127    gcc-13.4.0
parisc                randconfig-001-20251127    gcc-8.5.0
parisc                randconfig-002-20251127    gcc-13.4.0
parisc                randconfig-002-20251127    gcc-15.1.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      bamboo_defconfig    clang-22
powerpc                   bluestone_defconfig    clang-22
powerpc                 linkstation_defconfig    clang-22
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc               randconfig-001-20251127    clang-22
powerpc               randconfig-001-20251127    gcc-13.4.0
powerpc               randconfig-002-20251127    gcc-13.4.0
powerpc                     skiroot_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251127    clang-20
powerpc64             randconfig-001-20251127    gcc-13.4.0
powerpc64             randconfig-002-20251127    gcc-13.4.0
powerpc64             randconfig-002-20251127    gcc-14.3.0
riscv                            allmodconfig    clang-16
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251127    gcc-12.5.0
riscv                 randconfig-002-20251127    clang-22
riscv                 randconfig-002-20251127    gcc-12.5.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251127    gcc-11.5.0
s390                  randconfig-001-20251127    gcc-12.5.0
s390                  randconfig-002-20251127    clang-22
s390                  randconfig-002-20251127    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                          kfr2r09_defconfig    clang-22
sh                          r7780mp_defconfig    gcc-15.1.0
sh                    randconfig-001-20251127    gcc-12.5.0
sh                    randconfig-001-20251127    gcc-15.1.0
sh                    randconfig-002-20251127    gcc-12.5.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251127    clang-22
sparc                 randconfig-002-20251127    clang-22
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251127    clang-22
sparc64               randconfig-002-20251127    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251127    clang-22
um                    randconfig-002-20251127    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251127    clang-20
x86_64      buildonly-randconfig-002-20251127    clang-20
x86_64      buildonly-randconfig-003-20251127    clang-20
x86_64      buildonly-randconfig-004-20251127    clang-20
x86_64      buildonly-randconfig-005-20251127    clang-20
x86_64      buildonly-randconfig-006-20251127    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251127    gcc-14
x86_64                randconfig-002-20251127    gcc-14
x86_64                randconfig-003-20251127    gcc-14
x86_64                randconfig-004-20251127    gcc-14
x86_64                randconfig-005-20251127    gcc-14
x86_64                randconfig-006-20251127    gcc-14
x86_64                randconfig-011-20251127    gcc-14
x86_64                randconfig-012-20251127    gcc-14
x86_64                randconfig-013-20251127    gcc-14
x86_64                randconfig-014-20251127    gcc-14
x86_64                randconfig-015-20251127    gcc-14
x86_64                randconfig-016-20251127    gcc-14
x86_64                randconfig-071-20251127    gcc-14
x86_64                randconfig-072-20251127    gcc-14
x86_64                randconfig-073-20251127    gcc-14
x86_64                randconfig-074-20251127    gcc-14
x86_64                randconfig-075-20251127    gcc-14
x86_64                randconfig-076-20251127    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251127    clang-22
xtensa                randconfig-002-20251127    clang-22
xtensa                    xip_kc705_defconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
