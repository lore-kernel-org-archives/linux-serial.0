Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797FA20125A
	for <linux-serial@vger.kernel.org>; Tue,  2 Jul 2024 20:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719953753; cv=none; b=uXeTZvWTNDSzyVpQlRl3jBsH+ECXNwtERINzqRVL/0/ToivvgVz2NNLyKTAVP94qPgz+ZZ5Wkl6SG30iBpbPqlfRIsxqnRYWJHbgAMZEBLrzmpBcBRFkiroleUUG/5Yvqj5MeRxyBwQPbPxvTlNcHn/E8DKYrM1CuCb7CN72hBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719953753; c=relaxed/simple;
	bh=uUqtyjIBevpv3axTn89EiAqRZ9jg1h/EEqp6jZ6Wggw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ClBhb6xDajWSJlTgB4aYUPvsiCUDje8fQQWCBTtVD8tYqAjRQiS22VEIsb8s0RlAVrf+Tvq3t61b5Ms8Adkkq6JRdIS7B20j/41KZVAvuHgNYkHHLjWLvEVNng6T21ivtKLyCOE/D9P+2f5PwODQ+HhihcmyvexWQB1AjLJLOhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NMq378Nh; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NMq378Nh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719953751; x=1751489751;
  h=date:from:to:cc:subject:message-id;
  bh=uUqtyjIBevpv3axTn89EiAqRZ9jg1h/EEqp6jZ6Wggw=;
  b=NMq378NhD7Ro0kUU9NKvhXYjpWXiR4vsHOhcTS+Z1twFMbmbANvnuS0S
   5UiQigDVb6aPJLEXyHrWFEuvlMJjeYX5x9agVuxqIBJn4nSsb/qpnA7oD
   1JbCAFPW7RwJ9SQkP7udsUokwoF6dJjcXjZlAxaXjcMdMhqvGH/NU1+KL
   Z5HiLL15zDylEUriNTCfDBzqZ6mnjeMeN+r9iwsAkkkROja30t7iNA9vi
   YL9UbqKUiAteSIMWfMLOe2SvNDvmO6QOB1zn7p/wPIxoe1zIiUY3R1JzM
   EUDkj9TwBj7qZSKTBvxz/1ajmD/rDy/U3Tkt6VosP9qU37EmqXOicGAxq
   w==;
X-CSE-ConnectionGUID: DqxqugYnQp6+gbrwzzj3VA==
X-CSE-MsgGUID: GnHcPUNZQDm7xVk4iu7szg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17363626"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="17363626"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 13:55:50 -0700
X-CSE-ConnectionGUID: bsc/jiGOTKaV52qsM4pttQ==
X-CSE-MsgGUID: hhmNfzXZR2iVu3f8rAPIqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="46019860"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 02 Jul 2024 13:55:49 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sOkXT-000OfP-2k;
	Tue, 02 Jul 2024 20:55:47 +0000
Date: Wed, 03 Jul 2024 04:55:19 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 33827dc4ad8982c987ad4066d643693403ce7fd0
Message-ID: <202407030417.d2Mxw4Ai-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 33827dc4ad8982c987ad4066d643693403ce7fd0  Merge 6.10-rc6 into tty-next

elapsed time: 1905m

configs tested: 125
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                   randconfig-001-20240702   gcc-13.2.0
arc                   randconfig-002-20240702   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                   randconfig-001-20240702   gcc-13.2.0
arm                   randconfig-002-20240702   gcc-13.2.0
arm                   randconfig-003-20240702   gcc-13.2.0
arm                   randconfig-004-20240702   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240702   gcc-13.2.0
arm64                 randconfig-002-20240702   clang-19
arm64                 randconfig-002-20240702   gcc-13.2.0
arm64                 randconfig-003-20240702   gcc-13.2.0
arm64                 randconfig-004-20240702   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240702   gcc-13.2.0
csky                  randconfig-002-20240702   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon               randconfig-001-20240702   clang-19
hexagon               randconfig-002-20240702   clang-19
i386         buildonly-randconfig-001-20240702   gcc-13
i386         buildonly-randconfig-002-20240702   gcc-10
i386         buildonly-randconfig-002-20240702   gcc-13
i386         buildonly-randconfig-003-20240702   gcc-13
i386         buildonly-randconfig-004-20240702   clang-18
i386         buildonly-randconfig-004-20240702   gcc-13
i386         buildonly-randconfig-005-20240702   gcc-10
i386         buildonly-randconfig-005-20240702   gcc-13
i386         buildonly-randconfig-006-20240702   gcc-13
i386                  randconfig-001-20240702   gcc-10
i386                  randconfig-001-20240702   gcc-13
i386                  randconfig-002-20240702   gcc-12
i386                  randconfig-002-20240702   gcc-13
i386                  randconfig-003-20240702   gcc-13
i386                  randconfig-004-20240702   gcc-13
i386                  randconfig-005-20240702   gcc-10
i386                  randconfig-005-20240702   gcc-13
i386                  randconfig-006-20240702   clang-18
i386                  randconfig-006-20240702   gcc-13
i386                  randconfig-011-20240702   gcc-13
i386                  randconfig-011-20240702   gcc-9
i386                  randconfig-012-20240702   clang-18
i386                  randconfig-012-20240702   gcc-13
i386                  randconfig-013-20240702   gcc-11
i386                  randconfig-013-20240702   gcc-13
i386                  randconfig-014-20240702   clang-18
i386                  randconfig-014-20240702   gcc-13
i386                  randconfig-015-20240702   clang-18
i386                  randconfig-015-20240702   gcc-13
i386                  randconfig-016-20240702   clang-18
i386                  randconfig-016-20240702   gcc-13
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240702   gcc-13.2.0
loongarch             randconfig-002-20240702   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240702   gcc-13.2.0
nios2                 randconfig-002-20240702   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                randconfig-001-20240702   gcc-13.2.0
parisc                randconfig-002-20240702   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240702   gcc-13.2.0
powerpc               randconfig-002-20240702   clang-16
powerpc               randconfig-002-20240702   gcc-13.2.0
powerpc               randconfig-003-20240702   gcc-13.2.0
powerpc64             randconfig-001-20240702   clang-19
powerpc64             randconfig-001-20240702   gcc-13.2.0
powerpc64             randconfig-002-20240702   gcc-13.2.0
powerpc64             randconfig-003-20240702   clang-19
powerpc64             randconfig-003-20240702   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                 randconfig-001-20240702   gcc-13.2.0
riscv                 randconfig-002-20240702   gcc-13.2.0
s390                              allnoconfig   gcc-13.2.0
s390                  randconfig-001-20240702   clang-19
s390                  randconfig-001-20240702   gcc-13.2.0
s390                  randconfig-002-20240702   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                    randconfig-001-20240702   gcc-13.2.0
sh                    randconfig-002-20240702   gcc-13.2.0
sparc64               randconfig-001-20240702   gcc-13.2.0
sparc64               randconfig-002-20240702   gcc-13.2.0
um                                allnoconfig   gcc-13.2.0
um                    randconfig-001-20240702   gcc-13.2.0
um                    randconfig-001-20240702   gcc-8
um                    randconfig-002-20240702   gcc-13
um                    randconfig-002-20240702   gcc-13.2.0
x86_64       buildonly-randconfig-001-20240702   gcc-8
x86_64       buildonly-randconfig-002-20240702   clang-18
x86_64       buildonly-randconfig-003-20240702   clang-18
x86_64       buildonly-randconfig-004-20240702   clang-18
x86_64       buildonly-randconfig-005-20240702   gcc-13
x86_64       buildonly-randconfig-006-20240702   clang-18
x86_64                randconfig-001-20240702   clang-18
x86_64                randconfig-002-20240702   gcc-11
x86_64                randconfig-003-20240702   gcc-13
x86_64                randconfig-004-20240702   gcc-9
x86_64                randconfig-005-20240702   clang-18
x86_64                randconfig-006-20240702   gcc-13
x86_64                randconfig-011-20240702   clang-18
x86_64                randconfig-012-20240702   gcc-8
x86_64                randconfig-013-20240702   clang-18
x86_64                randconfig-014-20240702   gcc-13
x86_64                randconfig-015-20240702   gcc-13
x86_64                randconfig-016-20240702   clang-18
x86_64                randconfig-071-20240702   clang-18
x86_64                randconfig-072-20240702   gcc-13
x86_64                randconfig-073-20240702   gcc-8
x86_64                randconfig-074-20240702   clang-18
x86_64                randconfig-075-20240702   gcc-13
x86_64                randconfig-076-20240702   gcc-8
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240702   gcc-13.2.0
xtensa                randconfig-002-20240702   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
