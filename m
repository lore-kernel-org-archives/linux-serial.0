Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322B6C43334
	for <linux-serial@archiver.kernel.org>; Sun, 17 Jul 2022 02:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiGQCPK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 16 Jul 2022 22:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGQCPJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 16 Jul 2022 22:15:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8804EBF4B
        for <linux-serial@vger.kernel.org>; Sat, 16 Jul 2022 19:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658024106; x=1689560106;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8whLrbw0yagzGZnGC8lUHtNV4l1wBOGp0KnezY224wE=;
  b=j/H8LoMtHj7W8luOtqLbtkjafcDGjDVQvLkBGvHPfo8XGd+xQbhkzXuv
   JJBXAJxXrFdApRxX8qTM3ZV7qlKwkNK9Evsr705/TAMVb+z3SSPbbzl+S
   LsOBM3qhdZaacbboKmhizhfDX1z4nTmtOfoJt/3ZL7TH7wnKc6vySVk/U
   DiXwWxfBlBhoh3vagpn4+c7pf0g4vTv4tgkgPyIc+eLZmvkkV+gib1Obo
   f9k13X8uuUYuXcfU23viQVolTE9HCZrwdqBpJmS+s+zMiyRuP6mm3YDi+
   7DgFePS54UagRBeCfPQ6kxKd+7K3l3k/YdezgfI8G7wQuw2M00NtbGjbu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="311693493"
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="311693493"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 19:15:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="842916204"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jul 2022 19:15:05 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCtoG-0002Vu-O6;
        Sun, 17 Jul 2022 02:15:04 +0000
Date:   Sun, 17 Jul 2022 10:14:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     kbuild-all@lists.01.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 77/77] arch/mips/vr41xx/common/siu.c:18:9: error:
 'PORT_VR41XX_SIU' undeclared here (not in a function)
Message-ID: <202207171049.VucAZfef-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   ceefa81e6e69b020997205e5c30a42d43aa5ae63
commit: ceefa81e6e69b020997205e5c30a42d43aa5ae63 [77/77] serial: remove VR41XX serial driver
config: mips-tb0226_defconfig (https://download.01.org/0day-ci/archive/20220717/202207171049.VucAZfef-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?id=ceefa81e6e69b020997205e5c30a42d43aa5ae63
        git remote add tty https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
        git fetch --no-tags tty tty-testing
        git checkout ceefa81e6e69b020997205e5c30a42d43aa5ae63
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/mips/vr41xx/common/siu.c:18:9: error: 'PORT_VR41XX_SIU' undeclared here (not in a function)
      18 |         PORT_VR41XX_SIU,
         |         ^~~~~~~~~~~~~~~
>> arch/mips/vr41xx/common/siu.c:37:9: error: 'PORT_VR41XX_DSIU' undeclared here (not in a function)
      37 |         PORT_VR41XX_DSIU,
         |         ^~~~~~~~~~~~~~~~
   arch/mips/vr41xx/common/siu.c:110:13: warning: no previous prototype for 'vr41xx_siu_setup' [-Wmissing-prototypes]
     110 | void __init vr41xx_siu_setup(void)
         |             ^~~~~~~~~~~~~~~~


vim +/PORT_VR41XX_SIU +18 arch/mips/vr41xx/common/siu.c

891649409edbed Yoichi Yuasa 2007-05-09  16  
891649409edbed Yoichi Yuasa 2007-05-09  17  static unsigned int siu_type1_ports[SIU_PORTS_MAX] __initdata = {
891649409edbed Yoichi Yuasa 2007-05-09 @18  	PORT_VR41XX_SIU,
891649409edbed Yoichi Yuasa 2007-05-09  19  	PORT_UNKNOWN,
891649409edbed Yoichi Yuasa 2007-05-09  20  };
891649409edbed Yoichi Yuasa 2007-05-09  21  
891649409edbed Yoichi Yuasa 2007-05-09  22  static struct resource siu_type1_resource[] __initdata = {
891649409edbed Yoichi Yuasa 2007-05-09  23  	{
891649409edbed Yoichi Yuasa 2007-05-09  24  		.start	= 0x0c000000,
891649409edbed Yoichi Yuasa 2007-05-09  25  		.end	= 0x0c00000a,
891649409edbed Yoichi Yuasa 2007-05-09  26  		.flags	= IORESOURCE_MEM,
891649409edbed Yoichi Yuasa 2007-05-09  27  	},
891649409edbed Yoichi Yuasa 2007-05-09  28  	{
891649409edbed Yoichi Yuasa 2007-05-09  29  		.start	= SIU_IRQ,
891649409edbed Yoichi Yuasa 2007-05-09  30  		.end	= SIU_IRQ,
891649409edbed Yoichi Yuasa 2007-05-09  31  		.flags	= IORESOURCE_IRQ,
891649409edbed Yoichi Yuasa 2007-05-09  32  	},
891649409edbed Yoichi Yuasa 2007-05-09  33  };
891649409edbed Yoichi Yuasa 2007-05-09  34  
891649409edbed Yoichi Yuasa 2007-05-09  35  static unsigned int siu_type2_ports[SIU_PORTS_MAX] __initdata = {
891649409edbed Yoichi Yuasa 2007-05-09  36  	PORT_VR41XX_SIU,
891649409edbed Yoichi Yuasa 2007-05-09 @37  	PORT_VR41XX_DSIU,
891649409edbed Yoichi Yuasa 2007-05-09  38  };
891649409edbed Yoichi Yuasa 2007-05-09  39  

:::::: The code at line 18 was first introduced by commit
:::::: 891649409edbed528728b4a104d29e43e9d7473a [MIPS] separate platform_device registration for VR41xx serial interface

:::::: TO: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
