Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F683CDB483
	for <linux-serial@archiver.kernel.org>; Tue, 17 Oct 2023 08:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjJQIQB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Oct 2023 04:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbjJQIQA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Oct 2023 04:16:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F0393
        for <linux-serial@vger.kernel.org>; Tue, 17 Oct 2023 01:15:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B879C433C8;
        Tue, 17 Oct 2023 08:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697530559;
        bh=KDPdu7uelufo6a96s425sl4W+y1GnIar0MivxfTj76I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OHfLLH03BZJPQf2dFI+qQqX0zuOK+jpVsCGEZdonFensAyTN0+mDqAcZGLc3V7Gxr
         fD3/siVvdOj2xrmQ+PVKEhho/oB3BUmx1BPfz9IR/pduITik4+eSbNm/EJQcGFO1Tn
         o3UzLzqG7pWtA1dREME9fIbnP8BlMw4P+TrnrDEY=
Date:   Tue, 17 Oct 2023 10:15:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Brenda Streiff <brenda.streiff@ni.com>,
        oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org
Subject: Re: [tty:tty-testing 12/24]
 drivers/tty/serial/8250/8250_ni.c:446:41: warning: 'nic7a69' defined but not
 used
Message-ID: <2023101704-pacifism-audience-97c8@gregkh>
References: <202310170418.GCOnw1n1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310170418.GCOnw1n1-lkp@intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 17, 2023 at 04:37:14AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> head:   d7b7027a2dcfb08e3e592c81978551f53c3beb4f
> commit: 59dbecf92fa66c454ba8011231212e3ca51aae28 [12/24] serial: 8250: add driver for NI UARTs
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231017/202310170418.GCOnw1n1-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310170418.GCOnw1n1-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310170418.GCOnw1n1-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/tty/serial/8250/8250_ni.c:446:41: warning: 'nic7a69' defined but not used [-Wunused-const-variable=]
>      446 | static const struct ni16550_device_info nic7a69 = {
>          |                                         ^~~~~~~
> >> drivers/tty/serial/8250/8250_ni.c:439:41: warning: 'nic792b' defined but not used [-Wunused-const-variable=]
>      439 | static const struct ni16550_device_info nic792b = {
>          |                                         ^~~~~~~
> >> drivers/tty/serial/8250/8250_ni.c:433:41: warning: 'nic7772' defined but not used [-Wunused-const-variable=]
>      433 | static const struct ni16550_device_info nic7772 = {
>          |                                         ^~~~~~~
> >> drivers/tty/serial/8250/8250_ni.c:428:41: warning: 'nic7750' defined but not used [-Wunused-const-variable=]
>      428 | static const struct ni16550_device_info nic7750 = {
>          |                                         ^~~~~~~
> 
> 
> vim +/nic7a69 +446 drivers/tty/serial/8250/8250_ni.c
> 
>    426	
>    427	/* NI 16550 RS-485 Interface */
>  > 428	static const struct ni16550_device_info nic7750 = {
>    429		.uartclk = 33333333,
>    430	};
>    431	
>    432	/* NI CVS-145x RS-485 Interface */
>  > 433	static const struct ni16550_device_info nic7772 = {
>    434		.uartclk = 1843200,
>    435		.flags = NI_HAS_PMR,
>    436	};
>    437	
>    438	/* NI cRIO-904x RS-485 Interface */
>  > 439	static const struct ni16550_device_info nic792b = {
>    440		/* Sets UART clock rate to 22.222 MHz with 1.125 prescale */
>    441		.uartclk = 22222222,
>    442		.prescaler = 0x09,
>    443	};
>    444	
>    445	/* NI sbRIO 96x8 RS-232/485 Interfaces */
>  > 446	static const struct ni16550_device_info nic7a69 = {
>    447		/* Set UART clock rate to 29.629 MHz with 1.125 prescale */
>    448		.uartclk = 29629629,
>    449		.prescaler = 0x09,
>    450	};
>    451	

I'll go drop this patch, and the one before this in the series from you,
from my tree now, please fix it up and resend.

thanks,

greg k-h
