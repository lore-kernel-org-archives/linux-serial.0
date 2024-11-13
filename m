Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFEB2F5A
	for <linux-serial@vger.kernel.org>; Wed, 13 Nov 2024 01:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459704; cv=none; b=kKVFfoO9tjV2jNc8/4RnAm6pLXb1CcsAim9VikoTS7I2jf8iFXAj6HsumUNzYI0Wl+wXaMebxe63lNlRyW+mXCH3B0dJm6TaAGh74K2co1GXWFR42raMQzf+MLsv/KZzJ0q+/pASEOipYLODSObwWwcAG0jey6UujZiq4p+0ZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459704; c=relaxed/simple;
	bh=Gd2Pq2dabr2E0IBd5Af2CcwzpfjTrG8LuSjSApHsCdk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qGZsZHtF+NYD/X2mNFgj1MXUQPA2P4H+q9vZ+0MNwrn4VhiJdgPCA9NnVF2pryzEf5PW1qaRjDEJ0uqBe83UjVCI4SUi3eMCc1Ec66Qtz2OfVrG6XxiOZxGJ26xHTxPtgUcRXrSaQO9FKjx8yQO4rrgypsRUFwwIgmkoR6b1Lmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h15kvTFx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h15kvTFx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731459703; x=1762995703;
  h=date:from:to:cc:subject:message-id;
  bh=Gd2Pq2dabr2E0IBd5Af2CcwzpfjTrG8LuSjSApHsCdk=;
  b=h15kvTFxWW4/tYWTXyp3Z5+ly+yvw+S5n5lCMUmJbp8j/Nktljj2yfGh
   NrUSC7qcazcLtEPh2UuJQIzzBrvpzmTpuZKmf/6U1Sn0043EIEmy/B0qU
   kI9lD002/3HFtaFpRI03bgHeGsj90UgF49wim8JR7dOYX4j/ERpg3acQr
   d2Jhz0uonPCiuOTiSJRfm5QO5xom+aSm1pdMTvapAuAPiiotGdL0KJVpY
   XWK47j8GOOZgVlO6yvxaktQH2MzK8x+wOLEPemaM5un/6S94FvpnvWN7g
   qlb/qmPmmaNO3pMYZpWVcOL/HwRb/DZq70qoJgUb/xOOn+7exm2o1F5vX
   A==;
X-CSE-ConnectionGUID: opfow3yQSKyEU+qPrUymdw==
X-CSE-MsgGUID: 1bt0pc2HTGmTNwROvN8mZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="34193735"
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="34193735"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 17:01:42 -0800
X-CSE-ConnectionGUID: ZfoC+4uCQzWQ6FmcePvUsQ==
X-CSE-MsgGUID: ewtgpeB8R/C9gd7XZDW7iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="92640558"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 12 Nov 2024 17:01:41 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tB1lK-0001ts-2o;
	Wed, 13 Nov 2024 01:01:38 +0000
Date: Wed, 13 Nov 2024 09:00:49 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 166105c9030a30ba08574a9998afc7b60bc72dd7
Message-ID: <202411130944.co32huea-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 166105c9030a30ba08574a9998afc7b60bc72dd7  serial: 8250_fintek: Add support for F81216E

elapsed time: 766m

configs tested: 120
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                       allnoconfig    gcc-14.2.0
alpha                      allyesconfig    clang-20
alpha                      allyesconfig    gcc-14.2.0
arc                        allmodconfig    clang-20
arc                        allmodconfig    gcc-13.2.0
arc                         allnoconfig    gcc-14.2.0
arc                        allyesconfig    clang-20
arc                        allyesconfig    gcc-13.2.0
arc                      hsdk_defconfig    gcc-14.2.0
arm                        allmodconfig    clang-20
arm                        allmodconfig    gcc-14.2.0
arm                         allnoconfig    gcc-14.2.0
arm                        allyesconfig    clang-20
arm                        allyesconfig    gcc-14.2.0
arm                   at91_dt_defconfig    clang-20
arm               davinci_all_defconfig    gcc-14.2.0
arm                integrator_defconfig    clang-20
arm                  keystone_defconfig    gcc-14.2.0
arm                  mvebu_v5_defconfig    gcc-14.2.0
arm                 netwinder_defconfig    clang-20
arm                      qcom_defconfig    clang-20
arm                  shmobile_defconfig    gcc-14.2.0
arm64                      alldefconfig    gcc-14.2.0
arm64                      allmodconfig    clang-20
arm64                       allnoconfig    gcc-14.2.0
arm64                         defconfig    clang-20
csky                        allnoconfig    gcc-14.2.0
hexagon                    allmodconfig    clang-20
hexagon                     allnoconfig    gcc-14.2.0
hexagon                    allyesconfig    clang-20
i386                       allmodconfig    clang-19
i386                       allmodconfig    gcc-12
i386                        allnoconfig    clang-19
i386                        allnoconfig    gcc-12
i386                       allyesconfig    clang-19
i386                       allyesconfig    gcc-12
i386                          defconfig    clang-19
loongarch                  allmodconfig    gcc-14.2.0
loongarch                   allnoconfig    gcc-14.2.0
m68k                       allmodconfig    gcc-14.2.0
m68k                        allnoconfig    gcc-14.2.0
m68k                       allyesconfig    gcc-14.2.0
m68k                 m5249evb_defconfig    gcc-14.2.0
m68k                 m5475evb_defconfig    clang-20
microblaze                 allmodconfig    gcc-14.2.0
microblaze                  allnoconfig    gcc-14.2.0
microblaze                 allyesconfig    gcc-14.2.0
mips                        allnoconfig    gcc-14.2.0
mips                  qi_lb60_defconfig    gcc-14.2.0
mips                     xway_defconfig    clang-20
nios2                       allnoconfig    gcc-14.2.0
openrisc                    allnoconfig    clang-20
openrisc                    allnoconfig    gcc-14.2.0
openrisc                   allyesconfig    gcc-14.2.0
openrisc                      defconfig    gcc-12
parisc                     allmodconfig    gcc-14.2.0
parisc                      allnoconfig    clang-20
parisc                      allnoconfig    gcc-14.2.0
parisc                     allyesconfig    gcc-14.2.0
parisc                        defconfig    gcc-12
powerpc              adder875_defconfig    clang-20
powerpc                    allmodconfig    gcc-14.2.0
powerpc                     allnoconfig    clang-20
powerpc                     allnoconfig    gcc-14.2.0
powerpc                    allyesconfig    clang-20
powerpc                    allyesconfig    gcc-14.2.0
powerpc                  cell_defconfig    clang-20
powerpc           linkstation_defconfig    gcc-14.2.0
powerpc               mpc512x_defconfig    gcc-14.2.0
powerpc               mpc5200_defconfig    clang-20
powerpc           mpc836x_rdk_defconfig    clang-20
powerpc            mpc866_ads_defconfig    clang-20
powerpc                pcm030_defconfig    clang-20
powerpc               ppa8548_defconfig    gcc-14.2.0
powerpc               sequoia_defconfig    gcc-14.2.0
powerpc               tqm8555_defconfig    gcc-14.2.0
riscv                      allmodconfig    clang-20
riscv                      allmodconfig    gcc-14.2.0
riscv                       allnoconfig    clang-20
riscv                       allnoconfig    gcc-14.2.0
riscv                      allyesconfig    clang-20
riscv                      allyesconfig    gcc-14.2.0
riscv                         defconfig    gcc-12
s390                       allmodconfig    clang-20
s390                       allmodconfig    gcc-14.2.0
s390                        allnoconfig    clang-20
s390                       allyesconfig    gcc-14.2.0
s390                          defconfig    gcc-12
sh                         allmodconfig    gcc-14.2.0
sh                          allnoconfig    gcc-14.2.0
sh                         allyesconfig    gcc-14.2.0
sh                   apsh4a3a_defconfig    gcc-14.2.0
sh                            defconfig    gcc-12
sh          ecovec24-romimage_defconfig    clang-20
sh             secureedge5410_defconfig    clang-20
sh               sh7710voipgw_defconfig    gcc-14.2.0
sh             sh7724_generic_defconfig    clang-20
sh                       shx3_defconfig    clang-20
sparc                      allmodconfig    gcc-14.2.0
sparc64                       defconfig    gcc-12
um                         allmodconfig    clang-20
um                          allnoconfig    clang-17
um                          allnoconfig    clang-20
um                         allyesconfig    clang-20
um                         allyesconfig    gcc-12
um                            defconfig    gcc-12
um                       i386_defconfig    gcc-12
um                     x86_64_defconfig    gcc-12
x86_64                      allnoconfig    clang-19
x86_64                     allyesconfig    clang-19
x86_64                        defconfig    clang-19
x86_64                        defconfig    gcc-11
x86_64                            kexec    clang-19
x86_64                            kexec    gcc-12
x86_64                         rhel-8.3    gcc-12
x86_64                     rhel-8.3-bpf    clang-19
x86_64                   rhel-8.3-kunit    clang-19
x86_64                     rhel-8.3-ltp    clang-19
x86_64                    rhel-8.3-rust    clang-19
xtensa                      allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
