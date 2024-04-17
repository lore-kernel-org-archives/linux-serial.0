Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2379685633
	for <linux-serial@vger.kernel.org>; Wed, 17 Apr 2024 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713397673; cv=none; b=tpLXZVgj9EXF6t8JTqbqU9hGwcGZo4EIBQrLr28hGuOzHlZixSLA7mKqLgUnBDTFgjfbOMMAwlSKGueR3jCYarkQcC6iHhtUJSLot3f5d2hsDqbYP2hgP7sWnFDe7a92lJKZrxpi04m2kVH38pmFCbDH/3DiXuWHIb5kzA8D6L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713397673; c=relaxed/simple;
	bh=jxV2VYfhDmRxd27dKJpmia98gYbw1xGWBxp1QnrWMJE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QAXoGQAorVDuNIqj4J9XLEtKyggtbpZHngcpvRltwsmxzcfkHQ20+Tzniw7RrOjXNSQ3hri2RdW/RcQdGANaZfLu0lBnx4JPMPBfO1JHGXNJwFwGY5wCcl+O9PoKP47TAmfNggFUhES4IKncscGSUsBAs5uxuRKD9Y2qcjmCA8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zg8Upzrc; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zg8Upzrc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713397671; x=1744933671;
  h=date:from:to:cc:subject:message-id;
  bh=jxV2VYfhDmRxd27dKJpmia98gYbw1xGWBxp1QnrWMJE=;
  b=Zg8UpzrcBOTJfHPIvfi/CeZPfjMmO5/LhKEFMwscK6O7lwoyjrg73GVK
   09pGGcsyCwjlGyvb2xVmLkHpg6OOTOAM/lBC8ubEcXGS/zbX6DVN1maMH
   XFKWoJ1E+uRcQmG+lI4tB5E6KhH4DucpZGxw1+o0X8PSS8/Ph9LnVbAqA
   L2qNn5qJV+i3lkZZtd1ZQgSyMhy2pe2hkUEPFDGysZEpPoFz1KrIEAMuX
   3dTf8PQwOizFQSqXsDzrxRFxV5cuyCx3ZD57aIO9E8JbEpt1DZgEZnpfi
   vwxC2IYFrnViArrm5pxTMk/+I9jeepeleoyNSQjUWA2/ON/WcWKx7xiSE
   w==;
X-CSE-ConnectionGUID: URVduslvSPirsF9SKtp6NA==
X-CSE-MsgGUID: bxcsyhVTRV+0FGyJZxyjdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19526068"
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="19526068"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 16:47:50 -0700
X-CSE-ConnectionGUID: pxHetz9WS3OAtb5017FZzQ==
X-CSE-MsgGUID: oSDFBZp6SJ61gEqMCAFdhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="27567224"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 17 Apr 2024 16:47:50 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxF0E-00075o-22;
	Wed, 17 Apr 2024 23:47:46 +0000
Date: Thu, 18 Apr 2024 07:46:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 ea2624b5b829b8f93c0dce25721d835969b34faf
Message-ID: <202404180755.Khy0WJbC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: ea2624b5b829b8f93c0dce25721d835969b34faf  serial: stm32: Reset .throttled state in .startup()

elapsed time: 731m

configs tested: 101
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
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240417   clang
i386         buildonly-randconfig-002-20240417   gcc  
i386         buildonly-randconfig-003-20240417   clang
i386         buildonly-randconfig-004-20240417   gcc  
i386         buildonly-randconfig-005-20240417   gcc  
i386         buildonly-randconfig-006-20240417   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240417   clang
i386                  randconfig-002-20240417   gcc  
i386                  randconfig-003-20240417   gcc  
i386                  randconfig-004-20240417   clang
i386                  randconfig-005-20240417   clang
i386                  randconfig-006-20240417   clang
i386                  randconfig-011-20240417   gcc  
i386                  randconfig-012-20240417   gcc  
i386                  randconfig-013-20240417   clang
i386                  randconfig-014-20240417   gcc  
i386                  randconfig-015-20240417   gcc  
i386                  randconfig-016-20240417   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
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
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
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
