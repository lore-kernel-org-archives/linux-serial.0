Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B80C636D3
	for <linux-serial@archiver.kernel.org>; Fri,  3 Feb 2023 02:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjBCCaQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Feb 2023 21:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjBCCaP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Feb 2023 21:30:15 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969282278F
        for <linux-serial@vger.kernel.org>; Thu,  2 Feb 2023 18:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675391414; x=1706927414;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=LzE9b4D8HAXqwnPUd6q/5VA1qc0z/DdCRj9RVtiSvF0=;
  b=EzMvQeXAqFYzX7WJbJ3i05YNnuco8zmiJA/ckKYnUbVfcIf78D9YYD6i
   wlFN65vC4G1pLxUHsC8ygvOugMC4W1EF7Cu6j55Xiq3Gu3vtD9nUBIozU
   vpfpt4ZzojvptfkyyJS67xk3VwJUjoX2+dNxSc3FIPs1qPrlJJqhopoIM
   SH2TTyauk21dca8c0bzDxuf6dWWWpJfbvKb+au5bgRzG5w2o3r77+Ztr4
   7Gq01YbardBkaSmC0X9Lcex/CC2zJrwAo7Un+E1IstnK7VQ4ZmBi9vJC7
   +UWxPfsru83tSw71l3FcmEUOOvxLKgPuM0p4GRZa/2jQ8L6aefDnZ4qxJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="326333213"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="326333213"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 18:30:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="910986578"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="910986578"
Received: from lkp-server01.sh.intel.com (HELO 0572c01a5cf9) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 02 Feb 2023 18:30:13 -0800
Received: from kbuild by 0572c01a5cf9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNlq8-00002G-2f;
        Fri, 03 Feb 2023 02:30:12 +0000
Date:   Fri, 03 Feb 2023 10:29:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 fbe7e38f3e57e38916ae7f248fd6efafeb9ecdd3
Message-ID: <63dc71a3.I2u1FuHVjRO9i2l7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: fbe7e38f3e57e38916ae7f248fd6efafeb9ecdd3  serial: 8250: Fix mismerge regarding serial_lsr_in()

elapsed time: 724m

configs tested: 59
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
um                             i386_defconfig
alpha                               defconfig
um                           x86_64_defconfig
s390                             allmodconfig
s390                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
s390                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
alpha                            allyesconfig
x86_64                              defconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
i386                             allyesconfig
i386                                defconfig
riscv                randconfig-r042-20230202
s390                 randconfig-r044-20230202
arc                  randconfig-r043-20230202
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
m68k                             alldefconfig
arm                          gemini_defconfig

clang tested configs:
x86_64                          rhel-8.3-rust
i386                          randconfig-a004
i386                          randconfig-a002
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
powerpc                     pq2fads_defconfig
mips                         cobalt_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
