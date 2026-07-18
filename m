Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2051823C4F3
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 06:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784357122; cv=none; b=MLwsXdFm3DEqCUZ4wA/FbLsDis38IGXRe5Bex5L8JSy4YF3E6j7CySZFLRXgS+6PRCQTySW01I6usO4jptslffLgrBlyarTuE8UT2L3x1qGmaR4uo8aQ2arPT1WjyU/003UZkK79PIRszzuLPLhaV76qYk3WcBYlJfIPF0vJY7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784357122; c=relaxed/simple;
	bh=OE6TGJKu0YKlEf301c9ZOH142s6H5QVMJH+X9VkY4ak=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AT4CTMWH5MFOyYq014EOVw2fZIafGOA8t1SxiiwhIWO1RDdBusjJNiYTu1uSjFoiUFjC/rtgj6W1Pv5dXwTXEVpXw33eu8ow+sxyPz8EW0VOyoiyYXSH5fGeDtjM0RB2YE1IOX/e/U+jqMvn62LCk9iS91+wXPUulrSCqkSj/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mIiPs6hB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mIiPs6hB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784357120; x=1815893120;
  h=date:from:to:cc:subject:message-id;
  bh=OE6TGJKu0YKlEf301c9ZOH142s6H5QVMJH+X9VkY4ak=;
  b=mIiPs6hBlZKiqX6jjsnSSSiYGWhlhNBX5uFHkZs/cre8rFS1C9QVapcP
   4nRQkVrwQ+T9Le1OjNozjwNh37ONad/MdPaU5y9cHXU+iOd9ozyvifum2
   o0AhMwc45enSBJhUUD4uuKh2137kDPmxxf/UdAniFkQ2Xp+Fsvq8RNinn
   t6k3vcenMr2tZ+rtXquqtsrk8ICTKcVHDXQd4OzrKhG6YgSIUiE2Q8wyC
   rTRNGZIxg8YQ+qEute9FlddThdJ95Mfb+3ts6g/iNoEERPu+2K3QlO7w8
   VedyjDWnVjNgsudxGicxeq0CVa2UT3cHDxa3xANFOUQwZn3S79CzfqKSm
   g==;
X-CSE-ConnectionGUID: A4mhL8RVTruoOoPqTEXbmQ==
X-CSE-MsgGUID: HH7MuVASRwCd0JkdHuf53w==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="102568952"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="102568952"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 23:45:19 -0700
X-CSE-ConnectionGUID: MMdUJ0RXSCug6wZ/kHeOWg==
X-CSE-MsgGUID: pI8Kc1V6SsulnH6pB9Ztow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="281427746"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 17 Jul 2026 23:45:18 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wkynH-00000000TX5-1wfd;
	Sat, 18 Jul 2026 06:45:06 +0000
Date: Sat, 18 Jul 2026 14:44:54 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 af071d9e07e57cfff239e8d09d2f3b05ebc9c667
Message-ID: <202607181443.JkMSCm4V-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: af071d9e07e57cfff239e8d09d2f3b05ebc9c667  serial: sc16is7xx: implement gpio get_direction() callback

elapsed time: 752m

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
