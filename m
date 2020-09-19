Return-Path: <SRS0=IZPE=C4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6CAC43463
	for <linux-serial@archiver.kernel.org>; Sat, 19 Sep 2020 05:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6775121D43
	for <linux-serial@archiver.kernel.org>; Sat, 19 Sep 2020 05:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600494082;
	bh=ia6ZShmaX6yANhrqdVNBEQlU/3IBTzJiGcAHx+giQ4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hae0ZfmVo7JlPBr0zhSXgfKVaH1romeBOBRtFj6Exg6nFp3OLUpfRqulp7PzS+DSe
	 aSUUiw38anph88S1N/1sAixBl141KAwxp+kJC97OITtaAcdmQ1mrvlZiJwh/CrIpnu
	 lrpFFhl3pDbmtbUmnvUZ8Nis4A1ao2IdI7+Ug8Tc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgISFlW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 19 Sep 2020 01:41:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgISFlV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 19 Sep 2020 01:41:21 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29D5F207D3;
        Sat, 19 Sep 2020 05:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600494081;
        bh=ia6ZShmaX6yANhrqdVNBEQlU/3IBTzJiGcAHx+giQ4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KrJHbawDw1SipKWfL2OB2tXLPTMaVKMNx0hd/NtMSNs/Jump/ctGbpUa30ARx4NfF
         Go0lTVwysEegIj0pAskL5UcG+QNR7zNIPftIe1EqCcAUbf+ZuaHlWkH+6I8qwIFBwm
         R41QD1b+Gbn0B9pGe7dP3LixqFzFp7vgFiMIdAFA=
Date:   Sat, 19 Sep 2020 07:41:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] tty: serial: imx: fix link error with
 CONFIG_SERIAL_CORE_CONSOLE=n
Message-ID: <20200919054116.GB432686@kroah.com>
References: <20200918091305.3822598-1-yangyingliang@huawei.com>
 <20200918111658.GB2242974@kroah.com>
 <d39572f9-2f18-384e-ebc2-21a046c5986f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d39572f9-2f18-384e-ebc2-21a046c5986f@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Sep 19, 2020 at 10:26:38AM +0800, Yang Yingliang wrote:
> Hi,
> 
> On 2020/9/18 19:16, Greg KH wrote:
> > On Fri, Sep 18, 2020 at 05:13:05PM +0800, Yang Yingliang wrote:
> > > Fix the link error by selecting SERIAL_CORE_CONSOLE.
> > > 
> > > aarch64-linux-gnu-ld: drivers/tty/serial/imx_earlycon.o: in function `imx_uart_console_early_write':
> > > imx_earlycon.c:(.text+0x84): undefined reference to `uart_console_write'
> > > 
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > > ---
> > >   drivers/tty/serial/Kconfig | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > > index 9631ccf43378..1044fc387691 100644
> > > --- a/drivers/tty/serial/Kconfig
> > > +++ b/drivers/tty/serial/Kconfig
> > > @@ -521,6 +521,7 @@ config SERIAL_IMX_EARLYCON
> > >   	depends on ARCH_MXC || COMPILE_TEST
> > >   	depends on OF
> > >   	select SERIAL_EARLYCON
> > > +	select SERIAL_CORE_CONSOLE
> > >   	help
> > >   	  If you have enabled the earlycon on the Freescale IMX
> > >   	  CPU you can make it the earlycon by answering Y to this option.
> > > -- 
> > > 2.25.1
> > > 
> > What caused this build error to start happening?  Any pointers to the
> > specific commit?
> 
> It's start from 699cc4dfd140 ("tty: serial: imx: add imx earlycon driver"),
> the driver
> 
> uses the uart_console_write(), but SERIAL_CORE_CONSOLE is not selected, so
> uart_console_write
> 
> is not defined, then we get the error.

Great, can you add a Fixes: line to the patch and resend it with this
information added to the changelog text?

Always include this type of information if at all possible.

thanks,

greg k-h
