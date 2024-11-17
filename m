Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B97C26ACB
	for <linux-serial@vger.kernel.org>; Sun, 17 Nov 2024 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731859251; cv=none; b=DpMc1oWvjiXkRju4+PpsaeSB1fus86VcHGAU5tMXH9QxR3oCs9lDXLdfDtFPlGLG0R7mmPN2W/8BBlPy7Qrcdn6FrgDsaccB1g/jt4G9lki/Vas6uqGI+bY83UPax8wWB1tjByZbKB3serHmtKVnQgR8qpP0aAUQDIOUB4wUFWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731859251; c=relaxed/simple;
	bh=jQe+zXAtxWMLKPuwuaGptBqOVPtiaLEIjfHrWN6y50E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EUiTe/qXg4ov9A5QNf2oIa+uZkvaSTIl0xBuKcPI/3unxcyWMuDhsHHi0XNrtXJpVY3dp+sOOTrmxr8R29HvVuOI4vHaaYxFjpmrAGUE4wgdsU5zmERr4DlJXP9j5odzb2hO8gIu32KWo5k2lRQpBgDI04VX8loHyTTXzuKenOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GjhQ8rvh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GjhQ8rvh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731859251; x=1763395251;
  h=date:from:to:cc:subject:message-id;
  bh=jQe+zXAtxWMLKPuwuaGptBqOVPtiaLEIjfHrWN6y50E=;
  b=GjhQ8rvhPeTYDYtUFvnzkz0H9YIcN7STbAaiEp6sNT+m0LjTDMAC1nij
   1njr23BZNkCX5Jjb1i5A8U6eXjswSlSi2YFNuZZbk/5N8rNPWtAOCbZcs
   CuI10AZWQya+ki+3nbuTcpsKarJbgUe3Mm5AFVPSo21sQzxPmd4iz5uFt
   efsMFG3ipGjT/+NWTbjOytZKs39LzYkrTpX70AasI5JBSpHyLTLkpFGU9
   KjHokIoIa/hwgO9VkTrpbgtm1dJHkB2zFzDA4IRifHF+qzRv51k7ngpx5
   zPWEoVmR66rABuBVmre86emNQ6YTN5uCWuO3M1hJzJlaTSLCFrJM0J18L
   w==;
X-CSE-ConnectionGUID: CLyMrhA2T3GPfd8xm5dF5w==
X-CSE-MsgGUID: vhmI7KvsRmuj0CBKj65grQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="31947071"
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="31947071"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 08:00:50 -0800
X-CSE-ConnectionGUID: x6PYthRnQI6Mw8HD1XKb5w==
X-CSE-MsgGUID: 9yQZjJcOQgulNKdb18SnDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="112304852"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 17 Nov 2024 08:00:48 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tChhd-0001sO-3A;
	Sun, 17 Nov 2024 16:00:45 +0000
Date: Mon, 18 Nov 2024 00:00:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 b5a23a60e8ab5711f4952912424347bf3864ce8d
Message-ID: <202411180026.JOeUMGCX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: b5a23a60e8ab5711f4952912424347bf3864ce8d  serial: amba-pl011: fix build regression

elapsed time: 1458m

configs tested: 173
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-13.2.0
alpha                             allnoconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20241117    clang-20
arc                   randconfig-002-20241117    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                          collie_defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                          ixp4xx_defconfig    clang-20
arm                        multi_v7_defconfig    clang-20
arm                         nhk8815_defconfig    clang-20
arm                          pxa3xx_defconfig    clang-20
arm                             pxa_defconfig    clang-20
arm                   randconfig-001-20241117    clang-20
arm                   randconfig-002-20241117    clang-20
arm                   randconfig-003-20241117    clang-20
arm                   randconfig-004-20241117    clang-20
arm                         s5pv210_defconfig    clang-20
arm                           sama7_defconfig    clang-20
arm                           sunxi_defconfig    clang-20
arm                           u8500_defconfig    clang-20
arm                       versatile_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241117    clang-20
arm64                 randconfig-002-20241117    clang-20
arm64                 randconfig-003-20241117    clang-20
arm64                 randconfig-004-20241117    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241117    clang-20
csky                  randconfig-002-20241117    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241117    clang-20
hexagon               randconfig-002-20241117    clang-20
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241117    clang-19
i386        buildonly-randconfig-002-20241117    clang-19
i386        buildonly-randconfig-003-20241117    clang-19
i386        buildonly-randconfig-004-20241117    clang-19
i386        buildonly-randconfig-005-20241117    clang-19
i386        buildonly-randconfig-006-20241117    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241117    clang-19
i386                  randconfig-002-20241117    clang-19
i386                  randconfig-003-20241117    clang-19
i386                  randconfig-004-20241117    clang-19
i386                  randconfig-005-20241117    clang-19
i386                  randconfig-006-20241117    clang-19
i386                  randconfig-011-20241117    clang-19
i386                  randconfig-012-20241117    clang-19
i386                  randconfig-013-20241117    clang-19
i386                  randconfig-014-20241117    clang-19
i386                  randconfig-015-20241117    clang-19
i386                  randconfig-016-20241117    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241117    clang-20
loongarch             randconfig-002-20241117    clang-20
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           mtx1_defconfig    gcc-13.2.0
mips                   sb1250_swarm_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241117    clang-20
nios2                 randconfig-002-20241117    clang-20
openrisc                          allnoconfig    clang-20
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-20
parisc                              defconfig    gcc-12
parisc                generic-64bit_defconfig    gcc-13.2.0
parisc                randconfig-001-20241117    clang-20
parisc                randconfig-002-20241117    clang-20
parisc64                            defconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                     ksi8560_defconfig    gcc-13.2.0
powerpc                 mpc8313_rdb_defconfig    gcc-13.2.0
powerpc                     rainier_defconfig    gcc-13.2.0
powerpc               randconfig-001-20241117    clang-20
powerpc               randconfig-002-20241117    clang-20
powerpc               randconfig-003-20241117    clang-20
powerpc                     sequoia_defconfig    gcc-13.2.0
powerpc64                        alldefconfig    clang-20
powerpc64             randconfig-001-20241117    clang-20
powerpc64             randconfig-002-20241117    clang-20
powerpc64             randconfig-003-20241117    clang-20
riscv                             allnoconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241117    clang-20
riscv                 randconfig-002-20241117    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241117    clang-20
s390                  randconfig-002-20241117    clang-20
s390                       zfcpdump_defconfig    gcc-13.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                               j2_defconfig    gcc-13.2.0
sh                    randconfig-001-20241117    clang-20
sh                    randconfig-002-20241117    clang-20
sh                           se7206_defconfig    gcc-13.2.0
sh                           se7750_defconfig    gcc-13.2.0
sh                        sh7785lcr_defconfig    gcc-13.2.0
sh                            shmin_defconfig    clang-20
sh                          urquell_defconfig    gcc-13.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241117    clang-20
sparc64               randconfig-002-20241117    clang-20
um                                allnoconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241117    clang-20
um                    randconfig-002-20241117    clang-20
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241117    gcc-12
x86_64      buildonly-randconfig-002-20241117    gcc-12
x86_64      buildonly-randconfig-003-20241117    gcc-12
x86_64      buildonly-randconfig-004-20241117    gcc-12
x86_64      buildonly-randconfig-005-20241117    gcc-12
x86_64      buildonly-randconfig-006-20241117    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241117    gcc-12
x86_64                randconfig-002-20241117    gcc-12
x86_64                randconfig-003-20241117    gcc-12
x86_64                randconfig-004-20241117    gcc-12
x86_64                randconfig-005-20241117    gcc-12
x86_64                randconfig-006-20241117    gcc-12
x86_64                randconfig-011-20241117    gcc-12
x86_64                randconfig-012-20241117    gcc-12
x86_64                randconfig-013-20241117    gcc-12
x86_64                randconfig-014-20241117    gcc-12
x86_64                randconfig-015-20241117    gcc-12
x86_64                randconfig-016-20241117    gcc-12
x86_64                randconfig-071-20241117    gcc-12
x86_64                randconfig-072-20241117    gcc-12
x86_64                randconfig-073-20241117    gcc-12
x86_64                randconfig-074-20241117    gcc-12
x86_64                randconfig-075-20241117    gcc-12
x86_64                randconfig-076-20241117    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                          iss_defconfig    clang-20
xtensa                randconfig-001-20241117    clang-20
xtensa                randconfig-002-20241117    clang-20
xtensa                    xip_kc705_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
