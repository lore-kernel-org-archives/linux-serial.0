Return-Path: <SRS0=CVbj=7E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA105C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 22 May 2020 13:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 819CF20723
	for <linux-serial@archiver.kernel.org>; Fri, 22 May 2020 13:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590153191;
	bh=/7xPdW1crHgXukpo7wnpD9Ww40kk9wZF1CrxmOqLrvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sh2MZ330kPLhJUY4Gcqxd7dFMTmr/v/qXrF0Irk28+ZvwV4NgQS7B9U6ULHRCqxAv
	 wDsQGJ4VsurlHAM6JnQVL54TC/s2WTgLTgVsd/KRjyXytqHFez7XWQvZkOfRNbWUzc
	 oBgIotimdM/n/LC9Lbjz3wXj5xF5cZuYQOul28wc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgEVNNL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 May 2020 09:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729763AbgEVNNL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 May 2020 09:13:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 359B42070A;
        Fri, 22 May 2020 13:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590153190;
        bh=/7xPdW1crHgXukpo7wnpD9Ww40kk9wZF1CrxmOqLrvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t83hmuVBodGiab31ZGgAg7A+UAMQeVRt0YHPFvugG8Wz9d6EE3rHShbhNjJquYPrJ
         RUIuU6oEAgU0gToysftDfYikMUMXT6GdVdSaR1WSbd21IfAT4NSTs5IsV+wqJ7Vag4
         Na0EaWP3k2KGx41A3G1CLI2r9jWVp0WRLLbgY5k4=
Date:   Fri, 22 May 2020 15:13:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Mukesh, Savaliya" <msavaliy@codeaurora.org>
Cc:     akashast@codeaurora.org, linux-serial@vger.kernel.org,
        saravanak@google.com, sspatil@google.com, tkjos@google.com
Subject: Re: [PATCH V5] serial: msm_geni_serial_console : Add Earlycon support
Message-ID: <20200522131308.GB1629195@kroah.com>
References: <20200522124306.17859-1-msavaliy@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522124306.17859-1-msavaliy@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 22, 2020 at 06:13:06PM +0530, Mukesh, Savaliya wrote:
> From: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
> 
> This change enables earlyconsole support as static driver for geni
> based UART. Kernel space UART console driver will be generic for
> console and other usecases of UART.
> 
> Signed-off-by: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
> ---
> Changes In V2:
>  - Fixed Makefile Typo issue.
> 
> Changes In V3:
>  - Removed mb() calls as *_relaxed() should take care.
> 
> Changes In V4:
>  - Minor change: space between offset and base addition.
> 
> Changes In V5:
>  - Removed unlikely() macro.
>  - root_freq() array taken as static.
>  - Removed extra readback of the register having no meaning.
> 
>  drivers/tty/serial/Kconfig                   |  15 +
>  drivers/tty/serial/Makefile                  |   1 +
>  drivers/tty/serial/msm_geni_serial_console.c | 476 +++++++++++++++++++
>  3 files changed, 492 insertions(+)
>  create mode 100644 drivers/tty/serial/msm_geni_serial_console.c
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 0aea76cd67ff..ded19d80e696 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -956,6 +956,21 @@ config SERIAL_MSM_CONSOLE
>  	select SERIAL_CORE_CONSOLE
>  	select SERIAL_EARLYCON
>  
> +config SERIAL_MSM_GENI_HALF_SAMPLING
> +	bool "Changes clock divider which impacts sampling rate for QUP HW ver greater than 2.5.0"
> +	help
> +	  Clock divider value should be doubled for QUP hardware version
> +	  greater than 2.5.0.
> +	  As earlycon can't have HW version awareness, decision is taken
> +	  based on the configuration.

Can you split this option out into a separate file so we don't have to
keep arguing about it, preventing the "real" early console code from
being merged?

I really think someone needs to go yell at some hardware engineers for
this issue.  How is this going to work for a "generic" arm64 kernel
image?  Your hardware always has to be self-describing for crazy stuff
like this.  Or you pass it in from the bootloader.  You can't hard-code
this thing, it defeats the whole idea of dynamic systems...

thanks,

greg k-h
