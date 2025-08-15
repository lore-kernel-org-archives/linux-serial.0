Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8809F10E3
	for <linux-serial@vger.kernel.org>; Fri, 15 Aug 2025 05:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755236803; cv=none; b=IekqtVx2Jd7f6ykgNf2DWAEHOAv/MR2XDIEiae+J6uDYSAupXgF1u6yiTMUt91TVjbvegINtl/qMUPiOWZqO0p2enpDbGjyr1Duimh6PXafuSA9218NzvWFgNCeI3rzJ2NIbCxzDgby7vmHOJToOcSkgX3q4sVJ2kCxPAz/DxSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755236803; c=relaxed/simple;
	bh=JZkpOIyrHfnn21+JQzuBNQAoEViocWmJJxPS0yTkux8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=C/kljDIc2+nGmF6yApRiXUA9yNhIvNRacjkWXsggZOK0cEdaGOyGEh467fkkk+3rmZUUbzP5oGv8tYqBJeiUl7Sx8HIZfxfWkTyrcmdd+mlAkef645wgJiXif5LTVfJollGBqKLf6WWkYdrfhw/XPpHhD3Y5gkhfeg9leiYtnxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CM8YVg9H; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CM8YVg9H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755236802; x=1786772802;
  h=date:from:to:cc:subject:message-id;
  bh=JZkpOIyrHfnn21+JQzuBNQAoEViocWmJJxPS0yTkux8=;
  b=CM8YVg9Htku+JxVvJ//Pq77VNwMutxBVtllxwwlbyitpQP2tRn+5g6Re
   CPzxbzEypyI36AMSGgdQuXOaJujbnlrNUQYZ5sVJyx4LFuX+FO6QfGSAm
   eXnf/vA+u8Nf1nAfmEUpuoxoflE7iNoH1Yo/PjdMOz/Bot4FCa/LMAR7y
   7WzIMvqyFa91N4nW+SBuSo/XBcrD5yY9sVICvcyMVDuE5ecEnugP16nOU
   gAT/9MoD85e1ArulTwswZmiRQBsE4GlWsK+E3mtmzejMacequ96uBMf4g
   z3o0syGks77aBfJ886yFK2hD0J9coonqIBsEScUsvlFxUEMLXs5R+0AkA
   Q==;
X-CSE-ConnectionGUID: gOrUuQxzRE6ZeCYoIQTdwg==
X-CSE-MsgGUID: Kr8BEN/VQeGw/4GkhMrWbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57423928"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57423928"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 22:46:42 -0700
X-CSE-ConnectionGUID: re2hhyDxSieUk7mZo/EyRQ==
X-CSE-MsgGUID: gMZmDZp2SeiSBI1S7LlIZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="197937074"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 14 Aug 2025 22:46:40 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umnGs-000BcO-0N;
	Fri, 15 Aug 2025 05:46:37 +0000
Date: Fri, 15 Aug 2025 13:45:36 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 a1b51534b532dd4f0499907865553ee9251bebc3
Message-ID: <202508151331.XL4uaaie-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: a1b51534b532dd4f0499907865553ee9251bebc3  dt-bindings: serial: 8250: allow "main" and "uart" as clock names

elapsed time: 1168m

configs tested: 205
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250814    gcc-12.5.0
arc                   randconfig-001-20250815    clang-22
arc                   randconfig-002-20250814    gcc-13.4.0
arc                   randconfig-002-20250815    clang-22
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250814    clang-22
arm                   randconfig-001-20250815    clang-22
arm                   randconfig-002-20250814    clang-22
arm                   randconfig-002-20250815    clang-22
arm                   randconfig-003-20250814    gcc-10.5.0
arm                   randconfig-003-20250815    clang-22
arm                   randconfig-004-20250814    gcc-8.5.0
arm                   randconfig-004-20250815    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250814    clang-17
arm64                 randconfig-001-20250815    clang-22
arm64                 randconfig-002-20250814    gcc-8.5.0
arm64                 randconfig-002-20250815    clang-22
arm64                 randconfig-003-20250814    gcc-10.5.0
arm64                 randconfig-003-20250815    clang-22
arm64                 randconfig-004-20250814    gcc-13.4.0
arm64                 randconfig-004-20250815    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250814    gcc-15.1.0
csky                  randconfig-001-20250815    gcc-11.5.0
csky                  randconfig-002-20250814    gcc-15.1.0
csky                  randconfig-002-20250815    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250814    clang-20
hexagon               randconfig-001-20250815    gcc-11.5.0
hexagon               randconfig-002-20250814    clang-22
hexagon               randconfig-002-20250815    gcc-11.5.0
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250814    clang-20
i386        buildonly-randconfig-001-20250815    gcc-12
i386        buildonly-randconfig-002-20250814    gcc-12
i386        buildonly-randconfig-002-20250815    gcc-12
i386        buildonly-randconfig-003-20250814    gcc-12
i386        buildonly-randconfig-003-20250815    gcc-12
i386        buildonly-randconfig-004-20250814    clang-20
i386        buildonly-randconfig-004-20250815    gcc-12
i386        buildonly-randconfig-005-20250814    gcc-12
i386        buildonly-randconfig-005-20250815    gcc-12
i386        buildonly-randconfig-006-20250814    gcc-12
i386        buildonly-randconfig-006-20250815    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250815    gcc-12
i386                  randconfig-002-20250815    gcc-12
i386                  randconfig-003-20250815    gcc-12
i386                  randconfig-004-20250815    gcc-12
i386                  randconfig-005-20250815    gcc-12
i386                  randconfig-006-20250815    gcc-12
i386                  randconfig-007-20250815    gcc-12
i386                  randconfig-011-20250815    gcc-12
i386                  randconfig-012-20250815    gcc-12
i386                  randconfig-013-20250815    gcc-12
i386                  randconfig-014-20250815    gcc-12
i386                  randconfig-015-20250815    gcc-12
i386                  randconfig-016-20250815    gcc-12
i386                  randconfig-017-20250815    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250814    clang-22
loongarch             randconfig-001-20250815    gcc-11.5.0
loongarch             randconfig-002-20250814    gcc-15.1.0
loongarch             randconfig-002-20250815    gcc-11.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250814    gcc-10.5.0
nios2                 randconfig-001-20250815    gcc-11.5.0
nios2                 randconfig-002-20250814    gcc-9.5.0
nios2                 randconfig-002-20250815    gcc-11.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250814    gcc-10.5.0
parisc                randconfig-001-20250815    gcc-11.5.0
parisc                randconfig-002-20250814    gcc-13.4.0
parisc                randconfig-002-20250815    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250814    gcc-8.5.0
powerpc               randconfig-001-20250815    gcc-11.5.0
powerpc               randconfig-002-20250814    gcc-8.5.0
powerpc               randconfig-002-20250815    gcc-11.5.0
powerpc               randconfig-003-20250814    gcc-10.5.0
powerpc               randconfig-003-20250815    gcc-11.5.0
powerpc64             randconfig-001-20250814    clang-22
powerpc64             randconfig-001-20250815    gcc-11.5.0
powerpc64             randconfig-002-20250814    clang-22
powerpc64             randconfig-002-20250815    gcc-11.5.0
powerpc64             randconfig-003-20250814    clang-22
powerpc64             randconfig-003-20250815    gcc-11.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250814    clang-22
riscv                 randconfig-001-20250815    gcc-8.5.0
riscv                 randconfig-002-20250814    clang-22
riscv                 randconfig-002-20250815    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250814    clang-22
s390                  randconfig-001-20250815    gcc-8.5.0
s390                  randconfig-002-20250814    gcc-8.5.0
s390                  randconfig-002-20250815    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250814    gcc-9.5.0
sh                    randconfig-001-20250815    gcc-8.5.0
sh                    randconfig-002-20250814    gcc-15.1.0
sh                    randconfig-002-20250815    gcc-8.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250814    gcc-14.3.0
sparc                 randconfig-001-20250815    gcc-8.5.0
sparc                 randconfig-002-20250814    gcc-12.5.0
sparc                 randconfig-002-20250815    gcc-8.5.0
sparc64               randconfig-001-20250814    clang-22
sparc64               randconfig-001-20250815    gcc-8.5.0
sparc64               randconfig-002-20250814    gcc-8.5.0
sparc64               randconfig-002-20250815    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250814    clang-22
um                    randconfig-001-20250815    gcc-8.5.0
um                    randconfig-002-20250814    clang-22
um                    randconfig-002-20250815    gcc-8.5.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250814    clang-20
x86_64      buildonly-randconfig-001-20250815    gcc-12
x86_64      buildonly-randconfig-002-20250814    clang-20
x86_64      buildonly-randconfig-002-20250815    gcc-12
x86_64      buildonly-randconfig-003-20250814    gcc-12
x86_64      buildonly-randconfig-003-20250815    gcc-12
x86_64      buildonly-randconfig-004-20250814    clang-20
x86_64      buildonly-randconfig-004-20250815    gcc-12
x86_64      buildonly-randconfig-005-20250814    gcc-12
x86_64      buildonly-randconfig-005-20250815    gcc-12
x86_64      buildonly-randconfig-006-20250814    gcc-12
x86_64      buildonly-randconfig-006-20250815    gcc-12
x86_64                              defconfig    gcc-11
x86_64                randconfig-001-20250815    gcc-12
x86_64                randconfig-002-20250815    gcc-12
x86_64                randconfig-003-20250815    gcc-12
x86_64                randconfig-004-20250815    gcc-12
x86_64                randconfig-005-20250815    gcc-12
x86_64                randconfig-006-20250815    gcc-12
x86_64                randconfig-007-20250815    gcc-12
x86_64                randconfig-008-20250815    gcc-12
x86_64                randconfig-071-20250815    clang-20
x86_64                randconfig-072-20250815    clang-20
x86_64                randconfig-073-20250815    clang-20
x86_64                randconfig-074-20250815    clang-20
x86_64                randconfig-075-20250815    clang-20
x86_64                randconfig-076-20250815    clang-20
x86_64                randconfig-077-20250815    clang-20
x86_64                randconfig-078-20250815    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250814    gcc-8.5.0
xtensa                randconfig-001-20250815    gcc-8.5.0
xtensa                randconfig-002-20250814    gcc-10.5.0
xtensa                randconfig-002-20250815    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
