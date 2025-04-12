Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0561F03FF
	for <linux-serial@vger.kernel.org>; Sat, 12 Apr 2025 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744470630; cv=none; b=skuV/CyPPGAQj2BNm4tEKQbq5pu6g6YKzCTfv81Wp4ZDx4VTGuov0jAU6kqb8gIre75THhd8onOVAAlyXAdIi6+HHIZjd2aGLOtgvjQsPYYdpjlemNCFRMz6Z/7V1OaaR4y5PHGkBnf3XnVjGt0XB1KjY0UjnZ1k9Wlk/oIw9r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744470630; c=relaxed/simple;
	bh=fbNNbLkVarX5uzKqxSaRvCkmVOjQGqYocmjk2Oz4PZg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I6BtVAomj08gX/T/A+saGmzWPrrLInYLw/qFRSyk1ANe8PW6a1AAsygP8JgR/WVTcmEPpr9SWAPQdR40k9aDnRKYODPimsPdNSf5dB2Kz3jur0FLSfL+uovojt+kMiPRmMK84IAOL0zNw5aQbzKPAUFD9lylWXS7SZ5ZnDtvl08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPu1LCWS; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPu1LCWS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744470628; x=1776006628;
  h=date:from:to:cc:subject:message-id;
  bh=fbNNbLkVarX5uzKqxSaRvCkmVOjQGqYocmjk2Oz4PZg=;
  b=JPu1LCWSE0Z3wOGw/tvQnhI2dfRjLct56ke6Y3ijqq8opeCJn2/9Ibv1
   /JJ5RMe/Q4pgwp/e+FXOSSr3xaALIBOV/eAolAGMk4fNPapBeRd7G5tHB
   nBtFwp2dcBE4+JOU5TCCMkaDrBLbZARmtJFSL912GoTS6MCGRLvGMql12
   4ZTQp73LdQ5bgcOSsvqcOt1ZLcvVClweIQNrty4Mi3MFLqfYzZnBfPuv5
   ja9fSRGQ9tBIqWXLWnPfXEQ4zUgqMfYYUIcBROOn/mKzIB4TXo+9TnwYh
   K7ag9xysNk2p+K09pmixFqeXQD9ZL130q1ySZ8Wl32C2WhN3HAnog9RZs
   w==;
X-CSE-ConnectionGUID: OGwZnihtTzG42K3BoZfnMw==
X-CSE-MsgGUID: K2e16/JlQtqXIZRxg+nigg==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="45886295"
X-IronPort-AV: E=Sophos;i="6.15,208,1739865600"; 
   d="scan'208";a="45886295"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2025 08:10:28 -0700
X-CSE-ConnectionGUID: Z5+0OqZPRmmYp3vTJNnsWA==
X-CSE-MsgGUID: HKHslaSzS76Hn5GuI5MkXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,208,1739865600"; 
   d="scan'208";a="129382376"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 12 Apr 2025 08:10:27 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u3cUy-000Bsc-2Q;
	Sat, 12 Apr 2025 15:10:24 +0000
Date: Sat, 12 Apr 2025 23:09:45 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 ee6a44da3c87cf64d67dd02be8c0127a5bf56175
Message-ID: <202504122339.FT4rrXeY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: ee6a44da3c87cf64d67dd02be8c0127a5bf56175  tty: Require CAP_SYS_ADMIN for all usages of TIOCL_SELMOUSEREPORT

elapsed time: 1447m

configs tested: 87
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250412    gcc-14.2.0
arc                   randconfig-002-20250412    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250412    clang-21
arm                   randconfig-002-20250412    gcc-7.5.0
arm                   randconfig-003-20250412    clang-21
arm                   randconfig-004-20250412    clang-21
arm64                            allmodconfig    clang-19
arm64                 randconfig-001-20250412    clang-21
arm64                 randconfig-002-20250412    clang-21
arm64                 randconfig-003-20250412    gcc-8.5.0
arm64                 randconfig-004-20250412    clang-21
csky                  randconfig-001-20250412    gcc-14.2.0
csky                  randconfig-002-20250412    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250412    clang-21
hexagon               randconfig-002-20250412    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250412    clang-20
i386        buildonly-randconfig-002-20250412    clang-20
i386        buildonly-randconfig-003-20250412    clang-20
i386        buildonly-randconfig-004-20250412    clang-20
i386        buildonly-randconfig-005-20250412    clang-20
i386        buildonly-randconfig-006-20250412    gcc-11
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20250412    gcc-14.2.0
loongarch             randconfig-002-20250412    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250412    gcc-8.5.0
nios2                 randconfig-002-20250412    gcc-10.5.0
parisc                randconfig-001-20250412    gcc-7.5.0
parisc                randconfig-002-20250412    gcc-9.3.0
powerpc               randconfig-001-20250412    clang-18
powerpc               randconfig-002-20250412    clang-21
powerpc               randconfig-003-20250412    clang-18
powerpc64             randconfig-001-20250412    clang-21
powerpc64             randconfig-002-20250412    clang-21
powerpc64             randconfig-003-20250412    clang-21
riscv                 randconfig-001-20250412    clang-20
riscv                 randconfig-002-20250412    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250412    clang-18
s390                  randconfig-002-20250412    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250412    gcc-14.2.0
sh                    randconfig-002-20250412    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250412    gcc-10.3.0
sparc                 randconfig-002-20250412    gcc-13.3.0
sparc64               randconfig-001-20250412    gcc-13.3.0
sparc64               randconfig-002-20250412    gcc-5.5.0
um                               allmodconfig    clang-19
um                               allyesconfig    gcc-12
um                    randconfig-001-20250412    gcc-12
um                    randconfig-002-20250412    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250412    gcc-12
x86_64      buildonly-randconfig-002-20250412    clang-20
x86_64      buildonly-randconfig-003-20250412    gcc-11
x86_64      buildonly-randconfig-004-20250412    clang-20
x86_64      buildonly-randconfig-005-20250412    clang-20
x86_64      buildonly-randconfig-006-20250412    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250412    gcc-14.2.0
xtensa                randconfig-002-20250412    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
