Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B83FC433EF
	for <linux-serial@archiver.kernel.org>; Mon, 28 Feb 2022 10:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbiB1KzK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Feb 2022 05:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbiB1Kyk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Feb 2022 05:54:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84AC606C2
        for <linux-serial@vger.kernel.org>; Mon, 28 Feb 2022 02:52:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 603D5B80FD3
        for <linux-serial@vger.kernel.org>; Mon, 28 Feb 2022 10:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09EEC340E7;
        Mon, 28 Feb 2022 10:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646045536;
        bh=4PdbstDba4Kc1TZw3Ean3SBstKdCmQrdwOTl6BXVc1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YoXlvca33SaEsTzf2r5rC3El9OIyNUrPZt0mzU4mJD70BqtbBttd9muQSUbaX4dcM
         mkzF+15VTABS5L0YlXub4ECXipWzx/R7WiWpu2sTPMDwj+SaOT9p1em8A421AL8B7S
         k8mJWGGSgLRNEVNhzTSbRaRqP4DI88OhFtMfupIw=
Date:   Mon, 28 Feb 2022 11:52:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-serial@vger.kernel.org
Subject: Re: [tty:tty-testing 31/42] drivers/mmc/core/sdio_uart.c:253:16:
 error: implicit declaration of function 'UART_LCR_WLEN'; did you mean
 'UART_LCR_WLEN5'?
Message-ID: <YhypXNglrugN7ZLa@kroah.com>
References: <202202260105.p77piygB-lkp@intel.com>
 <f3c45778-851b-2a26-afe0-d109adb3667a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3c45778-851b-2a26-afe0-d109adb3667a@suse.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 28, 2022 at 05:36:53AM +0100, Jiri Slaby wrote:
> On 25. 02. 22, 19:34, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> > head:   a6d8f09319fff9e6e7a91cadb19923b8cb2573e0
> > commit: b6f8eaea0cf1afe2500f8af7b6cc805647fe4889 [31/42] sdio_uart: make use of UART_LCR_WLEN() + tty_get_char_size()
> > config: arc-randconfig-r043-20220225 (https://download.01.org/0day-ci/archive/20220226/202202260105.p77piygB-lkp@intel.com/config)
> > compiler: arceb-elf-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >          chmod +x ~/bin/make.cross
> >          # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?id=b6f8eaea0cf1afe2500f8af7b6cc805647fe4889
> >          git remote add tty https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
> >          git fetch --no-tags tty tty-testing
> >          git checkout b6f8eaea0cf1afe2500f8af7b6cc805647fe4889
> >          # save the config file to linux build tree
> >          mkdir build_dir
> >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >     drivers/mmc/core/sdio_uart.c: In function 'sdio_uart_change_speed':
> > > > drivers/mmc/core/sdio_uart.c:253:16: error: implicit declaration of function 'UART_LCR_WLEN'; did you mean 'UART_LCR_WLEN5'? [-Werror=implicit-function-declaration]
> >       253 |         cval = UART_LCR_WLEN(tty_get_char_size(termios->c_cflag));
> >           |                ^~~~~~~~~~~~~
> >           |                UART_LCR_WLEN5
> >     cc1: some warnings being treated as errors
> > 
> > 
> > vim +253 drivers/mmc/core/sdio_uart.c
> 
> This is caused by the move to serial.h. Apart from sdio_uart, these drivers
> do not include serial.h directly (but apart from sdio_uart are able to
> compile, i.e. include it via some chain):
> drivers/tty/serial/8250/8250_omap.c
> drivers/tty/serial/jsm/jsm_neo.c
> drivers/tty/serial/omap-serial.c
> drivers/tty/serial/pxa.c

Yes, this is my fault, I'll fix this up later today, thanks.

greg k-h
