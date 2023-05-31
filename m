Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B109C7EE23
	for <linux-serial@archiver.kernel.org>; Wed, 31 May 2023 22:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjEaWY5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 31 May 2023 18:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjEaWYq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 May 2023 18:24:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64009F
        for <linux-serial@vger.kernel.org>; Wed, 31 May 2023 15:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685571884; x=1717107884;
  h=date:from:to:cc:subject:message-id;
  bh=5BqGz2niNk4R3wnvmtAWwnyhu3uPpQwHdiSn7mRfj5A=;
  b=G6wChxCc1vc+asP+JfhNqNDb+p8fyyxNOsrFjNIWLqG/Ure2BeB3ZA5Z
   RApRVdq8jZpIWcU5bcmb494ek0zv7Vmv/XU8T88uIZIuDbS6C2dk3TsmR
   gxRhrxFjLQLiNW8cWnjA8yPjERAhM1NdXDXUw2roRVAw0RGZeSNXGeLIL
   0IlzJNgfzL53Rt7Lr97KghYSLF6v34DVWgjM6pnu2h2biYj65k1Ttz9AN
   kMTXVxv1INdgEE54gVB93UUU2rKyH5T0XrHjNj4r037M0SnzntXEzIzHM
   +ROj3WtIFjtUmpR+0V3RY74qnQk7f06cTXlDR5NNCsfILR/DMHLTkCG/n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="418879866"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="418879866"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 15:24:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="701292184"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="701292184"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 31 May 2023 15:24:43 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4UFG-0001dz-1v;
        Wed, 31 May 2023 22:24:42 +0000
Date:   Thu, 01 Jun 2023 06:23:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 84a9582fd203063cd4d301204971ff2cd8327f1a
Message-ID: <20230531222343.pvgEu%lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 84a9582fd203063cd4d301204971ff2cd8327f1a  serial: core: Start managing serial controllers to enable runtime PM

elapsed time: 750m

configs tested: 52
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
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
i386                 randconfig-i011-20230531   clang
i386                 randconfig-i012-20230531   clang
i386                 randconfig-i013-20230531   clang
i386                 randconfig-i014-20230531   clang
i386                 randconfig-i015-20230531   clang
i386                 randconfig-i016-20230531   clang
i386                 randconfig-i091-20230531   gcc  
i386                 randconfig-i092-20230531   gcc  
i386                 randconfig-i093-20230531   gcc  
i386                 randconfig-i094-20230531   gcc  
i386                 randconfig-i095-20230531   gcc  
i386                 randconfig-i096-20230531   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
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
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
