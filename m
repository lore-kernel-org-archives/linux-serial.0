Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C783019E82A
	for <linux-serial@vger.kernel.org>; Sun, 17 Aug 2025 23:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755474567; cv=none; b=ewyX67hR8HVIEGFf/s0JO5qChgKyzc1dLf9Tnqx1qTnNxy0Ubdx2+9Uppoo9tOduNcWUWHGnfM3fCCQDj5NY1BOVGCerBHsO3hbtYs81++d1rWoiX701HqmHCVr5bN/Ypn7opR/ugy8g/j5SxqGMsp5I7FsrR8nOBne953E+QsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755474567; c=relaxed/simple;
	bh=gUn61FJzcGdSJWy/vgZxPwn6FjjbJY4deSgYqZNREQ4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=urhxQf3gf2aa1QcScBtcdidMLXOPm8NQbx6tYA4FPoog1nolOA6ZtXIedisGaFWjFRAuXHnUc2cGz0OuQf3jpJw7d9laiA0kI1cSkk3VRoQdFINnL62I1IKUtmc86emopnSyQYEjafmtqRNQtODyP5jKhFSX4BKjjJT463iXgLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUcxXaH5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUcxXaH5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755474566; x=1787010566;
  h=date:from:to:cc:subject:message-id;
  bh=gUn61FJzcGdSJWy/vgZxPwn6FjjbJY4deSgYqZNREQ4=;
  b=BUcxXaH51lbqWsf3LPEMJ4x44kuBqPbQRAoHZJ4FjSjjPt58xlzgV5JT
   hRomzH082zZwq6r9cg8Ej4+KrbgrmtiMziQ50sRfKXZuJuJ+0qby/NPRo
   XEa3dmeorfwyXrpt2KK147pUEJCQULPBCCO4eycfxb2s6QAJ+7ybV1ko0
   RabHfZmQxRej4JJFRqtSFG0tpK86aE0uKLsmGEQfKyXHZJsyOrGunqrJT
   9Qm6bf8VReWGB5bPDSLWEP1RDeYFYy+WldTt/iyNRtXDm4OVcS3tTAw5a
   LGd1TqhQgQniPpRto50ZNv4jXXohP7GXUxo/xlUqhvdxwuzklZR6M+ocQ
   g==;
X-CSE-ConnectionGUID: uw+ZfMXvQg+9W199oGKdmw==
X-CSE-MsgGUID: 3b91j4dBTkKFoRCv0wUekg==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="61508136"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="61508136"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 16:49:25 -0700
X-CSE-ConnectionGUID: NI706bIfT1Ws9kv6sXfNkg==
X-CSE-MsgGUID: NU6GDrKlST2oSHo/YILtDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166933755"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 17 Aug 2025 16:49:24 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unn7p-000Dml-2r;
	Sun, 17 Aug 2025 23:49:21 +0000
Date: Mon, 18 Aug 2025 07:48:42 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 cfd956dcb101aa3d25bac321fae923323a47c607
Message-ID: <202508180733.lOLa3KTd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: cfd956dcb101aa3d25bac321fae923323a47c607  tty: hvc_console: Call hvc_kick in hvc_write unconditionally

elapsed time: 727m

configs tested: 132
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250817    gcc-15.1.0
arc                   randconfig-002-20250817    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   milbeaut_m10v_defconfig    clang-19
arm                       netwinder_defconfig    gcc-15.1.0
arm                   randconfig-001-20250817    gcc-14.3.0
arm                   randconfig-002-20250817    clang-22
arm                   randconfig-003-20250817    clang-22
arm                   randconfig-004-20250817    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250817    clang-22
arm64                 randconfig-002-20250817    clang-22
arm64                 randconfig-003-20250817    clang-20
arm64                 randconfig-004-20250817    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250817    gcc-15.1.0
csky                  randconfig-002-20250817    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250817    clang-22
hexagon               randconfig-002-20250817    clang-17
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250817    gcc-12
i386        buildonly-randconfig-002-20250817    clang-20
i386        buildonly-randconfig-003-20250817    gcc-12
i386        buildonly-randconfig-004-20250817    clang-20
i386        buildonly-randconfig-005-20250817    gcc-12
i386        buildonly-randconfig-006-20250817    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250817    clang-22
loongarch             randconfig-002-20250817    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                  cavium_octeon_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250817    gcc-8.5.0
nios2                 randconfig-002-20250817    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250817    gcc-8.5.0
parisc                randconfig-002-20250817    gcc-13.4.0
parisc64                         alldefconfig    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                    amigaone_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250817    clang-19
powerpc               randconfig-002-20250817    clang-22
powerpc               randconfig-003-20250817    clang-22
powerpc64             randconfig-001-20250817    clang-22
powerpc64             randconfig-002-20250817    clang-19
powerpc64             randconfig-003-20250817    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250817    gcc-12.5.0
riscv                 randconfig-002-20250817    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250817    clang-22
s390                  randconfig-002-20250817    clang-16
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250817    gcc-15.1.0
sh                    randconfig-002-20250817    gcc-12.5.0
sh                           sh2007_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250817    gcc-8.5.0
sparc                 randconfig-002-20250817    gcc-11.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250817    clang-22
sparc64               randconfig-002-20250817    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250817    clang-18
um                    randconfig-002-20250817    gcc-12
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250817    clang-20
x86_64      buildonly-randconfig-002-20250817    gcc-12
x86_64      buildonly-randconfig-003-20250817    gcc-12
x86_64      buildonly-randconfig-004-20250817    gcc-12
x86_64      buildonly-randconfig-005-20250817    clang-20
x86_64      buildonly-randconfig-006-20250817    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250817    gcc-8.5.0
xtensa                randconfig-002-20250817    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
