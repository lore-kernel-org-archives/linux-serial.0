Return-Path: <SRS0=D0ei=4Y=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C29C10F00
	for <linux-serial@archiver.kernel.org>; Sat,  7 Mar 2020 08:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA322070A
	for <linux-serial@archiver.kernel.org>; Sat,  7 Mar 2020 08:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583571181;
	bh=mVw4UFFtQ3phR17iNX2oFHY9snpXpZtDXIuO7A0vf70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oezltuwCkQveVc8zbLfl1hu+KL7wU+VrD2vZcW7LOdMkr5QHbAU4fiWZLjYwl9mPh
	 BYrZRvNGisaz8zqpm7Ebfea4D5bxIWvg5Y0f3vmZYqMjMxRrzzMoRJpP8ydKm4QbJf
	 CkZXFBm1tOn/qy88+xUy/YIHBOYdDQGPtW3GRYGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgCGIxB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 7 Mar 2020 03:53:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgCGIxB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 7 Mar 2020 03:53:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB8692070A;
        Sat,  7 Mar 2020 08:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583571177;
        bh=mVw4UFFtQ3phR17iNX2oFHY9snpXpZtDXIuO7A0vf70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UVKkq/YzACs4kzAZzYMr9h8Qgf+u1Zm6Ta5AxYGtXAU48j9OTfhwWdcM4gNxD8KJu
         5zk+sgliG/p7u6MYlTpqPOm2Eixcy9KFg+ldG9gsCZDu7/jBHZuQhMUCCdTibgeVRS
         baxijzpl/IadDQ1DEttPyj3wjN9BsOvCxAuKiPyw=
Date:   Sat, 7 Mar 2020 09:52:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Vincent Chen <vincent.chen@sifive.com>, kbuild-all@lists.01.org,
        linux-serial@vger.kernel.org
Subject: Re: [tty:tty-testing 76/89] drivers/tty/serial/sifive.c:904:19:
 error: 'sifive_serial_poll_get_char' undeclared here (not in a function);
 did you mean 'sifive_serial_clk_notifier'?
Message-ID: <20200307085253.GB3878075@kroah.com>
References: <202003062159.aGzhVVSH%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003062159.aGzhVVSH%lkp@intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 06, 2020 at 09:57:25PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> head:   8434c477300896e50907650a7476116249030b16
> commit: cc2d0148b11763808c835ec5a413620ad92fc340 [76/89] tty: serial: Add CONSOLE_POLL support to SiFive UART
> config: sh-allmodconfig (attached as .config)
> compiler: sh4-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout cc2d0148b11763808c835ec5a413620ad92fc340
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=sh 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/tty/serial/sifive.c:904:19: error: 'sifive_serial_poll_get_char' undeclared here (not in a function); did you mean 'sifive_serial_clk_notifier'?
>      .poll_get_char = sifive_serial_poll_get_char,
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>                       sifive_serial_clk_notifier
> >> drivers/tty/serial/sifive.c:905:19: error: 'sifive_serial_poll_put_char' undeclared here (not in a function); did you mean 'sifive_serial_poll_get_char'?
>      .poll_put_char = sifive_serial_poll_put_char,
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>                       sifive_serial_poll_get_char
> 
> vim +904 drivers/tty/serial/sifive.c
> 
>    886	
>    887	static const struct uart_ops sifive_serial_uops = {
>    888		.tx_empty	= sifive_serial_tx_empty,
>    889		.set_mctrl	= sifive_serial_set_mctrl,
>    890		.get_mctrl	= sifive_serial_get_mctrl,
>    891		.stop_tx	= sifive_serial_stop_tx,
>    892		.start_tx	= sifive_serial_start_tx,
>    893		.stop_rx	= sifive_serial_stop_rx,
>    894		.break_ctl	= sifive_serial_break_ctl,
>    895		.startup	= sifive_serial_startup,
>    896		.shutdown	= sifive_serial_shutdown,
>    897		.set_termios	= sifive_serial_set_termios,
>    898		.type		= sifive_serial_type,
>    899		.release_port	= sifive_serial_release_port,
>    900		.request_port	= sifive_serial_request_port,
>    901		.config_port	= sifive_serial_config_port,
>    902		.verify_port	= sifive_serial_verify_port,
>    903	#ifdef CONFIG_CONSOLE_POLL
>  > 904		.poll_get_char	= sifive_serial_poll_get_char,
>  > 905		.poll_put_char	= sifive_serial_poll_put_char,
>    906	#endif
>    907	};
>    908	

I'm dropping this patch from my tree now.

thanks,

greg k-h
