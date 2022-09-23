Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926BAC07E9D
	for <linux-serial@archiver.kernel.org>; Fri, 23 Sep 2022 18:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiIWSKl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Sep 2022 14:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiIWSKk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Sep 2022 14:10:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8883CAD993
        for <linux-serial@vger.kernel.org>; Fri, 23 Sep 2022 11:10:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 265606296F
        for <linux-serial@vger.kernel.org>; Fri, 23 Sep 2022 18:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE01C433D6;
        Fri, 23 Sep 2022 18:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663956637;
        bh=TNEkw7lJBAai2Va25HHqtz9AOKap22gLUNyUMdWBl/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k4gmzRuHUD/0MXDeGNyCqM2nNB/YZQ/wEYqS+4hlOPbBx33chHTvlZ8RSZAingd9K
         TXjsu8NBzTWlzmzH34bYq1vFH9qp6OyTzyVm3MEVo6lEN9ATELx00Icx/SsXLIKuE0
         wjVEqinM9r1eU6emUkSQR9SCM3MJtAY8SwdyvIh0=
Date:   Fri, 23 Sep 2022 20:10:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergiu.Moga@microchip.com
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-serial@vger.kernel.org
Subject: Re: [tty:tty-next 42/45] atmel_serial.c:undefined reference to
 `__clk_is_enabled'
Message-ID: <Yy32mnnbWH3LOtel@kroah.com>
References: <202209240013.GWFiVnCP-lkp@intel.com>
 <700b1dff-fb79-2cff-bee7-7172ed33b152@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <700b1dff-fb79-2cff-bee7-7172ed33b152@microchip.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 23, 2022 at 04:28:08PM +0000, Sergiu.Moga@microchip.com wrote:
> On 23.09.2022 19:22, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
> > head:   adafbbf6895eb0ce41a313c6ee68870ab9aa93cd
> > commit: 5e3ce1f261296bfe4bb59a98c82f4959d214a4f7 [42/45] tty: serial: atmel: Make the driver aware of the existence of GCLK
> > config: m68k-randconfig-r003-20220922 (https://download.01.org/0day-ci/archive/20220924/202209240013.GWFiVnCP-lkp@intel.com/config)
> > compiler: m68k-linux-gcc (GCC) 12.1.0
> > reproduce (this is a W=1 build):
> >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >          chmod +x ~/bin/make.cross
> >          # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?id=5e3ce1f261296bfe4bb59a98c82f4959d214a4f7
> >          git remote add tty https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
> >          git fetch --no-tags tty tty-next
> >          git checkout 5e3ce1f261296bfe4bb59a98c82f4959d214a4f7
> >          # save the config file
> >          mkdir build_dir && cp config build_dir/.config
> >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >     m68k-linux-ld: drivers/tty/serial/atmel_serial.o: in function `atmel_set_termios':
> >>> atmel_serial.c:(.text+0xf88): undefined reference to `__clk_is_enabled'
> >     m68k-linux-ld: drivers/tty/serial/atmel_serial.o: in function `atmel_serial_pm':
> >     atmel_serial.c:(.text+0x14fc): undefined reference to `__clk_is_enabled'
> > 
> > --
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
> 
> 
> This does not appear on ARCH=arm, for which this patch is intended. So I 
> guess this is fine?

No, you can't break the build on any arch.  Please fix up.

thanks,

greg k-h
