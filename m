Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3455FC4332F
	for <linux-serial@archiver.kernel.org>; Sat, 26 Feb 2022 19:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbiBZTPp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 26 Feb 2022 14:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiBZTPo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 26 Feb 2022 14:15:44 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB66350069
        for <linux-serial@vger.kernel.org>; Sat, 26 Feb 2022 11:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645902909; x=1677438909;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kOnomP9I3Pfl7Kza1qHl7P6ejed/MKwSnjWjpnggpwI=;
  b=OHe2x50bgZLkcbKTKUEhMeo70Kef66DpYMCZJ0fK+mqdSRXZfR/6wuS0
   pLFefD00E75sFsQYEltoDz3COgTAcAP4lYcBdEyvZIciRPL3COLl/COxk
   GGlMX7R16OjFEDHw9z+0onLSSXm4cvA7GTCSJQxg/AveBQalHfMhi+n/W
   kXX1r3oQIFXm3B+z26xChfWPAik2G6Sve6VY617zKyALUX1ZczygICqoU
   B9QGU1u4xxRL0t3WLToJjoxB6hkUmtXmR2uB93DmN88nnZX1NzIof37or
   NSUynTVZgM/kwOu/hYfFucipNMuF8el2iGGoaaNc4J/xmymDhlWC1srBM
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="313396769"
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="313396769"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 11:15:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="549700813"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Feb 2022 11:15:06 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nO2X4-0005sS-66; Sat, 26 Feb 2022 19:15:06 +0000
Date:   Sun, 27 Feb 2022 03:14:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yu Tu <yu.tu@amlogic.com>
Cc:     kbuild-all@lists.01.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 30/42] meson_uart.c:undefined reference to
 `__clk_get_name'
Message-ID: <202202262312.11J4P9pP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   71404f653cf7858fdbb81dd5419a8a4ac4ffa20c
commit: 44023b8e1f14bc72bb773dd84dc3563fc912d210 [30/42] tty: serial: meson: Describes the calculation of the UART baud rate clock using a clock frame
config: s390-randconfig-p002-20220226 (https://download.01.org/0day-ci/archive/20220226/202202262312.11J4P9pP-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?id=44023b8e1f14bc72bb773dd84dc3563fc912d210
        git remote add tty https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
        git fetch --no-tags tty tty-testing
        git checkout 44023b8e1f14bc72bb773dd84dc3563fc912d210
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/tty/serial/meson_uart.o: in function `meson_uart_probe_clocks.constprop.0':
>> meson_uart.c:(.text+0xc64): undefined reference to `__clk_get_name'
>> s390-linux-ld: meson_uart.c:(.text+0xc80): undefined reference to `devm_clk_hw_register_fixed_factor'
>> s390-linux-ld: meson_uart.c:(.text+0xd00): undefined reference to `__clk_get_name'
>> s390-linux-ld: meson_uart.c:(.text+0xd68): undefined reference to `__devm_clk_hw_register_divider'
>> s390-linux-ld: meson_uart.c:(.text+0xe80): undefined reference to `__devm_clk_hw_register_mux'
>> s390-linux-ld: meson_uart.c:(.text+0xe94): undefined reference to `clk_hw_get_rate'
>> s390-linux-ld: meson_uart.c:(.text+0xf12): undefined reference to `clk_hw_get_name'
   s390-linux-ld: meson_uart.c:(.text+0xf70): undefined reference to `__devm_clk_hw_register_divider'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
