Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3803851C3E
	for <linux-serial@vger.kernel.org>; Wed, 17 Apr 2024 05:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713330986; cv=none; b=dSPKDCLjdmgsaXQgwVG0asJXqfoqH9TgEoeSQy6Qv0EHoGayy3/hSRsx0VU0p8nvLh1/tC0rqY9Uisi5kHYeWFg133XCxH2pt5eWZIwk0PGlxR0rCFiN2s78o9Ml8sYkKD1uLVdbEPK3bUchxvhXfR158aWSLo9RZgVUuRPlOg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713330986; c=relaxed/simple;
	bh=o9JrWqIEeNxd3p4AH+Hmoxre7Q6q6jdtCrT9W1dXgtc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gWKyzcMkVoDtvbv7U2MeyuBfZe/+rBvaJzpQvQS1cb2BlRc5FYG46yFmVZiSmWRWx96lqSxcqbu9EFy+xBqIBUN9C6JT8/ppcQ0YpOZiRowvKLYqKrdHP0xfzsBxdndpItGPHWtXB/p+fy887uWQeBc30aBIpPkPZ4p2ME4qobM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VUdME/Sy; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VUdME/Sy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713330985; x=1744866985;
  h=date:from:to:cc:subject:message-id;
  bh=o9JrWqIEeNxd3p4AH+Hmoxre7Q6q6jdtCrT9W1dXgtc=;
  b=VUdME/SyRC0VLPefLO1TaixK2J/Pbsg+0/Pw0K8jPcAFExkBVlsRCasf
   2bkcYA+HFM5yZ4j8A/ROuDNxnIIvlBFxBeCyrP8B17QELwRcMM2brbXr5
   D76N8Zse4DoGpz8gMHABPAP6Ui/L9HV0De+diLZ4jjaWH3M19EYQRPy+w
   XyOBJHJlO+6wJqbmDl9HLYva7qZJDVFn7hpB+jbB2irzjQFF56kSkyZvE
   dum7pu9rxEvUxJY35u9pytAiYOTslm4bIMGiIZYN4dMJNqa1NBA+KN7Nz
   Sf09CWJP13TNb/sv8OdMFWc49vLBV4Tc2+alhm/4yKWxpEZt2/qUH5LO4
   w==;
X-CSE-ConnectionGUID: qnLtbI3GQyyUw0AY6Lwb0w==
X-CSE-MsgGUID: fBYwjyLYSHu3x2PlKAuDXQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12590166"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="12590166"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 22:16:24 -0700
X-CSE-ConnectionGUID: QZ3GB/k0QjS7lfzQhylIyw==
X-CSE-MsgGUID: P567/yS5SpSFK9XmlHSbbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="27191570"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 16 Apr 2024 22:16:24 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwxef-00069O-0E;
	Wed, 17 Apr 2024 05:16:21 +0000
Date: Wed, 17 Apr 2024 13:15:31 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 35fad98ed25ab9e08c4363f0f74efd612c8eb185
Message-ID: <202404171329.P0qbzyxv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 35fad98ed25ab9e08c4363f0f74efd612c8eb185  serial: meson+qcom: don't advance the kfifo twice

elapsed time: 1326m

configs tested: 158
configs skipped: 5

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
arc                   randconfig-001-20240417   gcc  
arc                   randconfig-002-20240417   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   clang
arm                                 defconfig   clang
arm                   randconfig-004-20240417   gcc  
arm64                            alldefconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-003-20240417   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240417   gcc  
csky                  randconfig-002-20240417   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240417   clang
i386         buildonly-randconfig-003-20240416   clang
i386         buildonly-randconfig-003-20240417   clang
i386         buildonly-randconfig-004-20240416   clang
i386         buildonly-randconfig-005-20240416   clang
i386                                defconfig   clang
i386                  randconfig-001-20240416   clang
i386                  randconfig-001-20240417   clang
i386                  randconfig-002-20240416   clang
i386                  randconfig-004-20240416   clang
i386                  randconfig-004-20240417   clang
i386                  randconfig-005-20240417   clang
i386                  randconfig-006-20240417   clang
i386                  randconfig-011-20240416   clang
i386                  randconfig-013-20240416   clang
i386                  randconfig-013-20240417   clang
i386                  randconfig-015-20240416   clang
i386                  randconfig-016-20240416   clang
i386                  randconfig-016-20240417   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240417   gcc  
loongarch             randconfig-002-20240417   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240417   gcc  
nios2                 randconfig-002-20240417   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240417   gcc  
parisc                randconfig-002-20240417   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      bamboo_defconfig   clang
powerpc                       holly_defconfig   clang
powerpc                     kmeter1_defconfig   gcc  
powerpc                     ksi8560_defconfig   gcc  
powerpc                  mpc866_ads_defconfig   clang
powerpc               randconfig-001-20240417   gcc  
powerpc               randconfig-002-20240417   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc                     tqm5200_defconfig   gcc  
powerpc64             randconfig-002-20240417   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240417   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                    randconfig-001-20240417   gcc  
sh                    randconfig-002-20240417   gcc  
sh                           se7721_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240417   gcc  
sparc64               randconfig-002-20240417   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-002-20240417   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240417   clang
x86_64       buildonly-randconfig-003-20240417   clang
x86_64       buildonly-randconfig-004-20240417   clang
x86_64       buildonly-randconfig-005-20240417   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-004-20240417   clang
x86_64                randconfig-005-20240417   clang
x86_64                randconfig-011-20240417   clang
x86_64                randconfig-012-20240417   clang
x86_64                randconfig-013-20240417   clang
x86_64                randconfig-015-20240417   clang
x86_64                randconfig-016-20240417   clang
x86_64                randconfig-072-20240417   clang
x86_64                randconfig-074-20240417   clang
x86_64                randconfig-075-20240417   clang
x86_64                randconfig-076-20240417   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240417   gcc  
xtensa                randconfig-002-20240417   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
