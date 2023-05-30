Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C722FC7EE23
	for <linux-serial@archiver.kernel.org>; Tue, 30 May 2023 23:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjE3Xgx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 May 2023 19:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjE3Xgw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 May 2023 19:36:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A8EB2
        for <linux-serial@vger.kernel.org>; Tue, 30 May 2023 16:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685489810; x=1717025810;
  h=date:from:to:cc:subject:message-id;
  bh=W34w2CML23YHqL5PuznHHxNJB5cifcQ/Grq4wTmyhnE=;
  b=NSQSHp0aCBw0DUGIHM9Zw9yh+ZtU8XR9osgrOXt9IiGq2HGcUvvwwSdw
   XSVdhwSlXRq5e0K2jpX71FGLmMKIYrRDs9hrh3lt9hRwiTQ4Ca8ptEej8
   j4CA474r401auJLgJMBgvt9PO7hU4BMnZuDXHqT7NPgLJfeBeEUw68Ilc
   BDCDtI9Q5y/BoKhxK38p1tUooVlnwP6v18KFepHEWT/uvDPcwi/bbEfbU
   qwIBdnJMDL3QLbe1aqUvvh5uVb3GM9mzTaKBB+j5KUie6rACXTzp6K2rL
   RW1nHO9RXhraEpw93fMYNMvD16atD480i4R4kHe/wRK6OiI8utRZGqDBm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="334696705"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="334696705"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 16:36:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="796456251"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="796456251"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 30 May 2023 16:36:49 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q48tV-0000uf-0o;
        Tue, 30 May 2023 23:36:49 +0000
Date:   Wed, 31 May 2023 07:35:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 7183c37fd53eee1e795206e625da12a5d7ec1e1a
Message-ID: <20230530233549.OzEnG%lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 7183c37fd53eee1e795206e625da12a5d7ec1e1a  serial: cpm_uart: Fix a COMPILE_TEST dependency

elapsed time: 723m

configs tested: 62
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230530   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i081-20230530   gcc  
i386                 randconfig-i082-20230530   gcc  
i386                 randconfig-i083-20230530   gcc  
i386                 randconfig-i084-20230530   gcc  
i386                 randconfig-i085-20230530   gcc  
i386                 randconfig-i086-20230530   gcc  
i386                 randconfig-r016-20230530   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r006-20230530   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r015-20230530   gcc  
microblaze   buildonly-randconfig-r005-20230530   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r013-20230530   clang
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230530   gcc  
openrisc             randconfig-r012-20230530   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230530   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r003-20230530   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x091-20230530   gcc  
x86_64               randconfig-x092-20230530   gcc  
x86_64               randconfig-x093-20230530   gcc  
x86_64               randconfig-x094-20230530   gcc  
x86_64               randconfig-x095-20230530   gcc  
x86_64               randconfig-x096-20230530   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
