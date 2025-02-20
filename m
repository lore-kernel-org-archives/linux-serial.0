Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BF61D61A3
	for <linux-serial@vger.kernel.org>; Thu, 20 Feb 2025 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065243; cv=none; b=GlmFwHO7XsS/IXWMK+YsWS26XPoZKN5t7TkSl+LezDriIO8EQeyc92rQox+rs0MiH6Spj/JSW1GKy9tsHYup7RDax4WmhtRt7AZQsmgCG6pHU52D+uqc4uIygYpAPFnnloyUF4c1dXkX1xmlchs+2BmssAjrh2jLuqdgWqTLLpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065243; c=relaxed/simple;
	bh=XDdI/NSz5RPA9cZc6t1+hPO1nkyB85UoGSFwOyVUxaM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=W81ID2ujGjZqSf2JIkZ4R/jczHEAQIicqMOsvEZcVpf6tEURDVEiTj4NEkRejIwW0YKnjfcQqi367BdZiLBY8cVrFTP5SRxGvbl0cQjlzTSClBs6xbN8g4OMvRjt/WKwgY4SQALBYnr8MElIy8m6xZYQr+SDRWTNaNmiQh2GJMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V94DS9Hb; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V94DS9Hb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740065241; x=1771601241;
  h=date:from:to:cc:subject:message-id;
  bh=XDdI/NSz5RPA9cZc6t1+hPO1nkyB85UoGSFwOyVUxaM=;
  b=V94DS9HbQPSPMSRMmvaTABRKxIgEiUcUX0j6r097hPgmz101zCwku3KD
   USR5iptbNr3tSuRHvrpUTVJZjl0JmUy57NvG8Cj6B5cJpwpBlqp4LoJfg
   maXu72fFdF+U+GTYqQMuBXOcckpb6gLWo5l3UTDCtIYHQ550nMlu+X5WB
   fQl7Rs+JKSE/43jv4OUHbHp1fq6qB3fwF1aH+KlAraGOaSW/0NLPg6gaA
   qKCeNZ2yfnKxM7sPOUCUCIQLqCvbb4ZXGm3jR2QiDvn+TTfBj2PiyQbAr
   Hp3vou5atqjKk+d5jJ26dPoC+ZV5kSltVrnW93vRIqcXAD7DO1iOLCv6C
   g==;
X-CSE-ConnectionGUID: DE059VnJSI2K2/hELBJ9kA==
X-CSE-MsgGUID: gqQKQzPlSFeqQkOdW3uKHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41057933"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41057933"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 07:27:20 -0800
X-CSE-ConnectionGUID: tvVEn6C3TaGmoN+zYtToDQ==
X-CSE-MsgGUID: SY0FHeG3T6qhUMVTcvWn9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120290270"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 20 Feb 2025 07:27:19 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tl8SF-0004RT-1C;
	Thu, 20 Feb 2025 15:27:12 +0000
Date: Thu, 20 Feb 2025 23:26:39 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 1bd2aad57da95f7f2d2bb52f7ad15c0f4993a685
Message-ID: <202502202333.kihsqEn3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 1bd2aad57da95f7f2d2bb52f7ad15c0f4993a685  serial: mctrl_gpio: split disable_ms into sync and no_sync APIs

elapsed time: 1455m

configs tested: 93
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250220    gcc-13.2.0
arc                   randconfig-002-20250220    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250220    gcc-14.2.0
arm                   randconfig-002-20250220    gcc-14.2.0
arm                   randconfig-003-20250220    gcc-14.2.0
arm                   randconfig-004-20250220    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250220    gcc-14.2.0
arm64                 randconfig-002-20250220    gcc-14.2.0
arm64                 randconfig-003-20250220    clang-21
arm64                 randconfig-004-20250220    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250220    gcc-14.2.0
csky                  randconfig-002-20250220    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250220    clang-21
hexagon               randconfig-002-20250220    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250220    gcc-12
i386        buildonly-randconfig-002-20250220    gcc-12
i386        buildonly-randconfig-003-20250220    gcc-12
i386        buildonly-randconfig-004-20250220    clang-19
i386        buildonly-randconfig-005-20250220    clang-19
i386        buildonly-randconfig-006-20250220    clang-19
i386                                defconfig    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250220    gcc-14.2.0
loongarch             randconfig-002-20250220    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250220    gcc-14.2.0
nios2                 randconfig-002-20250220    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250220    gcc-14.2.0
parisc                randconfig-002-20250220    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc               randconfig-001-20250220    gcc-14.2.0
powerpc               randconfig-002-20250220    clang-16
powerpc               randconfig-003-20250220    clang-21
powerpc64             randconfig-001-20250220    clang-16
powerpc64             randconfig-002-20250220    clang-18
powerpc64             randconfig-003-20250220    gcc-14.2.0
riscv                 randconfig-001-20250220    gcc-14.2.0
riscv                 randconfig-002-20250220    clang-21
s390                             allmodconfig    clang-19
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250220    clang-19
s390                  randconfig-002-20250220    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250220    gcc-14.2.0
sh                    randconfig-002-20250220    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250220    gcc-14.2.0
sparc                 randconfig-002-20250220    gcc-14.2.0
sparc64               randconfig-001-20250220    gcc-14.2.0
sparc64               randconfig-002-20250220    gcc-14.2.0
um                               allmodconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250220    gcc-12
um                    randconfig-002-20250220    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250220    gcc-12
x86_64      buildonly-randconfig-002-20250220    gcc-12
x86_64      buildonly-randconfig-003-20250220    gcc-12
x86_64      buildonly-randconfig-004-20250220    gcc-12
x86_64      buildonly-randconfig-005-20250220    gcc-12
x86_64      buildonly-randconfig-006-20250220    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250220    gcc-14.2.0
xtensa                randconfig-002-20250220    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
