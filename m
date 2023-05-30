Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496DBC77B73
	for <linux-serial@archiver.kernel.org>; Tue, 30 May 2023 18:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjE3Skp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 May 2023 14:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjE3Skp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 May 2023 14:40:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED00DA7
        for <linux-serial@vger.kernel.org>; Tue, 30 May 2023 11:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685472043; x=1717008043;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uxnwfYPjHSEVCOK8xUhZ7G9Y0f1O8DS7xItCY5soSW8=;
  b=Ms6W5GX9xx/e4rrxWItBhnXNsDgGYE/nAhWYoWvgTlcr37fQyThB0Hzc
   8YiLdbmb7DdyrPW4eOMsOMaFzBgJ3mYCyJhPVobFErXQ1aoABklkdBbY7
   gpotUZK/LygEI7fQ1lDb88rOAcAad0dUu5fSDRc6vPGWDIRl1CkmP0IL1
   Gn7aFXW40EM5MXNzVxLFSzIy9Fkha+yDxzcpQMwPyYQS8wVstvSgg8du/
   WMIvkmNtC4FURvHij5Z9n+gQjMhZK4SL2BEH3dyW18RtIHBLpWxFy4ZUT
   FQIrGdf+Ri1oSHKOKwpA42t1N/qwnxBdWlkZ57sQpjrGvRhzGQtCqK/yL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="353853966"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="353853966"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 11:40:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="706543362"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="706543362"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2023 11:40:36 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q44Gp-0000k1-2H;
        Tue, 30 May 2023 18:40:35 +0000
Date:   Wed, 31 May 2023 02:40:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 13/17] m68k-linux-ld: 8250_fsl.c:undefined
 reference to `serial8250_modem_status'
Message-ID: <202305310250.WwdLl25L-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Uwe,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   617ece73dd240cb11869a224c879ca685a151a38
commit: a0807ca158e00af2909f3d34a36c28b57b07ab06 [13/17] serial: 8250: Apply FSL workarounds also without SERIAL_8250_CONSOLE
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20230531/202305310250.WwdLl25L-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?id=a0807ca158e00af2909f3d34a36c28b57b07ab06
        git remote add tty https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
        git fetch --no-tags tty tty-testing
        git checkout a0807ca158e00af2909f3d34a36c28b57b07ab06
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305310250.WwdLl25L-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/tty/serial/8250/8250_fsl.o: in function `fsl8250_handle_irq':
   8250_fsl.c:(.text+0x92): undefined reference to `serial8250_rx_chars'
>> m68k-linux-ld: 8250_fsl.c:(.text+0x106): undefined reference to `serial8250_modem_status'
>> m68k-linux-ld: 8250_fsl.c:(.text+0x11e): undefined reference to `serial8250_tx_chars'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
