Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CD82EC0A6
	for <linux-serial@vger.kernel.org>; Tue,  4 Aug 2026 04:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785816888; cv=none; b=urwsOIlA3NsC9H9j4FdMt/P1ek5Ou2HzrinJVfJfo8GrVRH1l/gAA2qZg8HdMvCUJmKq/bTZBU+2Ul8v7WugF+2BY6pUvZyHhIp/a52om/N0XphcVKAr+ogWG9waTPmO2ftuTik7WD0+EdR/jgbmUPHlSo7TsdMVprnNFHCoGPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785816888; c=relaxed/simple;
	bh=nMg1ANsYFJ0UWTaVv8+MDU7yGfGYUwYI6UHIIBY0Y0U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=u4adFjms7h3RlrcBmf8hpz3cK0TzoicoleM9vrgU/8O04SEWmi6gesHfNHrDsixv9hNk3hmbzHbwFf+Sg2mgjNGu9cWtJmKtpP+iAx8epMlhg2hYnViBdtHNqCgXtewx+TeQ8ZU0X4T7XNTkWhYp7kF5a+6j+WmJGAbC1/1KP5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XPBpiSHK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XPBpiSHK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785816886; x=1817352886;
  h=date:from:to:cc:subject:message-id;
  bh=nMg1ANsYFJ0UWTaVv8+MDU7yGfGYUwYI6UHIIBY0Y0U=;
  b=XPBpiSHKtc+pSe8dy0FOIxo3HQwOz/m3v9s/2qe3k9meBiztzW/WG9v/
   oiIlx3ZyM2B8r2R1HDI5mBMPgh88Klm68GnFuXjWdYN4IuZ7RaJI9Lhi9
   VGvBndL1g0H5UMJky8NnPdNXVb7G0pbE0AtjgxrkcL8GZ+ASF8vOoJ6lp
   Z5wBytexJoDmooTN4ZPL2MvWzsF2TDSjBINg8QCmhCKnJzVl4lg61+78+
   KqWrC81UwwK53E5bdM5bx9www2/ihQkWwlx6gVENC0D/+jqKaZAUzHNhk
   DPb2mj/aKlDHOBGDKyqaLE/oB1dzVZrzLg9nuv26ZJR787pnjquJHwyns
   w==;
X-CSE-ConnectionGUID: LBQjnaivQiW56WLoXe5JRQ==
X-CSE-MsgGUID: W/9JKR/rRrmb7tQPRmMeVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="97868129"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="97868129"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 21:14:46 -0700
X-CSE-ConnectionGUID: pjMvUc9RTjW0f116paBC9g==
X-CSE-MsgGUID: XPEesD1CTOuZ6yuTpQfTNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="286049313"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 03 Aug 2026 21:14:44 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wr6Y5-000000008uf-43yI;
	Tue, 04 Aug 2026 04:14:41 +0000
Date: Tue, 04 Aug 2026 12:14:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 8b0b29fdcb47907ae0296b8fe829e918e05e300f
Message-ID: <202608041229.bSAJk4kn-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 8b0b29fdcb47907ae0296b8fe829e918e05e300f  serial: imx: serialize imx_uart_ports[] lifetime

elapsed time: 790m

configs tested: 52
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                  allnoconfig    gcc-16.1.0
alpha                 allyesconfig    gcc-16.1.0
alpha                    defconfig    gcc-16.1.0
arc                   allmodconfig    gcc-16.1.0
arc                   allyesconfig    gcc-16.1.0
arc        randconfig-001-20260804    gcc-15.2.0
arm        randconfig-002-20260804    gcc-15.2.0
arm        randconfig-004-20260804    gcc-8.5.0
csky                  allmodconfig    gcc-16.1.0
csky       randconfig-001-20260804    gcc-9.5.0
csky       randconfig-002-20260804    gcc-11.5.0
hexagon    randconfig-001-20260804    clang-24
hexagon    randconfig-002-20260804    clang-24
i386                  allmodconfig    gcc-14
i386       randconfig-001-20260804    gcc-14
i386       randconfig-002-20260804    gcc-14
i386       randconfig-003-20260804    gcc-14
i386       randconfig-004-20260804    gcc-14
i386       randconfig-005-20260804    gcc-14
i386       randconfig-006-20260804    clang-22
i386       randconfig-007-20260804    gcc-14
i386       randconfig-013-20260804    clang-22
i386       randconfig-016-20260804    gcc-13
loongarch                defconfig    clang-24
loongarch  randconfig-001-20260804    clang-24
loongarch  randconfig-002-20260804    gcc-16.1.0
nios2                  allnoconfig    gcc-11.5.0
nios2      randconfig-001-20260804    gcc-8.5.0
nios2      randconfig-002-20260804    gcc-11.5.0
parisc                allmodconfig    gcc-16.1.0
parisc                allyesconfig    gcc-16.1.0
parisc                   defconfig    gcc-16.1.0
parisc     randconfig-001-20260804    gcc-8.5.0
parisc     randconfig-002-20260804    gcc-8.5.0
powerpc    randconfig-001-20260804    clang-24
powerpc    randconfig-002-20260804    gcc-11.5.0
powerpc64  randconfig-001-20260804    gcc-8.5.0
powerpc64  randconfig-002-20260804    gcc-8.5.0
riscv      randconfig-002-20260804    gcc-13.4.0
s390       randconfig-002-20260804    clang-18
sh                       defconfig    gcc-16.1.0
sh         randconfig-001-20260804    gcc-16.1.0
sh         randconfig-002-20260804    gcc-16.1.0
sh                se7206_defconfig    gcc-16.1.0
sparc      randconfig-001-20260804    gcc-16.1.0
sparc      randconfig-002-20260804    gcc-16.1.0
sparc64    randconfig-001-20260804    clang-24
sparc64    randconfig-002-20260804    clang-20
um         randconfig-001-20260804    gcc-14
um         randconfig-002-20260804    gcc-14
xtensa     randconfig-001-20260804    gcc-8.5.0
xtensa     randconfig-002-20260804    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
