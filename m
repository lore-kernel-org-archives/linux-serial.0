Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C459937269F
	for <linux-serial@vger.kernel.org>; Mon, 16 Mar 2026 08:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773649491; cv=none; b=e5LCI28LfQ61jNi1d6ek8Z+CkOq7Xyu6F02fy8kK32lcRwEA5Nx3e0Yyzik03y01wMKfSrAyD98mU1YGyQt4+Hpx94grGajhBZyaUyeapjtr6cVfaxaE+cQbdavoWzJZt65fUtQ5oEX4IpwJGXJljSAVP3ox+Fg53E3oXH5NYQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773649491; c=relaxed/simple;
	bh=ckVuorEOUxDHBMi1KGu3S+cgykqI9ioysmPWZ7s2HQg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=A5nvvigiBDym7HMbiAta8Uge0Zo72CgYsWZxkZGsQPNKEvP8TXMSaMhxGls8idFxQvS+VzyOxG/rvudXkcsQdPRf0ASFRNQ3jHvabNfKRt7wai5HAftZpuaK8glrKZqqTXvRXKcxEAQOtM3SQc6Y4DdOdezq7scpXHa7H0bD82I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SlaSByP+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SlaSByP+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773649485; x=1805185485;
  h=date:from:to:cc:subject:message-id;
  bh=ckVuorEOUxDHBMi1KGu3S+cgykqI9ioysmPWZ7s2HQg=;
  b=SlaSByP+xdrizvfqBex3aHf5Jyom97m/uMyL5uijyCvwWVY2vAfJhuzK
   DQiUQF1qHTlWOe/9KQ5sFJAeRUVz0FRjYHWcdmvKB66Mf/qFwuG/O82hu
   EUX9GcOip1v6YFpVJaGuRnZJhmoWSeSPegYhTNxwYtELZvbtkwhbvMKYD
   VU0oEeY3rtvBgrVykYkV/AsgZ8xBZrGgLjhcRz3OOaUNjewUnfKCGGWAM
   +SVprEQB+RFnAiuBmy4ckSUrctu30WSWw1iSelEdG21dcK1OG2zxcqkYo
   ZbqQdSDu4jf2jrCrCfEWqRDr2Psj98nwC1QYFDSaGbFD5QCWoX+eLxJHE
   A==;
X-CSE-ConnectionGUID: wK69hMECTtqcGeSmBxm/xg==
X-CSE-MsgGUID: SeaLaBpUSjyT3uEiRm+qvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="97269174"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="97269174"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 01:24:44 -0700
X-CSE-ConnectionGUID: 6qJMEvwjQ6qmdcpndbPQTA==
X-CSE-MsgGUID: uoqmkKrtQ16AwS8pgy3clg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="221927602"
Received: from lkp-server01.sh.intel.com (HELO 892944969b78) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 16 Mar 2026 01:24:43 -0700
Received: from kbuild by 892944969b78 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w23Fg-000000000MW-0E2a;
	Mon, 16 Mar 2026 08:24:40 +0000
Date: Mon, 16 Mar 2026 16:24:28 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 5eb608319bb56464674a71b4a66ea65c6c435d64
Message-ID: <202603161622.2pYjab6Q-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 5eb608319bb56464674a71b4a66ea65c6c435d64  vt: save/restore unicode screen buffer for alternate screen

elapsed time: 789m

configs tested: 168
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260316    clang-23
arc                   randconfig-002-20260316    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260316    clang-23
arm                   randconfig-002-20260316    clang-23
arm                   randconfig-003-20260316    clang-23
arm                   randconfig-004-20260316    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260316    clang-23
arm64                 randconfig-002-20260316    clang-23
arm64                 randconfig-003-20260316    clang-23
arm64                 randconfig-004-20260316    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260316    clang-23
csky                  randconfig-002-20260316    clang-23
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260316    gcc-11.5.0
hexagon               randconfig-002-20260316    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260316    gcc-14
i386        buildonly-randconfig-002-20260316    gcc-14
i386        buildonly-randconfig-003-20260316    gcc-14
i386        buildonly-randconfig-004-20260316    gcc-14
i386        buildonly-randconfig-005-20260316    gcc-14
i386        buildonly-randconfig-006-20260316    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260316    gcc-14
i386                  randconfig-002-20260316    gcc-14
i386                  randconfig-003-20260316    gcc-14
i386                  randconfig-004-20260316    gcc-14
i386                  randconfig-005-20260316    gcc-14
i386                  randconfig-006-20260316    gcc-14
i386                  randconfig-007-20260316    gcc-14
i386                  randconfig-011-20260316    gcc-13
i386                  randconfig-012-20260316    gcc-13
i386                  randconfig-013-20260316    gcc-13
i386                  randconfig-014-20260316    gcc-13
i386                  randconfig-015-20260316    gcc-13
i386                  randconfig-016-20260316    gcc-13
i386                  randconfig-017-20260316    gcc-13
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260316    gcc-11.5.0
loongarch             randconfig-002-20260316    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260316    gcc-11.5.0
nios2                 randconfig-002-20260316    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260316    gcc-13.4.0
parisc                randconfig-002-20260316    gcc-13.4.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260316    gcc-13.4.0
powerpc               randconfig-002-20260316    gcc-13.4.0
powerpc64             randconfig-001-20260316    gcc-13.4.0
powerpc64             randconfig-002-20260316    gcc-13.4.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260316    gcc-12.5.0
riscv                 randconfig-002-20260316    gcc-12.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260316    gcc-12.5.0
s390                  randconfig-002-20260316    gcc-12.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260316    gcc-12.5.0
sh                    randconfig-002-20260316    gcc-12.5.0
sh                           sh2007_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260316    gcc-12.5.0
sparc                 randconfig-002-20260316    gcc-12.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260316    gcc-12.5.0
sparc64               randconfig-002-20260316    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260316    gcc-12.5.0
um                    randconfig-002-20260316    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260316    clang-20
x86_64      buildonly-randconfig-002-20260316    clang-20
x86_64      buildonly-randconfig-003-20260316    clang-20
x86_64      buildonly-randconfig-004-20260316    clang-20
x86_64      buildonly-randconfig-005-20260316    clang-20
x86_64      buildonly-randconfig-006-20260316    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260316    clang-20
x86_64                randconfig-002-20260316    clang-20
x86_64                randconfig-003-20260316    clang-20
x86_64                randconfig-004-20260316    clang-20
x86_64                randconfig-005-20260316    clang-20
x86_64                randconfig-006-20260316    clang-20
x86_64                randconfig-011-20260316    gcc-14
x86_64                randconfig-012-20260316    gcc-14
x86_64                randconfig-013-20260316    gcc-14
x86_64                randconfig-014-20260316    gcc-14
x86_64                randconfig-015-20260316    gcc-14
x86_64                randconfig-016-20260316    gcc-14
x86_64                randconfig-071-20260316    gcc-12
x86_64                randconfig-072-20260316    gcc-12
x86_64                randconfig-073-20260316    gcc-12
x86_64                randconfig-074-20260316    gcc-12
x86_64                randconfig-075-20260316    gcc-12
x86_64                randconfig-076-20260316    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260316    gcc-12.5.0
xtensa                randconfig-002-20260316    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
