Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDC23F485D
	for <linux-serial@vger.kernel.org>; Tue, 28 Jul 2026 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785236527; cv=none; b=S/c31nXszCtkgZXsyO+/cw4GlL6a9eTGuC1Ixs/+rXMgdB3sPhrQ5oDbbfGpSbJ/D8c7gN/5ozQZlo0LDVKe9MbVsxgcYmWYTZaOZLiQWvEOwQRXcek1s9pcOHdua8aBmxQiSRmzud19PI2piJpbB3a6W9jLi99uKYyS70ELSWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785236527; c=relaxed/simple;
	bh=cV2jI8YDuzci2QYgXzNCoqvIdqD6Q0GllWNMEY8Wy+A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EkSj4A652chiS2FlTB1HaBV0oBX9HJNsaz2W2YOt1Yja8IMyFeSx3XAgHyVTNbaANzZ5KjodMaXzEW3e5OmrI3kr0rkM6xR2TfX93zEaNvJPTB3cjOIG8kre5pXewDAXOJGgevs7PDUWvQxG6+gWVB+QhWuYkTPSlZUcT4ifxcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ee9GhieK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ee9GhieK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785236523; x=1816772523;
  h=date:from:to:cc:subject:message-id;
  bh=cV2jI8YDuzci2QYgXzNCoqvIdqD6Q0GllWNMEY8Wy+A=;
  b=ee9GhieKlj7Ns+V1eG3VCz0cXFNeygvTpdV6YLs153NX6jrq8fpdSkQ5
   4qQt7lD93xNayKvPL2pSa1cxb+iDwmelpcUe6Orsk0FPEYLO9LZxJO3/M
   PT9MMy2EfMY7nxXjzzUDWHuBbU7TWCam8CSOtBPCioaA1diMEr91hxD9/
   ewz6UlNq0LEorck94ntNztdU82MV2Y4eSrWO9u4PNU3NDt0LgaqZ5KQq9
   RiozGUWExGeAvBnCL1p1lbEHI4JcBTTTHZS1nWYmFG18oCywjh8eNUpRp
   jLyOPjRHsV/qj+15jib9OJg9aUnHHViFruLqSbUob2bP+yxU+kOq3g9hK
   g==;
X-CSE-ConnectionGUID: O3Q00ghpRPOT2IcrXpX0zA==
X-CSE-MsgGUID: TJOPb7UTSUayfXsajQiz4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85666149"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="85666149"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 04:02:02 -0700
X-CSE-ConnectionGUID: Sk4oZntnRRucLmSuZS3Oxg==
X-CSE-MsgGUID: h2Rlr2NBR9+RpsZj+wXWqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="260320102"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 28 Jul 2026 04:02:01 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wofZP-00000000eH1-0uxl;
	Tue, 28 Jul 2026 11:01:59 +0000
Date: Tue, 28 Jul 2026 19:01:07 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 a5339effdd523b4b3502fba5358d44e83c76a565
Message-ID: <202607281946.7xxVibu5-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: a5339effdd523b4b3502fba5358d44e83c76a565  Merge 7.2-rc5 into tty-next

elapsed time: 913m

configs tested: 102
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260728    gcc-8.5.0
arc                  randconfig-002-20260728    gcc-8.5.0
arm                      imx_v6_v7_defconfig    clang-24
arm                  randconfig-001-20260728    gcc-8.5.0
arm                  randconfig-002-20260728    gcc-8.5.0
arm                  randconfig-003-20260728    gcc-8.5.0
arm                  randconfig-004-20260728    gcc-8.5.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260728    gcc-14.3.0
arm64                randconfig-002-20260728    gcc-14.3.0
arm64                randconfig-003-20260728    gcc-14.3.0
arm64                randconfig-004-20260728    gcc-14.3.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260728    gcc-14.3.0
csky                 randconfig-002-20260728    gcc-14.3.0
hexagon              randconfig-001-20260728    gcc-11.5.0
hexagon              randconfig-002-20260728    gcc-11.5.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260728    gcc-14
i386       buildonly-randconfig-002-20260728    gcc-14
i386       buildonly-randconfig-003-20260728    gcc-14
i386       buildonly-randconfig-004-20260728    gcc-14
i386       buildonly-randconfig-005-20260728    gcc-14
i386       buildonly-randconfig-006-20260728    gcc-14
i386                 randconfig-001-20260728    gcc-14
i386                 randconfig-002-20260728    gcc-14
i386                 randconfig-003-20260728    gcc-14
i386                 randconfig-004-20260728    gcc-14
i386                 randconfig-005-20260728    gcc-14
i386                 randconfig-006-20260728    gcc-14
i386                 randconfig-007-20260728    gcc-14
i386                          randconfig-011    gcc-14
i386                 randconfig-011-20260728    gcc-14
i386                 randconfig-012-20260728    gcc-14
i386                 randconfig-013-20260728    gcc-14
i386                 randconfig-014-20260728    gcc-14
i386                 randconfig-015-20260728    gcc-14
i386                 randconfig-016-20260728    gcc-14
i386                 randconfig-017-20260728    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260728    gcc-11.5.0
loongarch            randconfig-002-20260728    gcc-11.5.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260728    gcc-11.5.0
nios2                randconfig-002-20260728    gcc-11.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260728    gcc-10.5.0
parisc               randconfig-002-20260728    gcc-10.5.0
powerpc              randconfig-001-20260728    gcc-10.5.0
powerpc              randconfig-002-20260728    gcc-10.5.0
powerpc64            randconfig-001-20260728    gcc-10.5.0
powerpc64            randconfig-002-20260728    gcc-10.5.0
riscv                randconfig-001-20260728    gcc-14.3.0
riscv                randconfig-002-20260728    gcc-14.3.0
s390                 randconfig-001-20260728    gcc-14.3.0
s390                 randconfig-002-20260728    gcc-14.3.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260728    gcc-14.3.0
sh                   randconfig-002-20260728    gcc-14.3.0
sparc                         randconfig-001    gcc-11.5.0
sparc                randconfig-001-20260728    gcc-11.5.0
sparc                randconfig-002-20260728    gcc-11.5.0
sparc64              randconfig-001-20260728    gcc-11.5.0
sparc64              randconfig-002-20260728    gcc-11.5.0
um                   randconfig-001-20260728    gcc-11.5.0
um                   randconfig-002-20260728    gcc-11.5.0
x86_64     buildonly-randconfig-001-20260728    clang-22
x86_64     buildonly-randconfig-002-20260728    clang-22
x86_64     buildonly-randconfig-003-20260728    clang-22
x86_64     buildonly-randconfig-004-20260728    clang-22
x86_64     buildonly-randconfig-005-20260728    clang-22
x86_64     buildonly-randconfig-006-20260728    clang-22
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260728    gcc-12
x86_64               randconfig-002-20260728    gcc-12
x86_64               randconfig-003-20260728    gcc-12
x86_64               randconfig-004-20260728    gcc-12
x86_64               randconfig-005-20260728    gcc-12
x86_64               randconfig-006-20260728    gcc-12
x86_64               randconfig-011-20260728    clang-22
x86_64               randconfig-012-20260728    clang-22
x86_64               randconfig-013-20260728    clang-22
x86_64               randconfig-014-20260728    clang-22
x86_64               randconfig-015-20260728    clang-22
x86_64               randconfig-016-20260728    clang-22
x86_64               randconfig-071-20260728    clang-22
x86_64               randconfig-072-20260728    clang-22
x86_64               randconfig-073-20260728    clang-22
x86_64               randconfig-074-20260728    clang-22
x86_64               randconfig-075-20260728    clang-22
x86_64               randconfig-076-20260728    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260728    gcc-11.5.0
xtensa               randconfig-002-20260728    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
