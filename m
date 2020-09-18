Return-Path: <SRS0=liNn=C3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9749C43466
	for <linux-serial@archiver.kernel.org>; Fri, 18 Sep 2020 11:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A92F621D7B
	for <linux-serial@archiver.kernel.org>; Fri, 18 Sep 2020 11:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600427791;
	bh=/GVzOHYgk06nPLydCdjRVQchH3n4ZOTQdwwxzIiWZjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sDoLginEF/HKMbLz69spFpfk0nBQyN1baLhVRpgIJeiuL1lv/mDDTNcNcmRplM/d8
	 lqBGG4i+PmHcASa+s+f4rPnCiK1x32iMMyvuZnfqC/xY6HW2p7ztP2daPZgcctKg7L
	 lFfEv9/+7wO64kcpo38gUnjag1b15aMMuZK6OpDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgIRLQb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Sep 2020 07:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgIRLQ2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Sep 2020 07:16:28 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3CAF22208;
        Fri, 18 Sep 2020 11:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600427788;
        bh=/GVzOHYgk06nPLydCdjRVQchH3n4ZOTQdwwxzIiWZjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ru8rfJZCViN2AHvi5AUZ2NuD5Iu1Oavn36gFGQfwHlFdTf0sD5gs7okInM09wPMmA
         uoXj7WhJM6/Kl8PSg9PvSJ7VToSUxvbksVzGFo+wvlJEH8XQMr+chL963KoCJ9ZQfH
         +bQT03S5oKZFBnHMlqFezGy3gG5Y7e8BVJy8Ac2A=
Date:   Fri, 18 Sep 2020 13:16:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] tty: serial: imx: fix link error with
 CONFIG_SERIAL_CORE_CONSOLE=n
Message-ID: <20200918111658.GB2242974@kroah.com>
References: <20200918091305.3822598-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918091305.3822598-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 18, 2020 at 05:13:05PM +0800, Yang Yingliang wrote:
> Fix the link error by selecting SERIAL_CORE_CONSOLE.
> 
> aarch64-linux-gnu-ld: drivers/tty/serial/imx_earlycon.o: in function `imx_uart_console_early_write':
> imx_earlycon.c:(.text+0x84): undefined reference to `uart_console_write'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/tty/serial/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 9631ccf43378..1044fc387691 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -521,6 +521,7 @@ config SERIAL_IMX_EARLYCON
>  	depends on ARCH_MXC || COMPILE_TEST
>  	depends on OF
>  	select SERIAL_EARLYCON
> +	select SERIAL_CORE_CONSOLE
>  	help
>  	  If you have enabled the earlycon on the Freescale IMX
>  	  CPU you can make it the earlycon by answering Y to this option.
> -- 
> 2.25.1
> 

What caused this build error to start happening?  Any pointers to the
specific commit?

thanks,

greg k-h
