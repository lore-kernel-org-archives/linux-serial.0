Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA83CC433EF
	for <linux-serial@archiver.kernel.org>; Mon, 22 Nov 2021 12:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhKVMkr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Nov 2021 07:40:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:60688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231258AbhKVMkr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Nov 2021 07:40:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 443E560F5B;
        Mon, 22 Nov 2021 12:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637584660;
        bh=OpGevv1sUWx/fiNY+lQSARluKugbOtOGIe3IWIpYJTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qj8zOQ9jume6bQInx0BKE4Is6qmvGbHFLwaJ04CHO68fvmni/me9Bb9RpLGm4x68p
         67wXRMA1tqmgzgHYdrtl+tg6x2Oucc37wcA8iZbihdXlviE3fuym8VrO3SCekJdjW1
         Sf8jWK0rkG6uXCEmrUKhe1hr7jwXuzMpikKhlA3g=
Date:   Mon, 22 Nov 2021 13:37:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Patrik John <patrik.john@u-blox.com>
Cc:     ldewangan@nvidia.com, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: tegra: Fixes lower tolerance baud limit for
 older tegra chips introduced by d781ec21bae6
Message-ID: <YZuPEj4jRC1jlGlE@kroah.com>
References: <sig.09604dbdc3.20211122115912.73522-1-patrik.john@u-blox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sig.09604dbdc3.20211122115912.73522-1-patrik.john@u-blox.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 22, 2021 at 12:59:14PM +0100, Patrik John wrote:
> The current implementation uses 0 as lower limit for the baud rate tolerance which contradicts the initial commit description (https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/commit/drivers/tty/serial/serial-tegra.c?h=for-next&id=d781ec21bae6ff8f9e07682e8947a654484611f5) of +4/-4% tolerance for tegra chips other than tegra186.
> This causes issues as soon as the baud rate clock is slightly lower than required which we have seen on the Tegra124-based Toradex Apalis TK1 which also uses tegra30 as compatible in the DT serial node (for reference line 1540ff https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/tree/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi?h=for-next)
> 
> The standard baud rate tolerance limits are also stated in the tegra20-hsuart driver description (https://www.kernel.org/doc/Documentation/devicetree/bindings/serial/nvidia%2Ctegra20-hsuart.txt).
> 
> The previously introduced check_rate_in_range() always fails due to the lower limit set to 0 even if the actual baud rate is within the required -4% tolerance.
> 
> static int tegra_check_rate_in_range(struct tegra_uart_port *tup)
> {
>     long diff;
>     diff = ((long)(tup->configured_rate - tup->required_rate) * 10000)
>         / tup->required_rate;
>     if (diff < (tup->cdata->error_tolerance_low_range * 100) ||
>         diff > (tup->cdata->error_tolerance_high_range * 100)) {
>         dev_err(tup->uport.dev,
>             "configured baud rate is out of range by %ld", diff);
>         return -EIO;
>     }
>     return 0;
> }
> 
> Changing the lower tolerance limit to the actual -4% resolved the issues we have seen with the Tegra124 and should resolve potential issues for other Tegra20/Tegra30 based platforms as well.
> ---
>  drivers/tty/serial/serial-tegra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
> index 45e2e4109acd..b6223fab0687 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -1506,7 +1506,7 @@ static struct tegra_uart_chip_data tegra20_uart_chip_data = {
>  	.fifo_mode_enable_status	= false,
>  	.uart_max_port			= 5,
>  	.max_dma_burst_bytes		= 4,
> -	.error_tolerance_low_range	= 0,
> +	.error_tolerance_low_range	= -4,
>  	.error_tolerance_high_range	= 4,
>  };
>  
> @@ -1517,7 +1517,7 @@ static struct tegra_uart_chip_data tegra30_uart_chip_data = {
>  	.fifo_mode_enable_status	= false,
>  	.uart_max_port			= 5,
>  	.max_dma_burst_bytes		= 4,
> -	.error_tolerance_low_range	= 0,
> +	.error_tolerance_low_range	= -4,
>  	.error_tolerance_high_range	= 4,
>  };
>  
> -- 
> 2.25.1
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

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
