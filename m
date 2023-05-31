Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747F0C77B7A
	for <linux-serial@archiver.kernel.org>; Wed, 31 May 2023 02:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjEaC6A (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 May 2023 22:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjEaC57 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 May 2023 22:57:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142E210B
        for <linux-serial@vger.kernel.org>; Tue, 30 May 2023 19:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685501878; x=1717037878;
  h=date:from:to:cc:subject:message-id;
  bh=HCM6QaZQblVOCNHzq/xt3M1hSjFZBI+XOz9nRbuK2Zk=;
  b=YoBJ7x47xFsJBrezQlc4rhs01W19YUVVPmwbCCEl6AVs1hNKkVtPtJek
   hTbjheQMwov3XcWJBl2Glkpi/gYnttlWCDKcIMf5KZr/vXyRR3ldetnyK
   MC2QVjRXz8YtZ7jUMpJMfYbTXTzqaxa+MS27KF27STFLxDO0NbCB3YMPB
   Xq41mVMSu2GQAPcLVxLWBh/hd56Boz0NE6Ei8hPAVeO4AKfwXxvLjM2Yr
   KHNXtpwYEUAQVVF5vkLn4YbQiYfnJqCZ/67y0O90yXEbpIWcpJlYaRhV5
   uoFTEmRnMTIOUt5h/EKKENozbTCGpSTpF+tQWoeuxf4I9asmUJGxboBfi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="418608870"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="418608870"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 19:57:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="776599408"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="776599408"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 May 2023 19:57:55 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4C26-000117-34;
        Wed, 31 May 2023 02:57:54 +0000
Date:   Wed, 31 May 2023 10:57:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD REGRESSION
 617ece73dd240cb11869a224c879ca685a151a38
Message-ID: <20230531025730.RjRWp%lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 617ece73dd240cb11869a224c879ca685a151a38  serial: core: Start managing serial controllers to enable runtime PM

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202305310250.WwdLl25L-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202305310433.jhGB8PhI-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

8250_fsl.c:(.text+0x10c): undefined reference to `serial8250_rx_chars'
8250_fsl.c:(.text.fsl8250_handle_irq+0x140): undefined reference to `serial8250_rx_chars'
arm-linux-gnueabi-ld: 8250_fsl.c:(.text+0x1d8): undefined reference to `serial8250_modem_status'
arm-linux-gnueabi-ld: 8250_fsl.c:(.text+0x218): undefined reference to `serial8250_tx_chars'
m68k-linux-ld: 8250_fsl.c:(.text+0x106): undefined reference to `serial8250_modem_status'
m68k-linux-ld: 8250_fsl.c:(.text+0x11e): undefined reference to `serial8250_tx_chars'
mips-linux-ld: 8250_fsl.c:(.text.fsl8250_handle_irq+0x220): undefined reference to `serial8250_modem_status'
mips-linux-ld: 8250_fsl.c:(.text.fsl8250_handle_irq+0x268): undefined reference to `serial8250_tx_chars'
powerpc-linux-ld: 8250_fsl.c:(.text+0x214): undefined reference to `serial8250_modem_status'
powerpc-linux-ld: 8250_fsl.c:(.text+0x254): undefined reference to `serial8250_tx_chars'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allmodconfig
|   |-- 8250_fsl.c:(.text):undefined-reference-to-serial8250_rx_chars
|   |-- arm-linux-gnueabi-ld:8250_fsl.c:(.text):undefined-reference-to-serial8250_modem_status
|   `-- arm-linux-gnueabi-ld:8250_fsl.c:(.text):undefined-reference-to-serial8250_tx_chars
|-- m68k-allmodconfig
|   |-- m68k-linux-ld:8250_fsl.c:(.text):undefined-reference-to-serial8250_modem_status
|   `-- m68k-linux-ld:8250_fsl.c:(.text):undefined-reference-to-serial8250_tx_chars
|-- mips-allmodconfig
|   |-- 8250_fsl.c:(.text.fsl8250_handle_irq):undefined-reference-to-serial8250_rx_chars
|   |-- mips-linux-ld:8250_fsl.c:(.text.fsl8250_handle_irq):undefined-reference-to-serial8250_modem_status
|   `-- mips-linux-ld:8250_fsl.c:(.text.fsl8250_handle_irq):undefined-reference-to-serial8250_tx_chars
`-- powerpc-allmodconfig
    |-- powerpc-linux-ld:8250_fsl.c:(.text):undefined-reference-to-serial8250_modem_status
    `-- powerpc-linux-ld:8250_fsl.c:(.text):undefined-reference-to-serial8250_tx_chars

elapsed time: 726m

configs tested: 40
configs skipped: 2

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
