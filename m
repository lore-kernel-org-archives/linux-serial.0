Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF263F9FB
	for <linux-serial@vger.kernel.org>; Sat, 11 Jul 2026 02:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783736686; cv=none; b=B0VeyimbBz1amRubm4efUfsgU5xi0YbaJ5+dJFlmfPrDrx6DimGIRlx46IMvk1ITmPfARx3i8OYO2RcQw6b1VoMv/ks9l/7z9xCSvSrASWLDBvut/YZFJmPuo3H+JzSpB57KGmTnXqlxHRpNPZJYOkjey+M1XaUhC7vpf2X124M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783736686; c=relaxed/simple;
	bh=xhIEF/EcLk/zRLbUNvZ8+3fA+9NUOABgeB6mGhEgFtU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KGgYxUs9YmtfNslm+5BSyi4F+2mRSRTbGgCJTIU5CXmknAoVjDCXURoEcHrd9HLyPecR+fsZbzdJOfuvtzZZjm0KEb5qsxl/5ggbwnaqGICFwJhnseuSUrax7SitdMzMkUzSi1CpNO5sbErWq5Y77QPHfH7MQOvcQobaY/KzYoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHQ986Um; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHQ986Um"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783736684; x=1815272684;
  h=date:from:to:cc:subject:message-id;
  bh=xhIEF/EcLk/zRLbUNvZ8+3fA+9NUOABgeB6mGhEgFtU=;
  b=lHQ986UmmirddsNdrRrA+/O14slK5EBmn3Wt50Zy9nFAPchtHFIrnLdb
   foiG38mojXTabtvlj/tk9syGuzpLhYHoQb/fLwI+1m/R04rBy8ScaieRc
   RMTwZRsayWRNJ7gw2vDZLOy/Y+uA9TyBr0VHPE78eAXwOnyyrfatSYxKS
   f4h4/6I9mtXDZrunYL4UDAL6isycpblqy3aGEdTsWdlF92j0xRRo4HrzN
   eE3KmYAOvEdRRqmaIK3VropLCYrFBMa2T46OS9HOU0bE4etK/jTeW3SEg
   dvPc7QHnr8TGcNa95/SpHVwyEM5SmS2SRoA6qOcWQi4h/vbNr2f9r1i3Q
   A==;
X-CSE-ConnectionGUID: W63Uti+bTSSSLDqK3dogfQ==
X-CSE-MsgGUID: XAkOzGXbRpSK3X4sJc27RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88262379"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88262379"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 19:24:44 -0700
X-CSE-ConnectionGUID: 5ES1AQgkQpeZRyj0sznG7w==
X-CSE-MsgGUID: W7MbzgaGSXaAipO5RS4XUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="285130496"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 10 Jul 2026 19:24:43 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wiNOS-00000000JeO-0IOc;
	Sat, 11 Jul 2026 02:24:40 +0000
Date: Sat, 11 Jul 2026 10:24:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS WITH WARNING
 bef5e068b89b0f0cf974c987ebba9869a14b44c6
Message-ID: <202607111058.Su2pLuJy-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: bef5e068b89b0f0cf974c987ebba9869a14b44c6  serial: max3100: use new UPIO_BUS as iotype

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202607110715.VGT2dVVz-lkp@intel.com

    drivers/tty/serial/8250/8250_hub6.c:44:6: warning: no previous prototype for 'hub6_match_port' [-Wmissing-prototypes]

Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   `-- drivers-tty-serial-8250_hub6.c:warning:no-previous-prototype-for-hub6_match_port
|-- i386-allmodconfig
|   `-- drivers-tty-serial-8250_hub6.c:warning:no-previous-prototype-for-hub6_match_port
|-- i386-allyesconfig
|   `-- drivers-tty-serial-8250_hub6.c:warning:no-previous-prototype-for-hub6_match_port
|-- i386-buildonly-randconfig-002-20260711
|   `-- drivers-tty-serial-8250_hub6.c:warning:no-previous-prototype-for-hub6_match_port
|-- i386-randconfig-003-20260711
|   `-- drivers-tty-serial-8250_hub6.c:warning:no-previous-prototype-for-hub6_match_port
|-- m68k-allmodconfig
|   `-- drivers-tty-serial-8250_hub6.c:warning:no-previous-prototype-for-hub6_match_port
|-- m68k-allyesconfig
|   `-- drivers-tty-serial-8250_hub6.c:warning:no-previous-prototype-for-hub6_match_port
|-- parisc-allmodconfig
|   `-- drivers-tty-serial-8250_hub6.c:warning:no-previous-prototype-for-hub6_match_port
`-- parisc-allyesconfig
    `-- drivers-tty-serial-8250_hub6.c:warning:no-previous-prototype-for-hub6_match_port

elapsed time: 728m

configs tested: 194
configs skipped: 4

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260711    gcc-13.4.0
arc                   randconfig-002-20260711    gcc-13.4.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                           omap1_defconfig    gcc-16.1.0
arm                   randconfig-001-20260711    gcc-13.4.0
arm                   randconfig-002-20260711    gcc-13.4.0
arm                   randconfig-003-20260711    gcc-13.4.0
arm                   randconfig-004-20260711    gcc-13.4.0
arm                        vexpress_defconfig    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260711    gcc-16.1.0
arm64                 randconfig-002-20260711    gcc-16.1.0
arm64                 randconfig-003-20260711    gcc-16.1.0
arm64                 randconfig-004-20260711    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260711    gcc-16.1.0
csky                  randconfig-002-20260711    gcc-16.1.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260711    gcc-16.1.0
hexagon               randconfig-002-20260711    gcc-16.1.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260711    gcc-14
i386        buildonly-randconfig-002-20260711    gcc-14
i386        buildonly-randconfig-003-20260711    gcc-14
i386        buildonly-randconfig-004-20260711    gcc-14
i386        buildonly-randconfig-005-20260711    gcc-14
i386        buildonly-randconfig-006-20260711    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260711    clang-22
i386                  randconfig-002-20260711    clang-22
i386                  randconfig-003-20260711    clang-22
i386                  randconfig-004-20260711    clang-22
i386                  randconfig-005-20260711    clang-22
i386                  randconfig-006-20260711    clang-22
i386                  randconfig-007-20260711    clang-22
i386                  randconfig-011-20260711    gcc-13
i386                  randconfig-012-20260711    gcc-13
i386                  randconfig-013-20260711    gcc-13
i386                  randconfig-014-20260711    gcc-13
i386                  randconfig-015-20260711    gcc-13
i386                  randconfig-016-20260711    gcc-13
i386                  randconfig-017-20260711    gcc-13
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260711    gcc-16.1.0
loongarch             randconfig-002-20260711    gcc-16.1.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                malta_qemu_32r6_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260711    gcc-16.1.0
nios2                 randconfig-002-20260711    gcc-16.1.0
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    clang-17
parisc                         randconfig-001    gcc-10.5.0
parisc                randconfig-001-20260711    clang-17
parisc                randconfig-001-20260711    gcc-10.5.0
parisc                         randconfig-002    clang-17
parisc                         randconfig-002    gcc-10.5.0
parisc                randconfig-002-20260711    clang-17
parisc                randconfig-002-20260711    gcc-10.5.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                        randconfig-001    clang-17
powerpc                        randconfig-001    gcc-10.5.0
powerpc               randconfig-001-20260711    clang-17
powerpc               randconfig-001-20260711    gcc-10.5.0
powerpc                        randconfig-002    clang-17
powerpc                        randconfig-002    gcc-10.5.0
powerpc               randconfig-002-20260711    clang-17
powerpc64                      randconfig-001    clang-17
powerpc64             randconfig-001-20260711    clang-17
powerpc64             randconfig-001-20260711    gcc-10.5.0
powerpc64                      randconfig-002    clang-17
powerpc64                      randconfig-002    gcc-10.5.0
powerpc64             randconfig-002-20260711    clang-17
powerpc64             randconfig-002-20260711    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260711    gcc-8.5.0
riscv                 randconfig-002-20260711    gcc-8.5.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260711    gcc-8.5.0
s390                  randconfig-002-20260711    gcc-8.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260711    gcc-8.5.0
sh                    randconfig-002-20260711    gcc-8.5.0
sh                   sh7724_generic_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260711    gcc-16.1.0
sparc                 randconfig-002-20260711    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260711    gcc-16.1.0
sparc64               randconfig-002-20260711    gcc-16.1.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260711    gcc-16.1.0
um                    randconfig-002-20260711    gcc-16.1.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260711    gcc-14
x86_64      buildonly-randconfig-002-20260711    gcc-14
x86_64      buildonly-randconfig-003-20260711    gcc-14
x86_64      buildonly-randconfig-004-20260711    gcc-14
x86_64      buildonly-randconfig-005-20260711    gcc-14
x86_64      buildonly-randconfig-006-20260711    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260711    gcc-14
x86_64                randconfig-002-20260711    gcc-14
x86_64                randconfig-003-20260711    gcc-14
x86_64                randconfig-004-20260711    gcc-14
x86_64                randconfig-005-20260711    gcc-14
x86_64                randconfig-006-20260711    gcc-14
x86_64                randconfig-011-20260711    gcc-14
x86_64                randconfig-012-20260711    gcc-14
x86_64                randconfig-013-20260711    gcc-14
x86_64                randconfig-014-20260711    gcc-14
x86_64                randconfig-015-20260711    gcc-14
x86_64                randconfig-016-20260711    gcc-14
x86_64                randconfig-071-20260711    gcc-14
x86_64                randconfig-072-20260711    gcc-14
x86_64                randconfig-073-20260711    gcc-14
x86_64                randconfig-074-20260711    gcc-14
x86_64                randconfig-075-20260711    gcc-14
x86_64                randconfig-076-20260711    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260711    gcc-16.1.0
xtensa                randconfig-002-20260711    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
