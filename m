Return-Path: <SRS0=071p=2J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592BFC43603
	for <linux-serial@archiver.kernel.org>; Thu, 19 Dec 2019 07:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C892206D7
	for <linux-serial@archiver.kernel.org>; Thu, 19 Dec 2019 07:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576740860;
	bh=YUYFcOfbg1jPV/4vhcRgtLTZCNFMFJDQ7aMO+SQ3VKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h3rpVv5LfZn8Wr9StM+AB6LTeCTNu/xMdD80YEf+svSIYr4/nyqjS5ZSf7eECzRQo
	 EqT3XDv7p0xGuaAaX4POtnrDpxBvZyU5NoqWvdmW0Kc7mdyoX7iIa419hKL611qzI8
	 Ei746HQllyi90Rdi7vaXvVcpkHJ0bDPJTYQPtIrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfLSHeT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Dec 2019 02:34:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfLSHeT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Dec 2019 02:34:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A1D4206D7;
        Thu, 19 Dec 2019 07:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576740859;
        bh=YUYFcOfbg1jPV/4vhcRgtLTZCNFMFJDQ7aMO+SQ3VKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xst2hQwWkpPAmcrd/XM4MHKdbWCSXEksYobsx2DWGZMu7Cvm5Qym5BeWj+Qp3XC6J
         362xZWuo/Hf2jBK8DcjZRUFMNeJtFU1EZK6wQA5PwQKX+J+9HjGd9okhf4RDUfSW97
         vNWTmK3dtM9wn2Zra/mKXk0V752Ng3NkhbPqzbCo=
Date:   Thu, 19 Dec 2019 08:34:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Dmitry Safonov <dima@arista.com>, kbuild-all@lists.01.org,
        linux-serial@vger.kernel.org
Subject: Re: [tty:tty-testing 23/75] drivers/tty/serial/21285.c:44:41: error:
 subscripted value is neither array nor pointer nor vector
Message-ID: <20191219073416.GA961893@kroah.com>
References: <201912191529.6kIYPFPw%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201912191529.6kIYPFPw%lkp@intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Dec 19, 2019 at 03:24:01PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> head:   82cfd2e62b354840af6a045e084f6e9e7c49584d
> commit: 1997e9dfdc84c8f73d6fc318355cf9e313aba183 [23/75] serial_core: Un-ifdef sysrq SUPPORT_SYSRQ
> config: arm-randconfig-a001-20191219 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 1997e9dfdc84c8f73d6fc318355cf9e313aba183
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/kernel.h:11:0,
>                     from include/linux/list.h:9,
>                     from include/linux/module.h:12,
>                     from drivers/tty/serial/21285.c:7:
>    drivers/tty/serial/21285.c: In function 'serial21285_stop_tx':
> >> drivers/tty/serial/21285.c:44:41: error: subscripted value is neither array nor pointer nor vector
>     #define tx_enabled(port) ((port)->unused[0])
>                                             ^

Ugh, this driver did the same hack the samsung_tty driver did!  That's
where samsung got the idea.

I'll go fix this up as well...

thanks,

greg k-h
