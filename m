Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA4F17278D
	for <linux-serial@vger.kernel.org>; Fri, 21 Jun 2024 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718971025; cv=none; b=YMWA1QzEoCBkLHKomrsgzNDJwFn7kTao/OloHbxwy89fakwdfEJAU2Ex9XrQiD8G/LeXcCONZOCfWV7EZ+AA9982BZWrwWQ0lV4fTIRorxu8iit9u3SwlfVxEQg/JL2+Nyc7N1NJhx3TfdSdrDLMN0E8XD9f3RbICN19Sz7GfKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718971025; c=relaxed/simple;
	bh=4VNLnD1wdWgfwwIfBt+yJ1fkPnqcTWHMzXsJztnPQW0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dRmahLg58R40HqyP481u1RU00MsNSiTdjm+rwH2eciJk1sdb1L2zdhshjg5OJPnU8D+V1atH4sJNKD1ZlHo6/pd9vCuNqXxlGm70+EvahJSpGy+OiqUakjaM23zDApdVpM2aER6qVwl1IkURcQgHJs9jzWHGlX3igY70R6fKRmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLHXlV6X; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLHXlV6X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718971023; x=1750507023;
  h=date:from:to:cc:subject:message-id;
  bh=4VNLnD1wdWgfwwIfBt+yJ1fkPnqcTWHMzXsJztnPQW0=;
  b=VLHXlV6Xr2e3JSTAGpdqA4FbsIS/v6NfOx8u1HfYXmSDdn2jqyT+q/dE
   2AIBaaAxDyC3+Lnz5L0yrv6KmaM7ZxVMYwBhGCPebdHtZW21J5xZ3+PLC
   GwtUf8SeS3xJxVggauJqBlNigAUHMpVi6KJVuGDY7Bl7RmyZX9jRp+IIM
   7xCZXszBWK7k4eodILfyZwKIOZYCO63Nv4XSLRfoHyK/JTAbDm3LxzIdP
   3sF9w57mG9jMsRmQmw6hTj+OzCg9TXC5jQzq1fSbUNT5zuTAZlagh+6r2
   owqdMTs5CAlNg7fO/RBOLC02ESSSto66E1RN5rZ7SB4Jp/KDUeNiFhu31
   g==;
X-CSE-ConnectionGUID: HFTDRpf+RJ2dNN8B8YwAmA==
X-CSE-MsgGUID: 0bTb/2CJTji2U1brRcvAMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="38523190"
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="38523190"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 04:57:03 -0700
X-CSE-ConnectionGUID: Xg7Rl7VCSN2tDr5WPg/PFw==
X-CSE-MsgGUID: pSnLKLnIQ2K8Q8SXYXYkSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="42676711"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 21 Jun 2024 04:57:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKct1-0008XO-1j;
	Fri, 21 Jun 2024 11:56:59 +0000
Date: Fri, 21 Jun 2024 19:56:11 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 bf14c18a2cbf65687c59a11f5e4824c4a0c8182b
Message-ID: <202406211908.08pLHLHg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: bf14c18a2cbf65687c59a11f5e4824c4a0c8182b  Merge tag 'v6.10-rc4' into tty-next

elapsed time: 4480m

configs tested: 59
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                                 defconfig   clang-14
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon                             defconfig   clang-19
i386         buildonly-randconfig-001-20240619   clang-18
i386         buildonly-randconfig-002-20240619   clang-18
i386         buildonly-randconfig-003-20240619   clang-18
i386         buildonly-randconfig-004-20240619   clang-18
i386         buildonly-randconfig-005-20240619   gcc-7
i386         buildonly-randconfig-006-20240619   gcc-7
i386                  randconfig-001-20240619   gcc-7
i386                  randconfig-002-20240619   gcc-7
i386                  randconfig-003-20240619   clang-18
i386                  randconfig-004-20240619   gcc-7
i386                  randconfig-005-20240619   clang-18
i386                  randconfig-006-20240619   gcc-9
i386                  randconfig-011-20240619   clang-18
i386                  randconfig-012-20240619   clang-18
i386                  randconfig-013-20240619   gcc-13
i386                  randconfig-014-20240619   clang-18
i386                  randconfig-015-20240619   clang-18
i386                  randconfig-016-20240619   gcc-13
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                           x86_64_defconfig   clang-15
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
