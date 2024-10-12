Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9003BDDC1
	for <linux-serial@vger.kernel.org>; Sat, 12 Oct 2024 02:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728701512; cv=none; b=gwU0PzbbC6f0didniHMUB4aWucLDuonsLLKDGMP0060KyrCBWsPGKhLyeccuDoL4Q+imbqfmcOyWOqtnfKBeiZ01MKiRqDM6x15ZImrlTa6LyHzeRQnWfelzglOuDSvOT2Zsnnyc7MJshGCmrfhm2fumr1FffluUpVFgnKwn9Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728701512; c=relaxed/simple;
	bh=9nBZvTxQhmQRFga6H2OtvAFHHX7gLDV5vJx/tpxbubA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YbXCjwzwhJiMUUjt3w7EngnBMrknkdBiLRH1MxVegnZ+Ba6aFqZWI3UZsGkxjjsJzK6uvD0+Laf2iWzj4KGCEapzOENq7IdHH62vb7zHCX0xos0d6IZDhiCDdF1fxi5aMKIGyki+ZfRDG6wie+Q+W3ghFj0sa15K0iMuonjGdWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H5iFWnbv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H5iFWnbv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728701511; x=1760237511;
  h=date:from:to:cc:subject:message-id;
  bh=9nBZvTxQhmQRFga6H2OtvAFHHX7gLDV5vJx/tpxbubA=;
  b=H5iFWnbvkvUYMHeG285cO7NYs3uJEWVmCcELc6Mcy03IGURiTwyolsWa
   zptomCnPJ274mBr+d8Jc1KarMmBvP6M9McQlVOv03/7E+R2M5XXHOfRJk
   +nTHgTHN38E8b/O9aCi2PRZlYiTzFZTTujerWpvmO0iuGdqaC3q5WVhDq
   8sAbayXgm0Mwo+YE7JW/MrQPcUesrHs7/ceVBD/GIlENQJpbzHLfBEGoQ
   cHxsBNQAVoi+Zn9EVmY9D3242wHzd3go94w5hCJOPF307SbbdY0DmfRrw
   U4j52rCoVN5LK8+FKOyAtTnvSdT8Vkt4opthskP8ELMbFKVAGS/wbMBQG
   g==;
X-CSE-ConnectionGUID: qDqNcIcKQemm9fyIzQFr/Q==
X-CSE-MsgGUID: 6u+46vv+QVG97Zk7sd0aaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39490428"
X-IronPort-AV: E=Sophos;i="6.11,197,1725346800"; 
   d="scan'208";a="39490428"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 19:51:50 -0700
X-CSE-ConnectionGUID: 7HQxJai5SSWPmwa5uuev3A==
X-CSE-MsgGUID: /3LYNAsnQMSp9wQfJVFVUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,197,1725346800"; 
   d="scan'208";a="81697862"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 Oct 2024 19:51:49 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szSEN-000Cyp-0I;
	Sat, 12 Oct 2024 02:51:47 +0000
Date: Sat, 12 Oct 2024 10:51:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 f5927d832bb823dbe827603a083f225911208cb6
Message-ID: <202410121056.OuhgaMBa-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: f5927d832bb823dbe827603a083f225911208cb6  serial: 8250_exar: Remove old exar_ee_read() and other unneeded code

elapsed time: 1139m

configs tested: 94
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241012    gcc-12
i386        buildonly-randconfig-002-20241012    gcc-12
i386        buildonly-randconfig-003-20241012    gcc-12
i386        buildonly-randconfig-004-20241012    gcc-12
i386        buildonly-randconfig-005-20241012    gcc-12
i386        buildonly-randconfig-006-20241012    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20241012    gcc-12
i386                  randconfig-002-20241012    gcc-12
i386                  randconfig-003-20241012    gcc-12
i386                  randconfig-004-20241012    gcc-12
i386                  randconfig-005-20241012    gcc-12
i386                  randconfig-006-20241012    gcc-12
i386                  randconfig-011-20241012    gcc-12
i386                  randconfig-012-20241012    gcc-12
i386                  randconfig-013-20241012    gcc-12
i386                  randconfig-014-20241012    gcc-12
i386                  randconfig-015-20241012    gcc-12
i386                  randconfig-016-20241012    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
