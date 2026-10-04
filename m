Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82F01E47CC
	for <linux-serial@vger.kernel.org>; Sun,  4 Oct 2026 04:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791089873; cv=none; b=OFBzLZlfnvSB377G/MWxaJbE3zDlqwa/CJ3Mm969/5jiDl7aDIU9Ct6eolx6LQLHzlMl7hkH1a2q6JuG9XQR9xkry0ssUuYLGAdcMklg3HLUgrLBQn0rwgfSDN1X3BqeGvWv+A1M3WvuNr3wzkqLHxzqFsjwBkk0qVZRSFDZhPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791089873; c=relaxed/simple;
	bh=263T5LWIuvcPi7Co7y3VWtOWL7M5QFcqal3uZPtQ9gw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EWGtzuR/M7d/vnYIdn/YKrYwSoNJh/Ae6rFvwvNz2zTSLsESFpXFp7vfWaLOHh7X/4eHX+N8tGzc4iEe2ysrCqrHLqzfJPkC8IclO/IIlCgP/xUwk7M6uWbF0czxj/qm/0ycdsW9V+2KrN341+p/vJZsbpnCXXyBDETKtlxVlJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAlluwQo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAlluwQo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791089871; x=1822625871;
  h=date:from:to:cc:subject:message-id;
  bh=263T5LWIuvcPi7Co7y3VWtOWL7M5QFcqal3uZPtQ9gw=;
  b=jAlluwQocKi04f3Jf7OUEcJd6thZB6l1AvqssIFcJ2xtVBoN6Byfl7QX
   gilcxYUSN3xUbBr/xPTd/rui+CcpMZWFdJFyV883qjFuAddHVYUwjEQmq
   bQ1Z9M6VQLPYyDv3IpWtnGUv1gBzwW9Cu3TnxILthy3KV89ONmlYJRanp
   iutMAA2vckHuFzFKABnJ2Fs79vuB0TBEdpaZIiBVOgfRkysWMf99UwF0P
   Yk3lPQ+GspGuT5qXLi3I8DWI/QXUGqzOzksQ+7CyZ1x9EG4Gz/VdaLLsu
   TUOMYsJ3ua6YRUpNAIWqmuRJTnIUfrXNDb4a4BiFii3gEgja9sZYDiSgw
   w==;
X-CSE-ConnectionGUID: JYTzmu8qRLqSmCImwTOCrg==
X-CSE-MsgGUID: GwWf+OnyQsOMGxjwdof6rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="91819513"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="91819513"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 21:57:50 -0700
X-CSE-ConnectionGUID: 0mfQWsHwSCWiPOc1xPkhpw==
X-CSE-MsgGUID: b9NHEJzBQx+UUrTqwAGtDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="302785546"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 03 Oct 2026 21:57:50 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xDEIE-00000000UU1-2OO8;
	Sun, 04 Oct 2026 04:57:46 +0000
Date: Sun, 04 Oct 2026 12:57:36 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 6c95ca52f27855dd2fb74131c8d4e8325d2af7de
Message-ID: <202610041232.QxpSNHtJ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 6c95ca52f27855dd2fb74131c8d4e8325d2af7de  tty: add missing driver flag kernel-doc colon

elapsed time: 1410m

configs tested: 421
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2100-20261002    gcc-11.5.0 cocci
arc                               alldefconfig    clang-24
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                  nsimosci_hs_smp_defconfig    gcc-16.1.0
arc                   randconfig-1000-20261003    clang-17
arc                   randconfig-1000-20261004    clang-22
arc                   randconfig-1001-20261003    clang-17
arc                   randconfig-1001-20261004    clang-22
arc                  randconfig-r2300-20261002    gcc-14     sparse
arc                  randconfig-r2300-20261002    gcc-14.3.0 sparse
arc                  randconfig-r2305-20261002    gcc-8.5.0  sparse
arc                  randconfig-r2306-20261002    gcc-16.1.0 sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                           collie_defconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                           ixp4xx_defconfig    clang-24
arm                       jornada720_defconfig    clang-24
arm                          nhk8815_defconfig    clang-24
arm                              pxa_defconfig    clang-24
arm                   randconfig-1000-20261003    clang-17
arm                   randconfig-1000-20261004    clang-22
arm                   randconfig-1001-20261003    clang-17
arm                   randconfig-1001-20261004    clang-22
arm                   randconfig-1002-20261003    clang-17
arm                   randconfig-1002-20261004    clang-22
arm                   randconfig-1003-20261003    clang-17
arm                   randconfig-1003-20261004    clang-22
arm                  randconfig-r2106-20261002    gcc-16.1.0 cocci
arm                  randconfig-r2309-20261003    gcc-8.5.0  sparse
arm                          socfpga_defconfig    clang-24
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261003    gcc-9.5.0
arm64                 randconfig-1000-20261004    gcc-16.1.0
arm64                 randconfig-1001-20261003    gcc-9.5.0
arm64                 randconfig-1001-20261004    gcc-16.1.0
arm64                 randconfig-1002-20261003    gcc-9.5.0
arm64                 randconfig-1002-20261004    gcc-16.1.0
arm64                 randconfig-1003-20261003    gcc-9.5.0
arm64                 randconfig-1003-20261004    gcc-16.1.0
arm64                randconfig-r2101-20261002    clang-21   cocci
arm64                randconfig-r2104-20261003    gcc-11.5.0 cocci
arm64                randconfig-r2105-20261002    clang-24   cocci
arm64                randconfig-r2202-20261003    clang-24   smatch
arm64                randconfig-r2300-20261003    gcc-9.5.0  sparse
arm64                randconfig-r2304-20261002    gcc-10.5.0 sparse
arm64                randconfig-r2305-20261002    gcc-10.5.0 sparse
arm64                randconfig-r2307-20261002    clang-24   sparse
arm64                randconfig-r2307-20261003    gcc-8.5.0  sparse
arm64                randconfig-r2309-20261002    gcc-16.1.0 sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261003    gcc-9.5.0
csky                  randconfig-1000-20261004    gcc-16.1.0
csky                  randconfig-1001-20261003    gcc-9.5.0
csky                  randconfig-1001-20261004    gcc-16.1.0
csky                 randconfig-r2300-20261003    gcc-14     sparse
csky                 randconfig-r2307-20261003    gcc-11.5.0 sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261003    gcc-16.1.0
hexagon               randconfig-1000-20261004    gcc-16.1.0
hexagon               randconfig-1001-20261003    gcc-16.1.0
hexagon               randconfig-1001-20261004    gcc-16.1.0
hexagon              randconfig-r2202-20261002    clang-18   smatch
hexagon              randconfig-r2304-20261003    gcc-14     sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261003    gcc-14
i386        buildonly-randconfig-1000-20261004    clang-22
i386        buildonly-randconfig-1001-20261003    gcc-14
i386        buildonly-randconfig-1001-20261004    clang-22
i386        buildonly-randconfig-1002-20261003    gcc-14
i386        buildonly-randconfig-1002-20261004    clang-22
i386        buildonly-randconfig-1003-20261003    gcc-14
i386        buildonly-randconfig-1003-20261004    clang-22
i386        buildonly-randconfig-1004-20261003    gcc-14
i386        buildonly-randconfig-1004-20261004    clang-22
i386        buildonly-randconfig-1005-20261003    gcc-14
i386        buildonly-randconfig-1005-20261004    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261003    gcc-14
i386                  randconfig-1000-20261004    gcc-14
i386                  randconfig-1001-20261003    gcc-14
i386                  randconfig-1001-20261004    gcc-14
i386                  randconfig-1002-20261003    gcc-14
i386                  randconfig-1002-20261004    gcc-14
i386                  randconfig-1003-20261003    gcc-14
i386                  randconfig-1003-20261004    gcc-14
i386                  randconfig-1004-20261003    gcc-14
i386                  randconfig-1004-20261004    gcc-14
i386                  randconfig-1005-20261003    gcc-14
i386                  randconfig-1005-20261004    gcc-14
i386                  randconfig-1006-20261003    gcc-14
i386                  randconfig-1006-20261004    gcc-14
i386                  randconfig-1007-20261003    gcc-14
i386                  randconfig-1008-20261003    gcc-14
i386                  randconfig-1009-20261003    gcc-14
i386                  randconfig-1010-20261003    gcc-14
i386                  randconfig-1011-20261003    gcc-14
i386                  randconfig-1012-20261003    gcc-14
i386                  randconfig-1013-20261003    gcc-14
i386                  randconfig-2100-20261002    gcc-14     cocci
i386                  randconfig-2100-20261003    gcc-14     cocci
i386                  randconfig-2101-20261002    gcc-14     cocci
i386                  randconfig-2101-20261003    gcc-14     cocci
i386                  randconfig-2102-20261002    gcc-14     cocci
i386                  randconfig-2102-20261003    gcc-14     cocci
i386                  randconfig-2103-20261002    gcc-14     cocci
i386                  randconfig-2103-20261003    gcc-14     cocci
i386                  randconfig-2200-20261002    gcc-14     smatch
i386                  randconfig-2200-20261003    gcc-14     smatch
i386                  randconfig-2300-20261002    gcc-12     sparse
i386                  randconfig-2300-20261003    clang-22   sparse
i386                  randconfig-2301-20261002    gcc-12     sparse
i386                  randconfig-2301-20261003    clang-22   sparse
i386                  randconfig-2302-20261002    gcc-12     sparse
i386                  randconfig-2302-20261003    clang-22   sparse
i386                 randconfig-r2103-20261003    gcc-13.4.0 cocci
i386                 randconfig-r2106-20261002    clang-24   cocci
i386                 randconfig-r2107-20261003    clang-21   cocci
i386                 randconfig-r2301-20261002    gcc-10.5.0 sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261003    gcc-16.1.0
loongarch             randconfig-1000-20261004    gcc-16.1.0
loongarch             randconfig-1001-20261003    gcc-16.1.0
loongarch             randconfig-1001-20261004    gcc-16.1.0
loongarch            randconfig-r2102-20261003    gcc-13.4.0 cocci
loongarch            randconfig-r2200-20261002    gcc-16.1.0 smatch
loongarch            randconfig-r2201-20261003    gcc-16.1.0 smatch
loongarch            randconfig-r2301-20261002    gcc-16.1.0 sparse
loongarch            randconfig-r2303-20261002    clang-18   sparse
loongarch            randconfig-r2304-20261002    clang-24   sparse
loongarch            randconfig-r2305-20261002    gcc-14     sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                 randconfig-r2101-20261003    gcc-12.5.0 cocci
m68k                 randconfig-r2103-20261002    clang-17   cocci
m68k                 randconfig-r2103-20261003    gcc-12.5.0 cocci
m68k                 randconfig-r2201-20261003    gcc-9.5.0  smatch
m68k                 randconfig-r2202-20261003    gcc-11.5.0 smatch
m68k                 randconfig-r2301-20261003    gcc-14     sparse
m68k                 randconfig-r2303-20261002    gcc-10.5.0 sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2200-20261003    gcc-8.5.0  smatch
microblaze           randconfig-r2201-20261002    gcc-8.5.0  smatch
microblaze           randconfig-r2202-20261002    gcc-8.5.0  smatch
microblaze           randconfig-r2305-20261003    gcc-9.5.0  sparse
microblaze           randconfig-r2307-20261002    gcc-16.1.0 sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                           eyeq6_defconfig    gcc-16.1.0
mips                            ip32_defconfig    gcc-16.1.0
mips                 malta_qemu_32r6_defconfig    gcc-16.1.0
mips                 randconfig-r2101-20261003    gcc-13.4.0 cocci
mips                 randconfig-r2200-20261003    clang-24   smatch
mips                 randconfig-r2300-20261002    gcc-10.5.0 sparse
mips                 randconfig-r2303-20261003    gcc-9.5.0  sparse
mips                 randconfig-r2308-20261003    gcc-8.5.0  sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261003    gcc-16.1.0
nios2                 randconfig-1000-20261004    gcc-16.1.0
nios2                 randconfig-1001-20261003    gcc-16.1.0
nios2                 randconfig-1001-20261004    gcc-16.1.0
nios2                randconfig-r2101-20261002    clang-17   cocci
nios2                randconfig-r2306-20261003    gcc-8.5.0  sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2102-20261002    gcc-12.5.0 cocci
openrisc             randconfig-r2302-20261003    gcc-9.5.0  sparse
openrisc             randconfig-r2306-20261003    gcc-11.5.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                 generic-32bit_defconfig    gcc-16.1.0
parisc                randconfig-1000-20261003    gcc-11.5.0
parisc                randconfig-1000-20261004    gcc-12.5.0
parisc                randconfig-1001-20261003    gcc-11.5.0
parisc                randconfig-1001-20261004    gcc-12.5.0
parisc               randconfig-r2102-20261003    gcc-12.5.0 cocci
parisc               randconfig-r2104-20261002    gcc-16.1.0 cocci
parisc64                          alldefconfig    gcc-16.1.0
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                      powernv_defconfig    clang-24
powerpc               randconfig-1000-20261003    gcc-11.5.0
powerpc               randconfig-1000-20261004    gcc-12.5.0
powerpc               randconfig-1001-20261003    gcc-11.5.0
powerpc               randconfig-1001-20261004    gcc-12.5.0
powerpc              randconfig-r2102-20261002    clang-17   cocci
powerpc              randconfig-r2104-20261002    clang-24   cocci
powerpc              randconfig-r2104-20261003    clang-21   cocci
powerpc              randconfig-r2107-20261003    gcc-11.5.0 cocci
powerpc              randconfig-r2302-20261002    gcc-10.5.0 sparse
powerpc              randconfig-r2303-20261002    gcc-14     sparse
powerpc64             randconfig-1000-20261003    gcc-11.5.0
powerpc64             randconfig-1000-20261004    gcc-12.5.0
powerpc64             randconfig-1001-20261003    gcc-11.5.0
powerpc64             randconfig-1001-20261004    gcc-12.5.0
powerpc64            randconfig-r2104-20261002    clang-17   cocci
powerpc64            randconfig-r2106-20261003    gcc-11.5.0 cocci
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261003    gcc-12.5.0
riscv                 randconfig-1000-20261004    gcc-11.5.0
riscv                 randconfig-1001-20261003    gcc-12.5.0
riscv                 randconfig-1001-20261004    gcc-11.5.0
riscv                 randconfig-2000-20261002    gcc-9.5.0
riscv                 randconfig-2000-20261003    gcc-16.1.0
riscv                 randconfig-2001-20261002    gcc-9.5.0
riscv                 randconfig-2001-20261003    gcc-16.1.0
riscv                randconfig-r2103-20261002    gcc-14.3.0 cocci
riscv                randconfig-r2301-20261003    gcc-9.5.0  sparse
riscv                randconfig-r2302-20261002    clang-17   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261003    gcc-12.5.0
s390                  randconfig-1000-20261004    gcc-11.5.0
s390                  randconfig-1001-20261003    gcc-12.5.0
s390                  randconfig-1001-20261004    gcc-11.5.0
s390                  randconfig-2000-20261002    gcc-9.5.0
s390                  randconfig-2000-20261003    gcc-16.1.0
s390                  randconfig-2001-20261002    gcc-9.5.0
s390                  randconfig-2001-20261003    gcc-16.1.0
s390                 randconfig-r2100-20261002    clang-17   cocci
s390                 randconfig-r2100-20261003    gcc-12.5.0 cocci
s390                 randconfig-r2107-20261002    clang-24   cocci
s390                 randconfig-r2309-20261003    gcc-11.5.0 sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261003    gcc-12.5.0
sh                    randconfig-1000-20261004    gcc-11.5.0
sh                    randconfig-1001-20261003    gcc-12.5.0
sh                    randconfig-1001-20261004    gcc-11.5.0
sh                    randconfig-2000-20261002    gcc-9.5.0
sh                    randconfig-2000-20261003    gcc-16.1.0
sh                    randconfig-2001-20261002    gcc-9.5.0
sh                    randconfig-2001-20261003    gcc-16.1.0
sh                   randconfig-r2106-20261002    gcc-16.1.0 cocci
sh                   randconfig-r2200-20261002    gcc-10.5.0 smatch
sh                   randconfig-r2201-20261002    gcc-12.5.0 smatch
sh                   randconfig-r2304-20261003    gcc-9.5.0  sparse
sh                            se7724_defconfig    gcc-16.1.0
sh                      sh7710voipgw_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261003    clang-17
sparc                 randconfig-1000-20261004    gcc-14
sparc                 randconfig-1001-20261003    clang-17
sparc                 randconfig-1001-20261004    gcc-14
sparc                 randconfig-2000-20261002    clang-24
sparc                 randconfig-2000-20261002    gcc-15.2.0
sparc                 randconfig-2000-20261003    gcc-14
sparc                 randconfig-2001-20261002    clang-24
sparc                 randconfig-2001-20261002    gcc-8.5.0
sparc                 randconfig-2001-20261003    gcc-14
sparc                randconfig-r2103-20261002    gcc-14     cocci
sparc                randconfig-r2105-20261003    gcc-11.5.0 cocci
sparc                randconfig-r2107-20261002    gcc-16.1.0 cocci
sparc                randconfig-r2201-20261002    gcc-8.5.0  smatch
sparc                randconfig-r2308-20261002    clang-24   sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261003    clang-17
sparc64               randconfig-1000-20261004    gcc-14
sparc64               randconfig-1001-20261003    clang-17
sparc64               randconfig-1001-20261004    gcc-14
sparc64               randconfig-2000-20261002    clang-24
sparc64               randconfig-2000-20261002    gcc-8.5.0
sparc64               randconfig-2000-20261003    gcc-14
sparc64               randconfig-2001-20261002    clang-24
sparc64               randconfig-2001-20261003    gcc-14
sparc64              randconfig-r2100-20261002    gcc-14     cocci
sparc64              randconfig-r2105-20261002    gcc-16.1.0 cocci
sparc64              randconfig-r2106-20261003    clang-21   cocci
sparc64              randconfig-r2302-20261002    gcc-14     sparse
sparc64              randconfig-r2308-20261002    gcc-16.1.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261003    clang-17
um                    randconfig-1000-20261004    gcc-14
um                    randconfig-1001-20261003    clang-17
um                    randconfig-1001-20261004    gcc-14
um                    randconfig-2000-20261002    clang-24
um                    randconfig-2000-20261003    gcc-14
um                    randconfig-2001-20261002    clang-24
um                    randconfig-2001-20261003    gcc-14
um                   randconfig-r2105-20261003    clang-21   cocci
um                   randconfig-r2301-20261002    gcc-14     sparse
um                   randconfig-r2308-20261003    gcc-11.5.0 sparse
um                   randconfig-r2309-20261002    clang-24   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-22   checkkconfigsymbols
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261003    clang-22
x86_64      buildonly-randconfig-1000-20261004    gcc-14
x86_64      buildonly-randconfig-1001-20261003    clang-22
x86_64      buildonly-randconfig-1001-20261004    gcc-14
x86_64      buildonly-randconfig-1002-20261003    clang-22
x86_64      buildonly-randconfig-1002-20261004    gcc-14
x86_64      buildonly-randconfig-1003-20261003    clang-22
x86_64      buildonly-randconfig-1003-20261004    gcc-14
x86_64      buildonly-randconfig-1004-20261003    clang-22
x86_64      buildonly-randconfig-1004-20261004    gcc-14
x86_64      buildonly-randconfig-1005-20261003    clang-22
x86_64      buildonly-randconfig-1005-20261004    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261003    clang-22
x86_64                randconfig-1000-20261004    gcc-14
x86_64                randconfig-1001-20261003    clang-22
x86_64                randconfig-1001-20261004    gcc-14
x86_64                randconfig-1002-20261003    clang-22
x86_64                randconfig-1002-20261004    gcc-14
x86_64                randconfig-1003-20261003    clang-22
x86_64                randconfig-1003-20261004    gcc-14
x86_64                randconfig-1004-20261003    clang-22
x86_64                randconfig-1004-20261004    gcc-14
x86_64                randconfig-1005-20261003    clang-22
x86_64                randconfig-1005-20261004    gcc-14
x86_64                randconfig-1006-20261003    clang-22
x86_64                randconfig-1006-20261004    clang-22
x86_64                randconfig-1007-20261003    clang-22
x86_64                randconfig-1007-20261004    clang-22
x86_64                randconfig-1008-20261003    clang-22
x86_64                randconfig-1008-20261004    clang-22
x86_64                randconfig-1009-20261003    clang-22
x86_64                randconfig-1009-20261004    clang-22
x86_64                randconfig-1010-20261003    clang-22
x86_64                randconfig-1010-20261004    clang-22
x86_64                randconfig-1011-20261003    clang-22
x86_64                randconfig-1011-20261004    clang-22
x86_64                randconfig-1012-20261003    clang-22
x86_64                randconfig-1013-20261003    clang-22
x86_64                randconfig-1014-20261003    clang-22
x86_64                randconfig-1015-20261003    clang-22
x86_64                randconfig-1016-20261003    clang-22
x86_64                randconfig-1017-20261003    clang-22
x86_64                randconfig-2100-20261002    gcc-14     cocci
x86_64                randconfig-2100-20261003    clang-22   cocci
x86_64                randconfig-2101-20261002    gcc-14     cocci
x86_64                randconfig-2101-20261003    clang-22   cocci
x86_64                randconfig-2102-20261002    gcc-14     cocci
x86_64                randconfig-2102-20261003    clang-22   cocci
x86_64                randconfig-2103-20261002    gcc-14     cocci
x86_64                randconfig-2103-20261003    clang-22   cocci
x86_64                randconfig-2200-20261002    clang-22   smatch
x86_64                randconfig-2200-20261003    gcc-14     smatch
x86_64                randconfig-2300-20261002    gcc-12     sparse
x86_64                randconfig-2300-20261003    clang-22   sparse
x86_64                randconfig-2301-20261002    gcc-12     sparse
x86_64                randconfig-2301-20261003    clang-22   sparse
x86_64                randconfig-2302-20261002    gcc-12     sparse
x86_64                randconfig-2302-20261003    clang-22   sparse
x86_64               randconfig-r2101-20261002    gcc-14     cocci
x86_64               randconfig-r2102-20261002    gcc-14     cocci
x86_64               randconfig-r2105-20261002    gcc-14     cocci
x86_64               randconfig-r2107-20261002    clang-22   cocci
x86_64               randconfig-r2303-20261003    gcc-14     sparse
x86_64               randconfig-r2305-20261003    gcc-14     sparse
x86_64               randconfig-r2306-20261002    clang-24   sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261003    clang-17
xtensa                randconfig-1000-20261004    gcc-14
xtensa                randconfig-1001-20261003    clang-17
xtensa                randconfig-1001-20261004    gcc-14
xtensa                randconfig-2000-20261002    clang-24
xtensa                randconfig-2000-20261002    gcc-13.4.0
xtensa                randconfig-2000-20261003    gcc-14
xtensa                randconfig-2001-20261002    clang-24
xtensa                randconfig-2001-20261002    gcc-11.5.0
xtensa                randconfig-2001-20261003    gcc-14
xtensa               randconfig-r2100-20261003    gcc-13.4.0 cocci
xtensa               randconfig-r2302-20261003    gcc-14     sparse
xtensa               randconfig-r2304-20261002    gcc-14     sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
