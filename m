Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07120C433FE
	for <linux-serial@archiver.kernel.org>; Mon,  7 Dec 2020 23:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C388823A21
	for <linux-serial@archiver.kernel.org>; Mon,  7 Dec 2020 23:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgLGXZI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Dec 2020 18:25:08 -0500
Received: from mga01.intel.com ([192.55.52.88]:21470 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgLGXZI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Dec 2020 18:25:08 -0500
IronPort-SDR: rOvOgPtKtRXEewYxlppiEnlQ93zs94LXt3HBuoHpQQZN2y/+DtRtRP0PdnlPxvLZy2+tNZRq7J
 g9s3NSMmDqew==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="192076766"
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; 
   d="scan'208";a="192076766"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 15:24:27 -0800
IronPort-SDR: hLHKTCiBw7mTsrvgymYBNhqeIKPWPBJTozh3gMmbJ0Gt44ZcaY04jupUgNtzjfjpIMwqkaRe9g
 T0ex2ucL846Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; 
   d="scan'208";a="317441692"
Received: from lkp-server01.sh.intel.com (HELO f1d34cfde454) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 Dec 2020 15:24:26 -0800
Received: from kbuild by f1d34cfde454 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kmPrl-0000C1-VE; Mon, 07 Dec 2020 23:24:25 +0000
Date:   Tue, 08 Dec 2020 07:24:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 76437b340b242fd21952f54ba8965d21a1ffa8c8
Message-ID: <5fceb99a.IJsi2BN+hQ4QrP/T%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: 76437b340b242fd21952f54ba8965d21a1ffa8c8  earlycon: drop semicolon from earlycon macro

i386-tinyconfig vmlinux size:

+-------+------------------------------+-------------------------------------------+
| DELTA |            SYMBOL            |                  COMMIT                   |
+-------+------------------------------+-------------------------------------------+
| +1821 | TOTAL                        | 3650b228f83a..76437b340b24 (ALL COMMITS)  |
|  +126 | TOTAL                        | ba3b8bb1263d Merge 5.10-rc7 into tty-next |
| +1751 | TEXT                         | 3650b228f83a..76437b340b24 (ALL COMMITS)  |
|  +125 | TEXT                         | ba3b8bb1263d Merge 5.10-rc7 into tty-next |
|   +68 | BSS                          | 3650b228f83a..76437b340b24 (ALL COMMITS)  |
|  +774 | seq_read_iter()              | 3650b228f83a..76437b340b24 (ALL COMMITS)  |
|  +255 | __add_to_page_cache_locked() | ba3b8bb1263d Merge 5.10-rc7 into tty-next |
|  +250 | __invalidate_mapping_pages() | 3650b228f83a..76437b340b24 (ALL COMMITS)  |
|  +225 | intel_pmu_drain_pebs_icl()   | 3650b228f83a..76437b340b24 (ALL COMMITS)  |
|  +224 | intel_pmu_drain_pebs_nhm()   | 3650b228f83a..76437b340b24 (ALL COMMITS)  |
|  +201 | intel_pmu_drain_pebs_core()  | 3650b228f83a..76437b340b24 (ALL COMMITS)  |
|  +117 | init.text                    | 3650b228f83a..76437b340b24 (ALL COMMITS)  |
|  +103 | collect_syscall()            | ba3b8bb1263d Merge 5.10-rc7 into tty-next |
|   +68 | dummy_iregs                  | 3650b228f83a..76437b340b24 (ALL COMMITS)  |
|   +66 | perf_event_aux_event()       | 3650b228f83a..76437b340b24 (ALL COMMITS)  |
|   +66 | perf_log_throttle()          | 3650b228f83a..76437b340b24 (ALL COMMITS)  |
|   -69 | __sb_start_write()           | 3650b228f83a..76437b340b24 (ALL COMMITS)  |
|   -78 | __ptrace_may_access()        | 3650b228f83a..76437b340b24 (ALL COMMITS)  |
|  -250 | __invalidate_mapping_pages() | 3650b228f83a..76437b340b24 (ALL COMMITS)  |
|  -255 | __add_to_page_cache_locked() | ba3b8bb1263d Merge 5.10-rc7 into tty-next |
|  -356 | __intel_pmu_pebs_event()     | 3650b228f83a..76437b340b24 (ALL COMMITS)  |
|  -470 | seq_read()                   | 3650b228f83a..76437b340b24 (ALL COMMITS)  |
+-------+------------------------------+-------------------------------------------+

elapsed time: 721m

configs tested: 129
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc836x_rdk_defconfig
arc                     haps_hs_smp_defconfig
mips                      fuloong2e_defconfig
powerpc                     ksi8560_defconfig
arm                         cm_x300_defconfig
mips                      maltasmvp_defconfig
arc                     nsimosci_hs_defconfig
powerpc                     kilauea_defconfig
s390                                defconfig
powerpc                  mpc866_ads_defconfig
xtensa                    smp_lx200_defconfig
arm                        trizeps4_defconfig
xtensa                generic_kc705_defconfig
m68k                        mvme16x_defconfig
m68k                          amiga_defconfig
mips                      pistachio_defconfig
sh                           se7750_defconfig
mips                     cu1830-neo_defconfig
powerpc                     pq2fads_defconfig
mips                    maltaup_xpa_defconfig
mips                         tb0226_defconfig
arm                        multi_v7_defconfig
powerpc                      ep88xc_defconfig
arm                         bcm2835_defconfig
mips                        maltaup_defconfig
powerpc                      makalu_defconfig
m68k                          multi_defconfig
mips                     loongson1b_defconfig
arc                            hsdk_defconfig
powerpc                     tqm8555_defconfig
sh                            shmin_defconfig
arm                  colibri_pxa270_defconfig
c6x                              alldefconfig
arm                            mmp2_defconfig
arm                          pcm027_defconfig
m68k                         amcore_defconfig
arm                          pxa168_defconfig
powerpc                      pcm030_defconfig
powerpc                 mpc8313_rdb_defconfig
sparc                            alldefconfig
arm                      footbridge_defconfig
powerpc                      ppc40x_defconfig
sh                            migor_defconfig
arm                       mainstone_defconfig
arm                           omap1_defconfig
arc                              alldefconfig
mips                           ip32_defconfig
arm                          lpd270_defconfig
powerpc                         ps3_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 mpc837x_rdb_defconfig
nds32                             allnoconfig
arc                 nsimosci_hs_smp_defconfig
mips                          rb532_defconfig
m68k                        m5272c3_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20201207
i386                 randconfig-a004-20201207
i386                 randconfig-a001-20201207
i386                 randconfig-a002-20201207
i386                 randconfig-a006-20201207
i386                 randconfig-a003-20201207
x86_64               randconfig-a016-20201207
x86_64               randconfig-a012-20201207
x86_64               randconfig-a014-20201207
x86_64               randconfig-a013-20201207
x86_64               randconfig-a015-20201207
x86_64               randconfig-a011-20201207
i386                 randconfig-a014-20201207
i386                 randconfig-a013-20201207
i386                 randconfig-a011-20201207
i386                 randconfig-a015-20201207
i386                 randconfig-a012-20201207
i386                 randconfig-a016-20201207
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201207
x86_64               randconfig-a006-20201207
x86_64               randconfig-a002-20201207
x86_64               randconfig-a001-20201207
x86_64               randconfig-a005-20201207
x86_64               randconfig-a003-20201207

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
