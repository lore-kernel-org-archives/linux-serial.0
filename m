Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8012CCBE
	for <linux-serial@vger.kernel.org>; Sat, 11 May 2024 05:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715406772; cv=none; b=tb7VlvqjqrLst+CQMZm/lL7Ihn5NEC8WymCWW3N9knjGxVZNvO3txQ2ZrOUEMAgTIx4h9q0mx3Sj+vEujIUYVYMSntwUiqr01UNdAyzvYZ2tTlquchreZREPD3ZuqT8VvLqpXTkRGpZCx1WzT8OzkbQdXR+AeouGuQpn/ty9nGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715406772; c=relaxed/simple;
	bh=cDbKK4Wc5TswFwefEGJZe50gxgri6z2VXLUIz/Scwn0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MbwRV+B5/vL96CNzSHYzr1UXsYqJNJaZFPsyM7Yni0S8rOlf6oPy4Gly43uQA+4aVr/xGVc0Ea2TKtWOhMCVBhf6sylL3EwpbyrwHaG1UBZ7h/IWEfGR8loOAtDZ+EksQoD7kTOmXirhQYJwfJKcsc/yFqOBuyUDd0vGDT7mQts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GmjKNNoy; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GmjKNNoy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715406770; x=1746942770;
  h=date:from:to:cc:subject:message-id;
  bh=cDbKK4Wc5TswFwefEGJZe50gxgri6z2VXLUIz/Scwn0=;
  b=GmjKNNoyPQbAhRKf5Cj9pWpVDAwdd4LnI6tA2OIPRccC8xMytLbybGHC
   LgikQWNzbAbcUMHUY+GLofReZQ6PzOALskfyMKY0toAfYj8D66KIDxYvb
   IImoqAVBCbbLchpXSuIUvX01ROhsAMqDD9ZUoLMqoKK5mxm5GGKOwnUTD
   AHdzKja1kqYTKHQSNZXJOziSUFrcNTSIQxNd/bO2W0pIQd+hntY2XTVS/
   moXZ/BNspe0PWguvMav8/7AcKoUybmx1Uau/OAEqcJZ4BBh5ndQCRLgbv
   UaJrG+c79LuIJALAoKtfXCvS9m2fO9yyGCbmwJXp4TXhyGDGQma0N+2mD
   A==;
X-CSE-ConnectionGUID: vZOhmB+lQCKpQbtiVZyIuQ==
X-CSE-MsgGUID: oUboMPwPTMiS+bVVZnC2uA==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="21986548"
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="21986548"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 22:52:50 -0700
X-CSE-ConnectionGUID: 3PIdqQi9RMSOJMbmcGikzw==
X-CSE-MsgGUID: dFk9czlIQdi3Br4qvap5tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="30228539"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 10 May 2024 22:52:49 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5ff4-00070F-1m;
	Sat, 11 May 2024 05:52:46 +0000
Date: Sat, 11 May 2024 13:52:29 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 e21de1455a721a0cb4217b18589ede846f5b0686
Message-ID: <202405111328.FvPXQ68x-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: e21de1455a721a0cb4217b18589ede846f5b0686  serial: Clear UPF_DEAD before calling tty_port_register_device_attr_serdev()

elapsed time: 1011m

configs tested: 127
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
arc                   randconfig-001-20240511   gcc  
arc                   randconfig-002-20240511   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240511   clang
arm                   randconfig-002-20240511   clang
arm                   randconfig-003-20240511   gcc  
arm                   randconfig-004-20240511   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240511   gcc  
arm64                 randconfig-002-20240511   clang
arm64                 randconfig-003-20240511   gcc  
arm64                 randconfig-004-20240511   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240511   gcc  
csky                  randconfig-002-20240511   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240511   clang
hexagon               randconfig-002-20240511   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240511   gcc  
i386         buildonly-randconfig-002-20240511   clang
i386         buildonly-randconfig-003-20240511   gcc  
i386         buildonly-randconfig-004-20240511   clang
i386         buildonly-randconfig-005-20240511   gcc  
i386         buildonly-randconfig-006-20240511   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240511   gcc  
i386                  randconfig-002-20240511   clang
i386                  randconfig-003-20240511   gcc  
i386                  randconfig-004-20240511   clang
i386                  randconfig-005-20240511   gcc  
i386                  randconfig-006-20240511   gcc  
i386                  randconfig-011-20240511   clang
i386                  randconfig-012-20240511   gcc  
i386                  randconfig-013-20240511   clang
i386                  randconfig-014-20240511   clang
i386                  randconfig-015-20240511   clang
i386                  randconfig-016-20240511   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240511   gcc  
loongarch             randconfig-002-20240511   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240511   gcc  
nios2                 randconfig-002-20240511   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240511   gcc  
parisc                randconfig-002-20240511   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240511   gcc  
powerpc               randconfig-002-20240511   clang
powerpc               randconfig-003-20240511   gcc  
powerpc64             randconfig-001-20240511   gcc  
powerpc64             randconfig-002-20240511   gcc  
powerpc64             randconfig-003-20240511   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
