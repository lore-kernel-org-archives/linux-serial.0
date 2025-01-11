Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF23A55
	for <linux-serial@vger.kernel.org>; Sat, 11 Jan 2025 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736611173; cv=none; b=Xwxpp7dSbHDT1Ul9Vm6yWIKKDXzTDfquMMTkipiDEOFgQ++9W1Fln/riFqRRP06hqK7tjpEsWRb0bkAhVBTXhBDDwv6XO1M+EzOE/ymhUHgtNPmZvJVj0vSXaoTbtr31C2stfHlRx0WxE+TD2c+Xb9MtixKQmcOhDQclsIkLtSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736611173; c=relaxed/simple;
	bh=qCZPbs2mVqGXmu1ER8NyEro86SrBqv9+kiL36AT4NU0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VMH0NZ94qzEP+N03e2yHOeQVnhXGXx4EQoI/ROcnPOoVAcJmxkFBuDVVZkjFGi0ONLzsXf9yoEedq88QgpfqX8HQA/eW35uFsTHjaxYWeHkL4mIhiLslN08Kkvsn++relQQPEBhyZs+8rDaIxnFdH/BqPGfA3usJ7Qta5bxeY24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jt1Gv7pn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jt1Gv7pn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736611172; x=1768147172;
  h=date:from:to:cc:subject:message-id;
  bh=qCZPbs2mVqGXmu1ER8NyEro86SrBqv9+kiL36AT4NU0=;
  b=jt1Gv7pnujIqK47l/Y276VKJ01b7acsgBIFbvj7fbSJyHQ6fYjgmUIz/
   Z/Gt0yR/lchrAz9fKUeQ0DBeCQHbmJrTJ0sUoToY6TQfJIl7lSd0JEyql
   O9IsgCdZ4sMOWoVh0LK7KxyTsW5Dy4bQa2eVlHawS0qEk7wQMGmdecpff
   I2QYtPVGta4tOC1xbr341n5BJ6c/JSfJnyT8CixGD+neCKxip/f//prQX
   SquA2AZADAM47PSjP5eqAWvPjve6kveZugmkLmJM+XTev+Vc+fyXYNs8n
   iwEccOmb4lHI1gv5s+KcXAcGbQf6fCx1RMYZQIDg6H4oDs+HJL92wGHFY
   Q==;
X-CSE-ConnectionGUID: w1cSVXHzSHSV8gohGE4mfw==
X-CSE-MsgGUID: hWSqd42gTui1BSNX7PfcjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11312"; a="54307172"
X-IronPort-AV: E=Sophos;i="6.12,307,1728975600"; 
   d="scan'208";a="54307172"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2025 07:59:30 -0800
X-CSE-ConnectionGUID: 3NrOFK6yTuaXdWtdh0Xnzg==
X-CSE-MsgGUID: CVg2VCmNSF6JHWeJoPI9/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,307,1728975600"; 
   d="scan'208";a="108911738"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 Jan 2025 07:59:29 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWdtX-000Kro-0v;
	Sat, 11 Jan 2025 15:59:27 +0000
Date: Sat, 11 Jan 2025 23:58:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 422c9727b07f9f86e2ec11c56622e566221591cc
Message-ID: <202501112340.dQzHbHmk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 422c9727b07f9f86e2ec11c56622e566221591cc  serial: 8250: Revert "drop lockdep annotation from serial8250_clear_IER()"

elapsed time: 1450m

configs tested: 74
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
arc                              allnoconfig    gcc-13.2.0
arc                  randconfig-001-20250111    gcc-13.2.0
arc                  randconfig-002-20250111    gcc-13.2.0
arm                              allnoconfig    clang-17
arm                  randconfig-001-20250111    clang-16
arm                  randconfig-002-20250111    gcc-14.2.0
arm                  randconfig-003-20250111    clang-20
arm                  randconfig-004-20250111    clang-20
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250111    gcc-14.2.0
arm64                randconfig-002-20250111    clang-20
arm64                randconfig-003-20250111    clang-18
arm64                randconfig-004-20250111    clang-16
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20250111    gcc-14.2.0
csky                 randconfig-002-20250111    gcc-14.2.0
hexagon                          allnoconfig    clang-20
hexagon              randconfig-001-20250111    clang-20
hexagon              randconfig-002-20250111    clang-15
i386       buildonly-randconfig-001-20250111    gcc-12
i386       buildonly-randconfig-002-20250111    gcc-11
i386       buildonly-randconfig-003-20250111    gcc-12
i386       buildonly-randconfig-004-20250111    gcc-12
i386       buildonly-randconfig-005-20250111    gcc-12
i386       buildonly-randconfig-006-20250111    clang-19
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250111    gcc-14.2.0
loongarch            randconfig-002-20250111    gcc-14.2.0
mips                          ip30_defconfig    gcc-14.2.0
nios2                randconfig-001-20250111    gcc-14.2.0
nios2                randconfig-002-20250111    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
openrisc                        allyesconfig    gcc-14.2.0
parisc                          allmodconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc                          allyesconfig    gcc-14.2.0
parisc               randconfig-001-20250111    gcc-14.2.0
parisc               randconfig-002-20250111    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250111    gcc-14.2.0
powerpc              randconfig-002-20250111    gcc-14.2.0
powerpc              randconfig-003-20250111    gcc-14.2.0
powerpc64            randconfig-001-20250111    gcc-14.2.0
powerpc64            randconfig-002-20250111    gcc-14.2.0
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250111    clang-18
riscv                randconfig-002-20250111    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-20
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250111    clang-20
s390                 randconfig-002-20250111    clang-19
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250111    gcc-14.2.0
sh                   randconfig-002-20250111    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250111    gcc-14.2.0
sparc                randconfig-002-20250111    gcc-14.2.0
sparc64              randconfig-001-20250111    gcc-14.2.0
sparc64              randconfig-002-20250111    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20250111    clang-18
um                   randconfig-002-20250111    clang-20
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250111    clang-19
x86_64     buildonly-randconfig-002-20250111    gcc-12
x86_64     buildonly-randconfig-003-20250111    gcc-12
x86_64     buildonly-randconfig-004-20250111    clang-19
x86_64     buildonly-randconfig-005-20250111    gcc-12
x86_64     buildonly-randconfig-006-20250111    gcc-12
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250111    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
