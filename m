Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D95433AF
	for <linux-serial@vger.kernel.org>; Wed, 15 May 2024 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757393; cv=none; b=jW16eLCqpwJAAAS8KLwofj6R1dICmn1ejWrZKTFxx5O0oAsqHzT/37819ABoHGKfkW9zJbCm8259FfyFmfF/Xze7ox0UnuCDvIJq164ZspHIr/KKK2uoA84i4nvwBu2HeO3ECE/GuZBSgjF//yssmokA4vBcKUP3ElMKpDiOxpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757393; c=relaxed/simple;
	bh=Qe94HlduhAqspQTYSiM3Dr6U8Bc4l/5FFCHCSStYz9Y=;
	h=Date:From:To:Subject:Message-ID; b=h4MpniWCgHreWp0vx+E6/0OoPLZB0tgwPRY4Jp78sGyrQtjCCsqH4OcBoGQkrzWfjT71oXFogyHdx3JqLeI8hJm0CVn3wkh0acvoc6iZ0hAQWJWxxMF14sZytMlvqZsl7AH3l8xYLPqvHZ0B0i54WGxOw7kJMwPDJ5dp7R/NbnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=axg2rAU2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="axg2rAU2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715757392; x=1747293392;
  h=date:from:to:subject:message-id;
  bh=Qe94HlduhAqspQTYSiM3Dr6U8Bc4l/5FFCHCSStYz9Y=;
  b=axg2rAU2OKPO0UPuWGngSoaCDWFqplP0Iba270OFVlUmzbrnSGqesnZJ
   fzUu6xPd7oFF4vjayyh5pXwlLq6egcUyZcGuK5CEKqc9LmgrLY5CGxde/
   NvqmiX3g4lRur53iCGwrJB7hnU8iwFMvx5e9MiNE5B5NjKLguzQ4RXxmg
   5t8+tiij62hSO9egpoogXj+9PyiagT3Fg3/QD6cwW9y6ceGrsxwhctYCb
   95mRPVKnMQ+H63229SHBeSkk4J4nP6mE7HnYrMO/CZa1Ig7d17q9gxayB
   ann0nP2sdg7DniOAIdgarFl51vN0eFtaQT0ftTZcUpHL/oteUD3bfTV5W
   A==;
X-CSE-ConnectionGUID: KAc6g5ePRdGfV0AhmlqMjA==
X-CSE-MsgGUID: PwmEV5G3R4ufjJjJtjUFDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11532967"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="11532967"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 00:16:31 -0700
X-CSE-ConnectionGUID: +HtvqrT+TVGksvz68fUhww==
X-CSE-MsgGUID: Hbb4fxiGRaGzGyoDIfP+Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="62134758"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 15 May 2024 00:16:30 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s78sG-000CZH-0M
	for linux-serial@vger.kernel.org;
	Wed, 15 May 2024 07:16:28 +0000
Date: Wed, 15 May 2024 15:15:38 +0800
From: kernel test robot <lkp@intel.com>
To: linux-serial@vger.kernel.org
Subject: [BUILD SUCCESS] LAST PATCH: [PATCH v1 2/2] serial: 8250_dw:
 Revert "Move definitions to the shared header"
Message-ID: <202405151536.pRX7Jzsc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/serial-8250_dw-Don-t-use-struct-dw8250_data-outside-of-8250_dw/20240515-030857
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20240514190730.2787071-3-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 2/2] serial: 8250_dw: Revert "Move definitions to the shared header"

[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

elapsed time: 716m

configs tested: 156
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240515   gcc  
arc                   randconfig-002-20240515   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            dove_defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                            mps2_defconfig   clang
arm                       netwinder_defconfig   gcc  
arm                   randconfig-001-20240515   clang
arm                   randconfig-002-20240515   gcc  
arm                   randconfig-003-20240515   clang
arm                   randconfig-004-20240515   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240515   gcc  
arm64                 randconfig-002-20240515   clang
arm64                 randconfig-003-20240515   clang
arm64                 randconfig-004-20240515   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240515   gcc  
csky                  randconfig-002-20240515   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240515   clang
hexagon               randconfig-002-20240515   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240515   gcc  
i386         buildonly-randconfig-002-20240515   gcc  
i386         buildonly-randconfig-003-20240515   gcc  
i386         buildonly-randconfig-004-20240515   gcc  
i386         buildonly-randconfig-005-20240515   gcc  
i386         buildonly-randconfig-006-20240515   clang
i386                                defconfig   clang
i386                  randconfig-001-20240515   clang
i386                  randconfig-002-20240515   gcc  
i386                  randconfig-003-20240515   gcc  
i386                  randconfig-004-20240515   gcc  
i386                  randconfig-005-20240515   clang
i386                  randconfig-006-20240515   gcc  
i386                  randconfig-011-20240515   clang
i386                  randconfig-012-20240515   gcc  
i386                  randconfig-013-20240515   clang
i386                  randconfig-014-20240515   gcc  
i386                  randconfig-015-20240515   gcc  
i386                  randconfig-016-20240515   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240515   gcc  
loongarch             randconfig-002-20240515   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                           gcw0_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240515   gcc  
nios2                 randconfig-002-20240515   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240515   gcc  
parisc                randconfig-002-20240515   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240515   clang
powerpc               randconfig-002-20240515   clang
powerpc               randconfig-003-20240515   gcc  
powerpc                      tqm8xx_defconfig   clang
powerpc64             randconfig-001-20240515   gcc  
powerpc64             randconfig-002-20240515   clang
powerpc64             randconfig-003-20240515   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240515   clang
riscv                 randconfig-002-20240515   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240515   clang
s390                  randconfig-002-20240515   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240515   gcc  
sh                    randconfig-002-20240515   gcc  
sh                          rsk7269_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240515   gcc  
sparc64               randconfig-002-20240515   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240515   gcc  
um                    randconfig-002-20240515   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240515   gcc  
xtensa                randconfig-002-20240515   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
