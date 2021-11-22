Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C047C433FE
	for <linux-serial@archiver.kernel.org>; Mon, 22 Nov 2021 13:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhKVNE4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Nov 2021 08:04:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230058AbhKVNEz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Nov 2021 08:04:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE7B060F5B;
        Mon, 22 Nov 2021 13:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637586107;
        bh=cfIg/uCuc4p0nRwYuqPMNhFVEk2R7HhI93wi9j5XUh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xY0t7XdeYDuvEgXTDk1mFWAOxEZwLc/VDUjeK/qujTUZvsMiXfjJWoJpgdxspvKyk
         HzfWVPWB7NJ+Ulb3SuH9phY7p0Uz+YCb63mmrzHoLvDoE0NzwLHyzVhLiEY313cO+B
         6trVaBHdpKbFDrx3kCOjISyorhYodLMe6te0jVr8=
Date:   Mon, 22 Nov 2021 14:01:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Patrik John <patrik.john@u-blox.com>
Cc:     linux-kernel@vger.kernel.org, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathan@nvidia.com,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] serial: tegra: Fixes lower tolerance baud rate limit for
 older tegra chips introduced by d781ec21bae6
Message-ID: <YZuUuNTCLS0yLH8A@kroah.com>
References: <sig.096060f39c.20211122124425.74031-1-patrik.john@u-blox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sig.096060f39c.20211122124425.74031-1-patrik.john@u-blox.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 22, 2021 at 01:44:26PM +0100, Patrik John wrote:
> The current implementation uses 0 as lower limit for the baud rate tolerance which contradicts the initial commit description (https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/commit/drivers/tty/serial/serial-tegra.c?h=for-next&id=d781ec21bae6ff8f9e07682e8947a654484611f5) of +4/-4% tolerance for older tegra chips other than Tegra186 and Tegra194.
> This causes issues on UART initilization as soon as the actual baud rate clock is slightly lower than required which we have seen on the Tegra124-based Toradex Apalis TK1 which also uses tegra30-hsuart as compatible in the DT serial node (for reference line 1540ff https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/tree/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi?h=for-next)

All of these links will break in a few days.

And a line number is not "1540ff" :(

> 
> The standard baud rate tolerance limits are also stated in the tegra20-hsuart driver description (https://www.kernel.org/doc/Documentation/devicetree/bindings/serial/nvidia%2Ctegra20-hsuart.txt).

You can just reference a file in the kernel source tree directly, no
need to go back to kernel.org

> 
> The previously introduced check_rate_in_range() always fails due to the lower limit set to 0 even if the actual baud rate is within the required -4% tolerance.

Can you please wrap your changelog text at 72 columns like git asked you
to when you committed the change to your local tree?

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

I do not understand, why is this code in the changelog?

> 
> Changing the lower tolerance limit to the actual -4% resolved the issues for the Tegra124 and should resolve potential issues for other Tegra20/Tegra30 based platforms as well.
> 
> Signed-off-by: Patrik John <patrik.john@u-blox.com>

What commit does this fix?  Should it have a "Fixes:" tag in it?

And should it go to stable kernel(s)?

Also, this is a v2 patch, please include below the --- line what changed
from the previous version when you resend v3.

thanks,

greg k-h
