Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52808183CB7
	for <linux-serial@vger.kernel.org>; Thu,  1 Aug 2024 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722509551; cv=none; b=iOsX4hXuUrTiXFv1IV1pN9UCDuB4Gkgjv3tjIIyTEohc/+PuW+RluND7oBlIXe0Qpij4vStusuHYmUPmKAQQOFDJTgouHE5iiUl8NiJxbwwkOaLnNs6kfA0ka4azsSVlslzRESIYWm8EdC7CX1rSBaXWa69yWVUMXptZQZ63tJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722509551; c=relaxed/simple;
	bh=Q39snWrHCfo0XgnIckfoDiPOprhiXu5POiM+tUz/WYU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cf9Uom675V4aBx3LNkDuB13hiQkSZ/b+q6AK1/KLzSTuyx9jRF1O5/YqUeMRTaraQM5iLeiGqkBDtBzWbe/Pv0xywZlV4GDGT6ikuJKes/TwH0Q5jbUV0ClVmmCivUcPDQ3TKNylTe4en2Xm32IOGWrojRQB22FbRPQZYUxe5s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nclg9gnZ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nclg9gnZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722509549; x=1754045549;
  h=date:from:to:cc:subject:message-id;
  bh=Q39snWrHCfo0XgnIckfoDiPOprhiXu5POiM+tUz/WYU=;
  b=nclg9gnZ7j9w2j7dG/LleWK5pGU6DmoatUULhPUR1pXRWb6f+NIsZJxC
   GHvcXHOGwC9jUJfszIz34Ffed9Tv+vLCwMxLz/b4ZzyZbmzZ2bkxP5kAd
   03WHydtKsd1Lfo/GdEV0JG5ut3izt35OCr/uwX7tYHKv5lvG7NPZ68iW6
   N76BfcPtczvTqiCxRZk/N07QRpCjRNoNVb+p9M5zC3acbG5Ua0KsUjPdp
   0aEzUZ/+hljrgP3WNMwAi2Au4lbktYYeJiMvYwzQoGi7SP4nnUZwa1OKC
   gm+y2OzHIU0/Zyxsn2reGUWvDkgIVtzxVusd8yLmDHT4N2odjPGjE7Tlf
   g==;
X-CSE-ConnectionGUID: YiCTLDOASouHqo8sRm/N1A==
X-CSE-MsgGUID: jn0fcuuJQrqa2vcf07vaVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="31105782"
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="31105782"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 03:52:28 -0700
X-CSE-ConnectionGUID: dO4fesa4SMmrhXdZHe5zbA==
X-CSE-MsgGUID: NPh1Ln7IQhyd60aoZvPggw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="54972314"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 01 Aug 2024 03:52:28 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZTQ1-000vVD-26;
	Thu, 01 Aug 2024 10:52:25 +0000
Date: Thu, 01 Aug 2024 18:51:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 2108aa2a01d850f850ed6ccea4e447100df9ee82
Message-ID: <202408011829.mBblwVyT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 2108aa2a01d850f850ed6ccea4e447100df9ee82  dt-bindings: serial: renesas: Document RZ/G2M v3.0 (r8a774a3) scif

elapsed time: 1447m

configs tested: 224
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                         haps_hs_defconfig   gcc-13.2.0
arc                 nsimosci_hs_smp_defconfig   gcc-13.2.0
arc                   randconfig-001-20240801   gcc-13.2.0
arc                   randconfig-002-20240801   gcc-13.2.0
arc                        vdk_hs38_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                         bcm2835_defconfig   clang-20
arm                        clps711x_defconfig   gcc-13.3.0
arm                                 defconfig   gcc-13.2.0
arm                       imx_v4_v5_defconfig   gcc-13.3.0
arm                        keystone_defconfig   gcc-14.1.0
arm                         nhk8815_defconfig   gcc-13.3.0
arm                             pxa_defconfig   gcc-14.1.0
arm                   randconfig-001-20240801   gcc-13.2.0
arm                   randconfig-002-20240801   gcc-13.2.0
arm                   randconfig-003-20240801   gcc-13.2.0
arm                   randconfig-004-20240801   gcc-13.2.0
arm                          sp7021_defconfig   clang-20
arm                          sp7021_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240801   gcc-13.2.0
arm64                 randconfig-002-20240801   gcc-13.2.0
arm64                 randconfig-003-20240801   gcc-13.2.0
arm64                 randconfig-004-20240801   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240801   gcc-13.2.0
csky                  randconfig-002-20240801   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240731   clang-18
i386         buildonly-randconfig-001-20240801   gcc-9
i386         buildonly-randconfig-002-20240731   clang-18
i386         buildonly-randconfig-002-20240801   gcc-9
i386         buildonly-randconfig-003-20240731   clang-18
i386         buildonly-randconfig-003-20240801   gcc-9
i386         buildonly-randconfig-004-20240731   clang-18
i386         buildonly-randconfig-004-20240801   gcc-9
i386         buildonly-randconfig-005-20240731   clang-18
i386         buildonly-randconfig-005-20240801   gcc-9
i386         buildonly-randconfig-006-20240731   clang-18
i386         buildonly-randconfig-006-20240801   gcc-9
i386                                defconfig   clang-18
i386                  randconfig-001-20240731   clang-18
i386                  randconfig-001-20240801   gcc-9
i386                  randconfig-002-20240731   clang-18
i386                  randconfig-002-20240801   gcc-9
i386                  randconfig-003-20240731   clang-18
i386                  randconfig-003-20240801   gcc-9
i386                  randconfig-004-20240731   clang-18
i386                  randconfig-004-20240801   gcc-9
i386                  randconfig-005-20240731   clang-18
i386                  randconfig-005-20240801   gcc-9
i386                  randconfig-006-20240731   clang-18
i386                  randconfig-006-20240801   gcc-9
i386                  randconfig-011-20240731   clang-18
i386                  randconfig-011-20240801   gcc-9
i386                  randconfig-012-20240731   clang-18
i386                  randconfig-012-20240801   gcc-9
i386                  randconfig-013-20240731   clang-18
i386                  randconfig-013-20240801   gcc-9
i386                  randconfig-014-20240731   clang-18
i386                  randconfig-014-20240801   gcc-9
i386                  randconfig-015-20240731   clang-18
i386                  randconfig-015-20240801   gcc-9
i386                  randconfig-016-20240731   clang-18
i386                  randconfig-016-20240801   gcc-9
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240801   gcc-13.2.0
loongarch             randconfig-002-20240801   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          amiga_defconfig   gcc-14.1.0
m68k                          atari_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                        mvme147_defconfig   gcc-13.3.0
m68k                        mvme16x_defconfig   gcc-13.2.0
m68k                        stmark2_defconfig   gcc-13.3.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                        bcm63xx_defconfig   gcc-13.3.0
mips                      bmips_stb_defconfig   gcc-13.2.0
mips                           ci20_defconfig   gcc-14.1.0
mips                     loongson1c_defconfig   clang-20
mips                          malta_defconfig   clang-20
mips                      maltaaprp_defconfig   gcc-13.3.0
mips                        maltaup_defconfig   gcc-14.1.0
mips                           mtx1_defconfig   gcc-13.3.0
mips                           mtx1_defconfig   gcc-14.1.0
mips                         rt305x_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240801   gcc-13.2.0
nios2                 randconfig-002-20240801   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240801   gcc-13.2.0
parisc                randconfig-002-20240801   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      bamboo_defconfig   clang-20
powerpc                   bluestone_defconfig   gcc-13.2.0
powerpc                      cm5200_defconfig   gcc-13.2.0
powerpc                        fsp2_defconfig   gcc-13.3.0
powerpc                       holly_defconfig   gcc-13.2.0
powerpc                  iss476-smp_defconfig   clang-20
powerpc                     kmeter1_defconfig   gcc-13.3.0
powerpc                 linkstation_defconfig   gcc-13.2.0
powerpc                      mgcoge_defconfig   gcc-13.2.0
powerpc                 mpc834x_itx_defconfig   gcc-14.1.0
powerpc               mpc834x_itxgp_defconfig   gcc-13.3.0
powerpc                      pcm030_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240801   gcc-13.2.0
powerpc               randconfig-002-20240801   gcc-13.2.0
powerpc               randconfig-003-20240801   gcc-13.2.0
powerpc                    socrates_defconfig   gcc-13.2.0
powerpc                  storcenter_defconfig   clang-20
powerpc                     tqm5200_defconfig   gcc-14.1.0
powerpc                     tqm8548_defconfig   clang-20
powerpc64             randconfig-001-20240801   gcc-13.2.0
powerpc64             randconfig-002-20240801   gcc-13.2.0
powerpc64             randconfig-003-20240801   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240801   gcc-13.2.0
riscv                 randconfig-002-20240801   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240801   gcc-13.2.0
s390                  randconfig-002-20240801   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                         apsh4a3a_defconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                ecovec24-romimage_defconfig   gcc-14.1.0
sh                         ecovec24_defconfig   gcc-13.2.0
sh                            hp6xx_defconfig   gcc-13.3.0
sh                    randconfig-001-20240801   gcc-13.2.0
sh                    randconfig-002-20240801   gcc-13.2.0
sh                   rts7751r2dplus_defconfig   gcc-13.3.0
sh                   rts7751r2dplus_defconfig   gcc-14.1.0
sh                           se7751_defconfig   gcc-14.1.0
sh                     sh7710voipgw_defconfig   gcc-13.3.0
sh                   sh7770_generic_defconfig   gcc-13.3.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc64_defconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240801   gcc-13.2.0
sparc64               randconfig-002-20240801   gcc-13.2.0
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240801   gcc-13.2.0
um                    randconfig-002-20240801   gcc-13.2.0
um                           x86_64_defconfig   clang-20
um                           x86_64_defconfig   gcc-14.1.0
x86_64                           alldefconfig   gcc-13.3.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240801   clang-18
x86_64       buildonly-randconfig-002-20240801   clang-18
x86_64       buildonly-randconfig-003-20240801   clang-18
x86_64       buildonly-randconfig-004-20240801   clang-18
x86_64       buildonly-randconfig-005-20240801   clang-18
x86_64       buildonly-randconfig-006-20240801   clang-18
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240801   clang-18
x86_64                randconfig-002-20240801   clang-18
x86_64                randconfig-003-20240801   clang-18
x86_64                randconfig-004-20240801   clang-18
x86_64                randconfig-005-20240801   clang-18
x86_64                randconfig-006-20240801   clang-18
x86_64                randconfig-011-20240801   clang-18
x86_64                randconfig-012-20240801   clang-18
x86_64                randconfig-013-20240801   clang-18
x86_64                randconfig-014-20240801   clang-18
x86_64                randconfig-015-20240801   clang-18
x86_64                randconfig-016-20240801   clang-18
x86_64                randconfig-071-20240801   clang-18
x86_64                randconfig-072-20240801   clang-18
x86_64                randconfig-073-20240801   clang-18
x86_64                randconfig-074-20240801   clang-18
x86_64                randconfig-075-20240801   clang-18
x86_64                randconfig-076-20240801   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                           alldefconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240801   gcc-13.2.0
xtensa                randconfig-002-20240801   gcc-13.2.0
xtensa                    smp_lx200_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
