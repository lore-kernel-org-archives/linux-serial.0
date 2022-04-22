Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2FEC433F5
	for <linux-serial@archiver.kernel.org>; Fri, 22 Apr 2022 23:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiDVXq1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Apr 2022 19:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiDVXqX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Apr 2022 19:46:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73812DB4A5
        for <linux-serial@vger.kernel.org>; Fri, 22 Apr 2022 16:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650671008; x=1682207008;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DNbYdNva6h3X6M/oHJo2WqlgWtXnrs+cSIDnARJ/xJ0=;
  b=ILT9pE3MfVI/NYc/LAuD8nbW7JKTCOQXJIDIg5wkyiG9iWqBHF4hXDqm
   c0/t+YwoMw6WRUF684O55IiTan8zBFecUz367qo2LHcdjQsZUt59YaHaH
   CMAljbMS1iqrFpTNplfBIZggermugauGnQAMoD7D4Bw30DMAGoQLO+HqT
   Qmpj/QfVIWZ94c5vvEMB2V/JiwoIGhri/sdotiD06iAfAflstuZk21RWG
   sN4AVCcDlo5K+wwdFZ8ZlG6ASmkr3e5ss0mnfKYu5FQOOh6y+MImh4EZA
   zfUDzOptsP1Gvh7daAGAH9oeSlXNfziHgouEcpa0vcVj6Q0QhSAgrVFg/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="244741765"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="244741765"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 16:43:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="615622248"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 22 Apr 2022 16:43:26 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni2vt-000Aft-T6;
        Fri, 22 Apr 2022 23:43:25 +0000
Date:   Sat, 23 Apr 2022 07:42:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Starke <daniel.starke@siemens.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-linus 23/26] drivers/tty/n_gsm.c:939:13: warning: variable
 'size' is used uninitialized whenever 'if' condition is false
Message-ID: <202204230704.5MxboEEo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
head:   637674fa40059cddcc3ad2212728965072f62ea3
commit: c19ffe00fed6bb423d81406d2a7e5793074c7d83 [23/26] tty: n_gsm: fix invalid use of MSC in advanced option
config: hexagon-randconfig-r035-20220422 (https://download.01.org/0day-ci/archive/20220423/202204230704.5MxboEEo-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?id=c19ffe00fed6bb423d81406d2a7e5793074c7d83
        git remote add tty https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
        git fetch --no-tags tty tty-linus
        git checkout c19ffe00fed6bb423d81406d2a7e5793074c7d83
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/tty/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/tty/n_gsm.c:939:13: warning: variable 'size' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           } else if (dlci->adaption == 2) {
                      ^~~~~~~~~~~~~~~~~~~
   drivers/tty/n_gsm.c:948:40: note: uninitialized use occurs here
           msg = gsm_data_alloc(gsm, dlci->addr, size, gsm->ftype);
                                                 ^~~~
   drivers/tty/n_gsm.c:939:9: note: remove the 'if' if its condition is always true
           } else if (dlci->adaption == 2) {
                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/n_gsm.c:934:10: note: initialize the variable 'size' to silence this warning
           int size;
                   ^
                    = 0
   1 warning generated.


vim +939 drivers/tty/n_gsm.c

   916	
   917	/**
   918	 *	gsm_dlci_modem_output	-	try and push modem status out of a DLCI
   919	 *	@gsm: mux
   920	 *	@dlci: the DLCI to pull modem status from
   921	 *	@brk: break signal
   922	 *
   923	 *	Push an empty frame in to the transmit queue to update the modem status
   924	 *	bits and to transmit an optional break.
   925	 *
   926	 *	Caller must hold the tx_lock of the mux.
   927	 */
   928	
   929	static int gsm_dlci_modem_output(struct gsm_mux *gsm, struct gsm_dlci *dlci,
   930					 u8 brk)
   931	{
   932		u8 *dp = NULL;
   933		struct gsm_msg *msg;
   934		int size;
   935	
   936		/* for modem bits without break data */
   937		if (dlci->adaption == 1) {
   938			size = 0;
 > 939		} else if (dlci->adaption == 2) {
   940			size = 1;
   941			if (brk > 0)
   942				size++;
   943		} else {
   944			pr_err("%s: unsupported adaption %d\n", __func__,
   945			       dlci->adaption);
   946		}
   947	
   948		msg = gsm_data_alloc(gsm, dlci->addr, size, gsm->ftype);
   949		if (!msg) {
   950			pr_err("%s: gsm_data_alloc error", __func__);
   951			return -ENOMEM;
   952		}
   953		dp = msg->data;
   954		switch (dlci->adaption) {
   955		case 1: /* Unstructured */
   956			break;
   957		case 2: /* Unstructured with modem bits. */
   958			if (brk == 0) {
   959				*dp++ = (gsm_encode_modem(dlci) << 1) | EA;
   960			} else {
   961				*dp++ = gsm_encode_modem(dlci) << 1;
   962				*dp++ = (brk << 4) | 2 | EA; /* Length, Break, EA */
   963			}
   964			break;
   965		default:
   966			/* Handled above */
   967			break;
   968		}
   969	
   970		__gsm_data_queue(dlci, msg);
   971		return size;
   972	}
   973	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
