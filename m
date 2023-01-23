Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021BCC05027
	for <linux-serial@archiver.kernel.org>; Mon, 23 Jan 2023 04:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjAWEN7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 22 Jan 2023 23:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjAWEN6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 22 Jan 2023 23:13:58 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FAEB75F
        for <linux-serial@vger.kernel.org>; Sun, 22 Jan 2023 20:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674447237; x=1705983237;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=apFwENabD7HCPLbiquQLbfy8hovH8b7o7eV6J6UHHRc=;
  b=fEPt2Nos+tEjddQLLIBESYfAGYQmUd6CNn5KNP1tkAy/WPKYRJ20dxYX
   Z3PqsKqpa994/dMACXqJSDXZ7XfAsSW8uNc5+IWqCOgamWr60DM/udNuv
   XuPUDk9WF/S65TGX5/DcQxY0Qmb3iduzJ2Ez2/XiitHi8cwmOdgjYJ30R
   iuzF90u/OXq/XmWbWmxCAw6KYSWyvXqJnpJHP2uD1tKNXQGXlBdEnJoph
   nB83Lu1HIY7AGZTxWdYBoSyTFT1UzW9OcTss387RjG0fmrn8z6F9SwpuC
   YhkKv18YX2wRaHeLWJ9ftn9prT3p84julGl5LLK/3R1CCyS1Qkn7XuLnI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="328058839"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="328058839"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 20:13:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="835330749"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="835330749"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Jan 2023 20:13:55 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJoDS-0005PQ-2b;
        Mon, 23 Jan 2023 04:13:54 +0000
Date:   Mon, 23 Jan 2023 12:13:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD REGRESSION
 7a6aa989f2e844a22cfab5c8ff30e77d17dabb2f
Message-ID: <63ce0955.zPL+AAYM8L6zdVxw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 7a6aa989f2e844a22cfab5c8ff30e77d17dabb2f  Merge 6.2-rc5 into tty-next

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202301230337.8Ta23Xqp-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/tty/serial/qcom_geni_serial.c:1058:12: error: no member named 'rx_fifo' in 'struct qcom_geni_serial_port'

Error/Warning ids grouped by kconfigs:

clang_recent_errors
|-- hexagon-randconfig-r041-20230122
|   `-- drivers-tty-serial-qcom_geni_serial.c:error:no-member-named-rx_fifo-in-struct-qcom_geni_serial_port
`-- s390-randconfig-r012-20230123
    `-- drivers-tty-serial-qcom_geni_serial.c:error:no-member-named-rx_fifo-in-struct-qcom_geni_serial_port

elapsed time: 722m

configs tested: 76
configs skipped: 2

gcc tested configs:
x86_64                            allnoconfig
i386                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
x86_64                              defconfig
i386                          randconfig-a016
x86_64                               rhel-8.3
x86_64               randconfig-a002-20230123
arm                        shmobile_defconfig
x86_64                           allyesconfig
x86_64               randconfig-a001-20230123
sh                          rsk7264_defconfig
arc                                 defconfig
x86_64               randconfig-a004-20230123
sh                        sh7785lcr_defconfig
x86_64               randconfig-a003-20230123
parisc                           alldefconfig
alpha                               defconfig
arm                                 defconfig
x86_64               randconfig-a005-20230123
x86_64                           rhel-8.3-syz
i386                          randconfig-a014
sh                               allmodconfig
ia64                             allmodconfig
i386                          randconfig-a012
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig
arc                  randconfig-r043-20230123
alpha                            allyesconfig
x86_64               randconfig-a006-20230123
x86_64                         rhel-8.3-kunit
s390                                defconfig
arm                              allyesconfig
arc                  randconfig-r043-20230122
m68k                             allyesconfig
arm64                            allyesconfig
i386                          randconfig-a001
arm                  randconfig-r046-20230123
riscv                randconfig-r042-20230122
powerpc                          allmodconfig
arc                              allyesconfig
x86_64                          rhel-8.3-func
i386                          randconfig-a003
s390                             allmodconfig
powerpc                      cm5200_defconfig
mips                             allyesconfig
s390                 randconfig-r044-20230122
x86_64                           rhel-8.3-kvm
s390                             allyesconfig
x86_64                           rhel-8.3-bpf
i386                             allyesconfig
i386                          randconfig-a005

clang tested configs:
i386                          randconfig-a015
i386                          randconfig-a006
x86_64               randconfig-a011-20230123
hexagon              randconfig-r041-20230123
x86_64               randconfig-a012-20230123
hexagon              randconfig-r045-20230122
x86_64               randconfig-a014-20230123
x86_64               randconfig-a016-20230123
hexagon              randconfig-r045-20230123
x86_64               randconfig-a013-20230123
arm                         hackkit_defconfig
x86_64               randconfig-a015-20230123
i386                          randconfig-a013
arm                         lpc32xx_defconfig
i386                          randconfig-a011
s390                 randconfig-r044-20230123
arm                  randconfig-r046-20230122
hexagon              randconfig-r041-20230122
arm                          pcm027_defconfig
riscv                randconfig-r042-20230123
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a004
powerpc                          allmodconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
