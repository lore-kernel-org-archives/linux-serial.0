Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0049235972
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784356973; cv=none; b=FIOHOfp4Pk5b/tk8D1JbOEBLstrqGcDvSs3QNCrAjMefeGmKqGsjo9aBoQBR9LS51u887BlD2SsqfK0wxxjqGYGCMCKDoOhKwGNctUrJpDMgMiRJbWwXARxtpGld8vpw6oXdbAnbWJGnKiRGKz72Xo58fq2CKcEeIED31N6MO88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784356973; c=relaxed/simple;
	bh=EHaKIoTL6PZOTPYEeRiWvY2iUW5czK67RETtA4TzPKc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=B4rZAW95BaInlbxjnDnRW+j4x2dToUtqvZuTmapWhA7KC39ka4CNHhRzcs6rpvS/wpuXWyIK/qioeyJh4W09QftZMNOfwACc9XWVE57X8Ss65OKOymQqTAfauTAoGKHBmaOnLeG5U6u4TRjoZXIAlNDBl25crteyF1YZP9WF6rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JeYN6vd5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JeYN6vd5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784356972; x=1815892972;
  h=date:from:to:cc:subject:message-id;
  bh=EHaKIoTL6PZOTPYEeRiWvY2iUW5czK67RETtA4TzPKc=;
  b=JeYN6vd5GD/vpNUYNJpXbc1rEuRPvoJ64P6i1VxUxxiH7qyWEnPBAzdT
   wTNx8BC6Ru2oN/1wMkE8V5r++R0yotnieVP4qDzcRY6RwNH7PNkDOFwtO
   hJF6alxSYthGKozUsykKfeXhlim0HqiRFws1yPUgeDkIRtBwmpcKtaGxb
   KYHByN8yxVlHhR85+t8p99++FPdoLPUgQE+f+JXOY/nvdK1Yf62xaC6Eo
   Fxr2f2AAgbUkIbgeRxhxVZt8d0nncD8LuWw4bEzu34Qr72zdQjlyktq0X
   BsKapX8XJ+0pdsqU5jwcq7Tenvla2kr8GFcSDbiXONjWJ+RwJs8B1e920
   w==;
X-CSE-ConnectionGUID: jZh59cQORVK/UhdzRDFAGA==
X-CSE-MsgGUID: E/swUxcOSC6zK4cvNdZ/Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="95614783"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="95614783"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 23:42:51 -0700
X-CSE-ConnectionGUID: XW+T+9XiQeCCR+yQ6/yysw==
X-CSE-MsgGUID: gE5eoGzKRTCSEiUwi2h6nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="254337260"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 17 Jul 2026 23:42:50 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wkyl2-00000000TWx-0cE1;
	Sat, 18 Jul 2026 06:42:45 +0000
Date: Sat, 18 Jul 2026 14:42:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-next] BUILD SUCCESS
 facd005eee65df088cd73733741fbcf8d989fc5e
Message-ID: <202607181424.YCk0ecxJ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
branch HEAD: facd005eee65df088cd73733741fbcf8d989fc5e  Revert "serial: qcom-geni: remove .pm callback, use runtime PM in startup/shutdown"

elapsed time: 749m

configs tested: 97
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    gcc-8.5.0
arc                  randconfig-001-20260718    gcc-8.5.0
arc                  randconfig-002-20260718    gcc-8.5.0
arm                  randconfig-001-20260718    gcc-8.5.0
arm                  randconfig-002-20260718    gcc-8.5.0
arm                  randconfig-003-20260718    gcc-8.5.0
arm                  randconfig-004-20260718    gcc-8.5.0
arm                          u8500_defconfig    gcc-16.1.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260718    gcc-14.3.0
arm64                randconfig-002-20260718    gcc-14.3.0
arm64                randconfig-003-20260718    gcc-14.3.0
arm64                randconfig-004-20260718    gcc-14.3.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260718    gcc-14.3.0
csky                 randconfig-002-20260718    gcc-14.3.0
hexagon              randconfig-001-20260718    clang-18
hexagon              randconfig-002-20260718    clang-18
i386                            allmodconfig    gcc-14
i386                 randconfig-001-20260718    gcc-14
i386                 randconfig-002-20260718    gcc-14
i386                 randconfig-003-20260718    gcc-14
i386                 randconfig-004-20260718    gcc-14
i386                 randconfig-005-20260718    gcc-14
i386                 randconfig-006-20260718    gcc-14
i386                 randconfig-007-20260718    gcc-14
i386                 randconfig-011-20260718    clang-22
i386                 randconfig-012-20260718    clang-22
i386                 randconfig-013-20260718    clang-22
i386                 randconfig-014-20260718    clang-22
i386                 randconfig-015-20260718    clang-22
i386                 randconfig-016-20260718    clang-22
i386                 randconfig-017-20260718    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260718    clang-18
loongarch            randconfig-002-20260718    clang-18
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260718    clang-18
nios2                randconfig-002-20260718    clang-18
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-16.1.0
parisc               randconfig-001-20260718    gcc-16.1.0
parisc               randconfig-002-20260718    gcc-16.1.0
powerpc              randconfig-001-20260718    gcc-16.1.0
powerpc              randconfig-002-20260718    gcc-16.1.0
powerpc64            randconfig-001-20260718    gcc-16.1.0
powerpc64            randconfig-002-20260718    gcc-16.1.0
riscv                randconfig-001-20260718    clang-24
riscv                randconfig-002-20260718    clang-24
s390                 randconfig-001-20260718    clang-24
s390                 randconfig-002-20260718    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260718    clang-24
sh                   randconfig-002-20260718    clang-24
sparc                randconfig-001-20260718    gcc-11.5.0
sparc                randconfig-002-20260718    gcc-11.5.0
sparc64              randconfig-001-20260718    gcc-11.5.0
sparc64              randconfig-002-20260718    gcc-11.5.0
um                   randconfig-001-20260718    gcc-11.5.0
um                   randconfig-002-20260718    gcc-11.5.0
x86_64     buildonly-randconfig-001-20260718    clang-22
x86_64     buildonly-randconfig-002-20260718    clang-22
x86_64     buildonly-randconfig-003-20260718    clang-22
x86_64     buildonly-randconfig-004-20260718    clang-22
x86_64     buildonly-randconfig-005-20260718    clang-22
x86_64     buildonly-randconfig-006-20260718    clang-22
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    gcc-14
x86_64               randconfig-001-20260718    gcc-14
x86_64               randconfig-002-20260718    gcc-14
x86_64               randconfig-003-20260718    gcc-14
x86_64               randconfig-004-20260718    gcc-14
x86_64               randconfig-005-20260718    gcc-14
x86_64               randconfig-006-20260718    gcc-14
x86_64               randconfig-011-20260718    gcc-14
x86_64               randconfig-012-20260718    gcc-14
x86_64               randconfig-013-20260718    gcc-14
x86_64               randconfig-014-20260718    gcc-14
x86_64               randconfig-015-20260718    gcc-14
x86_64               randconfig-016-20260718    gcc-14
x86_64               randconfig-071-20260718    clang-22
x86_64               randconfig-072-20260718    clang-22
x86_64               randconfig-073-20260718    clang-22
x86_64               randconfig-074-20260718    clang-22
x86_64               randconfig-075-20260718    clang-22
x86_64               randconfig-076-20260718    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260718    gcc-11.5.0
xtensa               randconfig-002-20260718    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
