Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6266EC64EC4
	for <linux-serial@archiver.kernel.org>; Fri, 10 Mar 2023 13:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjCJN7G (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Mar 2023 08:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjCJN7B (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Mar 2023 08:59:01 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220C612F0D
        for <linux-serial@vger.kernel.org>; Fri, 10 Mar 2023 05:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678456740; x=1709992740;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ejMjDPitSMcEsiQWdJrl4sOj8BMQkyZJaRAsbmw/mnM=;
  b=PF2j226qXcZ22YtS6mwbIp5X1v26v9K6rruXORu5AjxglLsZTwUN/ffv
   uNgkx4AfoJhtpqnms6nomcPuJRrmoFKu7m9anSFOxkc+2nfr9QNBor+9Y
   M/K8lL8xETHrEKZiZcI2cU/rTvoJa7Bg7NpWK7/umApTnGo1EanoWPUKf
   xC2SrZ6hfCGD0kv/xkMUhnbqy0XzbH2q0afe3ERY0GSzF/LvQ8paAYT3P
   M0NUxy7TtVoW58YBDFrWDfWQBvIYWBZXps3Qhq1pkOVy3xlf43y7EEJ7+
   rQFuFK4MYoBmPN+d2TDy5S70qRVkWn1dtSL3ARzt4ZSS7e/7BZYhi/WxR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="336749393"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="336749393"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 05:58:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="741985108"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="741985108"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 10 Mar 2023 05:58:20 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1padGF-0003tZ-2W;
        Fri, 10 Mar 2023 13:58:19 +0000
Date:   Fri, 10 Mar 2023 21:57:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 18365ebf23f3e713e5dd8e295c9a639295250f3c
Message-ID: <640b3748.wos4IPpAOmSb0ikd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 18365ebf23f3e713e5dd8e295c9a639295250f3c  tty: vt: protect KD_FONT_OP_GET_TALL from unbound access

elapsed time: 1254m

configs tested: 42
configs skipped: 3

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
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
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
https://github.com/intel/lkp-tests
