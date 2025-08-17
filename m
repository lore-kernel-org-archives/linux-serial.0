Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697E61F1513
	for <linux-serial@vger.kernel.org>; Sun, 17 Aug 2025 23:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755474509; cv=none; b=QjdGwP05+0RBlmmY5viOeJjUXg5Y/txytHVYNiNedzmtAq7NzpPMXqeD810/XQLLfSi9oyuxLnLrBFerIT9RhaJaA/UdAwknzAJ7gBPBSO9ZYYFmGv2v7PRDbcpYZtfUtxxQbpf6DlsPRcY6sGj5/PjCKhta9xA+dttFfRImcZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755474509; c=relaxed/simple;
	bh=mSg0lbo0HsTO/d2xLtK4Y8pdGVisqltBtC+ckfF98YY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tHlUi7kMdDIXjhhmLPKdWWC8/Sf4/UFvRNk8kRCznVO2IX952ktAs2YL7SD/GJTJL5B2yH4r3foEJk5Mli/AZhhD+mrPVEzr0aK7545YnANWntufBte1XDLGLco1Q7HJNJvZuv8/wXZmAuF3V6nr3oOlEb2h1bzGJRJ0fcBnyRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjiET9YI; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjiET9YI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755474507; x=1787010507;
  h=date:from:to:cc:subject:message-id;
  bh=mSg0lbo0HsTO/d2xLtK4Y8pdGVisqltBtC+ckfF98YY=;
  b=SjiET9YIZG4poQ/AbT2THqSqd/qiyjVtxj7XIcYPWJd/yvi7dbJxXSTL
   dkayhyqUmn8h/oTQ4T/8bFWaIV4X1ZUxMZyNI7RT4bFn28B8TXib8iyNh
   eSfeUAgzYFjh8eSX8EWpgSfjIfgCI/IWJOb1XmXZadNSCwzVR5l7Yvz1f
   SrlGJLd/etiapkE1L6peIX8ujHWr+dD5yXhgwEwG6HAQzoS7BnEfSNnP1
   1s8tyrR5nao2yil+n1XsAsEKSKII5J0kJbCWD27YM10Own5VWfOmlyeMa
   Ywg9OyeDf/wNLF3VXRN/YetzkzRcJI/qVJ/wOMIzQP3aakg9uU+LQ999e
   Q==;
X-CSE-ConnectionGUID: PrFrRY6qTS+0cxNyT9KhqA==
X-CSE-MsgGUID: hKz17/AWQXGmIGnFBb8Mjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="69065610"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="69065610"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 16:48:25 -0700
X-CSE-ConnectionGUID: ZuXGgG2kQWWN4ELG7mPOzg==
X-CSE-MsgGUID: OmjLw394SxuSSCuFeKEcCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167355835"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 17 Aug 2025 16:48:23 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unn6r-000Dmb-2e;
	Sun, 17 Aug 2025 23:48:21 +0000
Date: Mon, 18 Aug 2025 07:48:07 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 7cd9f5d6c5a3f31d2b282d31ddc4d78ff83a5c08
Message-ID: <202508180759.U6t0ndQU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 7cd9f5d6c5a3f31d2b282d31ddc4d78ff83a5c08  s390/char/con3270: use tty_port_tty guard()

elapsed time: 726m

configs tested: 134
configs skipped: 3

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
arm                        multi_v7_defconfig    gcc-15.1.0
arm                           omap1_defconfig    gcc-15.1.0
arm                   randconfig-001-20250817    gcc-14.3.0
arm                   randconfig-002-20250817    clang-22
arm                   randconfig-003-20250817    clang-22
arm                   randconfig-004-20250817    gcc-8.5.0
arm                         s3c6400_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
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
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250817    clang-22
loongarch             randconfig-002-20250817    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       bvme6000_defconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                     loongson1b_defconfig    clang-22
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
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
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
