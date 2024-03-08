Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2621D52B
	for <linux-serial@vger.kernel.org>; Fri,  8 Mar 2024 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903574; cv=none; b=O/gz3VIxsoSiTdWInIP9jwtiD63VAFjpG9qj1FPuHGFe5LkZ6QzGSHxSH3tYAve1QwYcBORHF5Jq+YNLCl0jvUl6C+0gxWbE6QLchzXGKSojfAGBC+ggXodq7hYWSOL2aTrgZWCW/EErAypnqHiaMgsklaYn6bfR/0DD70UfGb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903574; c=relaxed/simple;
	bh=oxH1VSnfhg7w1dNfFKu34GQxdkYEVkYa44Cc1SAyZVg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pMqTvnTO776uVzMTVeKIEJA1ThlK0z/gGunGARlMEorXQyp7NsMIXi/HTjZ0Z7btrjKPX8MEoZefs2XXG12sdmsa07IYpFaDKb2jg6ZddaG+oZ5+bPpmThD7OfeHbeTbAcw83Cwn3xrjglf3/al3vQBB51jARPxqYxm0lz1jto4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T4nIVWvW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4nIVWvW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709903572; x=1741439572;
  h=date:from:to:cc:subject:message-id;
  bh=oxH1VSnfhg7w1dNfFKu34GQxdkYEVkYa44Cc1SAyZVg=;
  b=T4nIVWvWY2uExlmZdaNnpDHdSMjw8jk2zk0N3wifXdR6Ld+ylFE1OVtr
   7XQ2dsN9FAX+yyuS10bP0ueNylsoBpUj+uHVYRPI3jcaorz2gtwSei2Cw
   kthVYj6F1OmuKJaSKMmkOyJD0Mzbcx6VeLk/bDERmneYUYwFQ0ATQTH4E
   RhYrpV/xr791v0nMZbeQhRGm+hzQYCi4U/Ozl5mA/wy0XsNsMP9EGSy3T
   Ledi72IaUBpj+5eepf7pECOmEyv+4Yw7KuSTZwbawEteOebGudE+0frBs
   ivkGGlF6WBalQG4tN0yPz3cWK74D9hut4R2ey3VaBww/60/XWOx8chTFJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="5219346"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="5219346"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:12:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="10559947"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 08 Mar 2024 05:12:50 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ria1o-0006OR-13;
	Fri, 08 Mar 2024 13:12:48 +0000
Date: Fri, 08 Mar 2024 21:12:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 d6c0d892b44cd16e0421909cf7f2883b9e625e4a
Message-ID: <202403082112.7oEP1DpM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: d6c0d892b44cd16e0421909cf7f2883b9e625e4a  dt-bindings: serial: stm32: add power-domains property

elapsed time: 924m

configs tested: 174
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
arc                   randconfig-001-20240308   gcc  
arc                   randconfig-002-20240308   gcc  
arm                              alldefconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   gcc  
arm                                 defconfig   clang
arm                        neponset_defconfig   gcc  
arm                           omap1_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20240308   gcc  
arm                   randconfig-002-20240308   clang
arm                   randconfig-003-20240308   clang
arm                   randconfig-004-20240308   clang
arm                        shmobile_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240308   clang
arm64                 randconfig-002-20240308   clang
arm64                 randconfig-003-20240308   clang
arm64                 randconfig-004-20240308   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240308   gcc  
csky                  randconfig-002-20240308   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240308   clang
hexagon               randconfig-002-20240308   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240308   clang
i386         buildonly-randconfig-002-20240308   clang
i386         buildonly-randconfig-003-20240308   gcc  
i386         buildonly-randconfig-004-20240308   gcc  
i386         buildonly-randconfig-005-20240308   gcc  
i386         buildonly-randconfig-006-20240308   clang
i386                                defconfig   clang
i386                  randconfig-001-20240308   clang
i386                  randconfig-002-20240308   clang
i386                  randconfig-003-20240308   clang
i386                  randconfig-004-20240308   gcc  
i386                  randconfig-005-20240308   clang
i386                  randconfig-006-20240308   clang
i386                  randconfig-011-20240308   gcc  
i386                  randconfig-012-20240308   clang
i386                  randconfig-013-20240308   clang
i386                  randconfig-014-20240308   clang
i386                  randconfig-015-20240308   gcc  
i386                  randconfig-016-20240308   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240308   gcc  
loongarch             randconfig-002-20240308   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     loongson1c_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240308   gcc  
nios2                 randconfig-002-20240308   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240308   gcc  
parisc                randconfig-002-20240308   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240308   gcc  
powerpc               randconfig-002-20240308   clang
powerpc               randconfig-003-20240308   clang
powerpc                  storcenter_defconfig   gcc  
powerpc64             randconfig-001-20240308   gcc  
powerpc64             randconfig-002-20240308   clang
powerpc64             randconfig-003-20240308   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240308   clang
riscv                 randconfig-002-20240308   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240308   gcc  
s390                  randconfig-002-20240308   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                    randconfig-001-20240308   gcc  
sh                    randconfig-002-20240308   gcc  
sh                           se7724_defconfig   gcc  
sh                            titan_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240308   gcc  
sparc64               randconfig-002-20240308   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240308   clang
um                    randconfig-002-20240308   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240308   gcc  
x86_64       buildonly-randconfig-003-20240308   gcc  
x86_64       buildonly-randconfig-005-20240308   gcc  
x86_64       buildonly-randconfig-006-20240308   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240308   gcc  
x86_64                randconfig-005-20240308   gcc  
x86_64                randconfig-006-20240308   gcc  
x86_64                randconfig-012-20240308   gcc  
x86_64                randconfig-015-20240308   gcc  
x86_64                randconfig-016-20240308   gcc  
x86_64                randconfig-072-20240308   gcc  
x86_64                randconfig-073-20240308   gcc  
x86_64                randconfig-074-20240308   gcc  
x86_64                randconfig-075-20240308   gcc  
x86_64                randconfig-076-20240308   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240308   gcc  
xtensa                randconfig-002-20240308   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
