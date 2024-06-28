Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B378157A4D
	for <linux-serial@vger.kernel.org>; Fri, 28 Jun 2024 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593696; cv=none; b=Ta34TLgh3f7JrJJmnHKEWng3JKaYtqtyDPdwmgLWIEySjsC5OIXcnOdln1ciIHqbXMkJcIKMmDDMWKVvdVtN6nsxjnb6FkWIqhmFlp11mhlDvBtgd22JqCpqDmEsHkhsGF3J6HBuTBcCL5VLuT26YrQ7BqJ57kpQl0U+BrEuHZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593696; c=relaxed/simple;
	bh=tjtI21mrNOHhxsxhFEemHqxjIJca9cR2qnqNQCyTYCI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=e042na05rSCBT1FzpqjCNQkBuL9UrVls0jMpUX2sfL7JSA1tSoTL+BbmTm4OddhveHaBbfnWvpVBzYyei0DoAI00q+ZUSlE4ZgqXQGM1vrZLruPTtrS8cxwazZD3Was+zjK5bvmK3MKo5sa02V0h3NZTuYhK1CVJfwoZMbMv8DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UA3PKRGP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UA3PKRGP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719593694; x=1751129694;
  h=date:from:to:cc:subject:message-id;
  bh=tjtI21mrNOHhxsxhFEemHqxjIJca9cR2qnqNQCyTYCI=;
  b=UA3PKRGPHgeulGQuMDT30/HO38W2EiUzsQ0lO/ULOvUc+n5645FCY5jV
   QzZd7yDAb5SXgJyTJMWGx6bA/yHan36akBwkaFO9tXWVnIFZ8kbOnCeOj
   9hJ9R5jHJ6rESn4hDgbPOs4jok0CJFSTiNsnUqQAHovwTaOSBa42ex1n2
   vyz82Qg3AFBrAO6tCcR3CuHUOPtlxjNIys1Q9SE5/iHIcYQXKO0tchGyD
   MsIdn+0JRuIaLxCTIRRQzneOOvBZuAMDJXo1tuBiceDJhDZ0DYzUzlQCA
   +aEo3ZK8CkSQPuVEwwCeT9ZRVF9HoLAHzXZfAGK8I4mtfnXXOpPR0b7jt
   Q==;
X-CSE-ConnectionGUID: Z+gLH/qsRfiXShalWHHWpQ==
X-CSE-MsgGUID: 8qJnh3MdQV6efHkyx/M4ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="27918843"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="27918843"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 09:54:54 -0700
X-CSE-ConnectionGUID: BSxwmizkR7iLXdwWN2EexQ==
X-CSE-MsgGUID: 4NyvR90IT82PUT0ouFQ0MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="75988141"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 28 Jun 2024 09:54:53 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNEs7-000HVC-0s;
	Fri, 28 Jun 2024 16:54:51 +0000
Date: Sat, 29 Jun 2024 00:54:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 4fb92bdb8e84e618f8c289dc56a923b914a72cac
Message-ID: <202406290046.VwSjo0dq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 4fb92bdb8e84e618f8c289dc56a923b914a72cac  serial: sc16is7xx: hardware reset chip if reset-gpios is defined in DT

elapsed time: 5899m

configs tested: 92
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                   randconfig-001-20240625   gcc-13.2.0
arc                   randconfig-002-20240625   gcc-13.2.0
arc                        vdk_hs38_defconfig   gcc-13.2.0
arm                       aspeed_g4_defconfig   clang-19
arm                         assabet_defconfig   clang-15
arm                          ixp4xx_defconfig   gcc-13.2.0
arm                         mv78xx0_defconfig   clang-19
arm                           omap1_defconfig   gcc-13.2.0
arm                   randconfig-003-20240625   gcc-13.2.0
arm                   randconfig-004-20240625   gcc-13.2.0
arm                        shmobile_defconfig   gcc-13.2.0
arm                       spear13xx_defconfig   gcc-13.2.0
arm                           sunxi_defconfig   gcc-13.2.0
arm                        vexpress_defconfig   gcc-13.2.0
arm                         vf610m4_defconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240625   gcc-13.2.0
arm64                 randconfig-002-20240625   gcc-13.2.0
arm64                 randconfig-004-20240625   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240625   gcc-13.2.0
csky                  randconfig-002-20240625   gcc-13.2.0
i386         buildonly-randconfig-001-20240628   gcc-10
i386         buildonly-randconfig-002-20240628   gcc-10
i386         buildonly-randconfig-003-20240628   gcc-10
i386         buildonly-randconfig-004-20240625   gcc-13
i386         buildonly-randconfig-004-20240628   gcc-10
i386         buildonly-randconfig-005-20240628   gcc-10
i386         buildonly-randconfig-006-20240628   gcc-10
i386                  randconfig-001-20240625   gcc-13
i386                  randconfig-001-20240628   gcc-10
i386                  randconfig-002-20240628   gcc-10
i386                  randconfig-003-20240625   gcc-7
i386                  randconfig-003-20240628   gcc-10
i386                  randconfig-004-20240628   gcc-10
i386                  randconfig-005-20240628   gcc-10
i386                  randconfig-006-20240625   gcc-13
i386                  randconfig-006-20240628   gcc-10
i386                  randconfig-011-20240628   gcc-10
i386                  randconfig-012-20240625   gcc-13
i386                  randconfig-012-20240628   gcc-10
i386                  randconfig-013-20240628   gcc-10
i386                  randconfig-014-20240628   gcc-10
i386                  randconfig-015-20240625   gcc-12
i386                  randconfig-015-20240628   gcc-10
i386                  randconfig-016-20240625   gcc-10
i386                  randconfig-016-20240628   gcc-10
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240625   gcc-13.2.0
loongarch             randconfig-002-20240625   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                          hp300_defconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                     cu1000-neo_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240625   gcc-13.2.0
nios2                 randconfig-002-20240625   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240625   gcc-13.2.0
parisc                randconfig-002-20240625   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                      katmai_defconfig   clang-19
powerpc               randconfig-002-20240625   gcc-13.2.0
powerpc               randconfig-003-20240625   gcc-13.2.0
powerpc                      walnut_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240625   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240625   gcc-13.2.0
s390                              allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sparc                       sparc32_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                                allnoconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13
x86_64       buildonly-randconfig-001-20240625   gcc-13
x86_64                randconfig-002-20240625   gcc-13
x86_64                randconfig-003-20240625   gcc-13
x86_64                randconfig-006-20240625   gcc-13
x86_64                randconfig-012-20240625   gcc-13
x86_64                randconfig-015-20240625   gcc-13
x86_64                randconfig-016-20240625   gcc-11
x86_64                randconfig-071-20240625   gcc-13
x86_64                randconfig-074-20240625   gcc-13
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
