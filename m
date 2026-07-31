Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB5C42B320
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507522; cv=none; b=S/faK+shyMUN/DAMghwOaVz58bBkm3IuAMl+SD1IzWSsr8WQJBaqP6t6AUczyOvjQF0jXk761k/IQg8PozFg8cWI1MY73dcR8YZuHTvageo92cSvnJIGHrkBMb5f901aEQpvaX5eJ5EfpE957ggRTFrXKL3GQKCd6rEF3SCnoh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507522; c=relaxed/simple;
	bh=rjO/QZcRa0Jh7QTb2aw4cUDccen77870dF60svA1zgA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tSS+N/5UliG7JSVIMh3kY5gO3p3M7p2urAJUJXlmmBSTq3aWPzfmDt7PgGmTCPUARofj97E51IX/tIn2dy7f258FUbH4AiGAuwe7clNZ8u0vitzbH/AXZz14WGEk+LpJdB1batlkaDmFUHQSntBmcr7j9/wXxh1BdWlYBOVExLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+eNvzNi; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+eNvzNi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785507521; x=1817043521;
  h=date:from:to:cc:subject:message-id;
  bh=rjO/QZcRa0Jh7QTb2aw4cUDccen77870dF60svA1zgA=;
  b=m+eNvzNiX/R5LCTtT0z9N0JOdDxsSj7bOKvy4QZvNMzsJl1Ta0bCrSZ+
   ADXmR26KLdwGpEiYCnqMkxVyb64RQ3QBvO+rjjDqAHSmiMYSo4R/+MN9j
   QP1yxXXcC0a67aqOEmlFKzIrnVAm9halTDY7XKM06NYQtCZrlZbDtR4Mo
   l6TLb3gaKj43omueX5b68qTaJVTSMt5U1+UxLfJ/8n9uQb1o3TJtOVc2S
   cXO3BM0O1lO9obttAiWihIzL1boB0W+xQ8HozuyrQVXvH3bLzJujGjhM5
   RLTF1FmpCHHzGi3vmobOdHor0mKubVjLWPxGhXnTuyyt52A6JHgu8M5hm
   w==;
X-CSE-ConnectionGUID: 5VsEo83zRHCkug6+nhZuKQ==
X-CSE-MsgGUID: jjBWJkeBQDax0j7rov1feg==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="85900389"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="85900389"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 07:18:41 -0700
X-CSE-ConnectionGUID: N2TiJPlPQNqPa5ZTBLmWZw==
X-CSE-MsgGUID: Y4Ybnt/ETk2RWFockTFzmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="256272090"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 31 Jul 2026 07:18:39 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wpo4L-000000001Bc-0e3R;
	Fri, 31 Jul 2026 14:18:37 +0000
Date: Fri, 31 Jul 2026 22:17:33 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 e3c04834ae1ab5e9cfbe8ac54ec734aa4774249d
Message-ID: <202607312221.KSO1VKTk-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: e3c04834ae1ab5e9cfbe8ac54ec734aa4774249d  serial: qcom-geni: fix TX DMA buffer flush

elapsed time: 801m

configs tested: 105
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260731    clang-17
arc                  randconfig-002-20260731    clang-17
arm                           mmp2_defconfig    gcc-16.1.0
arm                  randconfig-001-20260731    clang-17
arm                  randconfig-002-20260731    clang-17
arm                  randconfig-003-20260731    clang-17
arm                  randconfig-004-20260731    clang-17
arm64                randconfig-001-20260731    gcc-8.5.0
arm64                randconfig-002-20260731    gcc-8.5.0
arm64                randconfig-003-20260731    gcc-8.5.0
arm64                randconfig-004-20260731    gcc-8.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260731    gcc-8.5.0
csky                 randconfig-002-20260731    gcc-8.5.0
hexagon                       randconfig-001    clang-24
hexagon              randconfig-001-20260731    clang-24
hexagon              randconfig-002-20260731    clang-24
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260731    clang-22
i386       buildonly-randconfig-002-20260731    clang-22
i386       buildonly-randconfig-003-20260731    clang-22
i386       buildonly-randconfig-004-20260731    clang-22
i386       buildonly-randconfig-005-20260731    clang-22
i386       buildonly-randconfig-006-20260731    clang-22
i386                 randconfig-001-20260731    gcc-14
i386                 randconfig-002-20260731    gcc-14
i386                 randconfig-003-20260731    gcc-14
i386                 randconfig-004-20260731    gcc-14
i386                 randconfig-005-20260731    gcc-14
i386                 randconfig-006-20260731    gcc-14
i386                 randconfig-007-20260731    gcc-14
i386                 randconfig-011-20260731    clang-22
i386                 randconfig-012-20260731    clang-22
i386                 randconfig-013-20260731    clang-22
i386                 randconfig-014-20260731    clang-22
i386                 randconfig-015-20260731    clang-22
i386                 randconfig-016-20260731    clang-22
i386                 randconfig-017-20260731    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260731    clang-24
loongarch            randconfig-002-20260731    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260731    clang-24
nios2                randconfig-002-20260731    clang-24
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-8.5.0
parisc               randconfig-001-20260731    gcc-8.5.0
parisc               randconfig-002-20260731    gcc-8.5.0
powerpc              randconfig-001-20260731    gcc-8.5.0
powerpc              randconfig-002-20260731    gcc-8.5.0
powerpc64            randconfig-001-20260731    gcc-8.5.0
powerpc64            randconfig-002-20260731    gcc-8.5.0
riscv                   nommu_k210_defconfig    clang-24
riscv                         randconfig-001    clang-19
riscv                randconfig-001-20260731    clang-19
riscv                randconfig-002-20260731    clang-19
s390                 randconfig-001-20260731    clang-19
s390                 randconfig-002-20260731    clang-19
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260731    clang-19
sh                   randconfig-002-20260731    clang-19
sparc                         randconfig-001    gcc-14
sparc                randconfig-001-20260731    gcc-14
sparc                randconfig-002-20260731    gcc-14
sparc64              randconfig-001-20260731    gcc-14
sparc64              randconfig-002-20260731    gcc-14
um                   randconfig-001-20260731    gcc-14
um                   randconfig-002-20260731    gcc-14
x86_64     buildonly-randconfig-001-20260731    gcc-14
x86_64     buildonly-randconfig-002-20260731    gcc-14
x86_64     buildonly-randconfig-003-20260731    gcc-14
x86_64     buildonly-randconfig-004-20260731    gcc-14
x86_64     buildonly-randconfig-005-20260731    gcc-14
x86_64     buildonly-randconfig-006-20260731    gcc-14
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    gcc-14
x86_64               randconfig-001-20260731    gcc-14
x86_64               randconfig-002-20260731    gcc-14
x86_64               randconfig-003-20260731    gcc-14
x86_64               randconfig-004-20260731    gcc-14
x86_64               randconfig-005-20260731    gcc-14
x86_64               randconfig-006-20260731    gcc-14
x86_64               randconfig-011-20260731    gcc-14
x86_64               randconfig-012-20260731    gcc-14
x86_64               randconfig-013-20260731    gcc-14
x86_64               randconfig-014-20260731    gcc-14
x86_64               randconfig-015-20260731    gcc-14
x86_64               randconfig-016-20260731    gcc-14
x86_64               randconfig-071-20260731    clang-22
x86_64               randconfig-072-20260731    clang-22
x86_64               randconfig-073-20260731    clang-22
x86_64               randconfig-074-20260731    clang-22
x86_64               randconfig-075-20260731    clang-22
x86_64               randconfig-076-20260731    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260731    gcc-14
xtensa               randconfig-002-20260731    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
