Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F982C7EE2A
	for <linux-serial@archiver.kernel.org>; Fri,  2 Jun 2023 02:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjFBC17 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 1 Jun 2023 22:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjFBC16 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Jun 2023 22:27:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED1E180
        for <linux-serial@vger.kernel.org>; Thu,  1 Jun 2023 19:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685672877; x=1717208877;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bnQmixq8IosQfwazVE1IkhoN+lw8BUTq9bYtC+8DFVw=;
  b=MJZTeBDyuL9Oo/IY+5FbI4XXu1l6jjFlny62jFGFRBwU+dMkNM8XZpa2
   4xSVNnZjNEE82A+tLiUveuXdOywes9JiUo4ZRaNQsWcLQctartrhmw3dX
   TvAyp15cbyCFaZXchfqN8jh2KHe+f8kFKustI5h2cu+d4ECcLv2kzLODm
   8Rzig+wfqXLZnOmfmob9ZcSaJrJzFkNO7q2Hpg5UOydw5j33TQnodp24R
   kkeZ7tokqoG6T1snMIjAR+HOp70Cba5hGnH5bO4o709NIo4s+pjI6MSL1
   7rWJiyjHaou2Kgy9xXGUmtQBopKWI4kLfJGYrUFRdureg/0Ip2BgtIBDi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="335360370"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="335360370"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 19:27:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881872740"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="881872740"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Jun 2023 19:27:55 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4uWB-0002vw-0O;
        Fri, 02 Jun 2023 02:27:55 +0000
Date:   Fri, 2 Jun 2023 10:27:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 19/19] legacy_serial.c:undefined reference to
 `fsl8250_handle_irq'
Message-ID: <202306021041.qbRZZenE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   3a3d09a9ee0ef5b417d6bdf8486a4da2bef06dc3
commit: 3a3d09a9ee0ef5b417d6bdf8486a4da2bef06dc3 [19/19] serial: 8250: Apply FSL workarounds also without SERIAL_8250_CONSOLE
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230602/202306021041.qbRZZenE-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?id=3a3d09a9ee0ef5b417d6bdf8486a4da2bef06dc3
        git remote add tty https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
        git fetch --no-tags tty tty-testing
        git checkout 3a3d09a9ee0ef5b417d6bdf8486a4da2bef06dc3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306021041.qbRZZenE-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: arch/powerpc/kernel/legacy_serial.o: in function `serial_dev_init':
>> legacy_serial.c:(.init.text+0x46a): undefined reference to `fsl8250_handle_irq'
>> powerpc-linux-ld: legacy_serial.c:(.init.text+0x472): undefined reference to `fsl8250_handle_irq'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
