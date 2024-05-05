Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0921803D
	for <linux-serial@vger.kernel.org>; Sun,  5 May 2024 12:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714910582; cv=none; b=AQKJ0l9NJxOKuoYRzoBZJNw49aoBpSni0LPDtkc1oCCC1o59mFo9VY1LTBujrqxUFsG4n3AU3yKikN9PeV8PD2TuzIIDY71chn0SJ8th8rmmgQ8sr52SOdLokUGHujFWtRQBK7T65zDPCtgypW2agtGJUq4bVNN/gCYMKas4CB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714910582; c=relaxed/simple;
	bh=Tl8N7nDspIRTCaV+3C+008xX532Hk38eRJRIsd3/fng=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tueNhbU3gl3ldR9b9XHC49DPod6fYGhlx/NAfohULlLtwPoGehO/PUMMADDUDEV4ys2ZaYaiOpux4cF9C2XvZxvFFIxJmCo8hOxoLf1ZvG//NhKeDbADbycJWrszJNEl1iF53bzCJ2iFC+42h4u7rqW9C3b9hm3trif3G1Lm2SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hoWJ/tZN; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hoWJ/tZN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714910579; x=1746446579;
  h=date:from:to:cc:subject:message-id;
  bh=Tl8N7nDspIRTCaV+3C+008xX532Hk38eRJRIsd3/fng=;
  b=hoWJ/tZNwxRYHKjWY2wIX+KEjOgN3VYrxcv6f2xIiEVpycd9lHsze+T4
   ryd9WGvP44iNfp/B7D1h6i+3E8K6tDDBAsD1EjhTu/Ng3hnu9KdJtLn6C
   TKTjzlKR1nwAIOeLir7NVm64jn5k5j1z8WQ38OAf3ynKg4halhYALB9v3
   TadWbFLdhMK+/s+vFif0CEq705rHvpp4DSOkorE0inlIPpDzT/XbosBxJ
   EBHoH+2HZXqw8fVyZRmeuIyoznylFp4y67/0Y+VCGpOfK3rQDrt43KQmB
   wGWPEZP+IYeb4zquBR3hnheWMMuP5E0oNW/w1eS7FpcsXAozOFqDwle62
   w==;
X-CSE-ConnectionGUID: dKbAM11pTlKggZfY0gJCtg==
X-CSE-MsgGUID: towWYHDYQdCJBey6OXwIPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10819160"
X-IronPort-AV: E=Sophos;i="6.07,256,1708416000"; 
   d="scan'208";a="10819160"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2024 05:02:59 -0700
X-CSE-ConnectionGUID: uMrrEENtTPO7eXEglJt9cw==
X-CSE-MsgGUID: vIqJDo7MTN6xPfyKvHkC0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,256,1708416000"; 
   d="scan'208";a="32506017"
Received: from lkp-server01.sh.intel.com (HELO 123fad1cf874) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 05 May 2024 05:02:57 -0700
Received: from kbuild by 123fad1cf874 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s3aZz-0000Bs-0c;
	Sun, 05 May 2024 12:02:55 +0000
Date: Sun, 05 May 2024 20:02:21 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 8492bd91aa055907c67ef04f2b56f6dadd1f44bf
Message-ID: <202405052019.J8qAbmEm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 8492bd91aa055907c67ef04f2b56f6dadd1f44bf  serial: sc16is7xx: fix bug in sc16is7xx_set_baud() when using prescaler

elapsed time: 1184m

configs tested: 180
configs skipped: 4

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
arc                   randconfig-001-20240505   gcc  
arc                   randconfig-002-20240505   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          moxart_defconfig   gcc  
arm                           omap1_defconfig   gcc  
arm                   randconfig-001-20240505   clang
arm                   randconfig-002-20240505   gcc  
arm                   randconfig-003-20240505   gcc  
arm                   randconfig-004-20240505   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240505   clang
arm64                 randconfig-002-20240505   clang
arm64                 randconfig-003-20240505   clang
arm64                 randconfig-004-20240505   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240505   gcc  
csky                  randconfig-002-20240505   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240505   clang
hexagon               randconfig-002-20240505   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240505   clang
i386         buildonly-randconfig-002-20240505   clang
i386         buildonly-randconfig-003-20240505   clang
i386         buildonly-randconfig-004-20240505   gcc  
i386         buildonly-randconfig-005-20240505   clang
i386         buildonly-randconfig-006-20240505   clang
i386                                defconfig   clang
i386                  randconfig-001-20240505   clang
i386                  randconfig-002-20240505   clang
i386                  randconfig-003-20240505   gcc  
i386                  randconfig-004-20240505   clang
i386                  randconfig-005-20240505   gcc  
i386                  randconfig-006-20240505   gcc  
i386                  randconfig-011-20240505   gcc  
i386                  randconfig-012-20240505   gcc  
i386                  randconfig-013-20240505   clang
i386                  randconfig-014-20240505   gcc  
i386                  randconfig-015-20240505   gcc  
i386                  randconfig-016-20240505   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240505   gcc  
loongarch             randconfig-002-20240505   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240505   gcc  
nios2                 randconfig-002-20240505   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240505   gcc  
parisc                randconfig-002-20240505   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc                   microwatt_defconfig   gcc  
powerpc               randconfig-001-20240505   gcc  
powerpc               randconfig-002-20240505   clang
powerpc               randconfig-003-20240505   clang
powerpc64             randconfig-001-20240505   gcc  
powerpc64             randconfig-002-20240505   clang
powerpc64             randconfig-003-20240505   gcc  
riscv                            alldefconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240505   clang
riscv                 randconfig-002-20240505   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240505   gcc  
s390                  randconfig-002-20240505   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240505   gcc  
sh                    randconfig-002-20240505   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240505   gcc  
sparc64               randconfig-002-20240505   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240505   gcc  
um                    randconfig-002-20240505   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240505   gcc  
x86_64       buildonly-randconfig-002-20240505   clang
x86_64       buildonly-randconfig-003-20240505   clang
x86_64       buildonly-randconfig-004-20240505   clang
x86_64       buildonly-randconfig-005-20240505   gcc  
x86_64       buildonly-randconfig-006-20240505   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240505   clang
x86_64                randconfig-002-20240505   gcc  
x86_64                randconfig-003-20240505   clang
x86_64                randconfig-004-20240505   gcc  
x86_64                randconfig-005-20240505   gcc  
x86_64                randconfig-006-20240505   gcc  
x86_64                randconfig-011-20240505   clang
x86_64                randconfig-012-20240505   clang
x86_64                randconfig-013-20240505   clang
x86_64                randconfig-014-20240505   clang
x86_64                randconfig-015-20240505   clang
x86_64                randconfig-016-20240505   clang
x86_64                randconfig-071-20240505   clang
x86_64                randconfig-072-20240505   gcc  
x86_64                randconfig-073-20240505   gcc  
x86_64                randconfig-074-20240505   gcc  
x86_64                randconfig-075-20240505   clang
x86_64                randconfig-076-20240505   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240505   gcc  
xtensa                randconfig-002-20240505   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
