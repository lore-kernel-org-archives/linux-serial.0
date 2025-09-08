Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B1E1F4191
	for <linux-serial@vger.kernel.org>; Mon,  8 Sep 2025 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371567; cv=none; b=UMpi6uoKAO7StYfG/8mrNEDXEzi4iNIEIOoQZSN5/4voReZndJHLYBmK6XYNVEp46rbvJHEBFpJbwxsUm8s2l/UFUobg8Dg5pLVUvO77QetDP8OFsDVbxLkXMGQNRVjuXCUGIZqbaJyj0Ad+9LnRiXpDhT4/qtKE4ymLGsHoan8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371567; c=relaxed/simple;
	bh=LbfiTeO32ykv5PDV+M7vk4/Mv8AfugcarHWekLbdnQA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aDB+vDHRj2K9T76GkHIsIJaKsRbe3/5mpeOoLSBQsi1Jz518RI2z8y7r7OLzCqydhiZyzvLO7rzldjjvI9qvAQs7bKjAM4H2Xn2dCg4j70ujs3qpQSyNDjqti/AFMEWeVdpFF6uPWEGS0lhuV+Cc9jS0+pR9qSjFTMSy4ffpUPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OitagNNE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OitagNNE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757371565; x=1788907565;
  h=date:from:to:cc:subject:message-id;
  bh=LbfiTeO32ykv5PDV+M7vk4/Mv8AfugcarHWekLbdnQA=;
  b=OitagNNEy2hHfZ27pMV0QVKk+8Z329JXpxC64RXx9oaNXq8lkl47UDL2
   RL1Eqzm67pNw8zMFZ0mjrhVLe1ae5KK62/+Xa1gG2hN+7EkZtErfh4ymU
   wTl19rPJ15smSu/bsSKfWlgBUWUhSd4AZK8OLuEFGe1rijVqccgZK68Tv
   XT/7bpAU9qq5P71dwGSGHiHVH8aGCRBs8WsiFi52nhuLLjuu91WM6l4g4
   OAU9aJ6Pi4dBxRUuLa1BGQ2b9wlkkst6QXEqqxmUVYhYRDlOvqWW1p4z0
   MlMbq7gYyjV4lk630wLkcgmq7HDyNQAemvUQjgT4eDJKbY8XBNqpBO1sB
   w==;
X-CSE-ConnectionGUID: tdSJHKLORPG9hZjvTuQK+Q==
X-CSE-MsgGUID: +dkihaTqQbuelribNFcQsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59594633"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59594633"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 15:46:05 -0700
X-CSE-ConnectionGUID: dQS9Zz0qToW2D4FWJOGS4g==
X-CSE-MsgGUID: gN+X9ItIRqy9NrGUjh3TiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="210068400"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 08 Sep 2025 15:46:04 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvkcb-0004DH-2C;
	Mon, 08 Sep 2025 22:46:01 +0000
Date: Tue, 09 Sep 2025 06:45:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS WITH WARNING
 e81783899d7d19cad567b68e115fcb37880e427b
Message-ID: <202509090619.VnM91gY8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: e81783899d7d19cad567b68e115fcb37880e427b  Revert "m68k: make HPDCA and HPAPCI bools"

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202509070003.ozCgvRti-lkp@intel.com

    Warning: drivers/tty/n_gsm.c:4175 function parameter 'dlci' not described in 'gsm_modem_send_initial_msc'

Warning ids grouped by kconfigs:

recent_errors
|-- arc-randconfig-001-20250908
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- csky-randconfig-002-20250908
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- hexagon-randconfig-001-20250908
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- hexagon-randconfig-002-20250908
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- i386-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- i386-buildonly-randconfig-002-20250908
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- openrisc-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- parisc-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- parisc-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- powerpc-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- powerpc-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- powerpc64-randconfig-002-20250908
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- riscv-randconfig-001-20250908
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- s390-randconfig-002-20250908
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- um-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-buildonly-randconfig-002-20250908
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-buildonly-randconfig-005-20250908
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
`-- x86_64-rhel-9.4-rust
    `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc

elapsed time: 787m

configs tested: 113
configs skipped: 3

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250908    gcc-8.5.0
arc                   randconfig-002-20250908    gcc-13.4.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250908    clang-22
arm                   randconfig-002-20250908    clang-22
arm                   randconfig-003-20250908    gcc-12.5.0
arm                   randconfig-004-20250908    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250908    clang-20
arm64                 randconfig-002-20250908    clang-16
arm64                 randconfig-003-20250908    gcc-9.5.0
arm64                 randconfig-004-20250908    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250908    gcc-14.3.0
csky                  randconfig-002-20250908    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250908    clang-17
hexagon               randconfig-002-20250908    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250908    gcc-13
i386        buildonly-randconfig-002-20250908    gcc-13
i386        buildonly-randconfig-003-20250908    gcc-13
i386        buildonly-randconfig-004-20250908    gcc-13
i386        buildonly-randconfig-005-20250908    clang-20
i386        buildonly-randconfig-006-20250908    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250908    gcc-15.1.0
loongarch             randconfig-002-20250908    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250908    gcc-8.5.0
nios2                 randconfig-002-20250908    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250908    gcc-13.4.0
parisc                randconfig-002-20250908    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250908    gcc-15.1.0
powerpc               randconfig-002-20250908    clang-19
powerpc               randconfig-003-20250908    gcc-9.5.0
powerpc64             randconfig-001-20250908    gcc-8.5.0
powerpc64             randconfig-002-20250908    gcc-10.5.0
powerpc64             randconfig-003-20250908    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250908    gcc-11.5.0
riscv                 randconfig-002-20250908    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250908    clang-22
s390                  randconfig-002-20250908    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250908    gcc-14.3.0
sh                    randconfig-002-20250908    gcc-14.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250908    gcc-8.5.0
sparc                 randconfig-002-20250908    gcc-12.5.0
sparc64               randconfig-001-20250908    gcc-13.4.0
sparc64               randconfig-002-20250908    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-13
um                               allyesconfig    gcc-14
um                    randconfig-001-20250908    gcc-13
um                    randconfig-002-20250908    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250908    clang-20
x86_64      buildonly-randconfig-002-20250908    gcc-13
x86_64      buildonly-randconfig-003-20250908    gcc-13
x86_64      buildonly-randconfig-004-20250908    gcc-11
x86_64      buildonly-randconfig-005-20250908    gcc-13
x86_64      buildonly-randconfig-006-20250908    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250908    gcc-9.5.0
xtensa                randconfig-002-20250908    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
