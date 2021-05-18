Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1161C433ED
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 05:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AC4E61166
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 05:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbhERFlU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 May 2021 01:41:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234640AbhERFlT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 May 2021 01:41:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7856561019;
        Tue, 18 May 2021 05:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621316401;
        bh=2QjwTVqJlsfh4K6e7qEwUCi8M2rLkjF2RVXKpYdvzm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uRXDakjMM1BwEt2K481FEht6aq/8j3ilocoTeZrdTo27nAiVoIKI0MYW5yhg8wBpH
         x5xmaVJlECmlW/b+u859LfTKlQTtuPPnumCrRMFKt3Kl8Z6uDvdc3hN53Zbr3hIx9O
         i5O8v4x8kx0KrqHYoZBFXE5mlGVvwDKrvljhBWs4=
Date:   Tue, 18 May 2021 07:39:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jay Fang <f.fangjian@huawei.com>
Cc:     linux-serial@vger.kernel.org, linuxarm@huawei.com,
        huangdaode@huawei.com, tangzihao1@hisilicon.com
Subject: Re: [PATCH 00/11] tty: serial: Fix some coding style issues
Message-ID: <YKNTK/pkKK5kB6zu@kroah.com>
References: <1621303038-12062-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621303038-12062-1-git-send-email-f.fangjian@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 18, 2021 at 09:57:07AM +0800, Jay Fang wrote:
> From: Zihao Tang <tangzihao1@hisilicon.com>
> 
> This patchset fixes some coding style issues reported by checkpatch.pl.
> 
> Zihao Tang (11):
>   tty: serial: 21285: Fix some coding sytle issues
>   tty: serial: amba-pl010: Fix 2 coding style issues
>   tty: serial: amba-pl011: Replace the unsuitable spaces with tabs
>   tty: serial: amba-pl011: Remove initialization of static variable
>   tty: serial: apbuart: Fix some coding sytle issues
>   tty: serial: atmel: Fix some coding style issues
>   tty: serial: bcm63xx_uart: Fix some coding style issues
>   tty: serial: clps711x: Fix some coding style issuses
>   tty: serial: digicolor: Use 'unsigned int' instead of 'unsigned'
>   tty: serial: dz: Use 'unsigned int' instead of 'unsigned'
>   tty: serial: earlycon-arm-semihost : Fix some coding style issuses
> 
>  drivers/tty/serial/21285.c                 |  7 +++----
>  drivers/tty/serial/amba-pl010.c            |  4 ++--
>  drivers/tty/serial/amba-pl011.c            | 12 ++++++------
>  drivers/tty/serial/apbuart.c               |  5 ++++-
>  drivers/tty/serial/atmel_serial.c          | 13 +++++++++----
>  drivers/tty/serial/bcm63xx_uart.c          | 14 +++++++++-----
>  drivers/tty/serial/clps711x.c              |  4 ++--
>  drivers/tty/serial/digicolor-usart.c       |  2 +-
>  drivers/tty/serial/dz.c                    |  4 ++--
>  drivers/tty/serial/earlycon-arm-semihost.c |  3 ++-
>  10 files changed, 40 insertions(+), 28 deletions(-)
> 
> -- 
> 2.7.4
> 


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
