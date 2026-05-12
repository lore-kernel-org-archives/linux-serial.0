Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0405383338
	for <linux-serial@vger.kernel.org>; Tue, 12 May 2026 04:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778559045; cv=none; b=GtrDMN1GB4b0jYY1NKuLHJh+kx9nY10MNJ15GFmz81TlnE5MOns+GT9wPlUOnyrAucLOUTuLJ/GVc+jU3KuEJAXkIX4WQKMTLwIju4+WPVj0BApgMzj1Oo6PosxqhCi3uq7SAmimHN4VUyFOqBd7aRHkyhMHw5G0JdlvjCbCdZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778559045; c=relaxed/simple;
	bh=081pA+ji2o0tLBjLOE5PFNH4Ccj/HJmm78OO+ouzQAM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GFfD27A728oU2CxOn55p6SMKNjQDxUNMf3bda+waHm6JgGj6Xhveg+EahJjG9PleepMaSsEOXYlS2eHppodH0zeqkrvV4OYihdF3s+DURBzeAz7JOGz5JPEnnKOERqkFO4N4exHaDemWWwZgvab/tjxNDGbROOe5CoabjrSA3/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q16novog; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q16novog"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778559043; x=1810095043;
  h=date:from:to:cc:subject:message-id;
  bh=081pA+ji2o0tLBjLOE5PFNH4Ccj/HJmm78OO+ouzQAM=;
  b=Q16novogZc6qP0a/wf5AZWQ8QCnww1dPWiYoHIw8ycceCQbANU8xgusf
   60tp4Z3c7o0OvgL56FxT0EkCL+MC93wINzeONueviXGf4cw2fTAeHt3Ea
   TcuUxCK+JFyMIwJ3GWGF4JvKOhT4dvcJqCLIWNARmBM+AGnixI0ugHgRs
   jJJXCqlQYWpmilu6QGgLozP4Rou+NotfzJQlchdNMaTNG2ktq+lJNeSYZ
   KPYNURzD9R5/Dn8fSkL3hwCbbNAd0LE3wgCBSFtgmeotigF0N1nM0YeN3
   bv1Ib7efq4WEJGMeelU7nQSeOPPAGG5KXQmKIpf5yIZMxuNK9g3mG6P/I
   Q==;
X-CSE-ConnectionGUID: JDUau/07RG6PhG3YcHxmbg==
X-CSE-MsgGUID: dWWpq0vISTCUh2RDYzCb9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79319502"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79319502"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 21:10:42 -0700
X-CSE-ConnectionGUID: 36z/cKcSRueT9PpqqQMUfg==
X-CSE-MsgGUID: lxSKiGviSDCtlC78EDkAbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="239471031"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 May 2026 21:10:41 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMeS6-000000001Z5-2XE7;
	Tue, 12 May 2026 04:10:38 +0000
Date: Tue, 12 May 2026 12:09:49 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 16e95bfb79b5d9d01dc7651d98caf3c2ace331cd
Message-ID: <202605121242.3fb73qqi-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 16e95bfb79b5d9d01dc7651d98caf3c2ace331cd  serial: qcom-geni: Avoid probing debug console UART without console support

elapsed time: 738m

configs tested: 145
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260512    gcc-11.5.0
arc                   randconfig-001-20260512    gcc-8.5.0
arc                   randconfig-002-20260512    gcc-11.5.0
arc                   randconfig-002-20260512    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260512    clang-23
arm                   randconfig-001-20260512    gcc-11.5.0
arm                   randconfig-002-20260512    gcc-11.5.0
arm                   randconfig-003-20260512    clang-23
arm                   randconfig-003-20260512    gcc-11.5.0
arm                   randconfig-004-20260512    gcc-11.5.0
arm                   randconfig-004-20260512    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon               randconfig-001-20260512    clang-23
hexagon               randconfig-002-20260512    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260512    gcc-14
i386        buildonly-randconfig-002-20260512    gcc-14
i386        buildonly-randconfig-003-20260512    gcc-14
i386        buildonly-randconfig-004-20260512    clang-20
i386        buildonly-randconfig-005-20260512    clang-20
i386        buildonly-randconfig-006-20260512    clang-20
i386                  randconfig-011-20260512    clang-20
i386                  randconfig-012-20260512    clang-20
i386                  randconfig-013-20260512    clang-20
i386                  randconfig-014-20260512    clang-20
i386                  randconfig-015-20260512    clang-20
i386                  randconfig-016-20260512    clang-20
i386                  randconfig-017-20260512    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260512    clang-18
loongarch             randconfig-002-20260512    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
m68k                        m5272c3_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           jazz_defconfig    clang-17
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260512    gcc-11.5.0
nios2                 randconfig-002-20260512    gcc-10.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260512    gcc-11.5.0
parisc                randconfig-001-20260512    gcc-12.5.0
parisc                randconfig-002-20260512    gcc-12.5.0
parisc                randconfig-002-20260512    gcc-9.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                       holly_defconfig    clang-23
powerpc               randconfig-001-20260512    clang-23
powerpc               randconfig-001-20260512    gcc-12.5.0
powerpc               randconfig-002-20260512    gcc-12.5.0
powerpc64             randconfig-001-20260512    clang-17
powerpc64             randconfig-001-20260512    gcc-12.5.0
powerpc64             randconfig-002-20260512    clang-23
powerpc64             randconfig-002-20260512    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-071-20260512    clang-20
x86_64                randconfig-072-20260512    clang-20
x86_64                randconfig-073-20260512    clang-20
x86_64                randconfig-074-20260512    clang-20
x86_64                randconfig-075-20260512    clang-20
x86_64                randconfig-076-20260512    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260512    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
