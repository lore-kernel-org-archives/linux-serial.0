Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB95C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 24 Nov 2021 10:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241150AbhKXKKB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Nov 2021 05:10:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241070AbhKXKKB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Nov 2021 05:10:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEB0A60FDC;
        Wed, 24 Nov 2021 10:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637748411;
        bh=aXauE+pBxgFnPm4P4WO4H4wvRz1yJEs9bIEkDBcGM68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mCWwF6JjJuysDuYYe/QaFRFy7bOnM4cDg09ML73HBzTBYLuCikeUN6Frpk5YVatiq
         7nRGsLWjl4vixN7SSU3vV3ZOn4vTQ8SMS2XChZU9HvRRGvaxJM6CNe+8/5XsuyaZGf
         vXFJetT2pp+IsNX9la4NZnI1jQ6J4uRfPDKrEAZ8=
Date:   Wed, 24 Nov 2021 11:06:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, kernel.development@povil.us,
        michals@xilinx.com, git@xilinx.com,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v2] uartlite: Update the default for the
 SERIAL_UARTLITE_NR_UARTS
Message-ID: <YZ4OtwzCjofJvSlW@kroah.com>
References: <20211117051635.1316958-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117051635.1316958-1-shubhrajyoti.datta@xilinx.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 17, 2021 at 10:46:35AM +0530, Shubhrajyoti Datta wrote:
> The commit b44b96a060f3((uartlite: Adding a kernel parameter for the number of uartlites)
> states 
> "The uartlite is used by FPGAs that support a basically unlimited number
> of uarts so limiting it at 16 dosn't make sense as users might need more
> than that."
> the commit also said that number should be unlimited. However it set the
> default to 1 instead of 16.The original 16 written in driver should be
>  quite reasonable default to cover most of the cases.
> 
> So change the default number of uarts back to 16.
> 
> Fixes: b44b96a060f3 (uartlite: Adding a kernel parameter for the number of uartlites)
> Reviewed-by: Michal Simek <michal.simek@xilinx.com>
> Cc: Sam Povilus <kernel.development@povil.us>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
> v2: Update the commit message.
> 
>  drivers/tty/serial/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 131a6a587acd..1254b523ca9a 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -531,7 +531,7 @@ config SERIAL_UARTLITE_NR_UARTS
>  	int "Maximum number of uartlite serial ports"
>  	depends on SERIAL_UARTLITE
>  	range 1 256
> -	default 1
> +	default 16
>  	help
>  	  Set this to the number of uartlites in your system, or the number
>  	  you think you might implement.

If you know you want to increase the number, just do so in your
configuration file, right?

If not, no specific number is going to be "correct", so why do you have
a number at all in here?  Shouldn't this all "just work" and not need to
be pre-allocated by the driver at build time?

I'd much rather prefer to take a change that removes this build time
restriction entirely.

thanks,

greg k-h
