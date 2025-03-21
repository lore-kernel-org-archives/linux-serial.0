Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9478A13B59B
	for <linux-serial@vger.kernel.org>; Fri, 21 Mar 2025 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575140; cv=none; b=KeD5Tk/+E/rdcOML0Llg3SKLvYqPqACqh8QOvHmpMI+dTs6UNgG7LoUmqO/7Lqj5oLKRLX9Qlsvj0YpF7L9ynucdb5CiK0xcXbvvKu5VP3Q9pnV4XA5MnYSnLWRnvlqP/tGHQSEOuPanSN9+8amQkGGHyjXtnD55uZOVOw5InUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575140; c=relaxed/simple;
	bh=m9wCwJwzyK+L8m4XfZBvx/iUbMzBiAfaYKejor2AuXM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bmlBMdXw3gL86IONZ6oH04bLYKMePd0lhtr6xayQ7GcdGQ72lPTdFiAXhU2FX3rjdAlvo2dB1QHkty6EUp29mv+TXJPzwb+Bh4+FWhFbeBclD5C3+OlJAP37oqH63IXJtkoMakFuo9l+sFz8gY2m9BV9K+7fXez9xCJtNY/+2MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T6ygvfkV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T6ygvfkV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742575139; x=1774111139;
  h=date:from:to:cc:subject:message-id;
  bh=m9wCwJwzyK+L8m4XfZBvx/iUbMzBiAfaYKejor2AuXM=;
  b=T6ygvfkV6knHaa2TOqGvEjNqQdsoQxEyDAcs8Fmy7v4yBnEswolAtJAb
   QtoykTfzi0yVxlcfHpBeqqOGO2CD+9qxG+25vW72RN80MRtcxOL4LvHyk
   LtkdVC8sxFzwpgkDRUrKsFVUAIaSI5aKiKEegDFMDdD7afzp9LquBdzQJ
   qhTnsgnfx25B/uFKyr9o5zHD5ZPOyXG+aEt4x3JxzYw6KD7HK/WYtQ8Wh
   rsvPCLsxNI/qT5X+M5UL4ubaGSeipOjvNOd+hkj3x6ldZbxv6ODoaPNzW
   UPghAOCPXZ8GAGfbw25tgaeTesMWly+hiyYySS5qQZIsfaG6TRzI8GaHp
   A==;
X-CSE-ConnectionGUID: KcUZI4MaSEiEgtlQha1rGA==
X-CSE-MsgGUID: UvZyo2dTSHSjk4T2FdypJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43965450"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="43965450"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 09:38:58 -0700
X-CSE-ConnectionGUID: b23YR+H4Roe6Az+i2ILK0A==
X-CSE-MsgGUID: utz12jQxQvuh5PYSGgnBOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="146667045"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 21 Mar 2025 09:38:58 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvfOW-0001VV-0i;
	Fri, 21 Mar 2025 16:38:53 +0000
Date: Sat, 22 Mar 2025 00:38:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS WITH WARNING
 2790ce23951f0c497810c44ad60a126a59c8d84c
Message-ID: <202503220016.3u4wZnmn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 2790ce23951f0c497810c44ad60a126a59c8d84c  serial: stm32: do not deassert RS485 RTS GPIO prematurely

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202503210614.2qGlnbIq-lkp@intel.com

    drivers/tty/serial/fsl_lpuart.c:642:29: warning: unused variable 'sport' [-Wunused-variable]

Warning ids grouped by kconfigs:

recent_errors
|-- arc-allmodconfig
|   `-- drivers-tty-serial-fsl_lpuart.c:warning:unused-variable-sport
|-- arc-allyesconfig
|   `-- drivers-tty-serial-fsl_lpuart.c:warning:unused-variable-sport
|-- arm-allmodconfig
|   `-- drivers-tty-serial-fsl_lpuart.c:warning:unused-variable-sport
|-- arm-allyesconfig
|   `-- drivers-tty-serial-fsl_lpuart.c:warning:unused-variable-sport
|-- arm64-allmodconfig
|   `-- drivers-tty-serial-fsl_lpuart.c:warning:unused-variable-sport
|-- hexagon-allmodconfig
|   `-- drivers-tty-serial-fsl_lpuart.c:warning:unused-variable-sport
|-- hexagon-allyesconfig
|   `-- drivers-tty-serial-fsl_lpuart.c:warning:unused-variable-sport
|-- i386-allmodconfig
|   `-- drivers-tty-serial-fsl_lpuart.c:warning:unused-variable-sport
|-- i386-allyesconfig
|   `-- drivers-tty-serial-fsl_lpuart.c:warning:unused-variable-sport
|-- i386-buildonly-randconfig-006-20250321
|   `-- drivers-tty-serial-fsl_lpuart.c:warning:unused-variable-sport
|-- loongarch-allmodconfig
|   `-- drivers-tty-serial-fsl_lpuart.c:warning:unused-variable-sport
|-- microblaze-allmodconfig
|   `-- drivers-tty-serial-fsl_lpuart.c:warning:unused-variable-sport
|-- microblaze-allyesconfig
|   `-- drivers-tty-serial-fsl_lpuart.c:warning:unused-variable-sport
|-- parisc-allmodconfig
|   `-- drivers-tty-serial-fsl_lpuart.c:warning:unused-variable-sport
|-- parisc-allyesconfig
|   `-- drivers-tty-serial-fsl_lpuart.c:warning:unused-variable-sport
|-- powerpc-allmodconfig
|   `-- drivers-tty-serial-fsl_lpuart.c:warning:unused-variable-sport
|-- powerpc-allyesconfig
|   `-- drivers-tty-serial-fsl_lpuart.c:warning:unused-variable-sport
|-- riscv-allmodconfig
|   `-- drivers-tty-serial-fsl_lpuart.c:warning:unused-variable-sport
|-- riscv-allyesconfig
|   `-- drivers-tty-serial-fsl_lpuart.c:warning:unused-variable-sport
|-- sparc-allmodconfig
|   `-- drivers-tty-serial-fsl_lpuart.c:warning:unused-variable-sport
|-- x86_64-allyesconfig
|   `-- drivers-tty-serial-fsl_lpuart.c:warning:unused-variable-sport
`-- x86_64-buildonly-randconfig-003-20250321
    `-- drivers-tty-serial-fsl_lpuart.c:warning:unused-variable-sport

elapsed time: 1446m

configs tested: 86
configs skipped: 1

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250321    gcc-13.3.0
arc                   randconfig-002-20250321    gcc-11.5.0
arm                              allmodconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250321    clang-19
arm                   randconfig-002-20250321    gcc-9.3.0
arm                   randconfig-003-20250321    gcc-5.5.0
arm                   randconfig-004-20250321    clang-21
arm64                            allmodconfig    clang-19
arm64                 randconfig-001-20250321    gcc-5.5.0
arm64                 randconfig-002-20250321    gcc-5.5.0
arm64                 randconfig-003-20250321    clang-20
arm64                 randconfig-004-20250321    clang-21
csky                  randconfig-001-20250321    gcc-13.3.0
csky                  randconfig-002-20250321    gcc-13.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250321    clang-21
hexagon               randconfig-002-20250321    clang-16
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250321    clang-20
i386        buildonly-randconfig-002-20250321    clang-20
i386        buildonly-randconfig-003-20250321    clang-20
i386        buildonly-randconfig-004-20250321    clang-20
i386        buildonly-randconfig-005-20250321    clang-20
i386        buildonly-randconfig-006-20250321    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20250321    gcc-14.2.0
loongarch             randconfig-002-20250321    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
nios2                 randconfig-001-20250321    gcc-13.3.0
nios2                 randconfig-002-20250321    gcc-7.5.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250321    gcc-8.5.0
parisc                randconfig-002-20250321    gcc-6.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250321    clang-21
powerpc               randconfig-002-20250321    gcc-7.5.0
powerpc               randconfig-003-20250321    gcc-7.5.0
powerpc64             randconfig-001-20250321    gcc-5.5.0
powerpc64             randconfig-002-20250321    clang-16
powerpc64             randconfig-003-20250321    gcc-7.5.0
riscv                            allmodconfig    clang-21
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250321    clang-21
riscv                 randconfig-002-20250321    clang-21
s390                             allmodconfig    clang-18
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250321    clang-16
s390                  randconfig-002-20250321    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250321    gcc-7.5.0
sh                    randconfig-002-20250321    gcc-7.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20250321    gcc-12.4.0
sparc                 randconfig-002-20250321    gcc-6.5.0
sparc64               randconfig-001-20250321    gcc-10.5.0
sparc64               randconfig-002-20250321    gcc-6.5.0
um                               allmodconfig    clang-19
um                               allyesconfig    gcc-12
um                    randconfig-001-20250321    gcc-12
um                    randconfig-002-20250321    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250321    clang-20
x86_64      buildonly-randconfig-002-20250321    clang-20
x86_64      buildonly-randconfig-003-20250321    gcc-12
x86_64      buildonly-randconfig-004-20250321    clang-20
x86_64      buildonly-randconfig-005-20250321    clang-20
x86_64      buildonly-randconfig-006-20250321    clang-20
x86_64                              defconfig    gcc-11
xtensa                randconfig-001-20250321    gcc-6.5.0
xtensa                randconfig-002-20250321    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
