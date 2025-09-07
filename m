Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089FE25CC75
	for <linux-serial@vger.kernel.org>; Sun,  7 Sep 2025 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757244836; cv=none; b=Vs52govccRB0v6jJr+XfO3L/+M+x4ATq9Wp2KAEu5DJu3vZF8CsKldxBd3p1Rn6hThlFQWc7CPKqXMzAxknN8ibhA2vG4LuQOzBryYxUJzygAQjVaSidKyu2/S4ZMP0ThAawoPPiX1cCj8erq2oyOYU0u5ZSzMxFcqkaBbZ/NQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757244836; c=relaxed/simple;
	bh=JWP8HnMSTgV6OY2AU3YsJB65GVkE/s97ppEVqZDeO9E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=O/7EJb4suCokUxGEeD9lq0z9UBUEXT8SBb8QkjnSkGtwcBBDqG9arA1w6MtUeWSuJdAJ2dWfnN/bxEJRTCbwhWn1IhuEDWW98b6WvZtauqiMrgLVv7YCSeKbfY9xRbqNNMERoKBR1zjSJgd/yNPsc7Gz+RjEwil7b00XPv6E1xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WEH3dCU/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WEH3dCU/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757244834; x=1788780834;
  h=date:from:to:cc:subject:message-id;
  bh=JWP8HnMSTgV6OY2AU3YsJB65GVkE/s97ppEVqZDeO9E=;
  b=WEH3dCU/RR5d5rxqE1CsVhHfsSWfr7Pfzw5au3PR3YuRGTVYz/K9058q
   Ip8lFI8FwyzMUBT6CAIl/YzTXBe+vsTgFuE6mn8aN2VTWiGSkm9O7qaiU
   96pNI23OD+TqiMlLelkJylbsGRM+bqHdrOTgtYIxz28rwOCoK7kwOICdY
   2joD8l/MtiOXtlo4lRUGtW40+QnR760mD12GCfvobCXO5XDz1XWkSJTqZ
   qgg5MDY3bcd4nLEmRZyvawQOuJPCcZeGklYkCyOeFWPRUo7hKsiRwYB9B
   4yfXOFr9uXniSWTliRb5PMV+sVGzECIyTBgOdC2Nf0UH8OKHotMvHqDyd
   g==;
X-CSE-ConnectionGUID: tQDhNxOITqejK3t41TFNJg==
X-CSE-MsgGUID: 5GkvaozBRVOZ5p3b3/lsag==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="59597709"
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="59597709"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 04:33:51 -0700
X-CSE-ConnectionGUID: LxAAWpCsQ2qJ74NiR7nStw==
X-CSE-MsgGUID: jMVd9WAmTLi2qGnz84B9WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="176622098"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 Sep 2025 04:33:50 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvDeV-0002Dz-01;
	Sun, 07 Sep 2025 11:33:47 +0000
Date: Sun, 07 Sep 2025 19:32:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS WITH WARNING
 b601e1f41edd4667062aa7cccb4e5199814979a3
Message-ID: <202509071934.KpCOxMDL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: b601e1f41edd4667062aa7cccb4e5199814979a3  tty: remove redundant condition checks

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202509070003.ozCgvRti-lkp@intel.com

    Warning: drivers/tty/n_gsm.c:4175 function parameter 'dlci' not described in 'gsm_modem_send_initial_msc'

Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arc-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arc-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arc-randconfig-001-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arc-randconfig-002-20250906
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arm-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arm-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arm-randconfig-001-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arm64-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arm64-randconfig-001-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arm64-randconfig-003-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- csky-randconfig-002-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- hexagon-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- hexagon-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- hexagon-randconfig-002-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- i386-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- i386-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- i386-randconfig-011-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- i386-randconfig-013-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- i386-randconfig-141-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- loongarch-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- m68k-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- m68k-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- microblaze-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- microblaze-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- nios2-randconfig-001-20250907
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
|-- powerpc-randconfig-003-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- powerpc64-randconfig-003-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- riscv-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- riscv-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- riscv-randconfig-001-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- riscv-randconfig-r071-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- s390-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- s390-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- sh-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- sh-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- sparc-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- um-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- um-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- um-randconfig-001-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-buildonly-randconfig-002-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-randconfig-002-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-randconfig-006-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-randconfig-072-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-randconfig-074-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-randconfig-076-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-randconfig-077-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-randconfig-161-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-rhel-9.4
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-rhel-9.4-bpf
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-rhel-9.4-func
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-rhel-9.4-kselftests
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-rhel-9.4-kunit
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-rhel-9.4-ltp
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-rhel-9.4-rust
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- xtensa-randconfig-001-20250907
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- xtensa-randconfig-002-20250906
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
`-- xtensa-randconfig-002-20250907
    `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc

elapsed time: 1282m

configs tested: 233
configs skipped: 4

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                        nsim_700_defconfig    gcc-15.1.0
arc                   randconfig-001-20250906    gcc-14.3.0
arc                   randconfig-001-20250907    clang-22
arc                   randconfig-002-20250906    gcc-10.5.0
arc                   randconfig-002-20250907    clang-22
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   randconfig-001-20250906    clang-22
arm                   randconfig-001-20250907    clang-22
arm                   randconfig-002-20250906    clang-22
arm                   randconfig-002-20250907    clang-22
arm                   randconfig-003-20250906    gcc-13.4.0
arm                   randconfig-003-20250907    clang-22
arm                   randconfig-004-20250906    gcc-10.5.0
arm                   randconfig-004-20250907    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250906    gcc-8.5.0
arm64                 randconfig-001-20250907    clang-22
arm64                 randconfig-002-20250906    gcc-12.5.0
arm64                 randconfig-002-20250907    clang-22
arm64                 randconfig-003-20250906    clang-22
arm64                 randconfig-003-20250907    clang-22
arm64                 randconfig-004-20250906    gcc-9.5.0
arm64                 randconfig-004-20250907    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250907    gcc-11.5.0
csky                  randconfig-001-20250907    gcc-15.1.0
csky                  randconfig-002-20250907    gcc-11.5.0
csky                  randconfig-002-20250907    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250907    clang-17
hexagon               randconfig-001-20250907    gcc-11.5.0
hexagon               randconfig-002-20250907    clang-22
hexagon               randconfig-002-20250907    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250906    clang-20
i386        buildonly-randconfig-001-20250907    clang-20
i386        buildonly-randconfig-002-20250906    gcc-11
i386        buildonly-randconfig-002-20250907    clang-20
i386        buildonly-randconfig-003-20250906    gcc-13
i386        buildonly-randconfig-003-20250907    clang-20
i386        buildonly-randconfig-004-20250906    gcc-13
i386        buildonly-randconfig-004-20250907    clang-20
i386        buildonly-randconfig-005-20250906    clang-20
i386        buildonly-randconfig-005-20250907    clang-20
i386        buildonly-randconfig-006-20250906    clang-20
i386        buildonly-randconfig-006-20250907    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250907    gcc-13
i386                  randconfig-002-20250907    gcc-13
i386                  randconfig-003-20250907    gcc-13
i386                  randconfig-004-20250907    gcc-13
i386                  randconfig-005-20250907    gcc-13
i386                  randconfig-006-20250907    gcc-13
i386                  randconfig-007-20250907    gcc-13
i386                  randconfig-011-20250907    gcc-13
i386                  randconfig-012-20250907    gcc-13
i386                  randconfig-013-20250907    gcc-13
i386                  randconfig-014-20250907    gcc-13
i386                  randconfig-015-20250907    gcc-13
i386                  randconfig-016-20250907    gcc-13
i386                  randconfig-017-20250907    gcc-13
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250907    clang-22
loongarch             randconfig-001-20250907    gcc-11.5.0
loongarch             randconfig-002-20250907    clang-22
loongarch             randconfig-002-20250907    gcc-11.5.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    gcc-15.1.0
mips                        omega2p_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250907    gcc-11.5.0
nios2                 randconfig-002-20250907    gcc-11.5.0
openrisc                         alldefconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-13
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250907    gcc-11.5.0
parisc                randconfig-001-20250907    gcc-9.5.0
parisc                randconfig-002-20250907    gcc-11.5.0
parisc                randconfig-002-20250907    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250907    gcc-11.5.0
powerpc               randconfig-001-20250907    gcc-9.5.0
powerpc               randconfig-002-20250907    clang-22
powerpc               randconfig-002-20250907    gcc-11.5.0
powerpc               randconfig-003-20250907    gcc-11.5.0
powerpc               randconfig-003-20250907    gcc-15.1.0
powerpc                  storcenter_defconfig    gcc-15.1.0
powerpc                     tqm8555_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250907    gcc-11.5.0
powerpc64             randconfig-001-20250907    gcc-13.4.0
powerpc64             randconfig-002-20250907    clang-22
powerpc64             randconfig-002-20250907    gcc-11.5.0
powerpc64             randconfig-003-20250907    clang-22
powerpc64             randconfig-003-20250907    gcc-11.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-13
riscv                 randconfig-001-20250906    gcc-13.4.0
riscv                 randconfig-001-20250907    gcc-12.5.0
riscv                 randconfig-002-20250906    gcc-8.5.0
riscv                 randconfig-002-20250907    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-13
s390                  randconfig-001-20250906    gcc-10.5.0
s390                  randconfig-001-20250907    gcc-12.5.0
s390                  randconfig-002-20250906    clang-22
s390                  randconfig-002-20250907    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-13
sh                          polaris_defconfig    gcc-15.1.0
sh                    randconfig-001-20250906    gcc-15.1.0
sh                    randconfig-001-20250907    gcc-12.5.0
sh                    randconfig-002-20250906    gcc-12.5.0
sh                    randconfig-002-20250907    gcc-12.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250906    gcc-8.5.0
sparc                 randconfig-001-20250907    gcc-12.5.0
sparc                 randconfig-002-20250906    gcc-13.4.0
sparc                 randconfig-002-20250907    gcc-12.5.0
sparc                       sparc64_defconfig    gcc-15.1.0
sparc64                             defconfig    gcc-13
sparc64               randconfig-001-20250906    clang-22
sparc64               randconfig-001-20250907    gcc-12.5.0
sparc64               randconfig-002-20250906    gcc-14.3.0
sparc64               randconfig-002-20250907    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-13
um                                  defconfig    gcc-13
um                             i386_defconfig    gcc-13
um                    randconfig-001-20250906    gcc-12
um                    randconfig-001-20250907    gcc-12.5.0
um                    randconfig-002-20250906    clang-22
um                    randconfig-002-20250907    gcc-12.5.0
um                           x86_64_defconfig    gcc-13
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250906    clang-20
x86_64      buildonly-randconfig-001-20250907    gcc-13
x86_64      buildonly-randconfig-002-20250906    gcc-13
x86_64      buildonly-randconfig-002-20250907    gcc-13
x86_64      buildonly-randconfig-003-20250906    gcc-13
x86_64      buildonly-randconfig-003-20250907    gcc-13
x86_64      buildonly-randconfig-004-20250906    clang-20
x86_64      buildonly-randconfig-004-20250907    gcc-13
x86_64      buildonly-randconfig-005-20250906    gcc-13
x86_64      buildonly-randconfig-005-20250907    gcc-13
x86_64      buildonly-randconfig-006-20250906    gcc-13
x86_64      buildonly-randconfig-006-20250907    gcc-13
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250907    clang-20
x86_64                randconfig-002-20250907    clang-20
x86_64                randconfig-003-20250907    clang-20
x86_64                randconfig-004-20250907    clang-20
x86_64                randconfig-005-20250907    clang-20
x86_64                randconfig-006-20250907    clang-20
x86_64                randconfig-007-20250907    clang-20
x86_64                randconfig-008-20250907    clang-20
x86_64                randconfig-071-20250907    gcc-13
x86_64                randconfig-072-20250907    gcc-13
x86_64                randconfig-073-20250907    gcc-13
x86_64                randconfig-074-20250907    gcc-13
x86_64                randconfig-075-20250907    gcc-13
x86_64                randconfig-076-20250907    gcc-13
x86_64                randconfig-077-20250907    gcc-13
x86_64                randconfig-078-20250907    gcc-13
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-13
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-13
x86_64                           rhel-9.4-ltp    gcc-13
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250906    gcc-12.5.0
xtensa                randconfig-001-20250907    gcc-12.5.0
xtensa                randconfig-002-20250906    gcc-10.5.0
xtensa                randconfig-002-20250907    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
