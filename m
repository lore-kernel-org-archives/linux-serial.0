Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242CA481B1
	for <linux-serial@vger.kernel.org>; Wed, 23 Oct 2024 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729719381; cv=none; b=NQuBH+qag5z2pCYSdETuDMwJdki9xvpN9VutFSfGi7TsTZIpuC7hv5dDlVSfGBzlCRMPUGwhEGKNPDt9U5EK26jWPh+5UwxptWsmNmXcjoU6hmRYFW9yYJKnv7qgKQuSFqhqwPCojbSW4dXDRWyG90gMRAKOIzHjsY87JaOEmiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729719381; c=relaxed/simple;
	bh=VD+MwCvwQsW0ro1mRSwr8SVsNMI+C7mwlT++LBAU4cU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=U9+zZxkZACVAG6QpNfKVepn962BITSYiouhRsJYF6nh/yaLbn9ylVVdczV0sjK8s4drt2T1slFqn+d8sePuSoqvKEpMsRg4IyVKVEW9G22iWbn7mI59nLJZPVx0UMMcvdU7RzZWucEujqC4vcjlRONawHLVf9g5JTBMNM3EHEyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FSxJmqgB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FSxJmqgB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729719379; x=1761255379;
  h=date:from:to:cc:subject:message-id;
  bh=VD+MwCvwQsW0ro1mRSwr8SVsNMI+C7mwlT++LBAU4cU=;
  b=FSxJmqgBja06hAS2W0SVNFpi9SjNngrJ4avXvG5AV7wTKHb7DixU0yzs
   1zc6iIFiu6sxnfEFUQfC1RGA8iir9wJzjZsusuRq47v7bg1OByqWfZOvb
   oxVELOnTxNCwxY+iqnYgbQT1+dsez6xhNKyNuYE7/qX8SkGhuIrmJzxUE
   Q7rD68jhLtYDjZPlGWr89CYt+25uZGASiDsSrhDvH5ob+K5lSG5cPHOeb
   wx9jsYVdFMdzNfrAaYlBoJa7gdTk+15AyiYXl19JjRKrq4Gq4rSKmQ2JV
   Cm4K20BzD7kBfP3te6I76mYg7xo4gfFlHzg4VcPU0aTk0qbVDxjl7Tgj8
   A==;
X-CSE-ConnectionGUID: FBZ58NduSjG8iaIhTykqTA==
X-CSE-MsgGUID: OHscYLJ5Rlubah50nRzmZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33242287"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="33242287"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 14:36:18 -0700
X-CSE-ConnectionGUID: MytM2WXYQe25CnjQOfOUPA==
X-CSE-MsgGUID: vIhzu97ISLW+I2zoyWj81w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="85507049"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 23 Oct 2024 14:36:17 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3j1b-000Vbc-0X;
	Wed, 23 Oct 2024 21:36:15 +0000
Date: Thu, 24 Oct 2024 05:35:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 44059790a5cb9258ae6137387e4c39b717fd2ced
Message-ID: <202410240530.HdqeOBny-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 44059790a5cb9258ae6137387e4c39b717fd2ced  kfifo: don't include dma-mapping.h in kfifo.h

elapsed time: 925m

configs tested: 119
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                    vdk_hs38_smp_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                        spear3xx_defconfig    gcc-14.1.0
arm                           stm32_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                             alldefconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386                                defconfig    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                        m5272c3_defconfig    gcc-14.1.0
m68k                       m5275evb_defconfig    gcc-14.1.0
m68k                           virt_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                      mgcoge_defconfig    gcc-14.1.0
powerpc               mpc834x_itxgp_defconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    gcc-14.1.0
sh                        edosk7760_defconfig    gcc-14.1.0
sh                           se7712_defconfig    gcc-14.1.0
sh                           se7751_defconfig    gcc-14.1.0
sh                   sh7724_generic_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241023    gcc-12
x86_64      buildonly-randconfig-002-20241023    gcc-12
x86_64      buildonly-randconfig-003-20241023    gcc-12
x86_64      buildonly-randconfig-004-20241023    gcc-12
x86_64      buildonly-randconfig-005-20241023    gcc-12
x86_64      buildonly-randconfig-006-20241023    gcc-12
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241023    gcc-12
x86_64                randconfig-002-20241023    gcc-12
x86_64                randconfig-003-20241023    gcc-12
x86_64                randconfig-004-20241023    gcc-12
x86_64                randconfig-005-20241023    gcc-12
x86_64                randconfig-006-20241023    gcc-12
x86_64                randconfig-011-20241023    gcc-12
x86_64                randconfig-012-20241023    gcc-12
x86_64                randconfig-013-20241023    gcc-12
x86_64                randconfig-014-20241023    gcc-12
x86_64                randconfig-015-20241023    gcc-12
x86_64                randconfig-016-20241023    gcc-12
x86_64                randconfig-071-20241023    gcc-12
x86_64                randconfig-072-20241023    gcc-12
x86_64                randconfig-073-20241023    gcc-12
x86_64                randconfig-074-20241023    gcc-12
x86_64                randconfig-075-20241023    gcc-12
x86_64                randconfig-076-20241023    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  cadence_csp_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
