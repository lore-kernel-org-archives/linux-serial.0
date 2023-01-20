Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAD3C38159
	for <linux-serial@archiver.kernel.org>; Fri, 20 Jan 2023 03:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjATDgl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Jan 2023 22:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjATDgl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Jan 2023 22:36:41 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DDA9431D
        for <linux-serial@vger.kernel.org>; Thu, 19 Jan 2023 19:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674185800; x=1705721800;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dHrkUaDdx3vDZMeA28QcTczdKzM+64VSeVAAPcOUfJo=;
  b=QsxpkC6WElQkzNRIiGVqiJgAUmjvOketdKrax0B445rW/pJ3GMTQ9P6h
   HinaQbkpgI8lOtD498maOL039STIYn7msDWwKFOCbrSSgisKflfj6Dm44
   aKj5oIOufc9nOjbNgMHHZge0PSGnUeIoCjT3KW6hdPrOIkt/bBLwUlEPX
   stDubcrBxxiah7d0G9OMEJGu9tgmzTkoEpZRm9ogXo3yWJ1XoGgrmuXO6
   JOJ61KHHZOqtdMExWC0D7wXrY0fcXX7mhpUBL9mpm3j2tX19dWLmkXK9p
   KWS7rpFUDYoK0O8mZiuZniV8jEGey7Jstw2VKiWjEaLilKtRSfpQsORXB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="323188900"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="323188900"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 19:36:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="768545454"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="768545454"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jan 2023 19:36:38 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIiCj-00028q-1l;
        Fri, 20 Jan 2023 03:36:37 +0000
Date:   Fri, 20 Jan 2023 11:36:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD REGRESSION
 5342ab0af45064cbdc773645b93ab70c24ee161f
Message-ID: <63ca0c40.fC8jTwGRSKjZloA7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 5342ab0af45064cbdc773645b93ab70c24ee161f  tty: serial: qcom_geni: avoid duplicate struct member init

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202301200130.ttBiTzfO-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/tty/serial/stm32-usart.c:804:62: error: 'flags' undeclared (first use in this function)
drivers/tty/serial/stm32-usart.c:808:62: error: 'flags' undeclared (first use in this function)

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- alpha-randconfig-c041-20230119
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- arc-allyesconfig
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- arc-buildonly-randconfig-r002-20230119
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- arm-allyesconfig
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- arm-defconfig
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- arm-randconfig-c043-20230119
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- arm-randconfig-r046-20230119
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- arm64-allyesconfig
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- ia64-allmodconfig
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- ia64-randconfig-s052-20230119
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- loongarch-randconfig-r026-20230119
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- m68k-allmodconfig
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- m68k-allyesconfig
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- m68k-randconfig-r015-20230119
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- mips-allyesconfig
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- nios2-randconfig-r005-20230119
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- openrisc-randconfig-r002-20230119
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- parisc-randconfig-r001-20230119
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- parisc-randconfig-r034-20230119
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- powerpc-allmodconfig
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- s390-allyesconfig
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- sh-allmodconfig
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- sparc-randconfig-r034-20230119
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)
|-- um-allmodconfig
|   `-- drivers-tty-serial-stm32-usart.c:error:flags-undeclared-(first-use-in-this-function)

elapsed time: 723m

configs tested: 65
configs skipped: 2

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
sh                               allmodconfig
arm                                 defconfig
arm                  randconfig-r046-20230119
powerpc                          allmodconfig
arc                  randconfig-r043-20230119
s390                                defconfig
x86_64                    rhel-8.3-kselftests
s390                             allyesconfig
mips                             allyesconfig
x86_64                          rhel-8.3-func
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                                defconfig
i386                             allyesconfig
m68k                          hp300_defconfig
sparc                       sparc32_defconfig
sparc64                          alldefconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
sh                          sdk7786_defconfig
parisc                              defconfig
xtensa                          iss_defconfig
sh                         ecovec24_defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                          rhel-8.3-rust
hexagon              randconfig-r045-20230119
hexagon              randconfig-r041-20230119
s390                 randconfig-r044-20230119
riscv                randconfig-r042-20230119
x86_64                        randconfig-k001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
powerpc                 mpc8315_rdb_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
