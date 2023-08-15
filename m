Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ADEC04A94
	for <linux-serial@archiver.kernel.org>; Tue, 15 Aug 2023 12:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbjHOMA6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Aug 2023 08:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbjHOMAi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Aug 2023 08:00:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56841173C
        for <linux-serial@vger.kernel.org>; Tue, 15 Aug 2023 05:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692100824; x=1723636824;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TDD4s1T3Np+BQLjc4kxmTFmYTxGJw6JjdZx2NlZCfOs=;
  b=IqpO+XtT7iYCXCWlLlx1INY38AQ3qtNQsqkyQr3Ci6m1CsqGcY4tBRbR
   xBGuq6lknB7Mo/srPO3PDkwsibaXoCAuxMjKlBthdMFcpEXaJdA7WC9fV
   3xWGKP826PalyrGac7cyTlDRA/qgLJxwxu3kYHykoebCCWrrPGqGF2Ouc
   XtQBgCphyB0KuF7LBqwpTwRydmu92wwkQ/kg8ywEt+jsGIJo+ndf3B7jj
   8xwClU7crRLLlIalIHPWPIw72l/komPO7rtNvTuIv0oVWJ/lHp6x64vCv
   H50sz5gjP5Ca6XNFelWdiV1wiX5lzkxGFsyWVZaKYoPODb30p+NuOhNxA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="372256008"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="372256008"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 05:00:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="799171077"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="799171077"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 15 Aug 2023 05:00:22 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVsij-0000w7-2T;
        Tue, 15 Aug 2023 12:00:21 +0000
Date:   Tue, 15 Aug 2023 19:59:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-next 80/83] drivers/staging/gdm724x/gdm_tty.c:165:24:
 warning: comparison of distinct pointer types ('typeof (2048UL) *' (aka
 'unsigned long *') and 'typeof (remain) *' (aka 'unsigned int *'))
Message-ID: <202308151953.rNNnAR2N-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   e67d7f60d2382677c25de10b2e4d8d3717ace91f
commit: c3e5c706aefc3ceee941c1e7bd72084d3aeca37b [80/83] tty: gdm724x: convert counts to size_t
config: i386-buildonly-randconfig-r004-20230815 (https://download.01.org/0day-ci/archive/20230815/202308151953.rNNnAR2N-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230815/202308151953.rNNnAR2N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308151953.rNNnAR2N-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/staging/gdm724x/gdm_tty.c:165:24: warning: comparison of distinct pointer types ('typeof (2048UL) *' (aka 'unsigned long *') and 'typeof (remain) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
                   size_t sending_len = min(MUX_TX_MAX_SIZE, remain);
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:67:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   1 warning generated.


vim +165 drivers/staging/gdm724x/gdm_tty.c

   151	
   152	static ssize_t gdm_tty_write(struct tty_struct *tty, const u8 *buf, size_t len)
   153	{
   154		struct gdm *gdm = tty->driver_data;
   155		size_t remain = len;
   156		size_t sent_len = 0;
   157	
   158		if (!gdm_tty_ready(gdm))
   159			return -ENODEV;
   160	
   161		if (!len)
   162			return 0;
   163	
   164		while (1) {
 > 165			size_t sending_len = min(MUX_TX_MAX_SIZE, remain);
   166			gdm->tty_dev->send_func(gdm->tty_dev->priv_dev,
   167						(void *)(buf + sent_len),
   168						sending_len,
   169						gdm->index,
   170						gdm_tty_send_complete,
   171						gdm);
   172			sent_len += sending_len;
   173			remain -= sending_len;
   174			if (remain <= 0)
   175				break;
   176		}
   177	
   178		return len;
   179	}
   180	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
