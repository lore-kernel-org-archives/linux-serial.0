Return-Path: <SRS0=bNnH=52=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F5DC2D0EC
	for <linux-serial@archiver.kernel.org>; Fri, 10 Apr 2020 23:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CAE206DA
	for <linux-serial@archiver.kernel.org>; Fri, 10 Apr 2020 23:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgDJX43 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Apr 2020 19:56:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:51246 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgDJX43 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Apr 2020 19:56:29 -0400
IronPort-SDR: 52jYcHXEKN8hDDpzDA47pRHVS7ZWYBPdSKJFDOcabT0+3bPJCN2TMAHmiLBdQRI4Z89pwDWEdV
 NVxy4fgzQe7g==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 16:56:28 -0700
IronPort-SDR: wBgQ2nVr1uE4WKxqrSNvhduGxgcOvGGeq6xYcEZCjZ2ulzCQKSZPYV/OJ2MIPCv3HVsNuxl0jY
 yhpON0u4w0Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,368,1580803200"; 
   d="gz'50?scan'50,208,50";a="362580567"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2020 16:56:23 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jN3VW-000HeJ-Pw; Sat, 11 Apr 2020 07:56:22 +0800
Date:   Sat, 11 Apr 2020 07:56:16 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     kbuild-all@lists.01.org, jason.wessel@windriver.com,
        daniel.thompson@linaro.org, gregkh@linuxfoundation.org,
        hpa@zytor.com, kgdb-bugreport@lists.sourceforge.net,
        corbet@lwn.net, frowand.list@gmail.com, tglx@linutronix.de,
        jslaby@suse.com, linux-serial@vger.kernel.org, mingo@redhat.com,
        will@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        bp@alien8.de, catalin.marinas@arm.com,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] kgdboc: Add earlycon_kgdboc to support early kgdb
 using boot consoles
Message-ID: <202004110744.nPoRwmTD%lkp@intel.com>
References: <20200410151632.4.I8fba5961bf452ab92350654aa61957f23ecf0100@changeid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20200410151632.4.I8fba5961bf452ab92350654aa61957f23ecf0100@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Douglas,

I love your patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on tty/tty-testing v5.6 next-20200410]
[cannot apply to kgdb/kgdb-next]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Douglas-Anderson/kgdb-Support-late-serial-drivers-enable-early-debug-w-boot-consoles/20200411-062123
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: microblaze-mmu_defconfig (attached as .config)
compiler: microblaze-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=9.3.0 make.cross ARCH=microblaze 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/misc/kgdbts.c: In function 'configure_kgdbts':
>> drivers/misc/kgdbts.c:1080:8: error: too few arguments to function 'kgdb_register_io_module'
    1080 |  err = kgdb_register_io_module(&kgdbts_io_ops);
         |        ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/misc/kgdbts.c:86:
   include/linux/kgdb.h:326:12: note: declared here
     326 | extern int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops,
         |            ^~~~~~~~~~~~~~~~~~~~~~~

vim +/kgdb_register_io_module +1080 drivers/misc/kgdbts.c

e8d31c204e36e0 Jason Wessel 2008-03-07  1069  
e8d31c204e36e0 Jason Wessel 2008-03-07  1070  static int configure_kgdbts(void)
e8d31c204e36e0 Jason Wessel 2008-03-07  1071  {
e8d31c204e36e0 Jason Wessel 2008-03-07  1072  	int err = 0;
e8d31c204e36e0 Jason Wessel 2008-03-07  1073  
e8d31c204e36e0 Jason Wessel 2008-03-07  1074  	if (!strlen(config) || isspace(config[0]))
e8d31c204e36e0 Jason Wessel 2008-03-07  1075  		goto noconfig;
e8d31c204e36e0 Jason Wessel 2008-03-07  1076  
e8d31c204e36e0 Jason Wessel 2008-03-07  1077  	final_ack = 0;
e8d31c204e36e0 Jason Wessel 2008-03-07  1078  	run_plant_and_detach_test(1);
e8d31c204e36e0 Jason Wessel 2008-03-07  1079  
e8d31c204e36e0 Jason Wessel 2008-03-07 @1080  	err = kgdb_register_io_module(&kgdbts_io_ops);
e8d31c204e36e0 Jason Wessel 2008-03-07  1081  	if (err) {
e8d31c204e36e0 Jason Wessel 2008-03-07  1082  		configured = 0;
e8d31c204e36e0 Jason Wessel 2008-03-07  1083  		return err;
e8d31c204e36e0 Jason Wessel 2008-03-07  1084  	}
e8d31c204e36e0 Jason Wessel 2008-03-07  1085  	configured = 1;
e8d31c204e36e0 Jason Wessel 2008-03-07  1086  	kgdbts_run_tests();
e8d31c204e36e0 Jason Wessel 2008-03-07  1087  
e8d31c204e36e0 Jason Wessel 2008-03-07  1088  	return err;
e8d31c204e36e0 Jason Wessel 2008-03-07  1089  
e8d31c204e36e0 Jason Wessel 2008-03-07  1090  noconfig:
e8d31c204e36e0 Jason Wessel 2008-03-07  1091  	config[0] = 0;
e8d31c204e36e0 Jason Wessel 2008-03-07  1092  	configured = 0;
e8d31c204e36e0 Jason Wessel 2008-03-07  1093  
e8d31c204e36e0 Jason Wessel 2008-03-07  1094  	return err;
e8d31c204e36e0 Jason Wessel 2008-03-07  1095  }
e8d31c204e36e0 Jason Wessel 2008-03-07  1096  

:::::: The code at line 1080 was first introduced by commit
:::::: e8d31c204e36e019b9134f2a11926cac0fcf9b19 kgdb: add kgdb internal test suite

:::::: TO: Jason Wessel <jason.wessel@windriver.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--+QahgC5+KEYLbs62
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--+QahgC5+KEYLbs62--
