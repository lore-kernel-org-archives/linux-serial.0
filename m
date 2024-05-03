Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C521153584
	for <linux-serial@vger.kernel.org>; Fri,  3 May 2024 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744118; cv=none; b=E5uRg5VSNGY/A3vdl9nGnaA+/yKITi6NiZeutu7Nwq6132VctUykrv5j3PWS6NqzUUGJ4DWSMsXR+i9yGfyskb9ZP6T//8isjsgzK93hePISVt4563aQBCFuSWG+IzXdgDtQUmjtnrGiSUSoEgX13c/3APxOVL1jY+1hr+Mwpww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744118; c=relaxed/simple;
	bh=zvsIjGIgjDBIQhVVtOOMOFS6KsAb+bOhfvBgb4TilCk=;
	h=Date:From:To:Subject:Message-ID; b=Mt++i6w3HHKig7akxHTFMABrJW3qYTjoMj1yLKWLUbbM7CgtumpMSWOncevFTk0k6teh9QkufzpEn9Kka9djFxCNcHLTIVnf61TxOnLaKFiLu2li2PuIEW1iQWSYIPyKym0WeS6IreT+NHHx2WK7RFJHMXAYgdav7U2txdtHS7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lLLpGP1w; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLLpGP1w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714744117; x=1746280117;
  h=date:from:to:subject:message-id;
  bh=zvsIjGIgjDBIQhVVtOOMOFS6KsAb+bOhfvBgb4TilCk=;
  b=lLLpGP1wh/NqOyxucx3+19Dtmew+UTTMFhnfNJF9l/57nPjsPpfWdS3w
   sqFnQxvE4nbJihqopCyMJcQmE+oIk+k5ptRxDoQyv00hsRNMsPwtB3rSb
   9oZOMyhzCvSwvb9fcmEBTMP5Atno4R5ILjOZ4Vm71sF67KbBu3yMqXSQw
   wkv4iil4OkHGRZGaKXrw8pFN8ZjvjUyOBypZsWBSu9O6DAbHYUyAKbgxB
   iFr+aemHJl29sMBOYzsuNEQeX966TJ0i8/Nz/YIGjvjDlPZoKP/D9fSh3
   OQa2A4OR+vxXwrvhFhMcLaJXf72IdaLdZj9XZjGBIl1vgcZIh3mdi7cHC
   g==;
X-CSE-ConnectionGUID: ydfKWDfFS82I/EpmI0UkdA==
X-CSE-MsgGUID: w2i/JKDbQKq3I8HQzvW4lA==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="13500310"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="13500310"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 06:48:36 -0700
X-CSE-ConnectionGUID: Kr+qWHwtTk2EC9WxfKX0yg==
X-CSE-MsgGUID: nj8UpBqIQQKTZN6genLSng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27505311"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 03 May 2024 06:48:35 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2tH6-000Bji-0r
	for linux-serial@vger.kernel.org;
	Fri, 03 May 2024 13:48:32 +0000
Date: Fri, 03 May 2024 21:48:22 +0800
From: kernel test robot <lkp@intel.com>
To: linux-serial@vger.kernel.org
Subject: [BUILD SUCCESS] LAST PATCH: [PATCH v1 13/13] serial:
 8250_exar: Keep the includes sorted
Message-ID: <202405032120.urKSUwDv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/serial-8250_exar-Don-t-return-positive-values-as-error-codes/20240502-225048
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20240502144626.2716994-14-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 13/13] serial: 8250_exar: Keep the includes sorted

[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

elapsed time: 1356m

configs tested: 148
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240503   gcc  
arc                   randconfig-002-20240503   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        multi_v5_defconfig   gcc  
arm                   randconfig-004-20240503   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           sama5_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240503   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240503   gcc  
csky                  randconfig-002-20240503   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240503   clang
i386         buildonly-randconfig-002-20240503   clang
i386         buildonly-randconfig-003-20240503   gcc  
i386         buildonly-randconfig-004-20240503   gcc  
i386         buildonly-randconfig-005-20240503   gcc  
i386         buildonly-randconfig-006-20240503   clang
i386                                defconfig   clang
i386                  randconfig-001-20240503   gcc  
i386                  randconfig-002-20240503   clang
i386                  randconfig-003-20240503   clang
i386                  randconfig-004-20240503   gcc  
i386                  randconfig-005-20240503   clang
i386                  randconfig-006-20240503   clang
i386                  randconfig-011-20240503   clang
i386                  randconfig-012-20240503   gcc  
i386                  randconfig-013-20240503   gcc  
i386                  randconfig-014-20240503   gcc  
i386                  randconfig-015-20240503   gcc  
i386                  randconfig-016-20240503   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240503   gcc  
loongarch             randconfig-002-20240503   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240503   gcc  
nios2                 randconfig-002-20240503   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240503   gcc  
parisc                randconfig-002-20240503   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc               randconfig-003-20240503   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240503   gcc  
riscv                 randconfig-002-20240503   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240503   gcc  
s390                  randconfig-002-20240503   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                    randconfig-001-20240503   gcc  
sh                    randconfig-002-20240503   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240503   gcc  
sparc64               randconfig-002-20240503   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240503   gcc  
x86_64       buildonly-randconfig-002-20240503   gcc  
x86_64       buildonly-randconfig-003-20240503   gcc  
x86_64       buildonly-randconfig-005-20240503   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-004-20240503   gcc  
x86_64                randconfig-005-20240503   gcc  
x86_64                randconfig-076-20240503   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240503   gcc  
xtensa                randconfig-002-20240503   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
