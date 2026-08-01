Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F380358367
	for <linux-serial@vger.kernel.org>; Sat,  1 Aug 2026 03:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785556271; cv=none; b=m0sM+1VyHCZUuzwboShnWChH/sXvNvnmFofLyTUdaTSP2rPnzAuurMdtj6iU/4QioRcv+n6U3LJc/iGaBIbQlgFRPdGb3AxPEV0ZPMsi+TAb4lufOS/YUv1aBXDxtK2yj6oqw6UYIRgFeO7rJJEY3ro1vCLgWinWMT6VCAnpeuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785556271; c=relaxed/simple;
	bh=9dYdhwWxpQu7Fj52ZMN06M+W1ObLQsxmc+MBZlJOPT4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ryaa6Rq7HFE8LSVN1WgRbdJZghI2E+H3aghO3Lq0AVCN+mf8dus+afLxsKxAtXhfTPbmm+ioAsv26mlVW5UQHHHvuJZPFV9+UQLVwYNG+1K6+QQ9LqSxIzsuFrYiAXSHcYM0tPc0yUtHpqQ++tedxmzJ8CPs72LsVOPR5+s/Vgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XucNhC2F; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XucNhC2F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785556269; x=1817092269;
  h=date:from:to:cc:subject:message-id;
  bh=9dYdhwWxpQu7Fj52ZMN06M+W1ObLQsxmc+MBZlJOPT4=;
  b=XucNhC2F4zfjGfn0lA+ni78moxGK6a5X0IFfSNAgD0VNhufqmZh65G9s
   dPKzNpOhMHlekuhZZ3Q8SLdd2S678HH1ecozuHnCPYxm7ZMdkFAm4w+f2
   39VbrsG1QYig3X8yQkchwVQSD5Rrz0FUGfByEP8budl8ATnrn3rZbd/Fy
   9Ggoktgu6N92ocL9HZfMk/iAHKPeGEl6027/d33Ftp2pfNYxsvOVAor/9
   p73dKPyVAYQYx/P2u6Di/5o1FtDHOPdYsf6KaiuSPyLHu2ye4FRJ2etQo
   89G9BSQSHAr7JRpITUw4dREK4UNGAnWW8tB4pBwGXr4dZOOL/y2dVjf1b
   g==;
X-CSE-ConnectionGUID: 1fd95V0tRoq75Qoh0pYnFg==
X-CSE-MsgGUID: rSQp49C7R6GW9mETuhuWhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="111731100"
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="111731100"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 20:51:07 -0700
X-CSE-ConnectionGUID: KkNd1X/OSHS0L9PCtJxkAQ==
X-CSE-MsgGUID: jbw4677LQZGTIpjOIY/o7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="254448016"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 31 Jul 2026 20:51:06 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wq0kZ-000000002ft-2cw6;
	Sat, 01 Aug 2026 03:51:03 +0000
Date: Sat, 01 Aug 2026 11:50:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 e62745dd1172e475c101de3f11e39bf192d35ae5
Message-ID: <202608011130.3Vh2kaAq-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: e62745dd1172e475c101de3f11e39bf192d35ae5  vt: add mode validation in vt_setactivate

elapsed time: 787m

configs tested: 86
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260801    gcc-12.5.0
arc                  randconfig-002-20260801    gcc-12.5.0
arm                  randconfig-001-20260801    gcc-12.5.0
arm                  randconfig-002-20260801    gcc-12.5.0
arm                  randconfig-003-20260801    gcc-12.5.0
arm                  randconfig-004-20260801    gcc-12.5.0
arm64                randconfig-001-20260801    gcc-10.5.0
arm64                randconfig-002-20260801    gcc-10.5.0
arm64                randconfig-003-20260801    gcc-10.5.0
arm64                randconfig-004-20260801    gcc-10.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260801    gcc-10.5.0
csky                 randconfig-002-20260801    gcc-10.5.0
hexagon              randconfig-001-20260801    gcc-16.1.0
hexagon              randconfig-002-20260801    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260801    gcc-14
i386       buildonly-randconfig-002-20260801    gcc-14
i386       buildonly-randconfig-003-20260801    gcc-14
i386       buildonly-randconfig-004-20260801    gcc-14
i386       buildonly-randconfig-005-20260801    gcc-14
i386       buildonly-randconfig-006-20260801    gcc-14
i386                 randconfig-011-20260801    gcc-14
i386                 randconfig-012-20260801    gcc-14
i386                 randconfig-013-20260801    gcc-14
i386                 randconfig-014-20260801    gcc-14
i386                 randconfig-015-20260801    gcc-14
i386                 randconfig-016-20260801    gcc-14
i386                 randconfig-017-20260801    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260801    gcc-16.1.0
loongarch            randconfig-002-20260801    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260801    gcc-16.1.0
nios2                randconfig-002-20260801    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260801    gcc-9.5.0
parisc               randconfig-002-20260801    gcc-9.5.0
powerpc                     bamboo_defconfig    clang-21
powerpc              randconfig-001-20260801    gcc-9.5.0
powerpc              randconfig-002-20260801    gcc-9.5.0
powerpc64            randconfig-001-20260801    gcc-9.5.0
powerpc64            randconfig-002-20260801    gcc-9.5.0
riscv                randconfig-001-20260801    gcc-14.3.0
riscv                randconfig-002-20260801    gcc-14.3.0
s390                 randconfig-001-20260801    gcc-14.3.0
s390                 randconfig-002-20260801    gcc-14.3.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260801    gcc-14.3.0
sh                   randconfig-002-20260801    gcc-14.3.0
sparc                randconfig-001-20260801    gcc-11.5.0
sparc                randconfig-002-20260801    gcc-11.5.0
sparc64              randconfig-001-20260801    gcc-11.5.0
sparc64              randconfig-002-20260801    gcc-11.5.0
um                   randconfig-001-20260801    gcc-11.5.0
um                   randconfig-002-20260801    gcc-11.5.0
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260801    gcc-14
x86_64               randconfig-002-20260801    gcc-14
x86_64               randconfig-003-20260801    gcc-14
x86_64               randconfig-004-20260801    gcc-14
x86_64               randconfig-005-20260801    gcc-14
x86_64               randconfig-006-20260801    gcc-14
x86_64               randconfig-011-20260801    clang-22
x86_64               randconfig-012-20260801    clang-22
x86_64               randconfig-013-20260801    clang-22
x86_64               randconfig-014-20260801    clang-22
x86_64               randconfig-015-20260801    clang-22
x86_64               randconfig-016-20260801    clang-22
x86_64               randconfig-071-20260801    clang-22
x86_64               randconfig-072-20260801    clang-22
x86_64               randconfig-073-20260801    clang-22
x86_64               randconfig-074-20260801    clang-22
x86_64               randconfig-075-20260801    clang-22
x86_64               randconfig-076-20260801    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260801    gcc-11.5.0
xtensa               randconfig-002-20260801    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
