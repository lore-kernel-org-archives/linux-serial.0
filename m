Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037F742A78B
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507583; cv=none; b=Kc6klF/teg3GNFpHRCZOH4Q3qba5wMw8XOFOAVURS1Z+4T7K9f7g5PTnYZ6bXduduEzDFtA4wDXCmRA3AFYTSxkGbkfLe/3GZACFNda7rznqB8r66mceMDcEy8xSVW917T4GbTrHZ1Rj+XWf5rMEfTeDvxUjxW31oP9NJBwW5lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507583; c=relaxed/simple;
	bh=gPnc8oodKt65dzlO+wuaoyeoyF0KLvO1dIIwV7KCe5g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kOtS1qCAlKtOga4BisDf8V4LSyP94LzBt2Mp9Ohz141U0uhmdWnZ0dgqqF9sA5zwZ8YSPezAIt3T9xGapr1nQ/KPfwjwXo9MtneLh0SkxFV21eKbnxhM3j37fEEMF8GkvErQyh4bHWpWrbINtcaj9oKW2akCUhGO8C9COyOlmQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j1MH/f+c; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1MH/f+c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785507582; x=1817043582;
  h=date:from:to:cc:subject:message-id;
  bh=gPnc8oodKt65dzlO+wuaoyeoyF0KLvO1dIIwV7KCe5g=;
  b=j1MH/f+cwcYkljGDnD8poYhCr8dGy+JYu5RQbxXsg+jeM2KC0LZghjcM
   X157zyx94YkyNh+gMNKbTdxFkZccT9wHwCIvcXZ59JIuKJ2yeoZQ/uM4f
   sT/oJXEeNryr26E6IvRzUoOwylL8P4ZjV1LkyUGANf3HTzAZ+wWYFSkEV
   BEsp58MQ+lQ4lUJ6c8VJAX8S2qhZs+O2XhMiRKCXbc7KbyzP+CJ47yH+9
   cbxv0WJubqj+ECYunSFB3PdrhY6OIzqtG6Nn7ICJq3f/U4aV5iUMck9A6
   L5mFSkBNKZJaMOT0QgAyPw7/Z4tAzMCPio48saCGmdolRcgEMEpp3wuuN
   A==;
X-CSE-ConnectionGUID: zMFo2Lr7RHa8g78kj3y26w==
X-CSE-MsgGUID: jG/WnAFYSVyWw9aHxLuJWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="96792824"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="96792824"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 07:19:41 -0700
X-CSE-ConnectionGUID: VjueBGZgT5iw9qPZHmlf5A==
X-CSE-MsgGUID: TmrSFqfURfOWevo6NJn1XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="260652315"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 31 Jul 2026 07:19:40 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wpo5J-000000001Bv-38li;
	Fri, 31 Jul 2026 14:19:37 +0000
Date: Fri, 31 Jul 2026 22:18:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-next] BUILD SUCCESS
 57c0741b8c15b93ba4aa92c6618cde6f3f4115b2
Message-ID: <202607312217.Ktuk7dOy-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
branch HEAD: 57c0741b8c15b93ba4aa92c6618cde6f3f4115b2  Revert "serial: 8250: Clear CON_PRINTBUFFER on port re-registration"

elapsed time: 802m

configs tested: 105
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260731    clang-17
arc                  randconfig-002-20260731    clang-17
arm                           mmp2_defconfig    gcc-16.1.0
arm                  randconfig-001-20260731    clang-17
arm                  randconfig-002-20260731    clang-17
arm                  randconfig-003-20260731    clang-17
arm                  randconfig-004-20260731    clang-17
arm64                randconfig-001-20260731    gcc-8.5.0
arm64                randconfig-002-20260731    gcc-8.5.0
arm64                randconfig-003-20260731    gcc-8.5.0
arm64                randconfig-004-20260731    gcc-8.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260731    gcc-8.5.0
csky                 randconfig-002-20260731    gcc-8.5.0
hexagon                       randconfig-001    clang-24
hexagon              randconfig-001-20260731    clang-24
hexagon              randconfig-002-20260731    clang-24
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260731    clang-22
i386       buildonly-randconfig-002-20260731    clang-22
i386       buildonly-randconfig-003-20260731    clang-22
i386       buildonly-randconfig-004-20260731    clang-22
i386       buildonly-randconfig-005-20260731    clang-22
i386       buildonly-randconfig-006-20260731    clang-22
i386                 randconfig-001-20260731    gcc-14
i386                 randconfig-002-20260731    gcc-14
i386                 randconfig-003-20260731    gcc-14
i386                 randconfig-004-20260731    gcc-14
i386                 randconfig-005-20260731    gcc-14
i386                 randconfig-006-20260731    gcc-14
i386                 randconfig-007-20260731    gcc-14
i386                 randconfig-011-20260731    clang-22
i386                 randconfig-012-20260731    clang-22
i386                 randconfig-013-20260731    clang-22
i386                 randconfig-014-20260731    clang-22
i386                 randconfig-015-20260731    clang-22
i386                 randconfig-016-20260731    clang-22
i386                 randconfig-017-20260731    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260731    clang-24
loongarch            randconfig-002-20260731    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260731    clang-24
nios2                randconfig-002-20260731    clang-24
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-8.5.0
parisc               randconfig-001-20260731    gcc-8.5.0
parisc               randconfig-002-20260731    gcc-8.5.0
powerpc              randconfig-001-20260731    gcc-8.5.0
powerpc              randconfig-002-20260731    gcc-8.5.0
powerpc64            randconfig-001-20260731    gcc-8.5.0
powerpc64            randconfig-002-20260731    gcc-8.5.0
riscv                   nommu_k210_defconfig    clang-24
riscv                         randconfig-001    clang-19
riscv                randconfig-001-20260731    clang-19
riscv                randconfig-002-20260731    clang-19
s390                 randconfig-001-20260731    clang-19
s390                 randconfig-002-20260731    clang-19
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260731    clang-19
sh                   randconfig-002-20260731    clang-19
sparc                         randconfig-001    gcc-14
sparc                randconfig-001-20260731    gcc-14
sparc                randconfig-002-20260731    gcc-14
sparc64              randconfig-001-20260731    gcc-14
sparc64              randconfig-002-20260731    gcc-14
um                   randconfig-001-20260731    gcc-14
um                   randconfig-002-20260731    gcc-14
x86_64     buildonly-randconfig-001-20260731    gcc-14
x86_64     buildonly-randconfig-002-20260731    gcc-14
x86_64     buildonly-randconfig-003-20260731    gcc-14
x86_64     buildonly-randconfig-004-20260731    gcc-14
x86_64     buildonly-randconfig-005-20260731    gcc-14
x86_64     buildonly-randconfig-006-20260731    gcc-14
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    gcc-14
x86_64               randconfig-001-20260731    gcc-14
x86_64               randconfig-002-20260731    gcc-14
x86_64               randconfig-003-20260731    gcc-14
x86_64               randconfig-004-20260731    gcc-14
x86_64               randconfig-005-20260731    gcc-14
x86_64               randconfig-006-20260731    gcc-14
x86_64               randconfig-011-20260731    gcc-14
x86_64               randconfig-012-20260731    gcc-14
x86_64               randconfig-013-20260731    gcc-14
x86_64               randconfig-014-20260731    gcc-14
x86_64               randconfig-015-20260731    gcc-14
x86_64               randconfig-016-20260731    gcc-14
x86_64               randconfig-071-20260731    clang-22
x86_64               randconfig-072-20260731    clang-22
x86_64               randconfig-073-20260731    clang-22
x86_64               randconfig-074-20260731    clang-22
x86_64               randconfig-075-20260731    clang-22
x86_64               randconfig-076-20260731    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260731    gcc-14
xtensa               randconfig-002-20260731    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
