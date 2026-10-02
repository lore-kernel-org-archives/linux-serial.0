Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7457E409271
	for <linux-serial@vger.kernel.org>; Fri,  2 Oct 2026 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790973940; cv=none; b=SwSVJed19EqY3Tqj9VFRNDU7UqfKrAY1FsuPUSzcf4aSipxiL6W+Eb+4xjGPEMPLk7QyktxzOH95IJpfKXGnaZiUvA+0EFVhg2jd2BNiBT8616kZm50YldCE1EdJh9isn9+9cdl/0wm41vlvGxo5ZgW1koju+ILH2NfhbBtSD6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790973940; c=relaxed/simple;
	bh=FRa8OZAXMXhzGFVa2g1QLrbGVKlW33g6Wapuc+BKQ50=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bxBJNh/HRqD275MHChkCVo9gBIiLyJ8ezYIREQn9sKDPgE8/FGcvFlMbm/bz7GQ4h4tLkD3wvLEXIK5QiTdxe/bjDPS4HeYKPj6dxD44B9EB4khs/+N6XnQD2zKLTvpog6qIe17wJERrynvFZSmKIvhIEUp2JVaE0Mui+Gy/fyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mK2oxQ5q; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mK2oxQ5q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790973937; x=1822509937;
  h=date:from:to:cc:subject:message-id;
  bh=FRa8OZAXMXhzGFVa2g1QLrbGVKlW33g6Wapuc+BKQ50=;
  b=mK2oxQ5qZ/rAES97egYHrzwrWFyqc0GOF1rnnbWptJ07ByZmFOr2muqJ
   +FUk78AbN2U76j1OLf7nLsu0olpCmHbrqOTYwMWVDZ1v9cxVYxrR3qRac
   +X+JmDxkspK/tJLdTixpbL03XAeX7qZs1188DGQiYMRHRBuOHpI2NifC9
   KVagBeS9Wd/oNd0dLGs9CiSUfK2SPVI0XPH7ycbPbcpZFXnwtQMEbEm7Y
   3N0nh/bxxwD0LyWBROXE9yjFU+v+OM+E1J/usxZcQdLjZoJVb2E5uWS2l
   kJlKsWmuYhrD0XJaguM5inbHkKG2GNvbfsNymU8ftJiLFKto3y8CmwNnN
   w==;
X-CSE-ConnectionGUID: 5ZouP5dkTRGOlq7f5hkHqA==
X-CSE-MsgGUID: mTPK3SkdSZ6+9km69LsSPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="90642967"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90642967"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 13:45:35 -0700
X-CSE-ConnectionGUID: 4WxDQPdcQzSnBdl3a16AeA==
X-CSE-MsgGUID: CRbPsvXQTzOP/3aqk45bGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="275511833"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 02 Oct 2026 13:45:33 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xCk8I-00000000TT9-49RQ;
	Fri, 02 Oct 2026 20:45:30 +0000
Date: Sat, 03 Oct 2026 04:44:53 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 c44a4925cdac02af781ebfae96df68a7bf3580b0
Message-ID: <202610030450.741DKnk4-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: c44a4925cdac02af781ebfae96df68a7bf3580b0  serial: 8250: Fix section mismatch with CONFIG_MODULES=n

elapsed time: 1776m

configs tested: 264
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2105-20261001    gcc-15.2.0 cocci
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                       axs103_smp_defconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261002    clang-17
arc                   randconfig-1001-20261002    clang-17
arc                  randconfig-r2101-20261001    gcc-13.4.0 cocci
arc                  randconfig-r2102-20261001    gcc-13.4.0 cocci
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                          assabet_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                   randconfig-1000-20261002    clang-17
arm                   randconfig-1001-20261002    clang-17
arm                   randconfig-1002-20261002    clang-17
arm                   randconfig-1003-20261002    clang-17
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261002    gcc-12.5.0
arm64                 randconfig-1001-20261002    gcc-12.5.0
arm64                 randconfig-1002-20261002    gcc-12.5.0
arm64                 randconfig-1003-20261002    gcc-12.5.0
arm64                randconfig-r2104-20261002    clang-17   cocci
arm64                randconfig-r2201-20261001    gcc-16.1.0 smatch
arm64                randconfig-r2300-20261001    gcc-9.5.0  sparse
arm64                randconfig-r2303-20261001    gcc-9.5.0  sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261002    gcc-12.5.0
csky                  randconfig-1001-20261002    gcc-12.5.0
csky                 randconfig-r2305-20261001    gcc-15.2.0 sparse
csky                 randconfig-r2305-20261001    gcc-9.5.0  sparse
csky                 randconfig-r2309-20261001    clang-24   sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261002    gcc-13.4.0
hexagon               randconfig-1001-20261002    gcc-13.4.0
hexagon              randconfig-r2103-20261001    clang-24   cocci
hexagon              randconfig-r2202-20261002    clang-18   smatch
hexagon              randconfig-r2304-20261001    gcc-15.2.0 sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261002    clang-22
i386        buildonly-randconfig-1001-20261002    clang-22
i386        buildonly-randconfig-1002-20261002    clang-22
i386        buildonly-randconfig-1003-20261002    clang-22
i386        buildonly-randconfig-1004-20261002    clang-22
i386        buildonly-randconfig-1005-20261002    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261002    gcc-14
i386                  randconfig-1001-20261002    gcc-14
i386                  randconfig-1002-20261002    gcc-14
i386                  randconfig-1003-20261002    gcc-14
i386                  randconfig-1004-20261002    gcc-14
i386                  randconfig-1005-20261002    gcc-14
i386                  randconfig-1006-20261002    gcc-14
i386                  randconfig-1007-20261002    clang-22
i386                  randconfig-1008-20261002    clang-22
i386                  randconfig-1009-20261002    clang-22
i386                  randconfig-1010-20261002    clang-22
i386                  randconfig-1011-20261002    clang-22
i386                  randconfig-1012-20261002    clang-22
i386                  randconfig-1013-20261002    clang-22
i386                  randconfig-2100-20261001    gcc-14     cocci
i386                  randconfig-2100-20261002    gcc-14     cocci
i386                  randconfig-2101-20261001    gcc-14     cocci
i386                  randconfig-2101-20261002    gcc-14     cocci
i386                  randconfig-2102-20261001    gcc-14     cocci
i386                  randconfig-2102-20261002    gcc-14     cocci
i386                  randconfig-2103-20261001    gcc-14     cocci
i386                  randconfig-2103-20261002    gcc-14     cocci
i386                  randconfig-2200-20261001    clang-22   smatch
i386                  randconfig-2200-20261002    gcc-14     smatch
i386                  randconfig-2300-20261001    gcc-14     sparse
i386                  randconfig-2300-20261002    gcc-12     sparse
i386                  randconfig-2301-20261001    gcc-14     sparse
i386                  randconfig-2301-20261002    gcc-12     sparse
i386                  randconfig-2302-20261001    gcc-14     sparse
i386                  randconfig-2302-20261002    gcc-12     sparse
i386                 randconfig-r2308-20261001    clang-24   sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261002    gcc-13.4.0
loongarch             randconfig-1001-20261002    gcc-13.4.0
loongarch            randconfig-r2107-20261001    gcc-15.2.0 cocci
loongarch            randconfig-r2302-20261001    gcc-15.2.0 sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                 randconfig-r2105-20261002    clang-17   cocci
m68k                 randconfig-r2302-20261001    gcc-9.5.0  sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2201-20261002    gcc-8.5.0  smatch
microblaze           randconfig-r2202-20261001    gcc-8.5.0  smatch
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                      decstation_defconfig    gcc-16.1.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261002    gcc-13.4.0
nios2                 randconfig-1001-20261002    gcc-13.4.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc             randconfig-r2307-20261001    gcc-16.1.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                randconfig-1000-20261002    gcc-14.3.0
parisc                randconfig-1001-20261002    gcc-14.3.0
parisc               randconfig-r2102-20261001    clang-24   cocci
parisc               randconfig-r2104-20261001    gcc-15.2.0 cocci
parisc               randconfig-r2200-20261001    gcc-8.5.0  smatch
parisc64                             defconfig    clang-24
powerpc                            allnoconfig    clang-24
powerpc                   iss476-smp_defconfig    gcc-16.1.0
powerpc                      mpc83xx_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20261002    gcc-14.3.0
powerpc               randconfig-1001-20261002    gcc-14.3.0
powerpc              randconfig-r2303-20261001    gcc-15.2.0 sparse
powerpc                      tqm8555_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20261002    gcc-14.3.0
powerpc64             randconfig-1001-20261002    gcc-14.3.0
powerpc64            randconfig-r2307-20261001    clang-24   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                 randconfig-1000-20261002    clang-24
riscv                 randconfig-1001-20261002    clang-24
riscv                 randconfig-2000-20261001    gcc-10.5.0
riscv                 randconfig-2001-20261001    gcc-10.5.0
riscv                randconfig-r2300-20261001    gcc-15.2.0 sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                           debug_defconfig    gcc-16.1.0
s390                  randconfig-1000-20261002    clang-24
s390                  randconfig-1001-20261002    clang-24
s390                  randconfig-2000-20261001    gcc-10.5.0
s390                  randconfig-2001-20261001    gcc-10.5.0
s390                 randconfig-r2100-20261001    gcc-13.4.0 cocci
s390                 randconfig-r2106-20261002    clang-17   cocci
s390                 randconfig-r2308-20261001    gcc-16.1.0 sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                          ap325rxa_defconfig    gcc-16.1.0
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261002    clang-24
sh                    randconfig-1001-20261002    clang-24
sh                    randconfig-2000-20261001    gcc-10.5.0
sh                    randconfig-2001-20261001    gcc-10.5.0
sh                   randconfig-r2301-20261001    gcc-15.2.0 sparse
sh                   randconfig-r2306-20261001    gcc-16.1.0 sparse
sparc                              allnoconfig    clang-24
sparc                 randconfig-1000-20261002    clang-24
sparc                 randconfig-1001-20261002    clang-24
sparc                 randconfig-2000-20261001    clang-24
sparc                 randconfig-2000-20261002    clang-24
sparc                 randconfig-2001-20261001    clang-24
sparc                 randconfig-2001-20261002    clang-24
sparc                randconfig-r2101-20261001    clang-24   cocci
sparc                randconfig-r2106-20261001    gcc-15.2.0 cocci
sparc                randconfig-r2200-20261001    gcc-8.5.0  smatch
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261002    clang-24
sparc64               randconfig-1001-20261002    clang-24
sparc64               randconfig-2000-20261001    clang-24
sparc64               randconfig-2000-20261002    clang-24
sparc64               randconfig-2001-20261001    clang-24
sparc64               randconfig-2001-20261002    clang-24
sparc64              randconfig-r2103-20261001    gcc-13.4.0 cocci
sparc64              randconfig-r2107-20261002    clang-17   cocci
sparc64              randconfig-r2301-20261001    gcc-9.5.0  sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261002    clang-24
um                    randconfig-1001-20261002    clang-24
um                    randconfig-2000-20261001    clang-24
um                    randconfig-2000-20261002    clang-24
um                    randconfig-2001-20261001    clang-24
um                    randconfig-2001-20261002    clang-24
um                   randconfig-r2100-20261001    clang-24   cocci
um                   randconfig-r2306-20261001    clang-24   sparse
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-22   checkkconfigsymbols
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20261002    gcc-14
x86_64      buildonly-randconfig-1001-20261002    gcc-14
x86_64      buildonly-randconfig-1002-20261002    gcc-14
x86_64      buildonly-randconfig-1003-20261002    gcc-14
x86_64      buildonly-randconfig-1004-20261002    gcc-14
x86_64      buildonly-randconfig-1005-20261002    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261002    gcc-14
x86_64                randconfig-1001-20261002    gcc-14
x86_64                randconfig-1002-20261002    gcc-14
x86_64                randconfig-1003-20261002    gcc-14
x86_64                randconfig-1004-20261002    gcc-14
x86_64                randconfig-1005-20261002    gcc-14
x86_64                randconfig-1006-20261002    clang-22
x86_64                randconfig-1007-20261002    clang-22
x86_64                randconfig-1008-20261002    clang-22
x86_64                randconfig-1009-20261002    clang-22
x86_64                randconfig-1010-20261002    clang-22
x86_64                randconfig-1011-20261002    clang-22
x86_64                randconfig-1012-20261002    clang-22
x86_64                randconfig-1013-20261002    clang-22
x86_64                randconfig-1014-20261002    clang-22
x86_64                randconfig-1015-20261002    clang-22
x86_64                randconfig-1016-20261002    clang-22
x86_64                randconfig-1017-20261002    clang-22
x86_64                randconfig-2100-20261001    gcc-14     cocci
x86_64                randconfig-2101-20261001    gcc-14     cocci
x86_64                randconfig-2102-20261001    gcc-14     cocci
x86_64                randconfig-2103-20261001    gcc-14     cocci
x86_64                randconfig-2200-20261001    clang-22   smatch
x86_64                randconfig-2200-20261002    clang-22   smatch
x86_64                randconfig-2300-20261001    gcc-14     sparse
x86_64                randconfig-2300-20261002    gcc-12     sparse
x86_64                randconfig-2301-20261001    gcc-14     sparse
x86_64                randconfig-2301-20261002    gcc-12     sparse
x86_64                randconfig-2302-20261001    gcc-14     sparse
x86_64                randconfig-2302-20261002    gcc-12     sparse
x86_64               randconfig-r2304-20261001    gcc-9.5.0  sparse
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
xtensa                randconfig-1000-20261002    clang-24
xtensa                randconfig-1001-20261002    clang-24
xtensa                randconfig-2000-20261001    clang-24
xtensa                randconfig-2000-20261002    clang-24
xtensa                randconfig-2001-20261001    clang-24
xtensa                randconfig-2001-20261002    clang-24
xtensa               randconfig-r2309-20261001    gcc-16.1.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
